Return-Path: <stable+bounces-253520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIBSITABD2pfEAYAu9opvQ
	(envelope-from <stable+bounces-253520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:57:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2095F5A5402
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F4A93089A3D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3233E2741;
	Thu, 21 May 2026 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2J0VoIJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp0hxeWX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42FB3D6CAA
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367661; cv=none; b=Pq61e5JBI6MClULfps3tCQMBxYXfDPLjP+c5jwBxNaKGVRl9FltZxmu5ZIT6fFDr2IkAIdFjatLLt0nyWCwRo0mC+eT3dhjfKx0g6UNNMhbqbmuXa2WnQcXW/Z+WSFZA0uVwSwTmcwtJzCUyWZ5+JR8PlfF3BmGc8ajZ2gwfGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367661; c=relaxed/simple;
	bh=Dn6P2bkc/bzBUKXTydPjxy5n5j2Gvoyaa6sXWWpGFqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnZMr6vTcj4lmQrh7e3vZuD3CZT1isw4/DvaCV3JWvW7ICyumZHZWcsnrf4iQUAIxvWG3HOaZz5tXlo/yofeolk1UnqNfq/EamZ19cPHJRNUIdnx4NG6HZWTW4IbCdv6kuW3ZKRj4+E6SOyHkaNlg0FRIryc+vKytptqNbes7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2J0VoIJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp0hxeWX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779367658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
	b=J2J0VoIJovnvpXIfQz921eElWicFhuiIyDeFoc2IOxtcFBEgnpbhFEy02MekreI40niMxr
	+4n5CU98RioTcqgkt+OkGGCgBivDn+BHooZnZgjsig9tUnak10ELe/6FehqueTNTXAh/YO
	qTph5JP1FGsob325P4zZCCWlOU+PxlA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-RALcYGklOpGFfglVpEI6cQ-1; Thu, 21 May 2026 08:47:36 -0400
X-MC-Unique: RALcYGklOpGFfglVpEI6cQ-1
X-Mimecast-MFC-AGG-ID: RALcYGklOpGFfglVpEI6cQ_1779367656
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so3579238f8f.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779367656; x=1779972456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
        b=Xp0hxeWXTzkG+JHiiHIITTe2WKU43nP0bHUf05TxV1HgTZ6xQpVzHIoO1qlYNHdur9
         fQeWw0tV/vFZMHGFpadBy0tHwJ2LYbI4NCGFVKfmCCydVOGXqaWd7OMce8ymgTD1lPfV
         LTYAEEq6WkMFwCpZhK4KlRaM+Q1UmEH4XrWWo0qLwqLe6a1I7P9pekWJs/NkqTNmHikY
         u777LeE3eaYJjRIfG/bL7TjdsjjTk8mxkqEJS1MgTmvzdQplVQ0IPAnXwprE9PftTvgp
         ZfWh7fbnE7rJhqKcJvBL47iVTUSrTtzfKpve8p+Pws5oCE6j3pw0QJH1DrPl4z+uBTc0
         mYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367656; x=1779972456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
        b=Fi+4kAk4mC/FXCvBhAFhuFiUfl4EN+SOYHoBy7QQyBrMUBpeCzjH2Q/mbAGooQ1dRS
         o9E7ykNr2XBJmERpJZgAFnQ0emikEVg8kwfOR7Br9Cao7+uigWBa2qG7tUPrKMiVsRQu
         zYdPqZveqmvGTm7Jw66TnNS7JqzeawtEdIoCRbOjm6kEB8lFWEuTTJMM3GuWl27uVBIs
         Ane7loaZIfVVH1hoEw3gDZBDEto2QsjZbnTy1N1qghr19B4Bgy0ywIh//C+GCE3j1Qta
         KHDWwqvo6aWmq/Xd5rdFd3Psdq+1kltb3M3Y5snqLr/vqfUiLeBiVTYNh7f/kJpMcXAC
         COlA==
X-Forwarded-Encrypted: i=1; AFNElJ9igIjqRyPR/4Ixpx6YaPb7/Y3T0RL+7dRn6OY8Hfr5IFCw9hu4V7Yvv735Ty69nVkog4jyjv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8TdtNj5cKjPn6+AVdnSq2o7DPYQt8RRBIfhnXSwcwlrUhbRB
	DkRo/5X6r7OMOHXj3NLgL7wcp8x5MIkWn0ANK6xAQr0bJpBuY8yoe/HH7tGPSSFgQhBlRhX3il+
	UMXpLhV0kCglEqCh6RC1aWcwN2lo5sorhlrAZ8+bHRsJi6O2RVdjFpXw+RA==
X-Gm-Gg: Acq92OFLT089oA5wvH2mL9kNJLCiQjN7sRRY/UqDDYMqaLyfeMWs+zHm/6ORZD0Pp64
	lo3yQH2ydPFy19Kv2zEm1mkSPrXpVsBz1TN1AJFYbIG2eU1dVeoTuLWpjILzBfvfbq7mH7Ggo5F
	TVkQrX03ijyrXYzBDrvnSWI8j/FEOhSEs5cCsnVSqihYOcW2INh9h/SCctopRfMPCz/iXuQRS3J
	ZNKVsdiLCib9ZejI6wXJjz0dyhgUXvTve0bdhd6MePk1u+t0wCFuZhXVQg/sz5nNfF/AuNI8Ysm
	sHw8UyI1YyNwLBI9YGbCO31maWiY94w3A9DMUaNWtgMDyV3I6q/2mY1JM8Z66oqYbeJNnEh7Dpy
	5B1GyedrYNbTfyXJqBdOUgFvfJu3eYXQyhg3VO6bkQCUpFulrmVP5oG8wDg23DQb91OGDxwzIRi
	PhtCzyb/AFTZE=
X-Received: by 2002:a05:600c:3513:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490360cce5fmr38604405e9.29.1779367655700;
        Thu, 21 May 2026 05:47:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490360cce5fmr38603965e9.29.1779367655227;
        Thu, 21 May 2026 05:47:35 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d52c8bsm69391315e9.8.2026.05.21.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:47:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit builds
Date: Thu, 21 May 2026 14:47:32 +0200
Message-ID: <20260521124732.125771-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253520-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 2095F5A5402
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefano Garzarella <sgarzare@redhat.com>

On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
to 32-bit values. The multiplication can overflow before being assigned to
the u64 skb_overhead variable, making the skb overhead check ineffective.

Cast skb_queue_len() to u64 so the multiplication is always performed in
64-bit arithmetic.

This issue was reported by Sashiko while reviewing another patch.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Closes: https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index df3b418e0392..71198bf23fc4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
-- 
2.54.0


