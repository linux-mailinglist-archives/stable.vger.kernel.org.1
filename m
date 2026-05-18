Return-Path: <stable+bounces-249232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PjVOEXYCmrb8gQAu9opvQ
	(envelope-from <stable+bounces-249232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:13:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E67956974E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4D1D307CD89
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E13E51C7;
	Mon, 18 May 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwq/nw5X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6888Ohs"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926C3E5ED0
	for <stable@vger.kernel.org>; Mon, 18 May 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095228; cv=none; b=p5T3WW1vbI2W0SESRGqX1g/9YNyPndVgkfWkgr+lWk6IRXb0/PVJ0CzVqnti4bWAfSHo7PHHg+6FEQ80hQ8hpve1eTv2npmfjQ+Kf8HCYIHHPM0wyxbk/vus4u7V+7WO4nGrpffDbwfWfv5f0w8YW2kATp8X3Q+HNErW6+Daev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095228; c=relaxed/simple;
	bh=uQ6Wln7pJey/LF1d0dz2kzM3P6XyAQup1rTFP8pIs04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYdEBxWfbZLRldPxsBPMAv1DF53iyRfA3XbCiopsRqlTigeBqtp/WiA5hotTFRNpcyUccTQ0TgNz/Dd9sLhwLE+Ydxj1XDBEAjpDOpMa0dc4sZ4/ZLJM2j2rP7PW6ttrqikvXi8O9VKysFGVLgSHt0tjhHU0vLFo3++K7rkI8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rwq/nw5X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6888Ohs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
	b=Rwq/nw5XuznlzFJJ9HBTXwKl94hKCpkcUNwDl/VKD/AyZ3Ef+mY8SwWH0dxeVgy7/AqKNA
	ILXT5J+feyftvaN+gx2D3bzwuTKjWQrsM3m0IFk2ETctth4BCUnoBpCKsrDfkMa0HeXQ5t
	ojgRpzCZYZBfmDIQj8rbmYdtZDiWFRI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-7QT48jHGMDuFD-NAWze0mA-1; Mon, 18 May 2026 05:07:05 -0400
X-MC-Unique: 7QT48jHGMDuFD-NAWze0mA-1
X-Mimecast-MFC-AGG-ID: 7QT48jHGMDuFD-NAWze0mA_1779095224
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d789cebcfso2054010f8f.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095224; x=1779700024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
        b=S6888OhsGUJrpUapZHoe8wg1D12MJ6Z1NYXzeXUUO8b0icS0Ieaf0khOTB42Ka6b64
         rGzI5WyAHJusNVZMEDEv1Y1l68BFh5EgxaqFuAzM9w7W8rFk5p1qwoXk5tyTCnBF3Wtw
         Q9TU2ROluUhopKxci8X0cXmGif/+zMxqbWhHj+UgxjacCFQwr6iY8G7KrcVFr7mCGQmP
         8cQqJvHMIEJxRN4JvZGZJIexyN9EbAF06C25NeRXa8++U08ipne/syIdg4VKuwfT2Kok
         B9qTVlXtqfxEq7qZvLRegwM9llVh7KQ759O/eIoMvuFWTySy+CfcBx/yRA0WNhQXZyRD
         Zp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095224; x=1779700024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
        b=LOCrxQlupfzA0grgg/ta7sFzxejhYqdhfztK/uLercpNNyCc7uwjOJE1UYm1RjUEHc
         yqsgG01hPSVhOb79/NnsZ0uIzjjJ0zPyHMRT9Z3JXDIiHlHSzK0KATDuIEvLX7chPrWy
         hAenZFfki4oOtJHteDd4wzxlrCXOKeDnHgoLolzNvOUHxHLvKTqHcXmm7j2ORmpoy0C/
         KGozFQ4RtEcUizccnS7sSm2O3uYkkg8LbwH/DjRRLLTvsBw77qIbiga8ArzmQVYVbpkm
         gMx1dfM3v7Hoa0CrLf95Tlp+CPSEmxIIxf70AT9ot9wNfqPgx15PiMtblcK9nCJG6VtL
         5nbw==
X-Forwarded-Encrypted: i=1; AFNElJ8Jwg391hZqZmLi88qlyZOzViMBYE5BYh3HAwQW7umevIt2BVkYauipQ6NYxV/IHRROy3pn+Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFXSuu1Y9zugNoRHpWs+m/CuwjXa98M/gf6IXhiEjpzdFq4xC
	SXN7zYueGrKmfwzjJZzonCYUNqpeHv6KFuDfvZK2UUj0UWyUeYZI5ltQ0Ui0UIveU9u8gXfDd/d
	XfhFlXZT5UpKF6VYnS1nQ/vUWazUCL0+8lfa9ZyMYFImTvAhssnd7T5JVOA==
X-Gm-Gg: Acq92OH4NlHV2H/SIT+fNZ8MgxEursehWVeVCptFbx6hmooSylrau406YKX/WS1X6RO
	Rb/xnLFLubVESCRXKslENhbHvPcHARQI4lp8EhMb6YfE5ffQjNc/TQRtttUUyoG1iK/Z+FdiKsK
	lIiVNFIvIv1z5GBeK6UfwpelLu6YIiWPVRmbxnmlMJq86Y/J6NQ6ddkBNFa/I56jI4hXOep55zk
	R6SLBCqh0ZxQPypdrLUdrmfLKX5xrVbSDwaii1/ygVHr0HgyfKzi+K/YXhdU18FUepSa34AQF4A
	85yMjVsuTRmMo+OE2lGH+JQJrxSt9Sm/fAqFlPRcloilwYejKp2AVf40xDV18Yg7+w5uM/Dcg2n
	neBf+Eg/OLoIx2+0Yd2l//NPPXFBx5io1WQr7c7ofK9Ci8IMEjMyDntAodojB
X-Received: by 2002:a05:600c:1515:b0:48f:fe2a:107a with SMTP id 5b1f17b1804b1-48ffe2a10b7mr66193285e9.3.1779095223695;
        Mon, 18 May 2026 02:07:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1515:b0:48f:fe2a:107a with SMTP id 5b1f17b1804b1-48ffe2a10b7mr66192625e9.3.1779095223029;
        Mon, 18 May 2026 02:07:03 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b60csm105880345e9.6.2026.05.18.02.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:07:02 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] vsock/virtio: reset connection on receiving queue overflow
Date: Mon, 18 May 2026 11:06:55 +0200
Message-ID: <20260518090656.134588-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E67956974E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249232-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

When there is no more space to queue an incoming packet, the packet is
silently dropped. This causes data loss without any notification to
either peer, since there is no retransmission.

Under normal circumstances, this should never happen. However, it could
happen if the other peer doesn't respect the credit, or if the skb
overhead, which we recently began to take into account with commit
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
is too high.

Fix this by resetting the connection and setting the local socket error
to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
packet, so both peers are explicitly notified of the failure rather than
silently losing data.

Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e3409d28164..5028ff534888 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1335,7 +1335,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1350,10 +1350,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1393,6 +1391,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1405,7 +1405,17 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			virtio_transport_do_close(vsk, true);
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			vsock_remove_sock(vsk);
+			break;
+		}
 		vsock_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.54.0


