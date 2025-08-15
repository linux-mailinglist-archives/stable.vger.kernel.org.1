Return-Path: <stable+bounces-169776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE462B284AD
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23311CE41EE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67ED304BB0;
	Fri, 15 Aug 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J+Jk9oQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67570304BA8
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277664; cv=none; b=oGEWS90Jfx16lGg8cBKu3bhBrZik2BPiYvONtpEXHnPB09oPTCD/pwavCONrFzTQezyw0OSOPMEwvYQ0qi9seuOwn72xNT66/c2VaArrU+ZIxDMBZUxOLpf1j3lyNBxFUialG6zgPdjIUHMHJw9baKe3KatwWqcFLk9vRwzNft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277664; c=relaxed/simple;
	bh=tnlukhwx+mMVleTZN6pzu93w7eUurLTMdVGMAaQra0s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VmkQt9YuFyBhDnQhxEhdqz90qrVkTJASyyEn96k+xBHVYma1OAfIHS1hFCAXT8CfjLLnQoZTcIde88X9cNRH8JoNEaTDJjV2wyWJz9LLnBsOb3BH4o6aZTYd5iEsjp2Hgmg/+Y9yooQcqNC+swOw5cFUZ0Wg2wDLEuyePeDhWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J+Jk9oQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63999C4CEEB;
	Fri, 15 Aug 2025 17:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755277662;
	bh=tnlukhwx+mMVleTZN6pzu93w7eUurLTMdVGMAaQra0s=;
	h=Subject:To:Cc:From:Date:From;
	b=J+Jk9oQU4NS+uyhT0+pBqZQlLzQIuktnr2TL5Eo8sjv5/lpF6Sv4wVEZt57YY3Saz
	 5tdYNUH7uJCGUqThKaLM70tQGsG1OnC8dUjF2y1i0uxUrLonURUhoZ5GW0tgtjqCCd
	 60ScHgCYnMV5Mt7Qh1/qd16dxu8s9RJxkFkq6wdo=
Subject: FAILED: patch "[PATCH] eventpoll: Fix semi-unbounded recursion" failed to apply to 5.4-stable tree
To: jannh@google.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 19:07:35 +0200
Message-ID: <2025081535-enrage-raging-295b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f2e467a48287c868818085aa35389a224d226732
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081535-enrage-raging-295b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2e467a48287c868818085aa35389a224d226732 Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Jul 2025 18:33:36 +0200
Subject: [PATCH] eventpoll: Fix semi-unbounded recursion

Ensure that epoll instances can never form a graph deeper than
EP_MAX_NESTS+1 links.

Currently, ep_loop_check_proc() ensures that the graph is loop-free and
does some recursion depth checks, but those recursion depth checks don't
limit the depth of the resulting tree for two reasons:

 - They don't look upwards in the tree.
 - If there are multiple downwards paths of different lengths, only one of
   the paths is actually considered for the depth check since commit
   28d82dc1c4ed ("epoll: limit paths").

Essentially, the current recursion depth check in ep_loop_check_proc() just
serves to prevent it from recursing too deeply while checking for loops.

A more thorough check is done in reverse_path_check() after the new graph
edge has already been created; this checks, among other things, that no
paths going upwards from any non-epoll file with a length of more than 5
edges exist. However, this check does not apply to non-epoll files.

