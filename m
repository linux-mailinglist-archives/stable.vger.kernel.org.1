Return-Path: <stable+bounces-36025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E1C899558
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30CAB2355B
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88581749A;
	Fri,  5 Apr 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwuEdO0G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93B1370
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298659; cv=none; b=DWnNgEU9BL3awrwmO+fL9XOqDR7RzpEEiXOH7r0l2KJ+0Y99uob0mHbaB8ETZPa5nfP2aR6mN7cxRRQi9GQC9Joqwc1oUNqsTFpkiOG5+j8mZPSg+wQpJmjSoT8GJO4uaqFVZXwdAxzvLz7byXHyc/uUloph+0nVtDveAk0jXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298659; c=relaxed/simple;
	bh=alkjpBoBqayBJGQqu8ffHiOvxPYUer1YOIblaDmKT6w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NZVnuT4b2zJsnzR8V4NjnVTHemsmUnIHoh2C7dfIdqCLd6N3vmxd896NBB4KhdM9E0ZfdbnBikQz7Le4YlB8vOAPEJ02zi8PleaImLyOaNluo48v0uNYRd9pnQncEvhPTGBtveboZG+9FzsOPDnDueJcSFw2bxDwWqHXjCHuOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JwuEdO0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5930EC433F1;
	Fri,  5 Apr 2024 06:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298658;
	bh=alkjpBoBqayBJGQqu8ffHiOvxPYUer1YOIblaDmKT6w=;
	h=Subject:To:Cc:From:Date:From;
	b=JwuEdO0GVsn9sjV2fjBSPAVQDB1TmsbtD/LoOA2rLlpOtq5VRRQreFnPwXqoTbjpE
	 0BZLWvo1Mn7dVNdjCRusJJV/cIbWmxcmpkUzhtKgfGayvRVjtm3X2lLWKyIUvTpBWH
	 Nr1KzgrG9m49UQorPbTqHB4HWaJUcOW59iXgtB2Y=
Subject: FAILED: patch "[PATCH] vsock/virtio: fix packet delivery to tap device" failed to apply to 5.15-stable tree
To: marco.pinn95@gmail.com,kuba@kernel.org,sgarzare@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:30:55 +0200
Message-ID: <2024040555-recess-lividly-5b7f@gregkh>
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
git cherry-pick -x b32a09ea7c38849ff925489a6bf5bd8914bc45df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040555-recess-lividly-5b7f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b32a09ea7c38849ff925489a6bf5bd8914bc45df Mon Sep 17 00:00:00 2001
From: Marco Pinna <marco.pinn95@gmail.com>
Date: Fri, 29 Mar 2024 17:12:59 +0100
Subject: [PATCH] vsock/virtio: fix packet delivery to tap device

Commit 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks") added
virtio_transport_deliver_tap_pkt() for handing packets to the
vsockmon device. However, in virtio_transport_send_pkt_work(),
the function is called before actually sending the packet (i.e.
before placing it in the virtqueue with virtqueue_add_sgs() and checking
whether it returned successfully).
Queuing the packet in the virtqueue can fail even multiple times.
However, in virtio_transport_deliver_tap_pkt() we deliver the packet
to the monitoring tap interface only the first time we call it.
This certainly avoids seeing the same packet replicated multiple times
in the monitoring interface, but it can show the packet sent with the
wrong timestamp or even before we succeed to queue it in the virtqueue.

Move virtio_transport_deliver_tap_pkt() after calling virtqueue_add_sgs()
and making sure it returned successfully.

Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
Cc: stable@vge.kernel.org
Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20240329161259.411751-1-marco.pinn95@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 1748268e0694..ee5d306a96d0 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -120,7 +120,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 		if (!skb)
 			break;
 
-		virtio_transport_deliver_tap_pkt(skb);
 		reply = virtio_vsock_skb_reply(skb);
 		sgs = vsock->out_sgs;
 		sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
@@ -170,6 +169,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 			break;
 		}
 
+		virtio_transport_deliver_tap_pkt(skb);
+
 		if (reply) {
 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
 			int val;


