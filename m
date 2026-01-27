Return-Path: <stable+bounces-211695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB5hK6EOeGnRngEAu9opvQ
	(envelope-from <stable+bounces-211695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:02:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 057938E9B8
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FDA63017C38
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 01:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5F204583;
	Tue, 27 Jan 2026 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wE4SUt2M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D818CBE1
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475739; cv=none; b=EOEJGUQCnfre/vih/bup9agCKtmkezuHlIiv9GwDJh4hh39idbIXegXqeq0odwxAQDfPtKNxxc98cMd3j6e5BnLM5OF50Qj/1z5D5fN54Zv5KkfZnxkslzvhChCNVl9XRAvLVWRT5WsfEu7U7K1wKr3VAuY/AVwM1ODW/gzLoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475739; c=relaxed/simple;
	bh=zdJetp1O1ZvORiNn20moSdrXX3DYESBa1u9PB56wF/g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZoSqOLkKnkZaDsWxklV0iLEn86Jkxbyxu4Stj3WKWPuMHEQ6w6a9jtH1+gXqlySbAq65ZfUs7g+NiqyUm6rv2HkYbk//e0qQxKJGw59MJU+M48mHe2JI5KhCEt/Ktdi8kHEr4f3z33RrReNW7DssweWTg4Jzhd0YgIQayl9Nsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wE4SUt2M; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so4464049a91.0
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769475737; x=1770080537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4NgOfh1zEVM6ALsnvG7+EC5XrWm0zt0eNhDfo1U5SRc=;
        b=wE4SUt2M1jZnWGP5HdQKkElDQIrrIROm3081rBvNg+Fo7Un1f7r4oGEFg+WWllCbkP
         TXs0qsV0MnezNzs8tX2J3HWmBmE03x+kuGQgaFI30yIve2AoZniCc5KsAqA2V2sO1wT7
         +3HtkThw7xNu3SYbQyQlV5/jJlRhx1zGZnvdkWa4lnt/eypjfHq2HEPEeQZC8tV8Dcip
         Pmuq5q5Igd7sbtRs/XmKFzVjXSrPcBdXW6/7gbUSDtIpEH0QMqRD6F0t5NuB1+v2zlFu
         jgZnL8X89LvEunTM5FBMdCw0L/axmGznuFEoTm9ixhMmMriMbiHp/p8uPA4ne6HOaobk
         0ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769475737; x=1770080537;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NgOfh1zEVM6ALsnvG7+EC5XrWm0zt0eNhDfo1U5SRc=;
        b=C82M70FLZplsixicae50PHAOyLcQfyFBcyIUJ7tqS7gSq92zCiGHjnm28pg/JsHMcI
         8pFj51jQi4OQEBymbjad4qZUC8/Zt6KEwTwk55uGpugxtd8/OBvbpgd2Tl7WGoz5B5FN
         zUp8ie7SzpbAGBJ7cRtC1jNUHuqlrIXYUkad+bkFHhZiz+0c38VRgCuiXZKcE0vK9oSQ
         zzqyu8eDPYsjIF+BjcbJKxgyOlB3eAomJPDDkJd1+VNc9DsuU4ZIV9R1HJPPHFP8dN0+
         +ST0hgDQr1yXRN7E/GRys5k/c7ih0WxCAbMEsxY9qirq9XJFAZVuvtJfGTX5Sp5SAxKW
         QXhw==
X-Forwarded-Encrypted: i=1; AJvYcCXeMQUkvwj2tfDkzT8yvu766I70puov578UnqbleUJGZBW8nZ5tyKVFo79nXwAaLoez8CgiqVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOrakua18AZTbqwyjC/HaeJSzFUWRxif4GY3Lm5fnq1+0hpYe
	BrG67evj2DepuSFSwM3rk0g+hIYrF/4yegOs+aHjSOjNWdWXcX/vYPl/8T9AmXlDEVg4VIcEnj0
	x3OrN8kOdxups7gh00z4+nZy5JA==
X-Received: from pjbjx12.prod.google.com ([2002:a17:90b:46cc:b0:34f:8ef8:5834])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d83:b0:34e:5aa2:cf68 with SMTP id 98e67ed59e1d1-353fed8a891mr81138a91.30.1769475737301;
 Mon, 26 Jan 2026 17:02:17 -0800 (PST)
Date: Tue, 27 Jan 2026 01:02:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127010210.969823-1-hramamurthy@google.com>
Subject: [PATCH net] gve: fix probe failure if clock read fails
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, pkaligineedi@google.com, 
	ziweixiao@google.com, jordanrhee@google.com, nktgrg@google.com, 
	thostet@google.com, horms@kernel.org, yyd@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Shachar Raindel <shacharr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211695-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 057938E9B8
X-Rspamd-Action: no action

From: Jordan Rhee <jordanrhee@google.com>

If timestamping is supported, GVE reads the clock during probe,
which can fail for various reasons. Previously, this failure would
abort the driver probe, rendering the device unusable. This behavior
has been observed on production GCP VMs, causing driver initialization
to fail completely.

This patch allows the driver to degrade gracefully. If gve_init_clock()
fails, it logs a warning and continues loading the driver without PTP
support.

Cc: stable@vger.kernel.org
Fixes: a479a27f4da4 ("gve: Move gve_init_clock to after AQ CONFIGURE_DEVICE_RESOURCES call")
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Shachar Raindel <shacharr@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  5 +++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 12 +++++++-----
 drivers/net/ethernet/google/gve/gve_ptp.c     |  8 --------
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  2 +-
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 970d5ca8..cbdf3a84 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1206,6 +1206,11 @@ static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
 	}
 }
 
