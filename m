Return-Path: <stable+bounces-210290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF7D3A319
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3C78303739E
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF43559D9;
	Mon, 19 Jan 2026 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gieT5L7g"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113E355039
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814981; cv=none; b=N2rPfFnKa2g2Zhi1DSupGY3jO7fIb2VZ5gxh0XMouByUAPq3X1PuYpSgCwyc+mBWYr8sW8N7Sw/vvF7kA6OCmTiyjRkgur8wiE5Uh5QdelhodFDgyaGaPnp9ZVfyQ69ilpJk01Yixf8AAOcNS1bI8DVpXd+PewcdCtGiHQkJhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814981; c=relaxed/simple;
	bh=5U08ymozzcGqOa+0/gOyD2WLxOYPTrL6M+fxBFoORbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAkPLOU99CJ43EpnEiS6wnN6N2sN/jMKgPRiL2iX7VXwfDNxph5CD2amMgNoqONegZysoiSXgKTaF3WRqO1f0SMRmCTAd3Yof9lYEHK7P2+IUGgrqupeXJyFG805q+nSHrM0ZrObp4t/7nOeN8+Gb/06cIqK8fC5xbjn7ydpe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gieT5L7g; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-88a2ce041b2so4840556d6.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814979; x=1769419779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yz5ffcVS1QdI0IyJJ74d4ERRSZLiOHbia+pSPo7WObM=;
        b=u7FDVJPbK/g58hZE0yI+l6DFvVcRM4FW6BU+m8CBh8Rrosu8LmxJW9FTnuhhwbM9HC
         GfbSBGw5esh/2YadLOsgMQ8nBc37Q9bNmPdlMHVGxD4JAFoBIsMfd0KAQhARFkhKSsX8
         5ZtlD1+HlpBOKk8HWrnirvmM03/6KHE+7CnNBT3Q6UWdpXFytfu44ZgtacxZviSjcKIC
         e+bHf5yzmF9Ab/lxhFouqD0fI7MElFut0l++2F43036Jzks9ftkNVwgGLq9l9ahBy8of
         pqeNkivG3t938+cyz9ob3RLiiEeQzWicJjsZJkfPya4HKqdk8DENvyZjSuzv+7+I9R8u
         QSYw==
X-Gm-Message-State: AOJu0Yx3DXbPyjDLOte5d+8Fky5cVaXIejKyRsCi5pn0vZcR92F+/eCw
	9+0Y3w9Jry463Nq2TV0ASkrn1gRK9vtGxdJbL3N5K1lgNLbOz7Xu453RaXjVNB1riH11RMiJkND
	L6uqvy7r4/kI2ToPW7mqBl0adE+3u03TqLXHW30qKmYOcdeY3Av1F8CXTEGq97MzGDUwlbBtacf
	wxZTPfPmUXQtVDry5SxmaacjrBRzFJNeykRwhSsq9j2pOlhVnTKwrhUtPkY1C9mDom5H47hNhVJ
	Q0/L3iNLwjkmVuVFJ5Zprc1N9c/QwA=
X-Gm-Gg: AY/fxX6RbmM0gqhp1wNulpkBDw+IQQ8ofR4iiZcvIXTE1Ty8sRsjhRH1oNbGOzfrFFP
	Vdi5KjT8zrrdX41F6l4M+mlX82ISFMharQzcv5EU33WuKNB/vG+4w5mZybZSXrglLICbhWjbe6o
	x57hA3LWVtcz2fH2xWDK369bFgH0Rqw5hVP9FNMKXYKg28ixlZ+n+m6tKeWj4uV5oDxtIhwKQpx
	2FdF72Z+M7frBMzMQ7fwZyeHcwuYNYtrXDbq5sAzmEUuieIt06RtytyHPp4YwXBj8nD1ogi3GeZ
	rApP2b99mpzqgCq3jswqQ7+VPSN0npbVsEnRN4ejqwhL1iTMZs4nhB1M+Ur0vOGy3PYuePoCcqC
	h1/6OmeezfA2yJqt1MCsNBzBI01IZMaAOHMlh0uCNfsxcJBKxDna22WVYonwifRSsgqDl8iubsS
	h5bFK2GeIxThUcBX2x+POb5rWUlEGi68vIakzSWeQjeaDiSlJz07ddHvuklGKFGrQy
X-Received: by 2002:a05:6214:610a:b0:87d:cb51:4015 with SMTP id 6a1803df08f44-8942dbfb374mr105100556d6.1.1768814978733;
        Mon, 19 Jan 2026 01:29:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8942e6e3e49sm7098936d6.24.2026.01.19.01.29.38
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88887682068so14925276d6.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814977; x=1769419777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz5ffcVS1QdI0IyJJ74d4ERRSZLiOHbia+pSPo7WObM=;
        b=gieT5L7gnqNMRsILTR5L8mmzeaCvwgIuAY+VgbRiXsntn2Ah2mx9iKrZVDMMAY16Ct
         FfxWIqKo0Keprdo/G0NlRSZmppPGTbLXpY8+wjt9xH6YwhMkVVUs2hOVOD+k25gasiyy
         kcLvJwDn9l8ylT9wBFHldQNG8WhMIUVyKz3kU=
X-Received: by 2002:a05:6214:4c92:b0:894:2b9f:ccc6 with SMTP id 6a1803df08f44-8942dd90f52mr96288476d6.3.1768814977481;
        Mon, 19 Jan 2026 01:29:37 -0800 (PST)
