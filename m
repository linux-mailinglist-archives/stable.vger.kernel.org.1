Return-Path: <stable+bounces-210292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E03D3A31D
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 468DC303C122
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D90355804;
	Mon, 19 Jan 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bmrU6kBY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA92773FF
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814991; cv=none; b=gtgFV99+AuToWS1Nc5lJRpLDn9Kn6rcgKGuHd2Ipq6AR28/VCKap9KK/cNqdhEVE6pxRBVE+Xb4Dq52HN8VeGxbW0HuiNhVqXM5AlFL7td8nCwSXDN3LKpkWZt0D6ZB1VgC9e4IlVwsV/GwRafEdVclusdrLdsAseYFUquazAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814991; c=relaxed/simple;
	bh=RWuTHL2vG6VXYYw+aleWdAzTOjFVPPbKCGWiPi4YKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiKS7Q/hmjrXJJqWbDZzrXYnanUNO+2qQcRwGAgy1eHJH4PN63gBdriU+kQF4WtC5HUNQzbRsSpfXe2WH14A+B77ncPE/++o9JSKwb7X80nzKa1amcfAnFQNvOm9gLkuIKQeQ+tHnOSqt/3fHtI1NenRzL0aXINuYYzNAgjVEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bmrU6kBY; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a097cc08d5so9030025ad.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814984; x=1769419784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=G4KqFcZs1/bNe1ohiqhYlmyTAV8lr2sBGbJ+YPbiT47ZLkS1m0iOrp7DEwofwVKR3x
         8gI58CC0ffS2rQP4kUdxxKuvdfx9t4PLgHpi88vFmhbO8JQIxyp9WcWx2aDigA7ThOYP
         EbRsVugxe1kEqD28FatzCifGwcUL+hhepLxSJZkxQjcBGsAk9oNyBv+kluOMDq53vzf7
         UKgfl/XVH//MY2mW37WGXC7yn1/L+Lyx13pb4HbnI9Y+E752A93Q5OzN3tkyzkbWwlQV
         uSOrT0NBuI86gPyiyCD6DrCZhV3cIpUE7L0MR1hfyNV7aIl42Moj/qpgrqI6BiCI0X4f
         Me4g==
X-Gm-Message-State: AOJu0YzlCDQJl1LA0YQ+nthnbDs1F5jJquGLSo616z6+w164ZAKpPVm8
	p5REu2+Z52X+T8Di8Cq5YeH3qx4L/GYtjemIhJBpM3cjMpRndsC10DVBAHGCnGjh85yLBFcYsXD
	mdSXHGsQT6wRfhooRNKrdYRvnkyYvMMgMYsrxsEKh3R67FXXk9I798g8re4F5bWb9PnFZdbUpyv
	1Mso5KzdDCn1mvTbqRtkmp5QUi+ufV9iA3QgIEDCTkH5+LeFe4r5UlyKMjUjDJxLfxdo78CdiWj
	JJHDj0yJ+9DjRYBC1/LGE/tP0Mb3og=
X-Gm-Gg: AY/fxX6ycan5bpdOco32i3WtMpga3wijVNVM2GVHY5Cf+tarHDCSEzLP2UDufY7ItGJ
	SCBnBI2glIV00BBKvgFMMnLL0gEFmzOh7Bhp0aon9qe8T9mkv37BktdFGAt4ksfqfmwQ/Siinhv
	Vf2bLJpDIdUnppgeD4gED77uJt6wbSV8/GoSDlecl30RT3QTfoByh+B2TxJLPnZHFlvTmRqEouT
	ZVMzFOfBgxagQP6BpqxB75YX1z7izwuXnYu6J3fG2qquI7ycGK9+86oqEiNZt1T4B0qTT/VJ2SA
	Wdtb9E0aUlqH+Kj0U/s9Z1OXTsAC6t71xLNOfHAzX2By3L4I1M6ljkCtY8NqedpmaBNj/rBym0n
	DVBAXPve3J1Eqm9RerndSL/SQB+fAUfOacy0ipHLz/NYL//lcNNFvTyRBPpb3Byy952Uz22r6gX
	H9f53VM+OUYc9pvgq1sry5PSjoyAjDzYZomqTPXjlLbpAIARg2cNUUN/fbDvzdjfXo
