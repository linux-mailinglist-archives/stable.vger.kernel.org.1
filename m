Return-Path: <stable+bounces-210291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A499CD3A307
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C148300559B
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DB35505D;
	Mon, 19 Jan 2026 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LSBP/iXd"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1B3557F1
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814990; cv=none; b=PAN/HCYZJ29K+ejdzCoyoGc+LKDXUvfE/W+LFFMMRgK22uTaqepxrp3Qmtk7PjP+uqnuimMMxXiKfLB+LaJCL1Ktdw/mKEbV1GdxiHx8FLZjX7Uxwu8SG5psBpwvn3ZaVwFAHogMADSJGoqIqkTPXwBxyAqVkvCbhX1YRQTLi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814990; c=relaxed/simple;
	bh=QgXU/7yNwhrctzlcitKYbDUmDIC7I+TCoOtStmFwLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSr3H4Co4UdvfpFsgRa/CszYohNtot0fdswCxsq2LeTVhnz7WVZC9bZCg/QYEsWdsHZmWqRP6bD3AWIzDoeUIL7qgUJTUFMvu0Gl87LKQUzXlBK1Q58zzQT94C5wad3rcOMkXpvB5AxwnOmWSKbYITTxXclGbfrsnVH0W+JHsDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LSBP/iXd; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5636e549defso92782e0c.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814988; x=1769419788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=HOl0QViGb52Dg5pObhRTu84qEuHLmtt7yGFyBKfnomDsWdQDZkbopSaTFdVicMH+cZ
         sXzpnsyKGtRrOUngo0TXjiHc4MD/O6vYw/x5K6aYqPjiAULYmcZMm/G/PKFYA2miPXdp
         TtNCEgb6JJLiwEgFiJviLp8d+5AiYcdni+jZ8StoKMwxZhli51CiQrVNJ4Xn7ljtVaki
         TvjxD5N+NdD0KrW34k93wHn606PBxebbqpVCTl/tNThIl3RpZoh6T1dtnIuNeE4nIOwF
         K7nBbenncC2uVwHMdRLsrZBonpPCfEQCzjQwEPqy9Qtn0gY+IP+SAx+LrDX7z1l10Oss
         VqfQ==
X-Gm-Message-State: AOJu0YwscRwwSLAE8orCPWLIIjpqjPmXJm0yg4i7qCfUvOw4aZKBvnxP
	Trp5ttVsI61uuKRvjQSIfmjSZe0HGyIF0F3k76HYwFxxQOYtA9G7lwQi4ypF92h78sm3E2Bb0eg
	svpT6iXMusCnzO0dqMz89XLJCCWcauxyxmr10yNtlFHQXRli+8XlflESzZ4pp66kvrPzOGDIRbc
	PQNkGDDUL1ILdDTDdrqn+Gc4qKx/+qmx9cPBRZzVpxfgcLiDlVqnjeGFlGQVoZXDypS5W5i7iOz
	n8ipGZAaZ+y4Y/SdII773jpqrcv8GI=
X-Gm-Gg: AY/fxX4uS/9kosZXg5b50vRyBNlFIV6zUOYWT3O67F3fpAfb8uuPse8oNfW5htRRD9H
	clS10T1I8dgfs+WOOFdkRX2bPwQ4lPJVe8U7CuHMxLKU8HeCy89pFfyqR2IRDZE0+cVyGN5Fv3j
	Ezg7gtjpVGCQyp2jWtgcQv9pPG5eV6Pr0T1PcrtzDiFpmOW0BgCm2eccJcxs/kgZJid/CGpnqfV
	fEGzjMM6CIsDEQcT8PetVVOanjDWywsl9LBZSKQEcPhaAYoU8lIWH+/QiJ9GkuuJtrT5RBvB8Gm
	GQDStO8p/5WTajpmFoMcoeP9kfnYSMTJEDR5Dk4nc4/AF7krd28oQJtlw7mgYwccYTiNBMeKWnx
	MoAsbSRGLiNcYqsPGWsWpazMX04XKIbnQKd8ma2vcK7gq8hMyZv/FF1TabHeZ98oipxgJL7S65O
	n86qXU1K/k5+WCbO6GQ3RGb8N/VwgFGPh3neLTgi8lYQv99w8OGDRpV51famk+xw==
X-Received: by 2002:a05:6122:178b:b0:559:5ac3:4451 with SMTP id 71dfb90a1353d-563b5c834d9mr2214277e0c.3.1768814987748;
        Mon, 19 Jan 2026 01:29:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-563b710b43esm1518614e0c.7.2026.01.19.01.29.46
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c532029e50so147234885a.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814985; x=1769419785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=LSBP/iXdpJoroRaEFGxsqT0CrGJnGllNkU8VK2QsJtUFQYmadKFQIr2/x4GlFQc0X8
         LkG23hlzNPCesnNvplFu9S898ebRNxOjw9fuxz4o4lhIb2Q6/lBKe3wAZcQ69r/0vfyH
         STRDadUcWobJeHpzSls/zx6qDbS3aMgf9osPE=
X-Received: by 2002:a05:620a:700d:b0:8c5:305e:ea16 with SMTP id af79cd13be357-8c6a67ab9d5mr1074239685a.8.1768814985549;
        Mon, 19 Jan 2026 01:29:45 -0800 (PST)
X-Received: by 2002:a05:620a:700d:b0:8c5:305e:ea16 with SMTP id af79cd13be357-8c6a67ab9d5mr1074233885a.8.1768814984815;
        Mon, 19 Jan 2026 01:29:44 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:44 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 5/5] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 19 Jan 2026 09:26:02 +0000
Message-ID: <20260119092602.1414468-6-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
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


