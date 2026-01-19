Return-Path: <stable+bounces-210336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E5D3A77A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F3D30CFAB5
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558FE318ED8;
	Mon, 19 Jan 2026 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F23Wo5fw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197263191D4
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823573; cv=none; b=LkHJi9CyY4jio3iRodmkZ13x40gSPKd9my6DvHUytLYlUzr3hp5nYtJVIdKxcFqzj0H1zaTQOu6PV67wQywJEG1SMgB7hG6DWIxpds8Ts52DR71aD38Y/RNVQjwygZAFFuv4GsREy6PjIMJNzvVn+jRsqBdVDM1krhNtyzOcuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823573; c=relaxed/simple;
	bh=XjmEkDhy70C9BPaUIKs8e1nglyFuMhkb7Yn1iqBTdVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1Pzs+BDXlxO+l1uY7z6HTdjDDTTOztOS/4XB/KeZwFaO6Nv8dH8bV4x+1n2Y7VOO8WU6Gg/EvbZK4OhDSGjINAdyPMKukfQz/ZhZq9sLiyPotYWk7sA9G2m/ruXCmx22m0VvatJdd2PESEKNzQbainMu5G1JRdrz0HjLDHhp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F23Wo5fw; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-29f3018dfc3so9092215ad.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823563; x=1769428363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=QD7vJCsq3iZIp1eEv1baJWx0yApgPIGzA8R4xmLA2cLptS3Z+sgHHKQXVDjAAn0SiE
         g77UeL5i+GWXkl0PlE+etTDSXUvOhqk4DoZzoX/G1LMnUnTlz2Z2xKrIVunNuw7GeGsE
         pMN7bHkHmso4k6AVzWcespRqEaNYxKf7A3VA9ogqQ24SIq+9TqiGu9evFABg9V00YjNV
         WnwR129Wif6A1PwFzmUBDk1dyKgjXCJrjafeXTuKBPTx4yE8V2egH6e4Gryt3ENMteqq
         hSdB080p2/YFnNy6j68lqUMfL0ZGjEfCmi7Y4RIjaZ/lBd3ZBc5ZBNn8F7XvC71tQ1A8
         zBEw==
X-Gm-Message-State: AOJu0YwuAkmHqEQSxDfjC9Xy9iTQflYLBlLwUquFSwR9LgQxW61Tn8em
	8rg6BezrVRRYuUyziO3ENyJZXYVe+410ZM43Hvt4guyhrW9J8V/xB97gxu01peL7O1wFaY/pd3m
	Fmsq3dd3MemewUDI2Ly9tYBeSbx2qnzkGv99+wD1VKvwDd75oG0fKFITNs9MFgpsQcwuogLncUF
	nMqSHIvhLx5Vdlj0exRBkAmkPc+U5lUWQd9V/i+zLImhKAYNofxRNL0Uf1mP/LwK5i/AQGxnnxQ
	gdc+3DNT7PZUPQPRmDQXoZe9WDvAuM=
X-Gm-Gg: AZuq6aI0sbX1KKUpYW7/VaHG2GZ1I/fOoESmNCklhwW1HRPkgpq6rjQc4Avy4XsG7CJ
	93nXYD/C/N6vf9uFvOhBwLbIJMdoq8altruELoEolRFlT41JCk5/gAlgOTrpIss2ao2Ctnc1o3/
	/UKF0bfHJTtJIb12RZF8OyWVElfCoO1M/1pZ3rWepHwtMlt1mhqDIybIOeNqFR3FfR4ICJaQBy7
	eCS9LIBymBOSMSWuphNuxrzTLUrWzmkVt1ZVZk0i6AeKcBUCK1ZRh3U0yBEWj9oFPALbVWgyIWq
	f3sqGwntHn/NUr4LbiHwbrjbPTalhjODXj7nahLu0lGYt2wn9n6OVsSJWc+ADX+uiTfql6/4qnF
	KaG4dcplUHCxo9jIyV1L6ht6QmFX9ALcZ9uAPAWd3nmXmuamHJTLC5Tdi2ftO09pK6/TSREr/Er
	KEnYfOImVNDbHQSOrjsRtF+pF/6HzSsShr5AlhyR7E1rblYucEfH3ELtz4e4hw5Q==
X-Received: by 2002:a17:903:2287:b0:2a0:9424:7dc7 with SMTP id d9443c01a7336-2a7175c6815mr74611535ad.4.1768823563463;
        Mon, 19 Jan 2026 03:52:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7193999b3sm14928135ad.43.2026.01.19.03.52.43
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:52:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c532029e50so150621185a.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823562; x=1769428362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=F23Wo5fwQvVFRkHhHhqcR9lpNJ6LF7PVZdTf/zH3ptgW5YVd6leI4om435lU4ELIdJ
         lazrLlWh3eyOPOy3JU0J5PevpR5f/HBipLDIARwNQSKLi2edMrSgvmjdPc7Wddpc4fNC
         S1U+5QiGeyxjqYcJulwxt1bv7VRqYvEi3zsps=
X-Received: by 2002:a05:620a:2a05:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c6a67bc788mr1083870785a.9.1768823561644;
        Mon, 19 Jan 2026 03:52:41 -0800 (PST)
X-Received: by 2002:a05:620a:2a05:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c6a67bc788mr1083863185a.9.1768823559509;
        Mon, 19 Jan 2026 03:52:39 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71bf2b0sm772878885a.12.2026.01.19.03.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:52:38 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 19 Jan 2026 11:49:10 +0000
Message-ID: <20260119114910.1414976-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
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
[ Keerthana: Backport to v5.15-v6.1 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index c51377a15..e79bce6db 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -125,17 +125,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
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


