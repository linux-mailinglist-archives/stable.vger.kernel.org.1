Return-Path: <stable+bounces-208048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88CD10C2F
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 07:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5246F3001625
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 06:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CC31A56B;
	Mon, 12 Jan 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PTEjG4FG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA733319873
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200771; cv=none; b=O8LudgEIH3uJMZv2lKp2xI9Q+F5JZMIB4fwIVgZNPfg3Qq3+iKA9vSWKPHGe4OmoVwGrTS+Dw8g+4jZZuvLc10d8oqeEC52brXatZiVINhEBiyBOBdo1dnDKkCVksNHKIto5LGtjn7m0ErUfms4fYFVdA+ARIMlbc5Rzi2lZmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200771; c=relaxed/simple;
	bh=pvMCEzJj4SGW1oTw7LLKdutJEZeqLk/uCFRUpyapQq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSZ8ck3BPENaeMK68b42l88tL82PU4Pjy1x3XextQURbxdgjzF1yMZ1SzRxrCjpB0gcKtVF60dYGqOIRzmaJyOnx4hwVffasm/UivTHsIlK8zhvTbF17HUrWvBIjhm64NgfAJWoZq5GlH9FAgSz/p/PO7E8j0/EETnvcEmVOPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PTEjG4FG; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a2bff5f774so18859315ad.2
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200770; x=1768805570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLfXk/1BlceWtah76vfkztbqcGBEs/TIQ6b4f9GZ4FY=;
        b=OAlblLzvnjNoojs8GEvnnMD17hy3433bcAzAJ2q/Uxkjpd8XmKvyrYTB+s7+/EFRAa
         d9v36zmmEpQy1I0j0S56G0u+dCxBEXNz6O+uYeNSNs1Dg9bPz0DwDTBBMFvghxzb0iBE
         Zynp9P9Mscz4X/4vX66BMclp4+p+TZy5hB9psPnzbgcLd5kN/GSaR5sw9+/MIX3V1QlD
         zyAa9nyG4itaTwRrFW+3YnKWXKKkPC205vbJdT/7B8ilr5VLcwVF6F+xYrfcxXMrObyK
         7Gu10EfhILx/826sJZSHlRpVtCD7xuS8h8kdty2fb1Mt6n8P83plnJyWEk08YIutSC1K
         g29g==
X-Gm-Message-State: AOJu0YwPLCkai5MTgsjoaU+UEjL0W2ih+CG6N5FAZDN+7KKeeRS4yuj9
	SCrFiOsZJpkzo1N4Hb3n/2CQcf/0elXh/0OBQZ0pFkXqDIR25d8QvnnwPVtY+S0DOx3YOdN+r06
	v2K/ZlZX7TS1dxPQEk31yphfAB0K4TTOWY6J1CI8eeIovQl6amxI4B0Bn7YRlij7eqHA2aBQxnl
	UTf9ie8yNAqUnvH68PhYpHpB2J2XxP9ARqUSTgJCFDbtQ7hdyXAfFAPRE9MEqn3hVSjd1rcXhCw
	79TL+UXTGvftZmREJ3B8LJ8sRijAAU=
X-Gm-Gg: AY/fxX6dvbpT451aYMMAt4S5H+RFynAiSvY9GQa7b/0GIdw6MwFlKFqlxZzNF4LLqw0
	68sw8mZiChVZ8a/1xbQ7hb0Tni6iAESw8CZnurTM5GQwOnzf9rDHOfYXM9JHbYEu5utyybY8w/f
	H8Kr2P4H6HdGZCpGSn1jlAvhQP1FhcumPBOggJIvzHV6ptwyJGAQUMsBpSCBB2EYxHruarXTVd8
	BXCDQV9W1b7NxabYxoJfDEvsicHmu0U7o1/8ygQot1bECd0R9d3gghtiCsh/qUBwDjVgvBJvbBd
	j0jNTR9dKqXJ+7AuyGFOtSWKxfmqjz+ofskbPtMfvtl7zN3bRMcTv9jZJJ83N5HgRZdp458MfDD
	qxLRBVVo8EDM8cQ1MTRfyRt3j/vgApe25DdmyAqjbgKs6NwoO2ba94EkAHAUDojAGbsnVuZ2rZ2
	SxP1OeNxKnhZqUDkJ7imuW4q8tteo7b7NOyoaSs1U+LIuuS7y+8vvJW/VLlSo=
X-Google-Smtp-Source: AGHT+IHvG6Oiab2bb9b4i05KnGXH5IP6yWt00NYqGqx6c1Mx/xPTrk7Z9erfSHtFdDmYBQI+R3cABCSW41kv
X-Received: by 2002:a17:903:90d:b0:29f:6ca:a35b with SMTP id d9443c01a7336-2a3ee425ac0mr131236495ad.1.1768200770102;
        Sun, 11 Jan 2026 22:52:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c49d39sm20416685ad.16.2026.01.11.22.52.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:52:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bbb6031cfdso203701385a.1
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768200768; x=1768805568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLfXk/1BlceWtah76vfkztbqcGBEs/TIQ6b4f9GZ4FY=;
        b=PTEjG4FGTFl9K/FTiSEh+uQk/LOyR7P3c2UCg09bzWy50kHT26bMkYHqupAWbRTY2s
         Q9sERmZl+3vO5RmtBnfT/Kxv7mVWzftvlDKuvRTFQHBuA1jJW/euaQr9U5xHFbG6HPho
         e6R3k2nXZhMEw5VxHOdxYy8cc2YP2Vf4uNLto=
X-Received: by 2002:a05:620a:2804:b0:8b2:f090:b165 with SMTP id af79cd13be357-8c389388a4emr1707614385a.4.1768200768245;
        Sun, 11 Jan 2026 22:52:48 -0800 (PST)
X-Received: by 2002:a05:620a:2804:b0:8b2:f090:b165 with SMTP id af79cd13be357-8c389388a4emr1707611785a.4.1768200767714;
        Sun, 11 Jan 2026 22:52:47 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6b4fsm1442738085a.2.2026.01.11.22.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:52:47 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v6.12.y] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:49:44 +0000
Message-ID: <20260112064944.2969750-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
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
[ Keerthana: Backport to v6.12.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 0af7b3c52..99d503e03 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -123,17 +123,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
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


