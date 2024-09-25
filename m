Return-Path: <stable+bounces-77177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8269859AA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588ED2813AB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5695189911;
	Wed, 25 Sep 2024 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA3VvY9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3C1AC886;
	Wed, 25 Sep 2024 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264391; cv=none; b=NDWT2cdGhF7WRUr3VjPj5+IDYcu/UacX/SNO0hpcUZXo9p16QgieFgG95D3bmYaG6/+BM8uTaxdaLS2aWrccxQAgPyF9W0b1HBBP1Tlv6eZfGV78AHJ4dWwCLaRxAl3e+pZHrox7HYTNTNixzldguY8gMRRnS6E5B81dIfW9a1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264391; c=relaxed/simple;
	bh=odDU1Cp4iGsplsRPbwJ7Rwl4dqtlLTEMD+gKWjeyVhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH8RcWI5I0BbzxJk+XySdA+biX74rDWwSGOjrJDzjtQxEU/KfNEKE8oTiK6MCdahQcCSNLRdoYiqaMY3f/w4Oox3bSIBeIAINHxaUol8I96hSkoC1CL3InFJo2uqF8KYjByJFrwh3tY+B0TjxrIuxZzJAPQ10GnC/DxDJicT4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA3VvY9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1884C4CEC3;
	Wed, 25 Sep 2024 11:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264391;
	bh=odDU1Cp4iGsplsRPbwJ7Rwl4dqtlLTEMD+gKWjeyVhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DA3VvY9Iq7c4mYaiWBTH6AQNHuebm0mpQONTLonXXrFQdyzW+ukXNozUY+sd3Nhji
	 iKXsklM0YNH56kgCCSffcIVcD9090OmAKTI5x3TVpVbWC0ooucUSbsqPdE1xEERZDz
	 K7wW1Bzsj7UObWbaTYfo/laUhKC+HdX8Gxy/un7lNOuehRatx1DFkcboqwufc7RFUg
	 mmPPUFEjDQZXmcte34+WWwU0oXFEVOermsHw4m2AC3BNXV8NReD5RWYDXNa7HKDnMr
	 ACevODCvdyGcHTs2HufLk5LZcL5TgNkiCEAPsFRu2hMDUvX8w2lljUNMUGkTL0XfIQ
	 o4lQQdnEr8SaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	corbet@lwn.net,
	leitao@debian.org,
	johannes.berg@intel.com,
	jamie.bainbridge@gmail.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 079/244] net: napi: Prevent overflow of napi_defer_hard_irqs
Date: Wed, 25 Sep 2024 07:25:00 -0400
Message-ID: <20240925113641.1297102-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Joe Damato <jdamato@fastly.com>

[ Upstream commit 08062af0a52107a243f7608fd972edb54ca5b7f8 ]

In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
napi_defer_irqs was added to net_device and napi_defer_irqs_count was
added to napi_struct, both as type int.

This value never goes below zero, so there is not reason for it to be a
signed int. Change the type for both from int to u32, and add an
overflow check to sysfs to limit the value to S32_MAX.

The limit of S32_MAX was chosen because the practical limit before this
patch was S32_MAX (anything larger was an overflow) and thus there are
no behavioral changes introduced. If the extra bit is needed in the
future, the limit can be raised.

Before this patch:

$ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irqs'
$ cat /sys/class/net/eth4/napi_defer_hard_irqs
-2147483647

After this patch:

$ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irqs'
bash: line 0: echo: write error: Numerical result out of range

Similarly, /sys/class/net/XXXXX/tx_queue_len is defined as unsigned:

include/linux/netdevice.h:      unsigned int            tx_queue_len;

And has an overflow check:

dev_change_tx_queue_len(..., unsigned long new_len):

  if (new_len != (unsigned int)new_len)
          return -ERANGE;

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20240904153431.307932-1-jdamato@fastly.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/net_cachelines/net_device.rst | 2 +-
 include/linux/netdevice.h                              | 4 ++--
 net/core/net-sysfs.c                                   | 6 +++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 70c4fb9d4e5ce..d68f37f5b1f82 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -98,7 +98,7 @@ unsigned_int                        num_rx_queues
 unsigned_int                        real_num_rx_queues      -                   read_mostly         get_rps_cpu
 struct_bpf_prog*                    xdp_prog                -                   read_mostly         netif_elide_gro()
 unsigned_long                       gro_flush_timeout       -                   read_mostly         napi_complete_done
-int                                 napi_defer_hard_irqs    -                   read_mostly         napi_complete_done
+u32                                 napi_defer_hard_irqs    -                   read_mostly         napi_complete_done
 unsigned_int                        gro_max_size            -                   read_mostly         skb_gro_receive
 unsigned_int                        gro_ipv4_max_size       -                   read_mostly         skb_gro_receive
 rx_handler_func_t*                  rx_handler              read_mostly         -                   __netif_receive_skb_core
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 607009150b5fa..39eafd2e2368a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -356,7 +356,7 @@ struct napi_struct {
 
 	unsigned long		state;
 	int			weight;
-	int			defer_hard_irqs_count;
+	u32			defer_hard_irqs_count;
 	unsigned long		gro_bitmask;
 	int			(*poll)(struct napi_struct *, int);
 #ifdef CONFIG_NETPOLL
@@ -2091,7 +2091,7 @@ struct net_device {
 	unsigned int		real_num_rx_queues;
 	struct netdev_rx_queue	*_rx;
 	unsigned long		gro_flush_timeout;
-	int			napi_defer_hard_irqs;
+	u32			napi_defer_hard_irqs;
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
 	rx_handler_func_t __rcu	*rx_handler;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 291fdf4a328b3..93dd5d5436849 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -32,6 +32,7 @@
 #ifdef CONFIG_SYSFS
 static const char fmt_hex[] = "%#x\n";
 static const char fmt_dec[] = "%d\n";
+static const char fmt_uint[] = "%u\n";
 static const char fmt_ulong[] = "%lu\n";
 static const char fmt_u64[] = "%llu\n";
 
@@ -425,6 +426,9 @@ NETDEVICE_SHOW_RW(gro_flush_timeout, fmt_ulong);
 
 static int change_napi_defer_hard_irqs(struct net_device *dev, unsigned long val)
 {
+	if (val > S32_MAX)
+		return -ERANGE;
+
 	WRITE_ONCE(dev->napi_defer_hard_irqs, val);
 	return 0;
 }
@@ -438,7 +442,7 @@ static ssize_t napi_defer_hard_irqs_store(struct device *dev,
 
 	return netdev_store(dev, attr, buf, len, change_napi_defer_hard_irqs);
 }
-NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_dec);
+NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_uint);
 
 static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t len)
-- 
2.43.0


