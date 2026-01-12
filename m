Return-Path: <stable+bounces-208040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AD4D10B78
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 07:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2337130AC77C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 06:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED4D30FC38;
	Mon, 12 Jan 2026 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ThAgV2pu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5F30FC06
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199649; cv=none; b=J1nSotSMYwyy/1EhHZR3DcccQ2u0NPdrpY65xSWeNd8cQ5P3PFUBBRCGLEobxU/Qrzr2UEs7GEOJQmGxDhv4lVI/oKawjSuA2Mtnd8HPpbrsLbe7GAXkKvDroZD/nEfW6Vah5EDWpqXswXZ4eEWlXdPVJ6uZFsbHkRBeJ7fbYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199649; c=relaxed/simple;
	bh=QgXU/7yNwhrctzlcitKYbDUmDIC7I+TCoOtStmFwLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+2FoCXM6tJywn6Sl1sb9uPo+fqTUfEkX7mkBXzB1ja/afJ5soJKC5gr8Fa7Vy016dGP21uh9KHmQvNnY+8CSTqPq86JDisVOD53X5B6dp290KdJG1Qj59ue+tQlGb6PpB3XoVh5BIyVkaugrw28brMigv+/7fSDLoF11kCVl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ThAgV2pu; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8c35dfee1caso77891085a.1
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199641; x=1768804441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=IYQMLjERiArwBs3M3zjgqDxAvWaFNd65/u3O7faoocRJAwJ88ZI+rrRCTn1rxmYkyJ
         PLVY4Am79fXjuMN4YUfVInZ2SRdPLKDbs91mkr8oS+31a0t/QSlFkWNHwPlrnLAIY6dH
         olUZyVsMAOUPdRSQvYl1tHAeh/CIUHL8kXl2UiuRSoZVfP4QSzZ9ehGDZysHwO/138wl
         MFHBYfW5I/EIEobkJIlHgLu3VObtSVuHds4JGfaSuI3iV3qKJ/nNCXFDJN81dypBbEe+
         WQ4bxb6liPMEPWSdXFgoSwVrPXCfmm7T99wEvbvc2y7HpUL46vghefPvxR/0nFzTUuYp
         Ev2w==
X-Gm-Message-State: AOJu0Yz+LVoH8kQhr6gmIY76uWYCfTbGzaqCZnvbxV3mWKDFMm55y1eq
	DhnyB9aPl1Gml7Bt2Btlo6pJsz6u6q7Rxs/FbVluLFg/Nc1uOm3oCueQMYn4wJRApohOKxCCUxM
	euw0IXM7gpKXf3XmXHLIrssTz4KDs3DyFBL3JmwbCwbepIi5D4nGHltXStty+VOM0jFxxYd6uxy
	p0U0KoxsHZ0BmCfVfr6i5IqcsviGixfcy759bpBLhHz3+9fQKD9MKOG+2i9D6HYhvIGU03WRV5C
	0Ubgw1khCSSqwxfIq+0ZGznws/WiYU=
X-Gm-Gg: AY/fxX6b1LlHj5KX/1fyX0uk3s/iqIVytqCg104xbkZ/ROvb/n+3+4DAe2FKo57vgNx
	4T5DYofD1Em8GuMxSXCml8ehP4gzS2TbEqTYZTmswjHY/xUXbQcJaeJ2/c7dk7EooMShQ01iSTy
	Gl5y6947T5inDWIxHo4zMIMz9OSPSiZ/G5bbJYUflv25xJzpTt7uc2R29s3YJxE88D9Yo0a85ZS
	efHMxhQa55dvB/oEfsvLTeIHxHX62+IvqXirnhjc35XdTIu3ZiHZOOYD3hDNLyOzq6QHzKGZzCD
	C6T/hq29iEBijDI1jLWNtuqxvZY6KyX1Kggksaw3gqXZsqOzp93RFYwuO6gpw7U6xCF+EpIl6Bi
	rHjiwpHW2wkj2iWfyI8NtVpXh70ZZZuj4H7uTFuQJWUESm4pVosPzROulfypqiKas08rdPRDc74
	QgT7K539HP6sCU5iSGbqfcZZD8jRNCKarDby5h1+Xe9QPLHrNgoTHHIsvNNKs=
X-Google-Smtp-Source: AGHT+IGntI4zSNDP7hZwe4CqbdcTp2WjrBLZK58Mx9c1VfPr2xvEZQwt27oBbBjyaivmpBa4kxzI6UHY7XB8
X-Received: by 2002:a05:6214:27ec:b0:88f:ca7a:6c3a with SMTP id 6a1803df08f44-890840b7d83mr180402086d6.0.1768199640762;
        Sun, 11 Jan 2026 22:34:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89077179352sm22061336d6.32.2026.01.11.22.34.00
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:34:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b222111167so119510285a.1
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199640; x=1768804440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=ThAgV2pubm4Q7pp3q9FJDD2nM3KMDZhJFl7CqmIgihg7TH+444o1HybUOpKBLqZD3+
         nL4uRVC4EoCVe1XcLuoRra1iGqciBAevz393+GAUWs9RYsK9Ssik64JOSGZmwHv1o8nU
         VeV83qVSIoBKyUDZfMlbbWO+AF0+L9W9fKRuE=
X-Received: by 2002:ad4:5c48:0:b0:880:52f6:775e with SMTP id 6a1803df08f44-89084275c91mr188503876d6.6.1768199639798;
        Sun, 11 Jan 2026 22:33:59 -0800 (PST)
X-Received: by 2002:ad4:5c48:0:b0:880:52f6:775e with SMTP id 6a1803df08f44-89084275c91mr188503536d6.6.1768199639235;
        Sun, 11 Jan 2026 22:33:59 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:58 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sashal@kernel.org,
	leitao@debian.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jramaseu@redhat.com,
	aviadye@mellanox.com,
	ilyal@mellanox.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 3/3] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:30:39 +0000
Message-ID: <20260112063039.2968980-4-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]

get_netdev_for_sock() is called during setsockopt(),
so not under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dst_dev_rcu().

Note that the only ->ndo_sk_get_lower_dev() user is
bond_sk_get_lower_dev(), which uses RCU.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20250916214758.650211-6-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 8e89ff403073..8cf4e1651b0c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -113,17 +113,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = dst->dev;
-		dev_hold(netdev);
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	if (likely(dev)) {
+		lowest_dev = netdev_sk_get_lowest_dev(dev, sk);
+		dev_hold(lowest_dev);
 	}
+	rcu_read_unlock();
 
-	dst_release(dst);
-
-	return netdev;
+	return lowest_dev;
 }
 
 static void destroy_record(struct tls_record_info *record)
-- 
2.43.7


