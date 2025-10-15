Return-Path: <stable+bounces-185796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C135BDE241
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 492D350414F
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76D320CD8;
	Wed, 15 Oct 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sIZi0Wbv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A89B321F20
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525856; cv=none; b=jJrqt97g0n9zMwxyPmP4eeHtqb3tcidJ9bgQIIRqapK2MKFhuPFV2Am/fXnjmWwqN8iEiD8FMx8/gIjEKVN/L/wnKHs6gIzBs4X6qgcyUahlbgG0RrK1yJXtw9wgQEVOQWhitpUiKju2BqNQpuH6fHkJn0Jx/Bs8MvoxtUKk70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525856; c=relaxed/simple;
	bh=gAcQiJCKrBgbe0JeLj/3nc4aLPp3b+cLh1pxX6Ydrhs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RzY9jr+wv0X50cd6JpEWBFFCpMbW/Sf9R3vHS1F4gKeOaOabNHtZHmf0n3ZNwy9AmBT5Brolx68SKVrzrkCBPPFhK+jQHZAv2lME0x7x/rKIrfTnic8nVnZojKwTfL2X1RZi8t0JEzqanP0ekhepnIARAwi/J7veDMKwy8VwDns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sIZi0Wbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9138BC116B1;
	Wed, 15 Oct 2025 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760525855;
	bh=gAcQiJCKrBgbe0JeLj/3nc4aLPp3b+cLh1pxX6Ydrhs=;
	h=Subject:To:Cc:From:Date:From;
	b=sIZi0Wbv7jzl9CMjERKEVPgFHWR7ded1ojQVNGiqLjZHw1Ijrd0NEEgZ9LA7uAHT2
	 6GxyxxzH0W33wbDePzrBjSgrYdtCRzWO9s15GHFUsG865C/f1WpW0YfdjT2AHLbucb
	 HbmAQuF+LPh5POFax0p8YjmQ014ZGoFtBWu7e5qo=
Subject: FAILED: patch "[PATCH] statmount: don't call path_put() under namespace semaphore" failed to apply to 6.12-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 12:57:33 +0200
Message-ID: <2025101533-mutt-routing-a332@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e8c84e2082e69335f66c8ade4895e80ec270d7c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101533-mutt-routing-a332@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8c84e2082e69335f66c8ade4895e80ec270d7c4 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 19 Sep 2025 17:03:51 +0200
Subject: [PATCH] statmount: don't call path_put() under namespace semaphore

Massage statmount() and make sure we don't call path_put() under the
namespace semaphore. If we put the last reference we're fscked.

Fixes: 46eae99ef733 ("add statmount(2) syscall")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index ba3e5215b636..993983a76853 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5708,7 +5708,6 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 			struct mnt_namespace *ns)
 {
-	struct path root __free(path_put) = {};
 	struct mount *m;
 	int err;
 
@@ -5720,7 +5719,7 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!s->mnt)
 		return -ENOENT;
 
-	err = grab_requested_root(ns, &root);
+	err = grab_requested_root(ns, &s->root);
 	if (err)
 		return err;
 
@@ -5729,7 +5728,7 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	 * mounts to show users.
 	 */
 	m = real_mount(s->mnt);
-	if (!is_path_reachable(m, m->mnt.mnt_root, &root) &&
+	if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -5737,8 +5736,6 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (err)
 		return err;
 
-	s->root = root;
-
 	/*
 	 * Note that mount properties in mnt->mnt_flags, mnt->mnt_idmap
 	 * can change concurrently as we only hold the read-side of the
@@ -5960,6 +5957,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	if (!ret)
 		ret = copy_statmount_to_user(ks);
 	kvfree(ks->seq.buf);
+	path_put(&ks->root);
 	if (retry_statmount(ret, &seq_size))
 		goto retry;
 	return ret;