X-Received: by 2002:a05:6a20:12ca:b0:35f:f0fe:565b with SMTP id adf61e73a8af0-38dfe5a2e26mr7252142637.2.1768814983561;
        Mon, 19 Jan 2026 01:29:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-81fa128f919sm1130345b3a.10.2026.01.19.01.29.43
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88882c9b4d0so9048046d6.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814981; x=1769419781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=bmrU6kBY8jgheGuW0E+kX7911OSKXZJPfgWdr6zMMr6NFEH8fHcMd7rqeAzZawHMIV
         BTpM3jGYkKRFqAcnXVxvvSOTrpXRviMx6sY+tzy9xqpHnK/xj1D8Dez33auKxsaWIb9D
         R5j0/wufJUvM7XC8ygefW3PspBtJPosdtHhCo=
X-Received: by 2002:a05:6214:4c45:b0:880:4f69:e598 with SMTP id 6a1803df08f44-8942dd7fa20mr139501036d6.4.1768814981674;
        Mon, 19 Jan 2026 01:29:41 -0800 (PST)
X-Received: by 2002:a05:6214:4c45:b0:880:4f69:e598 with SMTP id 6a1803df08f44-8942dd7fa20mr139500646d6.4.1768814981167;
        Mon, 19 Jan 2026 01:29:41 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:40 -0800 (PST)
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
Subject: [PATCH v2 v5.10.y 4/5] net: netdevice: Add operation ndo_sk_get_lower_dev
Date: Mon, 19 Jan 2026 09:26:01 +0000
Message-ID: <20260119092602.1414468-5-keerthana.kalyanasundaram@broadcom.com>
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

[ Upstream commit 719a402cf60311b1cdff3f6320abaecdcc5e46b7]

ndo_sk_get_lower_dev returns the lower netdev that corresponds to
a given socket.
Additionally, we implement a helper netdev_sk_get_lowest_dev() to get
the lowest one in chain.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/linux/netdevice.h |  4 ++++
 net/core/dev.c            | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d3a3e77a18df..c9f2a88a6c83 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1435,6 +1435,8 @@ struct net_device_ops {
 	struct net_device*	(*ndo_get_xmit_slave)(struct net_device *dev,
 						      struct sk_buff *skb,
 						      bool all_slaves);
+	struct net_device*	(*ndo_sk_get_lower_dev)(struct net_device *dev,
+							struct sock *sk);
 	netdev_features_t	(*ndo_fix_features)(struct net_device *dev,
 						    netdev_features_t features);
 	int			(*ndo_set_features)(struct net_device *dev,
@@ -2914,6 +2916,8 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
diff --git a/net/core/dev.c b/net/core/dev.c
index c0dc524548ee..ad2be47b48a9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8169,6 +8169,39 @@ struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 }
 EXPORT_SYMBOL(netdev_get_xmit_slave);
 
+static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
+						  struct sock *sk)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (!ops->ndo_sk_get_lower_dev)
+		return NULL;
+	return ops->ndo_sk_get_lower_dev(dev, sk);
+}
+
+/**
+ * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
+ * @dev: device
+ * @sk: the socket
+ *
+ * %NULL is returned if no lower device is found.
+ */
+
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk)
+{
+	struct net_device *lower;
+
+	lower = netdev_sk_get_lower_dev(dev, sk);
+	while (lower) {
+		dev = lower;
+		lower = netdev_sk_get_lower_dev(dev, sk);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
 	struct netdev_adjacent *iter;
-- 
2.43.7