X-Received: by 2002:a05:6214:4c92:b0:894:2b9f:ccc6 with SMTP id 6a1803df08f44-8942dd90f52mr96288106d6.3.1768814976839;
        Mon, 19 Jan 2026 01:29:36 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:36 -0800 (PST)
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
	Tariq Toukan <tariqt@nvidia.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 3/5] net/bonding: Implement ndo_sk_get_lower_dev
Date: Mon, 19 Jan 2026 09:26:00 +0000
Message-ID: <20260119092602.1414468-4-keerthana.kalyanasundaram@broadcom.com>
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

From: Tariq Toukan <tariqt@nvidia.com>

[ Upstream commit 719a402cf60311b1cdff3f6320abaecdcc5e46b7 ]

Add ndo_sk_get_lower_dev() implementation for bond interfaces.

Support only for the cases where the socket's and SKBs' hash
yields identical value for the whole connection lifetime.

Here we restrict it to L3+4 sockets only, with
xmit_hash_policy==LAYER34 and bond modes xor/802.3ad.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/net/bonding/bond_main.c | 93 +++++++++++++++++++++++++++++++++
 include/net/bonding.h           |  2 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b4b2e6a7fdd4..fb30378cffce 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -301,6 +301,19 @@ netdev_tx_t bond_dev_queue_xmit(struct bonding *bond, struct sk_buff *skb,
 	return dev_queue_xmit(skb);
 }
 
+bool bond_sk_check(struct bonding *bond)
+{
+	switch (BOND_MODE(bond)) {
+	case BOND_MODE_8023AD:
+	case BOND_MODE_XOR:
+		if (bond->params.xmit_policy == BOND_XMIT_POLICY_LAYER34)
+			return true;
+		fallthrough;
+	default:
+		return false;
+	}
+}
+
 /*---------------------------------- VLAN -----------------------------------*/
 
 /* In the following 2 functions, bond_vlan_rx_add_vid and bond_vlan_rx_kill_vid,
@@ -4723,6 +4736,85 @@ static struct net_device *bond_xmit_get_slave(struct net_device *master_dev,
 	return NULL;
 }
 
+static void bond_sk_to_flow(struct sock *sk, struct flow_keys *flow)
+{
+	switch (sk->sk_family) {
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		if (sk->sk_ipv6only ||
+		    ipv6_addr_type(&sk->sk_v6_daddr) != IPV6_ADDR_MAPPED) {
+			flow->control.addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
+			flow->addrs.v6addrs.src = inet6_sk(sk)->saddr;
+			flow->addrs.v6addrs.dst = sk->sk_v6_daddr;
+			break;
+		}
+		fallthrough;
+#endif
+	default: /* AF_INET */
+		flow->control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
+		flow->addrs.v4addrs.src = inet_sk(sk)->inet_rcv_saddr;
+		flow->addrs.v4addrs.dst = inet_sk(sk)->inet_daddr;
+		break;
+	}
+
+	flow->ports.src = inet_sk(sk)->inet_sport;
+	flow->ports.dst = inet_sk(sk)->inet_dport;
+}
+
+/**
+ * bond_sk_hash_l34 - generate a hash value based on the socket's L3 and L4 fields
+ * @sk: socket to use for headers
+ *
+ * This function will extract the necessary field from the socket and use
+ * them to generate a hash based on the LAYER34 xmit_policy.
+ * Assumes that sk is a TCP or UDP socket.
+ */
+static u32 bond_sk_hash_l34(struct sock *sk)
+{
+	struct flow_keys flow;
+	u32 hash;
+
+	bond_sk_to_flow(sk, &flow);
+
+	/* L4 */
+	memcpy(&hash, &flow.ports.ports, sizeof(hash));
+	/* L3 */
+	return bond_ip_hash(hash, &flow);
+}
+
+static struct net_device *__bond_sk_get_lower_dev(struct bonding *bond,
+						  struct sock *sk)
+{
+	struct bond_up_slave *slaves;
+	struct slave *slave;
+	unsigned int count;
+	u32 hash;
+
+	slaves = rcu_dereference(bond->usable_slaves);
+	count = slaves ? READ_ONCE(slaves->count) : 0;
+	if (unlikely(!count))
+		return NULL;
+
+	hash = bond_sk_hash_l34(sk);
+	slave = slaves->arr[hash % count];
+
+	return slave->dev;
+}
+
+static struct net_device *bond_sk_get_lower_dev(struct net_device *dev,
+						struct sock *sk)
+{
+	struct bonding *bond = netdev_priv(dev);
+	struct net_device *lower = NULL;
+
+	rcu_read_lock();
+	if (bond_sk_check(bond))
+		lower = __bond_sk_get_lower_dev(bond, sk);
+	rcu_read_unlock();
+
+	return lower;
+}
+
 static netdev_tx_t __bond_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bonding *bond = netdev_priv(dev);
@@ -4859,6 +4951,7 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_fix_features	= bond_fix_features,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_xmit_slave	= bond_xmit_get_slave,
+	.ndo_sk_get_lower_dev	= bond_sk_get_lower_dev,
 };
 
 static const struct device_type bond_type = {
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 82d128c0fe6d..871920db4e51 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -273,6 +273,8 @@ struct bond_vlan_tag {
 	unsigned short	vlan_id;
 };
 
+bool bond_sk_check(struct bonding *bond);
+
 /**
  * Returns NULL if the net_device does not belong to any of the bond's slaves
  *
-- 
2.43.7


