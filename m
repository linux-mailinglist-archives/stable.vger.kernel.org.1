Return-Path: <stable+bounces-179641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1487DB58182
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 18:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D857AAFF5
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73002258CED;
	Mon, 15 Sep 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlZlogdL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB01D5CC7
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952213; cv=none; b=ILCTiulLUA1hGymNsDO3nxUIpgmjZ2qO35LmuqG5mhD7mHGTrwb30JxDTRWtKT8kcEY6BsW2zQCf0mLo3O4IMThHgtT3unS0+a8zKWIhIIQOG1TwgHYZuBbqQSv0G1rn+rOEqfDjOgGzhkgZM2XPK/ilsb5sc+KQxQfQxEiRKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952213; c=relaxed/simple;
	bh=Td5X+XiMVh4U7xnk374qdTWdLYQJomqL2LvZMLkRmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNpwoQ1XGFt29wYnFfYIYYwfRtG4K2KGQWMBbcLgTrOpM7+ZFN2OoG/xFXpNncPdI1anGRFYjzWx1Tu5z5I7w935prWLWtrrh8mE+Dyr9yv7a+27dnC7nAjSWIYQ0JCK84+40eyr1il1e0hFNpF8CFmd0O2SSSBDWo7/+rzarsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlZlogdL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SwVQfN4OpfJrsdY2VoqmkkTVqEBYDZduzuqg8McG+qs=;
	b=MlZlogdLnDsle4QwgopMYv7FZVTy1FMme9RoxJsSeyQdLXXlIyE2bZ8odej87BIhUheKH+
	KNUIiBXhI31Oy0PvUfHwbuKuFrhQF7WevgcmDIhXVo1HxtQgbHxV630v5AFQSHPFSNS56+
	ZmjJsILTrRjBJfK/1yzdgS4vB60b+Ho=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-VaFDiOYnO_2H0TpB5BR6PQ-1; Mon, 15 Sep 2025 12:03:29 -0400
X-MC-Unique: VaFDiOYnO_2H0TpB5BR6PQ-1
X-Mimecast-MFC-AGG-ID: VaFDiOYnO_2H0TpB5BR6PQ_1757952208
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b07c2924d53so241952766b.3
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 09:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952208; x=1758557008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwVQfN4OpfJrsdY2VoqmkkTVqEBYDZduzuqg8McG+qs=;
        b=lHCFKEGdvuG5UqfEt4TyUfZQL0+pWLbCeYy8z7kQtiV70xTVBae46cDE+zK4SDhn/W
         asdX9HjiMN6TnGUCPDDNhgO0yIQb0Wn66Dp+8pf9m0pBPVoq+2zxtU1ErckwOYcadd8R
         U3H9qSvdPnB1klLgKrY8rOmaaQ6sePy5yIi/ncZV9+5BPdMxn+P7fPyNK5e50/RBZSrZ
         /+DcvGUbCH5vSIQ8UHvS4SSuZhaW4cJ2TRjcbUhq+tAvT5joeW/IyQJ4F5nhOEOQSRaM
         id7pTmiGYOQuXkcoTVVuxObesgIjgwJa6v+cV/sBKGwIGJwM8cCr3ayXA/Czzrnt9XtN
         VwFg==
X-Forwarded-Encrypted: i=1; AJvYcCUdNkzAyEjrvUkaSP9niFDBwSjbcM1Gronl3m+29usAt18XpOyrS7kr37l6KO3+YDOqEsQEYBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvzuIUHI7v1fjfwFLpj2btgQsKtpItmGY+Z9C3QAWoN5IvR08
	JKVHepBGcH3FO85/JBPD45lXfo6qLikaVJNniJraDmgsHePUmDIBMjnlbdaBvn4sqNQ9t806y0W
	7KTDqXZAsVwLn8Hqkv1SF82QFw0jns84ethMCG011+8aPFSo0MQcbbS8S8Q==
