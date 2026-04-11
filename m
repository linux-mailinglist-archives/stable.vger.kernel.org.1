Return-Path: <stable+bounces-235694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF9JF/wI2mkcyAgAu9opvQ
	(envelope-from <stable+bounces-235694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:40:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF6F3DEFFA
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59BA4300C30D
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653FE31353C;
	Sat, 11 Apr 2026 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMGvZkLx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70630EF91
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775896824; cv=none; b=qI/ldIUm/+KVIotb5lR44i4jih84mbk15NqmWulKrZ2TurJRLdwkwyODsV5++e2KjXsSqiwU1590hSRE4IkUuyqVxJPRUlV5kHqLPCGbY4ege2yjipZY18h0AdSoGJxRa2byuIRXfs/wwvu3a8qeWeqQdRMOA77gyIGcoqVQrNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775896824; c=relaxed/simple;
	bh=mIRP6L+hb77SJIiAE3rkIP7boFxJE9dvNqAhHyLa+zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8CPAwJ1UP+Yl2QHKW9x8FGGsCRHI3y5PHJ5nHb2ACrpa0EQzg2ujXPeU1aFKbmJJj1Za/I393FIgrrReLxayxGq6UNmp3EUjoEuU/0i3ZGdvjFSlYMURzmysIZpNfutbJv9x/Id1KmSDvUGB6NH5a6Q785tIMbrISZZ5VZFA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMGvZkLx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35e30bb6482so689701a91.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775896822; x=1776501622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gij9R0BiMf/CLJF+fbkJbgQX286SYIp1XpOlyH59MlQ=;
        b=SMGvZkLxv9G4ISNcKd3SG4ZfTidXAj+c4ucXqdZtpPiL7pNlMRSYYvgxHX9lEsXpP5
         NpYUz5s8Qq7NItfukbPEsKmG/NJb4ztFBUBD9DYS6TCcE7xZptVdMyM6klfDv/u175DB
         Vb5sZh0L5F/a4RenDGHfYZCX6Fg6wKnqJD7EZeErNj+zPWrEYgygmp8iI14CK8eDXKcJ
         qsjA0WrXW6qeKifbk+1sZwizNdw5VS1ssuA2xfkHnV4Voso6sVxjWINooUKk/CRIHH76
         bo0l3leNO1XsGGN6OM9yht63AEP9eEM0PnatfOk+8PWL41+IN2qrXYXfK/0J9xn37zFi
         H/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775896822; x=1776501622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gij9R0BiMf/CLJF+fbkJbgQX286SYIp1XpOlyH59MlQ=;
        b=TWsHhiJRdqck4pmilcgQsjUKFchyfPqtKpj9TW8zPtw0sqokcdakyIX5pg/X+tZQTw
         peCOo3oKG7Ald9NMEiv8qNouXBBtfiG+fXud0NQZk4YRVCwqhblLbd5vuKmdZz+3NF2w
         qY43lfAYldCjAbGNT2umtcoCkNs/9ZPVdix70fwpwhjGFRcjoggaK8TQzhPa+lRzSR4F
         P5mBMQzH2JcN+Yn/VGR8v820944lEw+3ESXiRrauBh0iGO/FroM7YMS7NWVW/KNL0fPK
         UrGuItGht7/N6mSaW6VenYhl9OWhNV5mGtyfyE19Zd/oEYGjFHhTP/aiV5MbO0rhRva6
         1j1A==
X-Forwarded-Encrypted: i=1; AJvYcCViPQ2dqnmEO9o9EndiQK/0FrCYF/zz5eVivwx6DlMaeOPTxRU8aM94iZ9LVg3ubQqE/0dhRiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dDZFABNmwiH+AvjiDS5uYtl0v1mB3blcm5a+dCLSSHSH64g+
	iSVkVEX51O0NExbwky5asdg5dF8YA6ymM9qcN+OF8ldNJ3zAcvE79qUD
X-Gm-Gg: AeBDietpt3dOpdAsQG1higyG0NbPJE37go7xhfe08+fGZzECt0T889SSlUAQijfXif3
	OgKJafqBZLLQmgxc+7nq6rpWh6kFxlnVlJt+YyjsFfHTK3yYuhaNqQaAlIetNDhGSHliEWZew89
	OX2AFepoB06qTmzmjImAN1OMnjC2BJMUgk0d5YgxYlAvOgBETnZHh6TlGcCrjkKQh/Yya4vecWE
	jGSrc8ISIpi1j3WHpALmZozSLPDMh81BSniCOqydQd8aQiq6rtiexxmCDwbRnZhjB+K33xS/OAl
	d67847fhFkQcPNclEbt5wmcPFG1LsQ7/JqJKaBAuahoKzuUgZ1CQgZQ0Ca6eWJnirVqBGQEcO1P
	FHjuDsXNNh6DDU72eCapU2P8jdJ4/D1KWv4J1fZ14PMeY6kczE0fq/pQffHXmo+/S2lUYEq91h1
	aIT5Gjl57DbFBjL/xd0xhyE12YsLc=
X-Received: by 2002:a17:902:c950:b0:2b2:5be3:ba34 with SMTP id d9443c01a7336-2b2d580c7dbmr37649635ad.0.1775896822160;
        Sat, 11 Apr 2026 01:40:22 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3a8f7sm53874255ad.71.2026.04.11.01.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:40:21 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: w@1wt.eu
Cc: chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Sat, 11 Apr 2026 04:39:57 -0400
Message-ID: <20260411083957.567676-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235694-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEF6F3DEFFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
a loop bound over port_msg->data[] without checking that the message buffer
contains sufficient data. A modem sending port_count=65535 in a 12-byte
buffer triggers a slab-out-of-bounds read of up to 262140 bytes.

Add a struct_size() check after extracting port_count and before the loop.
Pass msg_len from both call sites: skb->len at the DPMAIF path after
skb_pull(), and the captured rt_feature->data_len at the handshake path.

Fixes: 1e3e8eb9b6e3 ("net: wwan: t7xx: Add control DMA interface")
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
2.51.0


