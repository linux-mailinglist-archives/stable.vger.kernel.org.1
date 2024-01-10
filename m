Return-Path: <stable+bounces-9590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110A823307
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC2C1F246EB
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49A1C29C;
	Wed,  3 Jan 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVnjmphH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572A1C292;
	Wed,  3 Jan 2024 17:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD123C433C7;
	Wed,  3 Jan 2024 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704302099;
	bh=wb/HNqI/RClyscrZjtFKRrlj2xhFqaYMbH8slfNgyks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVnjmphH/2uVzejOXEAj9NneZQI9cNhkOE/BNaDTk9brTg53n4YnQPA4r/lZZhxCt
	 Ljgkv5Vi0IMee2w7Hg8mcgyyLDIa/XgbbvuCrAC3CETwzFOxMv4gab0cLnXZ26I8MI
	 gTKAmla8FCSCuMIE0Lv3AWVU/Z/P9es+BN4WzeqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 45/49] ftrace: Fix modification of direct_function hash while in use
Date: Wed,  3 Jan 2024 17:56:05 +0100
Message-ID: <20240103164841.969983746@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
References: <20240103164834.970234661@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit d05cb470663a2a1879277e544f69e660208f08f2 upstream.

Masami Hiramatsu reported a memory leak in register_ftrace_direct() where
if the number of new entries are added is large enough to cause two
allocations in the loop:

        for (i = 0; i < size; i++) {
                hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
                        new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
                        if (!new)
                                goto out_remove;
                        entry->direct = addr;
                }
        }

Where ftrace_add_rec_direct() has:

        if (ftrace_hash_empty(direct_functions) ||
            direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
                struct ftrace_hash *new_hash;
                int size = ftrace_hash_empty(direct_functions) ? 0 :
                        direct_functions->count + 1;

                if (size < 32)
                        size = 32;

                new_hash = dup_hash(direct_functions, size);
                if (!new_hash)
                        return NULL;

                *free_hash = direct_functions;
                direct_functions = new_hash;
        }

The "*free_hash = direct_functions;" can happen twice, losing the previous
allocation of direct_functions.

But this also exposed a more serious bug.

The modification of direct_functions above is not safe. As
direct_functions can be referenced at any time to find what direct caller
it should call, the time between:

                new_hash = dup_hash(direct_functions, size);
 and
                direct_functions = new_hash;

can have a race with another CPU (or even this one if it gets interrupted),
and the entries being moved to the new hash are not referenced.

That's because the "dup_hash()" is really misnamed and is really a
"move_hash()". It moves the entries from the old hash to the new one.

Now even if that was changed, this code is not proper as direct_functions
should not be updated until the end. That is the best way to handle
function reference changes, and is the way other parts of ftrace handles
this.

The following is done:

 1. Change add_hash_entry() to return the entry it created and inserted
    into the hash, and not just return success or not.

 2. Replace ftrace_add_rec_direct() with add_hash_entry(), and remove
    the former.

 3. Allocate a "new_hash" at the start that is made for holding both the
    new hash entries as well as the existing entries in direct_functions.

 4. Copy (not move) the direct_function entries over to the new_hash.

 5. Copy the entries of the added hash to the new_hash.

 6. If everything succeeds, then use rcu_pointer_assign() to update the
    direct_functions with the new_hash.

This simplifies the code and fixes both the memory leak as well as the
race condition mentioned above.

Link: https://lore.kernel.org/all/170368070504.42064.8960569647118388081.stgit@devnote2/
Link: https://lore.kernel.org/linux-trace-kernel/20231229115134.08dd5174@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 763e34e74bb7d ("ftrace: Add register_ftrace_direct()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ftrace.c |  100 +++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 53 deletions(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1183,18 +1183,19 @@ static void __add_hash_entry(struct ftra
 	hash->count++;
 }
 
-static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+static struct ftrace_func_entry *
+add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
 {
 	struct ftrace_func_entry *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
-		return -ENOMEM;
+		return NULL;
 
 	entry->ip = ip;
 	__add_hash_entry(hash, entry);
 
-	return 0;
+	return entry;
 }
 
 static void
@@ -1349,7 +1350,6 @@ alloc_and_copy_ftrace_hash(int size_bits
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *new_hash;
 	int size;
-	int ret;
 	int i;
 
 	new_hash = alloc_ftrace_hash(size_bits);
@@ -1366,8 +1366,7 @@ alloc_and_copy_ftrace_hash(int size_bits
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			ret = add_hash_entry(new_hash, entry->ip);
-			if (ret < 0)
+			if (add_hash_entry(new_hash, entry->ip) == NULL)
 				goto free_hash;
 		}
 	}