+static inline bool gve_is_clock_enabled(struct gve_priv *priv)
+{
+	return priv->nic_ts_report;
+}
+
 /* gqi napi handler defined in gve_main.c */
 int gve_napi_poll(struct napi_struct *napi, int budget);
 
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index f7864ae7..137dd728 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -952,7 +952,7 @@ static int gve_get_ts_info(struct net_device *netdev,
 
 	ethtool_op_get_ts_info(netdev, info);
 
-	if (priv->nic_timestamp_supported) {
+	if (gve_is_clock_enabled(priv)) {
 		info->so_timestamping |= SOF_TIMESTAMPING_RX_HARDWARE |
 					 SOF_TIMESTAMPING_RAW_HARDWARE;
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 96adbbe1..dbc84de3 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -680,10 +680,12 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		}
 	}
 
-	err = gve_init_clock(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev, "Failed to init clock");
-		goto abort_with_ptype_lut;
+	if (priv->nic_timestamp_supported) {
+		err = gve_init_clock(priv);
+		if (err) {
+			dev_warn(&priv->pdev->dev, "Failed to init clock, continuing without PTP support");
+			err = 0;
+		}
 	}
 
 	err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
@@ -2183,7 +2185,7 @@ static int gve_set_ts_config(struct net_device *dev,
 	}
 
 	if (kernel_config->rx_filter != HWTSTAMP_FILTER_NONE) {
-		if (!priv->nic_ts_report) {
+		if (!gve_is_clock_enabled(priv)) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "RX timestamping is not supported");
 			kernel_config->rx_filter = HWTSTAMP_FILTER_NONE;
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index 073677d8..de42fc2c 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -70,11 +70,6 @@ static int gve_ptp_init(struct gve_priv *priv)
 	struct gve_ptp *ptp;
 	int err;
 
-	if (!priv->nic_timestamp_supported) {
-		dev_dbg(&priv->pdev->dev, "Device does not support PTP\n");
-		return -EOPNOTSUPP;
-	}
-
 	priv->ptp = kzalloc(sizeof(*priv->ptp), GFP_KERNEL);
 	if (!priv->ptp)
 		return -ENOMEM;
@@ -116,9 +111,6 @@ int gve_init_clock(struct gve_priv *priv)
 {
 	int err;
 
-	if (!priv->nic_timestamp_supported)
-		return 0;
-
 	err = gve_ptp_init(priv);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index f1bd8f5d..63a96106 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -484,7 +484,7 @@ int gve_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
 {
 	const struct gve_xdp_buff *ctx = (void *)_ctx;
 
-	if (!ctx->gve->nic_ts_report)
+	if (!gve_is_clock_enabled(ctx->gve))
 		return -ENODATA;
 
 	if (!(ctx->compl_desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID))
-- 
2.52.0.457.g6b5491de43-goog


