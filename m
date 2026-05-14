Return-Path: <stable+bounces-247262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBIVMzwNBmrSeQIAu9opvQ
	(envelope-from <stable+bounces-247262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:58:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8EC545946
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD68E3014FDA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C938F951;
	Thu, 14 May 2026 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDM7vq7y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74841314A98
	for <stable@vger.kernel.org>; Thu, 14 May 2026 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781496; cv=none; b=LdUuInfIvMALzfyfHPOtnat29uOMr1D7QkbtPDGDy4JVHwLaNPu4aFgEOe3EJAuUrKLWp57g+lgDouunVqlZ52is2iaV3gWIcDJUUlXOrdoryJBEP2Y40LxR8WMtL7QPk2zOEFqka3s8jalVxZ+kLtDvWEPF4WgYszDSFDUo/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781496; c=relaxed/simple;
	bh=Ob1RXTvuijlyJH84WP5CklzYgC4r1bp5tOcl0QoALvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulhvShH6kX7hk6lSZ/z9cd7ZG0S3mFXBMTcb2mpa5DWoSi6UnYa0kcwFXcz9/6aPRsj/dc10DSBHsS8AkmlPqFEArfuOZuY8Ud/ruUbmoRHYKyXxBknkos7ZuVuc2dtuBRs14gvzAGVCx4i8/uTx7EHpB9fcSgnytBgye6rooNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDM7vq7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974D5C2BCB3;
	Thu, 14 May 2026 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778781496;
	bh=Ob1RXTvuijlyJH84WP5CklzYgC4r1bp5tOcl0QoALvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDM7vq7yGs2QxQ6/ZqWLBcxg+mOEKqyChyghllcpXDd6U+BpxCCIXTVQtfn+aPoMr
	 9vqJu69BotkxsyEnDY+1YHg/yjvCRtwq5xx1CFmbm0yMn+5l2S1SF2/0N58GdEM15p
	 lbu2Ve7RRf0KxLhUtoka37+0egl0XTlh5fH/3SpAPVNcq0t6nEukNlVAUyoGnPpckD
	 epYXwi7qrKLIzijBvqzh4GVbdTYHnNg9CNa5vy2nLcZl3KQr2zUMe+GivOuAl+SX1+
	 NVqNZJSXQ3fK9NMyZXOCEBl0HIW4Q0Wi1PkhmaPyU+rYOLVViH1N0uyT91ZmjleGd4
	 HzZYmEGvSOVkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavitra Jha <jhapavitra98@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Thu, 14 May 2026 13:58:13 -0400
Message-ID: <20260514175813.518419-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051251-blunderer-treat-334d@gregkh>
References: <2026051251-blunderer-treat-334d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A8EC545946
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247262-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Pavitra Jha <jhapavitra98@gmail.com>

[ Upstream commit 0e7c074cfcd9bd93765505f9eb8b42f03ed2a744 ]

t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
a loop bound over port_msg->data[] without checking that the message buffer
contains sufficient data. A modem sending port_count=65535 in a 12-byte
buffer triggers a slab-out-of-bounds read of up to 262140 bytes.

Add a sizeof(*port_msg) check before accessing the port message header
fields to guard against undersized messages.

Add a struct_size() check after extracting port_count and before the loop.

In t7xx_parse_host_rt_data(), guard the rt_feature header read with a
remaining-buffer check before accessing data_len, validate feat_data_len
against the actual remaining buffer to prevent OOB reads and signed
integer overflow on offset.

Pass msg_len from both call sites: skb->len at the DPMAIF path after
skb_pull(), and the validated feat_data_len at the handshake path.

Fixes: da45d2566a1d ("net: wwan: t7xx: Add control port")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Link: https://patch.msgid.link/20260501110713.145563-1-jhapavitra98@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 17 +++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 18 ++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  2 +-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 7d0f5e4f0a781..d90300a1d2804 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -415,8 +415,20 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 
 	offset = sizeof(struct feature_query);
 	for (i = 0; i < FEATURE_COUNT && offset < data_length; i++) {
+		size_t remaining = data_length - offset;
+		size_t feat_data_len, feat_total;
+
+		if (remaining < sizeof(*rt_feature))
+			break;
+
 		rt_feature = data + offset;
-		offset += sizeof(*rt_feature) + le32_to_cpu(rt_feature->data_len);
+		feat_data_len = le32_to_cpu(rt_feature->data_len);
+
+		if (feat_data_len > remaining - sizeof(*rt_feature))
+			break;
+
+		feat_total = sizeof(*rt_feature) + feat_data_len;
+		offset += feat_total;
 
 		ft_spt_cfg = FIELD_GET(FEATURE_MSK, core->feature_set[i]);
 		if (ft_spt_cfg != MTK_FEATURE_MUST_BE_SUPPORTED)
@@ -427,7 +439,8 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 			return -EINVAL;
 
 		if (i == RT_ID_MD_PORT_ENUM)
-			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
+			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data,
+						   feat_data_len);
 	}
 
 	return 0;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index 68430b130a678..245b5b1df88d4 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -117,6 +117,7 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
  * t7xx_port_enum_msg_handler() - Parse the port enumeration message to create/remove nodes.
  * @md: Modem context.
  * @msg: Message.
+ * @msg_len:	Length of @msg in bytes.
  *
  * Used to control create/remove device node.
  *
@@ -124,12 +125,18 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
  * * 0		- Success.
  * * -EFAULT	- Message check failure.
  */
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len)
 {
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	unsigned int version, port_count, i;
 	struct port_msg *port_msg = msg;
 
+	if (msg_len < sizeof(*port_msg)) {
+		dev_err(dev, "Port enum msg too short for header: need %zu, have %zu\n",
+			sizeof(*port_msg), msg_len);
+		return -EINVAL;
+	}
+
 	version = FIELD_GET(PORT_MSG_VERSION, le32_to_cpu(port_msg->info));
 	if (version != PORT_ENUM_VER ||
 	    le32_to_cpu(port_msg->head_pattern) != PORT_ENUM_HEAD_PATTERN ||
@@ -141,6 +148,13 @@ int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
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
@@ -187,7 +201,7 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 
 	case CTL_ID_PORT_ENUM:
 		skb_pull(skb, sizeof(*ctrl_msg_h));
-		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data);
+		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data, skb->len);
 		if (!ret)
 			ret = port_ctl_send_msg_to_md(port, CTL_ID_PORT_ENUM, 0);
 		else
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index bc1ff5c6c7005..8632f6325ae49 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -91,7 +91,7 @@ void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
 void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int state);
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg);
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len);
 int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned int ch_id,
 				       bool en_flag);
 
-- 
2.53.0


