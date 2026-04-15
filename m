Return-Path: <stable+bounces-238065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKn5D2tR32nLRgAAu9opvQ
	(envelope-from <stable+bounces-238065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:50:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B940225C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91474302590C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB023D47B2;
	Wed, 15 Apr 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSjKUm7d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF1307AE3
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242977; cv=none; b=psEAeROo99FHil45c6PFU3qhfhYSXhgwws+ebp7kfYNEuvygweYX3CJ5gPht2zVgwIXsg/RXwQQtNnz4PrHLP7Kw5i/vWc05FLq8S3CSPRC7nSiGwMy7M+CIUlhJhWw7k4m/Bdg43Tm9Dlz5TXBGmRP+umVIxfBNwZxaRJnrXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242977; c=relaxed/simple;
	bh=MnPayftqVi09a3drMg0t4qocs6aUdLqOEGb/ORTQOB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scukZHh2eNoCbjZEx9i5ObB78f/ApxQexHpuUlO1DXiGAaQt2fQCD+v/1f8pmcOayxFzuh0DduD9wzyOxokqBZCUI235F2vlsfc0n/9WnBLOjU1Yyrmr/zm/wc0yRGPQjhKicwT2VHyuQykgyoCDASP58F3bo24tuBZ3zbvCIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSjKUm7d; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aae4d2d215so6625605ad.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776242974; x=1776847774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBagG6nPdWPH/FpnMTW4SeLjEl1Kaw67bUgUq4EnXws=;
        b=eSjKUm7dsGebnmPXytVIxQwt/PXAmeoo9EViyJJzaR4zi0CDjGKU/jQf4KH2cBF3yZ
         mmJpzT0mNk1HTEJ0Oesm4yVUnxY2Y03DkGWGwwf6CVW/FiHGcHyfc5urtVEIgi5xw1lG
         Jx8Y17wLENmfA81zVJRIKGeVrzQ0wE5HApOBBjErXklhTtoeAUXltoiz4FNsAhKCfFPk
         yJm+3wvvVLArGoplxxf75ntiFB+MCCLm2ZVRzHFM46+svKuGIdmeFqqVvAf2GeFWbPMI
         J64rMU2v9lFs11wBGI/6B+8w20qXXkT9x7WfsUV/lomfd5ttke3lD9QZ8AvS1W9P7iB6
         c+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776242974; x=1776847774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBagG6nPdWPH/FpnMTW4SeLjEl1Kaw67bUgUq4EnXws=;
        b=jBLhFI58X+NmWK/s2d/l9UoHXuQQsveGEoji5SypXJurs87KPXr4wkLgfgUBroF0aI
         zrlwfyQ6EBCHAuWjR5KCqw5q+g3isfzlrkEAOWEdaqE4Ng/rE4laTwUcmEQbWwz8B0qC
         RF4l8dctceCYAsZxhX7h1tHdIDKgY/NVeeX2uDvT8qo98oo2pRS8/DxsN84IefrqJA2G
         riBdJj/ASB4aWJ744/l6atPhmt6zi07gLlkXUHhRx+gvMjJLF8S/TbkwkKHe6RA+rly7
         xMb41GeZ1cpwsVbI073Uod+ZHXQRMAx91ChvMcENZcRSCHPsiuNBCE4YoEd/Wn74fpqi
         29nQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KGyeWhX2pJd7WNTndOiwxbn7J7lNJa4fS3n9/waUAcotg17mhd9x1d6SERcygqWlTFy2a650=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Jzg8foXu7cgmzBbUKvX1+L0R/Qmfxd6wLdDgiUauGrudifyj
	NHhQ2jWsgpaRMeSwOodcJOEm9iXr8QhRq10qSDNsGxbFoaoLSKjyWD7m
X-Gm-Gg: AeBDievLjhU88Ila8yHgmS+rmIKHsv5cFqe3kzLhGg8w8PQ712GHxJqUiLY76TgjQX8
	mMqzXrVcoDo+hbpHhPObROzb6DR4uquqi9Q66E1Bba6IC2RphRZPUGyyg1axbTZFy5DC1snx39v
	747pSq17ce9jVmyg0OOmFMQNxx4nLoQBVHpHUYbtqqtxiy9cwF6QTIekwafNxqVuNx8S76wInf0
	FippRNU9YQIbJUMAMMflMqzf3UCRhmcTIkUU6dc1ASXl3mcdJmqJ5qBxIGX+QsITlEXtbDeRB0G
	SHwvBtcePOYtwGRpfFM6uctMWs1UXP8xcYUgHA76rFby6UKGv5QGoKsDg0WGdn/AuyfXfePo99r
	+Cdj24Oh8N3mDW+Z4AoO9mhpqUhSJvBf73BX8YoHj2zhDI+BR90vaJiyBw8upbfHGE/5gSeNIPu
	mnBIhatkA7JeZYW156deRLYpoB58ey
X-Received: by 2002:a17:902:8e8b:b0:2ae:464f:fe3e with SMTP id d9443c01a7336-2b4775b794bmr7402045ad.5.1776242974047;
        Wed, 15 Apr 2026 01:49:34 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782ac324sm18807255ad.65.2026.04.15.01.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:49:33 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: w@1wt.eu
Cc: pabeni@redhat.com,
	chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v3] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Wed, 15 Apr 2026 04:47:28 -0400
