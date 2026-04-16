Return-Path: <stable+bounces-238304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEXjBzrK4GkdmAAAu9opvQ
	(envelope-from <stable+bounces-238304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:38:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBBE40D7F7
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68E98319276A
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4BD3AB269;
	Thu, 16 Apr 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqfbuVGR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC93A1E89
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339171; cv=none; b=ma6BB0eeINatrk/0ExYfRdMbcTMkWNEcJeBeN+XBaDBAVFdZko9/Srgwe8HqSnjUoPJRXCokKhV2ybWyEkOvRk2BOj+1XG7nrImr+OcjSi2+ItquZvNz/dBgIGRsul+kGtehklakY8tXRJ6sHHTjuwR3qhC2yxuN726ftKdir34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339171; c=relaxed/simple;
	bh=LthEZFquLxYnf3eWuf9b/raQUnsAIxOokNNsZ6zhLcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkjqfVwS4cv51qjPHot6+sxOzcgRfbZcQrUHtsHb8Ot19Zv8rosWfFWGV3sktSesTLqwavf+6dJ+B7WwcBU9lOpsWA6WYFTi/ptiX0DwHqUuVxCHmN221bh7L1zsq8CFbyK+RrXysjpZDmSy8rLJpGCnV2i/7qIAuJV6wpOsWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqfbuVGR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aae4d2d215so8234385ad.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776339169; x=1776943969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkJWBH61iYRdnXJ2r0XjRioP0rvUjxtyWtkR0Sw12W8=;
        b=LqfbuVGRN4tKOLo+re9EjEGBl1qDT8zAuCKO8M0swFjDgKL6RNd1gCfLrWS3ygcZJF
         Tsf5WGjxPUpIs85vEOB/m2xJ1TD6P3XeYF1Exjk7QAVSMVDHUXvEY8QlCHGS36SLMTzk
         VrZG+wZ6kmoX5/4lCN7r4RzRskvTgT43pf5UCbuKO0TyK4fRkzbDMYJ1mc6+/RGIPG1U
         4Av68kK/f1tFnOQJcFvh+FO3zbEKQmGuZpad9Gh14W9SU/sc0MBhgKxlr5Q10pAcyn5v
         Uc429B//wvSxtSAmXP12XbchzlDJFo1t7pqu06+AUvj/QqXdy77XZQhAAENUI5OXqFpY
         gpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339169; x=1776943969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkJWBH61iYRdnXJ2r0XjRioP0rvUjxtyWtkR0Sw12W8=;
        b=OynxrDuj2gQKt049+BqgAZEOuWdCwLNQ1ycni3lWz8yMOV/9KXfPoQVzKJizHAQTs5
         YWnnFtTX3NVuoTWYpokZKNN22eqfTBuZscofO+RDZRauucd74Mw6DjynelGdZevLk/t4
         8aE1O2RiLl41pm7Zlx+5oyzsuZ2koT+hKmmHHaX4UwuyTcmDarIQ84hNRobz7yeLJRla
         WyUjZvDM7unPbgpDKYLZP2WxVb5EANErSvX0rGElS0n67NaoXgEKRVfnVUAcla3O0C+w
         GeqbOVfeoJ3EpDaVThLxIkv1c1giu3JdK2m7HrKMVkfv0SWAWVCiAvxhUeYryCmfxhUZ
         uuiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fqxs2vT2CNseYL2blcyw0GHV8W/Z/6LO0KYQ3WtvNe5eVqaFWCDt4Uc6C8wfqLN+BWVVo/gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5JIJscw4d1eqjcEigS5jBNKCADwoxd/xJpGLO16wdcrEyBdp
	oSHo5FlRoBaGGgJ0XNkWZONOtEPFsi5wDeCfSvs5BkjT6tmZbKW36z/7
X-Gm-Gg: AeBDies+GjgXWeeFknXvZweJoSEom5Z6/HONfDF24GQveDjoOmFBbc07Sgoirl9yjPa
	gqvzaneU5JLanVJavxK+7u5ROSnjfyY6fe2yAgApbvJjq50SNDhJKBimrwM1ytwoQWmwwzQDPlW
	QAIW53TOoNtpk/XxwDTobrfjt2xwKjTu975tFF3Fls0hmQ5pnBQ4oF3AZytT1XGiKgxxBzPgHUl
	xh21zyCyo/yEl4OcpO/9qTTiNogqXXGOFwlUOncySlqThJN/LtcooQoq4rxMCWWE0vpgDkDqdva
	9U32Z+kVilohYxrmQkzEQYNfLCCXliRqDDnVzgCIluYrMpT67wCOxKy43ne/m0KJrMqGOnFOBls
	1nyvYyyw+5sFpOP+/8FN67kgR8uipM2ao3OMKsR4yj8izAMcBBdfaXK7btQ9H/d42OZnJPT8COP
	AsqDk1esQDCXu8kugaxDm/BzuSYCk=
X-Received: by 2002:a17:903:2284:b0:2b0:4d17:4d6e with SMTP id d9443c01a7336-2b5ed9c944cmr14013835ad.3.1776339169437;
        Thu, 16 Apr 2026 04:32:49 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47810ae96sm68463125ad.21.2026.04.16.04.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 04:32:49 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: w@1wt.eu
Cc: pabeni@redhat.com,
	chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v4] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Thu, 16 Apr 2026 07:32:05 -0400
Message-ID: <20260416113205.1789319-1-jhapavitra98@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238304-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BBBE40D7F7
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
@@ -124,8 +124,9 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
  * * 0		- Success.
  * * -EFAULT	- Message check failure.
+ * @msg_len: Length of @msg in bytes.
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


