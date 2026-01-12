Return-Path: <stable+bounces-208039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 439E7D10B69
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 07:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F8630754E6
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79F31E4AB;
	Mon, 12 Jan 2026 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D3CQ3Mxy"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2B3101B9
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199638; cv=none; b=Li72iVRx5WaZKx/BEsjX5h5YZLrqkiIvf0DV6EKiWvE2E8vL2aNRFBUVwlcfv7d7z+eufWiG/7k2/EJcOEdov+AbqkszG+2VUKn3qAOvg4QkuSNt3HNuvpH90LFaW4ERz3RhY62lSnCEyTsISazLtP2LrQNQcXWMo7KzYEEXEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199638; c=relaxed/simple;
	bh=RWuTHL2vG6VXYYw+aleWdAzTOjFVPPbKCGWiPi4YKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk5JIF5IB/oBPeFWhSQXTwqyZ7yS9vtTX9MSUfhXhstg+jh4WzkXTU+M4D2vfjOmDDFSLu3HKJ3L0wDw/TALxF0yRxnghWuhSqjGVHmKAGhed+badKWlNqbIKiMXERK7WERCOK6vFJ8a2iVxMx9NhTtwRkpUPM5aEZnkWDldL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D3CQ3Mxy; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-78e611f3f1aso3316987b3.1
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199636; x=1768804436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=fDWOtN7/A/Emmd8QvCRmu+1E/RBC/kW1z+0AS8i2Hav5EUqXVnKNOONWa6vRCQ8K+Z
         HnOx05+oKZMZiG1wIeunz0sL5AEnmsiQBfvmD70PYBaUr/zQuvB/BWu/oNjemCF9nrVt
         WGss+PensVVWQWb9Uv5QEWoyWUASY/SVQ6SPUrjNOC2ep3qnreVfruQCToEEUpcMDFkf
         t9X4cynUiwoADn07Fk1mOtoWzaMyisTtN5X9YTUJ/Ag+I40M5ozs8pTVfvoodPL7fuPI
         YbLuS0Ht4JXElEd0Sr9ubkj1vx1AadmxS5cxzPU8RE8nEZJa1zDyNdd/xaxRXfBqFqc6
         urZQ==
X-Gm-Message-State: AOJu0YzhLYfljVo32u3mWXtuOPwrRVGU8SSq4IoWyFwo3W0Zp69+tdCH
	7tQfj1X2jB95z4ek1rX3K1uzj1xlOfOKtTAKq78HYKtXYBiyPp6X1CIfPSPF1jtsSDm/qbUd85+
	9hasZH2NeQRHd60gqxEm360RdQRPGLfJCoLt2LAWo20rNZ3xFgW55xoomyyyk2q2X5wjyg0ikU9
	vJmZto4suOgoOeS4nPyyu3pJe4o4F4HSI/cemMNz64P3gj9pBDPrgteYUEwNZg9DSxDr0jd9+B+
	9XOat3CuoOFfqrMMXDPTE6yrAAIiVI=
X-Gm-Gg: AY/fxX64jfklOKVJkbeE+mWpk2SiVv6JfXk/7AbeF29BE+ik0z1gQRyG9mCctcZmNud
	xBvckPcxB7xazFBwkiiM/bJg+SLb+eLFAG0YJVSi3wq0GAGO8jAUxUaqrOr7rhQcfm0uCtqdvpB
	6oNTO5WTjWcGD1Usz+WddZMIakTGTgPqwnDOH9cHXvBzSlV2xsJQanjmKkoGDksF3ZUxhZViiLz
	vya++5bere0h9Xen99jbHFxEu0XDAg5NI5mPEmALT+Ss3ePmBMBz2HMMxXgEzACh2p1y+Vp/b7b
	XB9IkWKnvX7u34OG7gH2j7JH45/aLp0Jg2DBOFbfoABpsgaHveE3vzfvC6jce7352SmJeXmMVls
	qtlBXxrYO67yvmQDJgNiKDrmTi4DNq7JU8oThYwJQY6cI9LJMYY3ImMpFEtz1YdQLoc/nxIemJc
	xrILV8oPtUIBaWayWC4eX+SxczuksAHL4P+CSgIP5sIsOTwhJxS7RWSR7bRJ0=
X-Google-Smtp-Source: AGHT+IEezRKqkLMLygvpffL8RZCtyKPqtSQX0abCkMtAecJLu395/E6d70jDjLas6XSyH1ZbnnGyjkq1bP19
X-Received: by 2002:a05:690c:113:b0:78f:84dc:5631 with SMTP id 00721157ae682-790b55dd393mr125963027b3.3.1768199636218;
        Sun, 11 Jan 2026 22:33:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa6dd21esm13245337b3.25.2026.01.11.22.33.56
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:33:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b1be0fdfe1so206491885a.2
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199635; x=1768804435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=D3CQ3Mxye8QpcUZIhbG6wp4M0lYb2Ja3TYS0hWlLWGWeK2VuosaF3kOgrH50w+ZkQh
         iyVDyjmFecWmrkQmvkG6jLxDoL37g8RN4ABjXZ8dLd62Fi6y5Mzmn/h0TMf3q1bwnidQ
         FQ0F7LALUuOj2ExAkvj1yowUDV4gzpBbFLWfI=
X-Received: by 2002:a05:620a:2886:b0:878:7b3e:7bbf with SMTP id af79cd13be357-8c38937a047mr1725533085a.3.1768199635066;
        Sun, 11 Jan 2026 22:33:55 -0800 (PST)
X-Received: by 2002:a05:620a:2886:b0:878:7b3e:7bbf with SMTP id af79cd13be357-8c38937a047mr1725529485a.3.1768199634468;
        Sun, 11 Jan 2026 22:33:54 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:53 -0800 (PST)
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
	Tariq Toukan <tariqt@nvidia.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 2/3] net: netdevice: Add operation ndo_sk_get_lower_dev
Date: Mon, 12 Jan 2026 06:30:38 +0000
Message-ID: <20260112063039.2968980-3-keerthana.kalyanasundaram@broadcom.com>
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