X-Gm-Gg: ASbGncsYgQxs0b2oQHWXGdi3gjBHSnQefGBgvkiSUVf56fyZydQLAqpFAnsoprF1r1L
	r+ZVy9B92ekfrdkysW9kY769EiCIRFzCRKoCqjThXkzxnF6tUbuWZQd/ZpmpjsTxIPzlm7sOdhW
	eXgv5p/X3KJq3+xOdg1IqirdHtRu+OrrVUHKT1/vYgAvgeeBe6CkrtdLbxxfsD4EGbA+8GgqtoE
	Y3oYVeLFkXoo/+bMqxSxVRLt5tAZWV007ZjqbxxFKGRZsllI3pUAUB/f/O4v6SOiJZXAabnnmdb
	XWR4ioSv52utd3QPUaWBrRdXJXPU
X-Received: by 2002:a17:907:2d91:b0:b04:2252:7cb1 with SMTP id a640c23a62f3a-b07c353f091mr1403697066b.12.1757952207946;
        Mon, 15 Sep 2025 09:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHflQiZxxzDRLnw+SKuDwn0eon4gL/iAAz/hcWcH2BNBputbB1OvgE3pkj1W+m1ugIR7po3zQ==
X-Received: by 2002:a17:907:2d91:b0:b04:2252:7cb1 with SMTP id a640c23a62f3a-b07c353f091mr1403693066b.12.1757952207517;
        Mon, 15 Sep 2025 09:03:27 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f20dcsm963017266b.90.2025.09.15.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:27 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 2/3] Revert "vhost/net: Defer TX queue re-enable until
 after sendmsg"
Message-ID: <45c47a7a1c4790275763b2147c220923b9e59aba.1757952021.git.mst@redhat.com>
References: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
sendmsg") tries to defer the notification enabling by moving the logic
out of the loop after the vhost_tx_batch() when nothing new is
spotted. This will bring side effects as the new logic would be reused
for several other error conditions.

One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
might return -EAGAIN and exit the loop and see there's still available
buffers, so it will queue the tx work again until userspace feed the
IOTLB entry correctly. This will slowdown the tx processing and
trigger the TX watchdog in the guest as reported in
https://lkml.org/lkml/2025/9/10/1596.

To fix, revert the change. A follow up patch will being the performance
back in a safe way.

Link: https://lkml.org/lkml/2025/9/10/1596.
Reported-by: Jon Kohler <jon@nutanix.com>
Cc: stable@vger.kernel.org
Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 16e39f3ab956..57efd5c55f89 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 	int err;
 	int sent_pkts = 0;
 	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
-	bool busyloop_intr;
 	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
 
 	do {
-		busyloop_intr = false;
+		bool busyloop_intr = false;
+
 		if (nvq->done_idx == VHOST_NET_BATCH)
 			vhost_tx_batch(net, nvq, sock, &msg);
 
@@ -780,10 +780,13 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			break;
 		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (head == vq->num) {
-			/* Kicks are disabled at this point, break loop and
-			 * process any remaining batched packets. Queue will
-			 * be re-enabled afterwards.
-			 */
+			if (unlikely(busyloop_intr)) {
+				vhost_poll_queue(&vq->poll);
+			} else if (unlikely(vhost_enable_notify(&net->dev,
+								vq))) {
+				vhost_disable_notify(&net->dev, vq);
+				continue;
+			}
 			break;
 		}
 
@@ -839,22 +842,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		++nvq->done_idx;
 	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
 
-	/* Kicks are still disabled, dispatch any remaining batched msgs. */
 	vhost_tx_batch(net, nvq, sock, &msg);
-
-	if (unlikely(busyloop_intr))
-		/* If interrupted while doing busy polling, requeue the
-		 * handler to be fair handle_rx as well as other tasks
-		 * waiting on cpu.
-		 */
-		vhost_poll_queue(&vq->poll);
-	else
-		/* All of our work has been completed; however, before
-		 * leaving the TX handler, do one last check for work,
-		 * and requeue handler if necessary. If there is no work,
-		 * queue will be reenabled.
-		 */
-		vhost_net_busy_poll_try_queue(net, vq);
 }
 
 static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
-- 
MST