@@ -2536,7 +2535,7 @@ ftrace_find_unique_ops(struct dyn_ftrace
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /* Protected by rcu_tasks for reading, and direct_mutex for writing */
-static struct ftrace_hash *direct_functions = EMPTY_HASH;
+static struct ftrace_hash __rcu *direct_functions = EMPTY_HASH;
 static DEFINE_MUTEX(direct_mutex);
 int ftrace_direct_func_count;
 
@@ -2555,39 +2554,6 @@ unsigned long ftrace_find_rec_direct(uns
 	return entry->direct;
 }
 
-static struct ftrace_func_entry*
-ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
-		      struct ftrace_hash **free_hash)
-{
-	struct ftrace_func_entry *entry;
-
-	if (ftrace_hash_empty(direct_functions) ||
-	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
-		struct ftrace_hash *new_hash;
-		int size = ftrace_hash_empty(direct_functions) ? 0 :
-			direct_functions->count + 1;
-
-		if (size < 32)
-			size = 32;
-
-		new_hash = dup_hash(direct_functions, size);
-		if (!new_hash)
-			return NULL;
-
-		*free_hash = direct_functions;
-		direct_functions = new_hash;
-	}
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return NULL;
-
-	entry->ip = ip;
-	entry->direct = addr;
-	__add_hash_entry(direct_functions, entry);
-	return entry;
-}
-
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
@@ -4223,8 +4189,8 @@ enter_record(struct ftrace_hash *hash, s
 		/* Do nothing if it exists */
 		if (entry)
 			return 0;
-
-		ret = add_hash_entry(hash, rec->ip);
+		if (add_hash_entry(hash, rec->ip) == NULL)
+			ret = -ENOMEM;
 	}
 	return ret;
 }
@@ -5266,7 +5232,8 @@ __ftrace_match_addr(struct ftrace_hash *
 		return 0;
 	}
 
-	return add_hash_entry(hash, ip);
+	entry = add_hash_entry(hash, ip);
+	return entry ? 0 :  -ENOMEM;
 }
 
 static int
@@ -5410,7 +5377,7 @@ static void remove_direct_functions_hash
  */
 int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
-	struct ftrace_hash *hash, *free_hash = NULL;
+	struct ftrace_hash *hash, *new_hash = NULL, *free_hash = NULL;
 	struct ftrace_func_entry *entry, *new;
 	int err = -EBUSY, size, i;
 
@@ -5436,17 +5403,44 @@ int register_ftrace_direct(struct ftrace
 		}
 	}
 
-	/* ... and insert them to direct_functions hash. */
 	err = -ENOMEM;
+
+	/* Make a copy hash to place the new and the old entries in */
+	size = hash->count + direct_functions->count;
+	if (size > 32)
+		size = 32;
+	new_hash = alloc_ftrace_hash(fls(size));
+	if (!new_hash)
+		goto out_unlock;
+
+	/* Now copy over the existing direct entries */
+	size = 1 << direct_functions->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &direct_functions->buckets[i], hlist) {
+			new = add_hash_entry(new_hash, entry->ip);
+			if (!new)
+				goto out_unlock;
+			new->direct = entry->direct;
+		}
+	}
+
+	/* ... and add the new entries */
+	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
+			new = add_hash_entry(new_hash, entry->ip);
 			if (!new)
-				goto out_remove;
+				goto out_unlock;
+			/* Update both the copy and the hash entry */
+			new->direct = addr;
 			entry->direct = addr;
 		}
 	}
 
+	free_hash = direct_functions;
+	rcu_assign_pointer(direct_functions, new_hash);
+	new_hash = NULL;
+
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
@@ -5454,17 +5448,17 @@ int register_ftrace_direct(struct ftrace
 
 	err = register_ftrace_function_nolock(ops);
 
- out_remove:
-	if (err)
-		remove_direct_functions_hash(hash, addr);
-
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
-	if (free_hash) {
+	if (free_hash && free_hash != EMPTY_HASH) {
 		synchronize_rcu_tasks();
 		free_ftrace_hash(free_hash);
 	}
+
+	if (new_hash)
+		free_ftrace_hash(new_hash);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
@@ -6309,7 +6303,7 @@ ftrace_graph_set_hash(struct ftrace_hash
 
 				if (entry)
 					continue;
-				if (add_hash_entry(hash, rec->ip) < 0)
+				if (add_hash_entry(hash, rec->ip) == NULL)
 					goto out;
 			} else {
 				if (entry) {



