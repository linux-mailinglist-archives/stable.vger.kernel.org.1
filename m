Return-Path: <stable+bounces-109522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CB6A16D89
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2ED3A1E29
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C71E1C16;
	Mon, 20 Jan 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Na/GC0F7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92291E1A3E
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380407; cv=none; b=h36TBaaf8yzkIL7giChldeqWe/8+XGM2dN3W4N7sCQwqPCk+9kgUX/Lue8hCz9hG2hENgfFLYGgJq22a2dQkV8Doil2++12/yD9eXnfo+Mw7b1caVWymUixzS8w8NIIcR0JGIowZZ7Ye1D3/XeCgeZSWc8onWQiJPlWpN9xwIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380407; c=relaxed/simple;
	bh=uY06+sadiRSMdHoHcux6TXfbd9SI64Lu4BieiFIxWV0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KTe4T3vVgUc4a7UdZGqckFCrukSiivRtWkfWJlZqV1xymuCL9BvwVvKTJkfyCvfblg08pohuaBJl5BudCzAhT/PBzLaea2fEFYesgOuvvgr1qyPq1+LNFGWKIbv+xm+qxhBJkzzGyfmLcyp4/uoft6/D4QPUkqyqFBX8I5nQ/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Na/GC0F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61D2C4CEDD;
	Mon, 20 Jan 2025 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737380407;
	bh=uY06+sadiRSMdHoHcux6TXfbd9SI64Lu4BieiFIxWV0=;
	h=Subject:To:Cc:From:Date:From;
	b=Na/GC0F7KCkmdpngiG33Ah4mY5RCWwjyypRUkMTJV114B9iEm1f5ejN6BNF+ZDt94
	 cpV95yKyjBimCyo2qX1Al7kmg4oPo5zoBzVZw8kiGTws4AQpQYPAVh4ZJijGiafcOm
	 e6DQerXtNdTY35n7xkGOR05EwxLrK8glrZPYqAWQ=
Subject: FAILED: patch "[PATCH] vsock/virtio: discard packets if the transport changes" failed to apply to 5.15-stable tree
To: sgarzare@redhat.com,pabeni@redhat.com,qwerty@theori.io,v4bel@theori.io
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:40:04 +0100
Message-ID: <2025012004-rise-cavity-58aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012004-rise-cavity-58aa@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


