Return-Path: <stable+bounces-237910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HNOBxdf3mn+CQAAu9opvQ
	(envelope-from <stable+bounces-237910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:36:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA453FBF71
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00D5330844FB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075773EBF29;
	Tue, 14 Apr 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE2M1ma0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868313EC2D7
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180781; cv=none; b=VROZpLSAHmVMSRhkrBdfgZQtWRJ+lHD3veJIhixgHToETgWsdH62ZJrIAVYWfUAiWahZVnv/ZEj2HlO7WCvU6cuaqoQi4Fc/DLCe/Bn/VKbu8O/2j1eU8pyQZyTKowjJUaHlL9p6hMh4yklTpuu+Hl09snYfd6rO+5Dq4cs+nG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180781; c=relaxed/simple;
	bh=cW1b161WL6TconDoEkhqZhBsnMI3QiEWMBYCnXK/k3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw7bDg61xTJd6wrQUFWwfQDp5LNyKhrZm9Njn5FJvA7o1X81XN9MvOhb+JNlSKIEFZVi+0xRxFvQAWgi1RmolgRvdAdoz3xVe4lkcln+8YQ5sxpnhAvLAD4CDkiQzAmjfzQxs6nvsgODj4UoAncjviWl/JTFgwlr4XmLCumfHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE2M1ma0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35daa02ea08so632452a91.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776180780; x=1776785580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmddVIQ8wGr99frrCwHRglOUUCwkkGiShQ/ZLd77AU0=;
        b=RE2M1ma0oFgjTBF3O9GsMuyqCBCOF3KpTwlruQHf3tVUqFXa6eRt6hWUByU90lU0uH
         4W5K5H2RwGb4Yz4iHliIv0T1r3dXR7CcEN++EYsylO4PZR9+QN2CYSUUzD8gH2U/RPy1
         HiFG5amO2RKwBtiFp7I2eXK3m7g9JMHDzNK3Pz3Pq8k/Ip1/47AmaSLMutXVFj0BpoM5
         +0KdszudbNdjfh7yIVT2A63Z8wJxhmO3ZewFZHx6/S7XY1CV5d/rQB/yjhlcecxkRGMM
         /nkge1e/R8Uryqcxg+R2u0g5NE3Ykb0dscxW30aiHOGS4GzAul0YAD0nv15pf++vxwKB
         GIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180780; x=1776785580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RmddVIQ8wGr99frrCwHRglOUUCwkkGiShQ/ZLd77AU0=;
        b=CulFAG5Sg252utxsQsYzDsA5CMJEZleH8hxy3BvWvfixKqadR34XkLmgbp1DWVaxs3
         6/r/9VgLZ30Kv6zCWfuVvZsLGbWX/fjclt1LEFvmV6BF3tLZ7UyXEu9ZeayXY2qYxD3f
         pBTqe+Rnq6YUfI8aMsKipxAA1zXFRLSS4rFue6PqgMqg8zTm2rLvhFKsCZKlKdeOmLgp
         6yVtW8mKhsJiv4msQ/RGcBzfvepZpj2loKSUtt5aZDAHSJT4XmN5L7AJ+TXn3BfiBizD
         TncxIqQorFS5gj90uIcF0K44JvbtaSpVO4yMdRpY/TZLMrdnsLcoCM8b3cpR230+DROk
         gpyg==
X-Forwarded-Encrypted: i=1; AFNElJ/BFht/0cJfPuaHgU0IrHcvqxlnDLW3cwgxJ3db/es8qTK58jdmd8/2EBp0HnWltaadqBiKt1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuUu0odlDZUOR5fPrCP0tvycyZ+qTD0Bhc444+t1dKNFI9eK9
	3uahQTYYRewbINCeANtoKbdPNEIyRexa5XLhwu8nVOI+UjzS/0t96zqJ
X-Gm-Gg: AeBDiet/q5Q3WeuQpshn7dIrkE2ETsO6cgiqnjB0suXkJTNGG67CiHWMh0f4fJRSFnL
	fE0zwF9ZPryYBEKH8g1q6PUy8Pi/KJnNTd2Hdk0gy/ul5GlcTWGg+Er47MQQ3+8jhm0wiDBCTFY
	P+jBgiUw+BHiZYWYw/COjNHpKj6f9Ute5KrXCUBjv7N/zWSj9OwGNs7j5dGub1QCBkcEa6Kc55R
	K0yVEOIvemdJACcRzOyX96aWivOeXDT+vfBoyrZHxSDgZSmD+GOgt/FqUcug7i6M8jBo1WO0VKO
	hm2ucyXHUEhoQEgHJLP5YYWuAXGMlMpv8eR89Mb7CSQv5j2A84U1EbjQjZWzVyQYvwmzIgCjDcw
	E4v5HcN91IiFE+zdREXralHoeBV1JSz3YcuTF7CQcdJpv/37hcAIQwqjHCD0PgrUh/nQTbedQSt
	coiACdUES9y1nEtEGY+e3psrYb040=
X-Received: by 2002:a17:90b:4b8d:b0:35b:94db:fdaf with SMTP id 98e67ed59e1d1-35e44297be3mr10689923a91.4.1776180779704;
        Tue, 14 Apr 2026 08:32:59 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fcdeb2c59sm68388a91.4.2026.04.14.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:32:59 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: pabeni@redhat.com
Cc: w@1wt.eu,
	chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Tue, 14 Apr 2026 11:31:56 -0400
Message-ID: <20260414153201.1633720-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ad4-bTbjtxbUXDU9@1wt.eu>
References: <ad4-bTbjtxbUXDU9@1wt.eu>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[1wt.eu,intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-237910-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CA453FBF71
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
Reported-by: Pavitra Jha <jhapavitra98@gmail.com>
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
-
 		ft_spt_st = FIELD_GET(FEATURE_MSK, rt_feature->support_info);
 		if (ft_spt_st != MTK_FEATURE_MUST_BE_SUPPORTED)
 			return -EINVAL;
-
-		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM)
-			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
+		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM) {
+			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data,
+						   feat_data_len);
+		}
 	}
-
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
-
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


