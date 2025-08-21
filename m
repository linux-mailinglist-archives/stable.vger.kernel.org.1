Return-Path: <stable+bounces-171931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 510CBB2E91E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 02:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B701C21C7E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 00:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A91F4188;
	Thu, 21 Aug 2025 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU9wKg1G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C51DB92A;
	Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734412; cv=none; b=OGw0ZwnywlpIFAkFSNgPhb3AHZpkm2mGvmZnLVZp+DPGXNfpeZ3If3zwJDIisho8Cu2Hv76FaxxDBDBBzE7pBBazWzvA28R8Nf3CAfCtiQGQ7paTEkVVuOupkq+MmCb58fAuV8h37722GRr1jma6EnJf0K9Bd5aK++G7bCzvyd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734412; c=relaxed/simple;
	bh=xzcqqAu060KrqgK9BKBA5RSwOAj5TM90H9Kt0e+bDu8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oqePQCtuf+dxAzFjavFQ/hwoEhjm1bldwzOQCAwjbjj9j1/1/5oBI4w7HY+/DnvHN2qSxJ/L6fAsZmk2t4oijH6YdSugmm9C64wKxP29/4Q81PP4McE/XQXOCNMsmqcBTQz6FAlGRpG2dyM0h67a6QkTkWnYfR8TG6QvWR5Frbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU9wKg1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEBBC4CEEB;
	Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755734411;
	bh=xzcqqAu060KrqgK9BKBA5RSwOAj5TM90H9Kt0e+bDu8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=UU9wKg1GLhh11fp31QsTU9iDHo5sE2jtSfGyU170FSFp/Ywd2Y0Awja3KYNzV8TjG
	 kqIKN5FLuY+ZZS5j584+o9RxzIqJbSMPxgvKGWd9qCeqeSEb51R4e9Rr6bSX6J2ZhP
	 3XCVp8rnltNYnlkp0QSrPpv3XkIeMesCRU8SrO9cWSVfVtyjC+WL7OCMG/OvbaVR0k
	 nvL+C8seq3MAXsewEXj/dNXvHd2XilUOktXWYETbuYbU6770/g6C15UjXFTC3odogH
	 M8jU39zg2CbKS9bXWJ28p6oW6WORruAgxutNjv1TU64kf2A5oBmMZHCb/2UOM72vMd
	 DXw1rmbUP6Etg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uosj1-000000013fC-1Ftl;
	Wed, 20 Aug 2025 20:00:15 -0400
Message-ID: <20250821000015.149907671@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 20:00:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tengda Wu <wutengda@huaweicloud.com>
Subject: [for-linus][PATCH 6/6] ftrace: Also allocate and copy hash for reading of filter files
References: <20250821000000.210778097@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently the reader of set_ftrace_filter and set_ftrace_notrace just adds
the pointer to the global tracer hash to its iterator. Unlike the writer
that allocates a copy of the hash, the reader keeps the pointer to the
filter hashes. This is problematic because this pointer is static across
function calls that release the locks that can update the global tracer
hashes. This can cause UAF and similar bugs.

Allocate and copy the hash for reading the filter files like it is done
for the writers. This not only fixes UAF bugs, but also makes the code a
bit simpler as it doesn't have to differentiate when to free the
iterator's hash between writers and readers.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250820091913.146b77ea@gandalf.local.home
Fixes: c20489dad156 ("ftrace: Assign iter->hash to filter or notrace hashes on seq read")
Closes: https://lore.kernel.org/all/20250813023044.2121943-1-wutengda@huaweicloud.com/
Reported-by: Tengda Wu <wutengda@huaweicloud.com>
Tested-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 00b76d450a89..f992a5eb878e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4661,13 +4661,14 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	        } else {
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
+	} else {
+		iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+	}
 
-		if (!iter->hash) {
-			trace_parser_put(&iter->parser);
-			goto out_unlock;
-		}
-	} else
-		iter->hash = hash;
+	if (!iter->hash) {
+		trace_parser_put(&iter->parser);
+		goto out_unlock;
+	}
 
 	ret = 0;
 
@@ -6543,9 +6544,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
-	} else {
-		/* For read only, the hash is the ops hash */
-		iter->hash = NULL;
 	}
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);
-- 
2.50.1



