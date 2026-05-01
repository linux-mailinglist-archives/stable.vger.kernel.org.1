Return-Path: <stable+bounces-242311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pod9InyJ9GnQCAIAu9opvQ
	(envelope-from <stable+bounces-242311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:07:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D34ABE41
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65A543002B01
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953D13939CE;
	Fri,  1 May 2026 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeSeOipb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB772622
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633656; cv=none; b=Npw/+imvtgaZz0qZ7gfGEZaZp3grxhdNbA0mb36kLfjYStR+tKL4WfGC3OfBhhKeaG2MVJUDvGlF7wRSLuNF0vTz9FESkNO1mBW+oPg/pcGVpOpb0/P8jKQdYFNiRCJjEnzFVDQL2dE46IwmJc0kLRnNQcO/FhPFvxui614Mb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633656; c=relaxed/simple;
	bh=jqnmZ3qK5FWR+auny98vneTll7ItLkOsfIphl62IFk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G19iocSwkZD+1ZBvrasR+zKqTrQTl09FY8/bvbtovKCDJjGTUowY7CV0llK/im0YakLQIUp6mOW3OGUm4ILzjHeopwZo1WZKY+A/AExANW1IuyM/ZhfASS8VbkxYBy7sSOOUsQZGofZW5k5xMahV3VI55ainkR7MAJiheTKjO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeSeOipb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d9b4f93f0so426401a91.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633654; x=1778238454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HALLtUgaTuc9QAZd4EIJCwVvzb6x8jv+HBAmz8DHBns=;
        b=GeSeOipbE0gz+hTdAwXJgz1mcqoeVu7YdCcvNgGXSjABaXiElWVjPA2i49Hf3ombuS
         nF7KZ8rcingDW3S8IEg+hv3+6UyQVZjoAxGs2RYaf6tusOW521Qh3OPwz+r37FyVDo7e
         fJLt0O06gzjfNiMgpMqNBKaKWp6gLhz3k1Ftk7TUNa5XRLPwnYuQipqYKvVYvLAm/387
         tdCs0PXnWvSwXJP7I8xI2ih3ij6isp6mB1KUjiCmRuNhyH0wdvFfnPLG3dfTXhlZdvIL
         ehq/8OcOz7Fb5Vwh/AWpimr5mQFLtN9b775zopgrkF97hOfY3iUhaCkdDjO9BEY0Z89Y
         wkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633654; x=1778238454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HALLtUgaTuc9QAZd4EIJCwVvzb6x8jv+HBAmz8DHBns=;
        b=ZsCOEVLgKIyT9fmhOt3e9yqtiIjjRpw7xSIShGusvazL9gfsck0gcS+koHHd50J0CV
         x2bv/c4FRgUUtpAwayqksq5CfZRPGQy0o6YbvhgNzV0/x6q/faASjWFFjmfMOPldPpYo
         hKdLRAtDxBlJZAIswLDXAc2lPA4gtxjEj4kFgL7ZRvvPjyyOjjAw7BqmkaWKRuzAXepg
         BhvxH/DyYQwrI52thKWEPnCzlCRAEhnIVNb87YV0ad9ybz4XVb6cCelEpK+hh04eprnb
         DSNl/Qc8rGaUZwseRIFfRDve3hoga5VAQkqltoA4v464mT4WtW1DVcBP5naJh7kHzXpf
         FB5g==
X-Forwarded-Encrypted: i=1; AFNElJ9DJTMBdByPWgKJfP3d4lfgoQB71KwEClknvxuQjboyvcR5Cv9fEbO+OI2P+URwZ2uunehwMO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuS7hWKuvcRj2M6IcDj4OMk9gYi7w0ucL3N8y4oQ1IdzoynaeW
	YbVWqz2c/25du9gw2Kpcp1aQ1T/1pwBFRtafv7UnWxdgZ4nkZo/sRZ7R
X-Gm-Gg: AeBDieuIvk0tXGDvbTvY8vFoiUZM6apbtO/3K6na84GDo3cYBa+0jl3jVu9NELmlsV4
	3rjoOI5qus/xr19TEYuO4UF4AGDJtF/AlqT1YS+OtkQXm2ia6gESh8lyHVnlNoY77MvfWBENURa
	LnsbMc/ZI9cPMNXv2UcbgVdQlWw20XGoKJZ3FR/OCqgL/r62kIHiPem4UyVSWdu8iv09vq+CU34
	03FLcBw1rUrfwvB4TKS8bo88M5nzMSOzeqeV/ZohMZxWVruRvUXWf3UuKmxpW/6Ut+cr6CFfnkF
	RNaSG4aQJnBjYW/uzuRpzBxMU0UwLwvSLRJskSr3SyiWzJrMFXN0zIo6fesBlIZe93YB9OiqW84
	KGAgvXts+zSY3eoAYIX+808J5tTASUbWMYxVkkuasOL/kKhasB6emEndFjmsxokzTWtZltKdHwL
	VJQDO3RfxWkzAW8ETAVH3pPDofTlM+
X-Received: by 2002:a17:90b:5605:b0:362:bac0:1f54 with SMTP id 98e67ed59e1d1-364c33dfce5mr3958572a91.6.1777633654275;
        Fri, 01 May 2026 04:07:34 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebd46484sm2827597a91.0.2026.05.01.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:07:33 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: w@1wt.eu
Cc: pabeni@redhat.com,
	horms@kernel.org,
	chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v6] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Fri,  1 May 2026 07:07:12 -0400
Message-ID: <20260501110713.145563-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427190407.1248872-1-horms@kernel.org>
References: <20260427190407.1248872-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 171D34ABE41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-242311-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 20 +++++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 18 ++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  2 +-
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 7968e208d..adb29d30c 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -457,8 +457,20 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 
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
@@ -468,8 +480,10 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
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
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index ae632ef96..f869e4ed9 100644
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
@@ -191,7 +205,7 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 
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