As a result, it is possible to recurse to a depth of at least roughly 500,
tested on v6.15. (I am unsure if deeper recursion is possible; and this may
have changed with commit 8c44dac8add7 ("eventpoll: Fix priority inversion
problem").)

To fix it:

1. In ep_loop_check_proc(), note the subtree depth of each visited node,
and use subtree depths for the total depth calculation even when a subtree
has already been visited.
2. Add ep_get_upwards_depth_proc() for similarly determining the maximum
depth of an upwards walk.
3. In ep_loop_check(), use these values to limit the total path length
between epoll nodes to EP_MAX_NESTS edges.

Fixes: 22bacca48a17 ("epoll: prevent creating circular epoll structures")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d4dbffdedd08..44648cc09250 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -218,6 +218,7 @@ struct eventpoll {
 	/* used to optimize loop detection check */
 	u64 gen;
 	struct hlist_head refs;
+	u8 loop_check_depth;
 
 	/*
 	 * usage count, used together with epitem->dying to
@@ -2142,23 +2143,24 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 }
 
 /**
- * ep_loop_check_proc - verify that adding an epoll file inside another
- *                      epoll structure does not violate the constraints, in
- *                      terms of closed loops, or too deep chains (which can
- *                      result in excessive stack usage).
+ * ep_loop_check_proc - verify that adding an epoll file @ep inside another
+ *                      epoll file does not create closed loops, and
+ *                      determine the depth of the subtree starting at @ep
  *
  * @ep: the &struct eventpoll to be currently checked.
  * @depth: Current depth of the path being checked.
  *
- * Return: %zero if adding the epoll @file inside current epoll
- *          structure @ep does not violate the constraints, or %-1 otherwise.
+ * Return: depth of the subtree, or INT_MAX if we found a loop or went too deep.
  */
 static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 {
-	int error = 0;
+	int result = 0;
 	struct rb_node *rbp;
 	struct epitem *epi;
 
+	if (ep->gen == loop_check_gen)
+		return ep->loop_check_depth;
+
 	mutex_lock_nested(&ep->mtx, depth + 1);
 	ep->gen = loop_check_gen;
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
@@ -2166,13 +2168,11 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 		if (unlikely(is_file_epoll(epi->ffd.file))) {
 			struct eventpoll *ep_tovisit;
 			ep_tovisit = epi->ffd.file->private_data;
-			if (ep_tovisit->gen == loop_check_gen)
-				continue;
 			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS)
-				error = -1;
+				result = INT_MAX;
 			else
-				error = ep_loop_check_proc(ep_tovisit, depth + 1);
-			if (error != 0)
+				result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1);
+			if (result > EP_MAX_NESTS)
 				break;
 		} else {
 			/*
@@ -2186,9 +2186,27 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 			list_file(epi->ffd.file);
 		}
 	}
+	ep->loop_check_depth = result;
 	mutex_unlock(&ep->mtx);
 
-	return error;
+	return result;
+}
+
+/**
+ * ep_get_upwards_depth_proc - determine depth of @ep when traversed upwards
+ */
+static int ep_get_upwards_depth_proc(struct eventpoll *ep, int depth)
+{
+	int result = 0;
+	struct epitem *epi;
+
+	if (ep->gen == loop_check_gen)
+		return ep->loop_check_depth;
+	hlist_for_each_entry_rcu(epi, &ep->refs, fllink)
+		result = max(result, ep_get_upwards_depth_proc(epi->ep, depth + 1) + 1);
+	ep->gen = loop_check_gen;
+	ep->loop_check_depth = result;
+	return result;
 }
 
 /**
@@ -2204,8 +2222,22 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
  */
 static int ep_loop_check(struct eventpoll *ep, struct eventpoll *to)
 {
+	int depth, upwards_depth;
+
 	inserting_into = ep;
-	return ep_loop_check_proc(to, 0);
+	/*
+	 * Check how deep down we can get from @to, and whether it is possible
+	 * to loop up to @ep.
+	 */
+	depth = ep_loop_check_proc(to, 0);
+	if (depth > EP_MAX_NESTS)
+		return -1;
+	/* Check how far up we can go from @ep. */
+	rcu_read_lock();
+	upwards_depth = ep_get_upwards_depth_proc(ep, 0);
+	rcu_read_unlock();
+
+	return (depth+1+upwards_depth > EP_MAX_NESTS) ? -1 : 0;
 }
 
 static void clear_tfile_check_list(void)