Message-ID: <20260415084728.1709824-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ad5p7XlSOKoaQC5D@1wt.eu>
References: <ad5p7XlSOKoaQC5D@1wt.eu>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238065-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8D6B940225C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
a loop bound over port_msg->data[] without checking that the message buffer
contains sufficient data. A modem sending port_count=65535 in a 12-byte
buffer triggers a slab-out-of-bounds read of up to 262140 bytes.

Add a struct_size() check after extracting port_count and before the loop.
Pass msg_len to t7xx_port_enum_msg_handler() and use it to validate
the message size before accessing port_msg->data[].
Pass msg_len from both call sites: skb->len at the DPMAIF path after
skb_pull(), and the captured rt_feature->data_len at the handshake path.

Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 14 +++++++-------
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 12 +++++++++---
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 7968e208d..d0559fe16 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -453,25 +453,25 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 {
 	enum mtk_feature_support_type ft_spt_st, ft_spt_cfg;
 	struct mtk_runtime_feature *rt_feature;
+	size_t feat_data_len;
 	int i, offset;
 
 	offset = sizeof(struct feature_query);
 	for (i = 0; i < FEATURE_COUNT && offset < data_length; i++) {
 		rt_feature = data + offset;
-		offset += sizeof(*rt_feature) + le32_to_cpu(rt_feature->data_len);
-
+		feat_data_len = le32_to_cpu(rt_feature->data_len);
+		offset += sizeof(*rt_feature) + feat_data_len;
 		ft_spt_cfg = FIELD_GET(FEATURE_MSK, core->feature_set[i]);
 		if (ft_spt_cfg != MTK_FEATURE_MUST_BE_SUPPORTED)
 			continue;
 
 		ft_spt_st = FIELD_GET(FEATURE_MSK, rt_feature->support_info);
 		if (ft_spt_st != MTK_FEATURE_MUST_BE_SUPPORTED)
 			return -EINVAL;
 
-		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM)
-			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
+		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM) {
+			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data,
+						   feat_data_len);
+		}
 	}
 
 	return 0;
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index ae632ef96..d984a688d 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -124,7 +124,7 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
  * * 0		- Success.
  * * -EFAULT	- Message check failure.
  */
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len)
 {
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	unsigned int version, port_count, i;
@@ -141,6 +141,13 @@ int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
 	}
 
 	port_count = FIELD_GET(PORT_MSG_PRT_CNT, le32_to_cpu(port_msg->info));
+
+	if (msg_len < struct_size(port_msg, data, port_count)) {
+		dev_err(dev, "Port enum msg too short: need %zu, have %zu\n",
+			struct_size(port_msg, data, port_count), msg_len);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < port_count; i++) {
 		u32 port_info = le32_to_cpu(port_msg->data[i]);
 		unsigned int ch_id;
@@ -154,7 +161,6 @@ int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
 
 	return 0;
 }
 
 static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
@@ -191,7 +197,7 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 
 	case CTL_ID_PORT_ENUM:
 		skb_pull(skb, sizeof(*ctrl_msg_h));
-		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data);
+		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data, skb->len);
 		if (!ret)
 			ret = port_ctl_send_msg_to_md(port, CTL_ID_PORT_ENUM, 0);
 		else
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index f0918b36e..7c3190bf0 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -103,7 +103,7 @@ void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
 void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int state);
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg);
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len);
 int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned int ch_id,
 				       bool en_flag);
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
-- 
2.53.0


