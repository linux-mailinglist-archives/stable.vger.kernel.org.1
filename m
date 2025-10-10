Return-Path: <stable+bounces-183866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C98BCCE7C
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 14:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C7142105D
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344E71F9F7A;
	Fri, 10 Oct 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j2NzuYbF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FC25771
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099483; cv=none; b=Agm0D2ggeBpHFbr7IUWR1EO4asuVSydhfoZQWTOzGwd6sU8E1CSQKL2g9t3rKmGTKUPVxP/R+7fFa4+ycZRPmTGyRq9wYi+Gj0DFGp2xAlCmBWa48NecIDf9fz65NrHP/QltRUlBAjktZzq6p40rw34M6xVxK/LKj3vpLWNZon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099483; c=relaxed/simple;
	bh=DMNBg9eXTTZzI9TgFMAyZf7iN0tI7LYqrLm/nhKyF+s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rl0y1T4uyXiV7ZhifIzegBPygbGUHydXCj3lxYxk0gJ3acKcFpSNBdfysmlUJbYAE4NvZ9suEVIKP51a84eE5Savw35QoFaGh0bZkdFdIgnQQk9OZXuMLCuxadNOqjRapz9E24/FSJFwDLeMsqRIjpCdMx2i74fb1NWHV4Gppxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j2NzuYbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15F4C4CEF1;
	Fri, 10 Oct 2025 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760099482;
	bh=DMNBg9eXTTZzI9TgFMAyZf7iN0tI7LYqrLm/nhKyF+s=;
	h=Subject:To:Cc:From:Date:From;
	b=j2NzuYbFL4L2KIaKtBPyzfG7SAOWXqDgr9wvlZTigEA0qZt70TsmcORh3eEJbd/7N
	 /Qn0DF4jy+7iUXguGpqnIut1IX7SnLMZjzfN8Hlh+wS3O7/Pw8CBunppGEgDrUQL8G
	 dAg9+Dr1khw6HnQ/FyjFQCnPEoNqRIwvGDfp8Qww=
Subject: FAILED: patch "[PATCH] net/9p: fix double req put in p9_fd_cancelled" failed to apply to 5.10-stable tree
To: Sergey.Nalivayko@kaspersky.com,asmadeus@codewreck.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 10 Oct 2025 14:31:19 +0200
Message-ID: <2025101019-zeppelin-polymer-aadc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 674b56aa57f9379854cb6798c3bbcef7e7b51ab7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101019-zeppelin-polymer-aadc@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 674b56aa57f9379854cb6798c3bbcef7e7b51ab7 Mon Sep 17 00:00:00 2001
From: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
Date: Tue, 15 Jul 2025 18:48:15 +0300
Subject: [PATCH] net/9p: fix double req put in p9_fd_cancelled

Syzkaller reports a KASAN issue as below:

general protection fault, probably for non-canonical address 0xfbd59c0000000021: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xdead000000000108-0xdead00000000010f]
CPU: 0 PID: 5083 Comm: syz-executor.2 Not tainted 6.1.134-syzkaller-00037-g855bd1d7d838 #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:__list_del include/linux/list.h:114 [inline]
RIP: 0010:__list_del_entry include/linux/list.h:137 [inline]
RIP: 0010:list_del include/linux/list.h:148 [inline]
RIP: 0010:p9_fd_cancelled+0xe9/0x200 net/9p/trans_fd.c:734

Call Trace:
 <TASK>
 p9_client_flush+0x351/0x440 net/9p/client.c:614
 p9_client_rpc+0xb6b/0xc70 net/9p/client.c:734
 p9_client_version net/9p/client.c:920 [inline]
 p9_client_create+0xb51/0x1240 net/9p/client.c:1027
 v9fs_session_init+0x1f0/0x18f0 fs/9p/v9fs.c:408
 v9fs_mount+0xba/0xcb0 fs/9p/vfs_super.c:126
 legacy_get_tree+0x108/0x220 fs/fs_context.c:632
 vfs_get_tree+0x8e/0x300 fs/super.c:1573
 do_new_mount fs/namespace.c:3056 [inline]
 path_mount+0x6a6/0x1e90 fs/namespace.c:3386
 do_mount fs/namespace.c:3399 [inline]
 __do_sys_mount fs/namespace.c:3607 [inline]
 __se_sys_mount fs/namespace.c:3584 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3584
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

This happens because of a race condition between:

- The 9p client sending an invalid flush request and later cleaning it up;
- The 9p client in p9_read_work() canceled all pending requests.

      Thread 1                              Thread 2
    ...
    p9_client_create()
    ...
    p9_fd_create()
    ...
    p9_conn_create()
    ...
    // start Thread 2
    INIT_WORK(&m->rq, p9_read_work);
                                        p9_read_work()
    ...
    p9_client_rpc()
    ...
                                        ...
                                        p9_conn_cancel()
                                        ...
                                        spin_lock(&m->req_lock);
    ...
    p9_fd_cancelled()
    ...
                                        ...
                                        spin_unlock(&m->req_lock);
                                        // status rewrite
                                        p9_client_cb(m->client, req, REQ_STATUS_ERROR)
                                        // first remove
                                        list_del(&req->req_list);
                                        ...

    spin_lock(&m->req_lock)
    ...
    // second remove
    list_del(&req->req_list);
    spin_unlock(&m->req_lock)
  ...

Commit 74d6a5d56629 ("9p/trans_fd: Fix concurrency del of req_list in
p9_fd_cancelled/p9_read_work") fixes a concurrency issue in the 9p filesystem
client where the req_list could be deleted simultaneously by both
p9_read_work and p9_fd_cancelled functions, but for the case where req->status
equals REQ_STATUS_RCVD.

Update the check for req->status in p9_fd_cancelled to skip processing not
just received requests, but anything that is not SENT, as whatever
changed the state from SENT also removed the request from its list.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: afd8d6541155 ("9P: Add cancelled() to the transport functions.")
Cc: stable@vger.kernel.org
Signed-off-by: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
Message-ID: <20250715154815.3501030-1-Sergey.Nalivayko@kaspersky.com>
[updated the check from status == RECV || status == ERROR to status != SENT]
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 339ec4e54778..8992d8bebbdd 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -726,10 +726,10 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
 
 	spin_lock(&m->req_lock);
-	/* Ignore cancelled request if message has been received
-	 * before lock.
-	 */
-	if (req->status == REQ_STATUS_RCVD) {
+	/* Ignore cancelled request if status changed since the request was
+	 * processed in p9_client_flush()
+	*/
+	if (req->status != REQ_STATUS_SENT) {
 		spin_unlock(&m->req_lock);
 		return 0;
 	}


