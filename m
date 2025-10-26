Return-Path: <stable+bounces-189796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B00C0AA14
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3E1F349BC8
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F731E9B22;
	Sun, 26 Oct 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lf2896zW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1C14D29B
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488960; cv=none; b=P/7wJFWbZs954d0gi7HDrLnvBq+qUFFDbuh/F7brxvGZgiV8BzeL8BzqQhDrVHQXyhSTsPk9B/IJjST4BqJ+hepghKKFHb6sYg1knBYemfT9ayKEUILe93ILj2MI7HiDhRJ6EPJ+dYgHb1Tg3XY4hExYnWjv3tlyVUvMojWFmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488960; c=relaxed/simple;
	bh=DJ0PlTJbGgWZTdqu812uuC6VChqabX1+O3+A/5th420=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gW5liHpru1LBeoGTO1CB3aN5yfBDC3RszW80fTar1f06S4VnZWn7NENp1RwTorh3AjsNBWrwtDYK3cMaQFwdEbu3eu9T4OZcM8+kyciv6uQKjTu6T8Xb2kpzSRKcsy1YqauYpezGz4k1riZ/JLrKwRVlx0yszRDPoYFrIgAN3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lf2896zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F536C4CEE7;
	Sun, 26 Oct 2025 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488959;
	bh=DJ0PlTJbGgWZTdqu812uuC6VChqabX1+O3+A/5th420=;
	h=Subject:To:Cc:From:Date:From;
	b=lf2896zWnKIy8E3wP4EMCiLF5oo+LefscIuTjxWjgkG1AK2KIdcYhImbGZO/n6VSG
	 gbEtZQuAMb2lIHcu0EIPk7lzxurzyYeVCqyxe1F42/gABgq5qsWlAlC9wFoqLZHbKk
	 cxiF5H1rt/WWc0MezX63ifJ3P9eFhy6ALsBNWEG8=
Subject: FAILED: patch "[PATCH] vsock: fix lock inversion in vsock_assign_transport()" failed to apply to 5.10-stable tree
To: sgarzare@redhat.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:29:16 +0100
Message-ID: <2025102616-navy-creatable-7fad@gregkh>
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
git cherry-pick -x f7c877e7535260cc7a21484c994e8ce7e8cb6780
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102616-navy-creatable-7fad@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7c877e7535260cc7a21484c994e8ce7e8cb6780 Mon Sep 17 00:00:00 2001
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Oct 2025 14:17:18 +0200
Subject: [PATCH] vsock: fix lock inversion in vsock_assign_transport()

Syzbot reported a potential lock inversion deadlock between
vsock_register_mutex and sk_lock-AF_VSOCK when vsock_linger() is called.

The issue was introduced by commit 687aa0c5581b ("vsock: Fix
transport_* TOCTOU") which added vsock_register_mutex locking in
vsock_assign_transport() around the transport->release() call, that can
call vsock_linger(). vsock_assign_transport() can be called with sk_lock
held. vsock_linger() calls sk_wait_event() that temporarily releases and
re-acquires sk_lock. During this window, if another thread hold
vsock_register_mutex while trying to acquire sk_lock, a circular
dependency is created.

Fix this by releasing vsock_register_mutex before calling
transport->release() and vsock_deassign_transport(). This is safe
because we don't need to hold vsock_register_mutex while releasing the
old transport, and we ensure the new transport won't disappear by
obtaining a module reference first via try_module_get().

Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Tested-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Fixes: 687aa0c5581b ("vsock: Fix transport_* TOCTOU")
Cc: mhal@rbox.co
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20251021121718.137668-1-sgarzare@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..76763247a377 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,12 +487,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport && vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -512,20 +526,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {


