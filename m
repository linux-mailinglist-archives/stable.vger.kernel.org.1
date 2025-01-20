Return-Path: <stable+bounces-109523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C4A16D8A
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C6218813B4
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8F1E1A3E;
	Mon, 20 Jan 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VqPBNqel"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D01E1A1F
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380416; cv=none; b=REcoFNf7LIBlow43LIpnIS71aoNt/hwsBtQZCAk9WjgYecEuIfNhH1aqtjzipoOXnGySPC7nS9eqx5oNuoBdmJUFNlWgPSEDXrh1QHNIaBCTC8Us+MdyZf+EbZxmFWC5u5fPGGtquUoy3JJEeEAOSxlRRutpuU83jn9nw+qnw+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380416; c=relaxed/simple;
	bh=33UeKWhtVB9WmGBEsjt1qkX6U+ZNjJobuZ2WmY6seEs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kNyGPkmbNAhh41NeCdcx6SG9mtaVE4iK5chOC4NHzKbRUKtwrKNKAl7iPim5atCYQbsyex4OF6myepqDLFA6cMKqHsd93psAlT3cQ5Pxa9yJ9czxXb3DoO4z1Fj0zDCzdHjjItKTx6OSi9NQ+K6OrPx9ayvxlE6yCJvr9HAb8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqPBNqel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB17C4CEDD;
	Mon, 20 Jan 2025 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737380416;
	bh=33UeKWhtVB9WmGBEsjt1qkX6U+ZNjJobuZ2WmY6seEs=;
	h=Subject:To:Cc:From:Date:From;
	b=VqPBNqel962GzgxodTaiVdNKRWP9J+GgLukVxbpbsbpwftfcbwyitjAkpyTGU2lLe
	 En8xusGeZOqnY2YotraDgXjgKQ/xb43o9TBPg5Hzv4yObnx3dvYDOqU9efclNo0ROu
	 qK7ccD0u8ruUqYWeApZp/Lo+TDdklQtzhQh6+y4Y=
Subject: FAILED: patch "[PATCH] vsock/virtio: discard packets if the transport changes" failed to apply to 5.10-stable tree
To: sgarzare@redhat.com,pabeni@redhat.com,qwerty@theori.io,v4bel@theori.io
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:40:05 +0100
Message-ID: <2025012005-supervise-armband-ab52@gregkh>
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
git cherry-pick -x 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012005-supervise-armband-ab52@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1 Mon Sep 17 00:00:00 2001
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 10 Jan 2025 09:35:07 +0100
Subject: [PATCH] vsock/virtio: discard packets if the transport changes

If the socket has been de-assigned or assigned to another transport,
we must discard any packets received because they are not expected
and would cause issues when we access vsk->transport.

A possible scenario is described by Hyunwoo Kim in the attached link,
where after a first connect() interrupted by a signal, and a second
connect() failed, we can find `vsk->transport` at NULL, leading to a
NULL pointer dereference.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Reported-by: Wongi Lee <qwerty@theori.io>
Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..51a494b69be8 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed before lock_sock */
-	if (sock_flag(sk, SOCK_DONE)) {
+	/* Check if sk has been closed or assigned to another transport before
+	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);


