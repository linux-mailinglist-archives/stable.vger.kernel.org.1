Return-Path: <stable+bounces-161479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19AAFF024
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 19:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB305A7CA7
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5572356CB;
	Wed,  9 Jul 2025 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RG8Tupd7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5622256F
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083399; cv=none; b=Jq2vnWabChPevxvEpKX7Z8q1eoD5biGm3stgazge80RPxkvyupAAFWHQtT8FR+KB4c9P9Dd1vjlVosDsZCoEU5FHRQdYgMEURqsOu2OzYD6ECquCEtiBIxTC0IFFKoc5MiX5NNWWhQJ3WnccjkTMTZBcbilpOQ241AM/WkLgf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083399; c=relaxed/simple;
	bh=fp13JmlXHdq/nQ6HLVzuaBdtpFF8aCP1PCIbRVjcwvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmgR1c3itFFUC38xUQtbx9hx6eUiJhrO46zOphxkra24btAy3gtT1izK7XtRqAcdcn9ysPE8TH6zKQGe9NccEo/aqy+mTyJGt5jl5P1AHJEQlut9ZtFWIMQubS4+GCI7H6ksl9FepCVuZ1E0MQQ+RiO1yHhmcdpoDPdCwFaUzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RG8Tupd7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234f17910d8so2241045ad.3
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752083396; x=1752688196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAZS8c+XOFL4yIQsOoZL8wVWpMH2f81j7GH/LPt+ShU=;
        b=RG8Tupd7yeDy+gWjk8saZVIgp+b8iKmwS40alv0iUHyYmknXrR7xv9U3hgNiyOIs8f
         xgAq8kjfwArGo5tcORB+h6c3t7VdLj79cayaJprX2BFFEbkyZKZHAZbibmTNDqtpYHDI
         TWGmFQT/dIWbS3RAc+58x7eakfNgXCxL4IGJcv5z867a5X97FXPR3KdDVHQ5AAeVqazP
         EKjnD403SDmmUDr2y6NBm6Mvifc2vG8FxAt4jD5pMCe6+ICSzXYKjM3z1UXt+kgqV80P
         6sqoPMKHmYy8MIMvKghvv8DaRfU1C+mhozTpsml7nmYHg49DnYymogqNUZK1w5A4Mo4E
         gvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752083396; x=1752688196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAZS8c+XOFL4yIQsOoZL8wVWpMH2f81j7GH/LPt+ShU=;
        b=XbjMBcs9VI3XbkSLuolsQdJY7SPrLKNnNXzSpaArkFE5M6V8RHps1/m5OfPlVjbo4W
         ETt5MIJnAuwCtf/fuLrqMR4bgmYZR/wSRIFHGwtn+hvFOaVbghiDK+AkNkXzOSJEUWrp
         glFV2zs6nKQpxo2JTWF1ccnwu9ETd5dW8ZzVpqmlbqfbQXxXGSgVv+aZVVk0Oxc7fZUt
         o1CMgOsG6KpY/yuIEfLDVUrZxfcaOOzzdiO4TkjY+i9YQfH5P6/K3lwYhRNMVkfvlYsM
         TzB4tKo4Av17oKBOjw1yd/TqLxwWdw8+LDicuc1qONBmqvBu9DhuK23/mwTbXAIiSJjK
         jrYA==
X-Forwarded-Encrypted: i=1; AJvYcCX6OAxLLdQiA35d4yY+rNHiKuFCMSxrRM10HUwZU5keMWG2e5CuiuDx2zNYa3Jz6CWfUmkhNYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGqwoj94to4jSqX3adUWSv93KZ7OSXWyr90VI5bCpY/yKd4nN
	9BKdSNyel1Pmx4mra/TG75nZH7QtZK5y7b3/Sd349EorP5oYX3Cv5lJ1WFnGUqDDCZs=
X-Gm-Gg: ASbGncuC9djbvhNP0dl/rxx2OirT/Fobi0Q3i7sEjwW2M+YbxgdOX5Tc6vbr8tKU2cV
	awoSTPTfBqun3jadZiHG+lAm1/zvRHx2Dk8DAdUEiIJfpo4ZcuC5hg8U8loRPFnfuwkB/1diHxU
	YfJEChQMHSi+JIJoII6KzsztZN3aDt4p31NtjoGWqRVTm8rI/fVa4kGCd5t+Lla0aqTsxGDdOY2
	CL6GbXnp2Ic1k2VzbLHbrSLd1qF80eO+Xwlatqwi75No75Xz6cPS2WjLIYy/zpZrY11ls4kWVaz
	VHJkSaLMSH13xqgRw/TRoVKJh+jNmoX7ZeqCXxFefMjUG2RQQvxY2aSFw+c=
X-Google-Smtp-Source: AGHT+IGSQWOZmDkajE7cVVeVfEIdL7s4JkrGA77ytx56rAzGuMiLP/gh8mVeauZZ93RVI3bqFn25Lw==
X-Received: by 2002:a17:902:f78f:b0:234:8a4a:adad with SMTP id d9443c01a7336-23de24d9922mr9810515ad.26.1752083396036;
        Wed, 09 Jul 2025 10:49:56 -0700 (PDT)
Received: from x-wing.. ([49.207.58.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee475a3asm14797479a12.17.2025.07.09.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:49:55 -0700 (PDT)
From: Amit Pundir <amit.pundir@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Yongqin Liu <yongqin.liu@linaro.org>,
	Jie Gan <jie.gan@oss.qualcomm.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	linux-sound <linux-sound@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "soundwire: qcom: Add set_channel_map api support"
Date: Wed,  9 Jul 2025 23:19:49 +0530
Message-ID: <20250709174949.8541-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7796c97df6b1b2206681a07f3c80f6023a6593d5.

This patch broke Dragonboard 845c (sdm845). I see:

    Unexpected kernel BRK exception at EL1
    Internal error: BRK handler: 00000000f20003e8 [#1]  SMP
    pc : qcom_swrm_set_channel_map+0x7c/0x80 [soundwire_qcom]
    lr : snd_soc_dai_set_channel_map+0x34/0x78
    Call trace:
     qcom_swrm_set_channel_map+0x7c/0x80 [soundwire_qcom] (P)
     sdm845_dai_init+0x18c/0x2e0 [snd_soc_sdm845]
     snd_soc_link_init+0x28/0x6c
     snd_soc_bind_card+0x5f4/0xb0c
     snd_soc_register_card+0x148/0x1a4
     devm_snd_soc_register_card+0x50/0xb0
     sdm845_snd_platform_probe+0x124/0x148 [snd_soc_sdm845]
     platform_probe+0x6c/0xd0
     really_probe+0xc0/0x2a4
     __driver_probe_device+0x7c/0x130
     driver_probe_device+0x40/0x118
     __device_attach_driver+0xc4/0x108
     bus_for_each_drv+0x8c/0xf0
     __device_attach+0xa4/0x198
     device_initial_probe+0x18/0x28
     bus_probe_device+0xb8/0xbc
     deferred_probe_work_func+0xac/0xfc
     process_one_work+0x244/0x658
     worker_thread+0x1b4/0x360
     kthread+0x148/0x228
     ret_from_fork+0x10/0x20
    Kernel panic - not syncing: BRK handler: Fatal exception

Dan has also reported following issues with the original patch
https://lore.kernel.org/all/33fe8fe7-719a-405a-9ed2-d9f816ce1d57@sabinyo.mountain/

Bug #1:
The zeroeth element of ctrl->pconfig[] is supposed to be unused.  We
start counting at 1.  However this code sets ctrl->pconfig[0].ch_mask = 128.

Bug #2:
There are SLIM_MAX_TX_PORTS (16) elements in tx_ch[] array but only
QCOM_SDW_MAX_PORTS + 1 (15) in the ctrl->pconfig[] array so it corrupts
memory like Yongqin Liu pointed out.

Bug 3:
Like Jie Gan pointed out, it erases all the tx information with the rx
information.

Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/soundwire/qcom.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 295a46dc2be7..0f45e3404756 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -156,7 +156,6 @@ struct qcom_swrm_port_config {
 	u8 word_length;
 	u8 blk_group_count;
 	u8 lane_control;
-	u8 ch_mask;
 };
 
 /*
@@ -1049,13 +1048,9 @@ static int qcom_swrm_port_enable(struct sdw_bus *bus,
 {
 	u32 reg = SWRM_DP_PORT_CTRL_BANK(enable_ch->port_num, bank);
 	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
-	struct qcom_swrm_port_config *pcfg;
 	u32 val;
 
-	pcfg = &ctrl->pconfig[enable_ch->port_num];
 	ctrl->reg_read(ctrl, reg, &val);
-	if (pcfg->ch_mask != SWR_INVALID_PARAM && pcfg->ch_mask != 0)
-		enable_ch->ch_mask = pcfg->ch_mask;
 
 	if (enable_ch->enable)
 		val |= (enable_ch->ch_mask << SWRM_DP_PORT_CTRL_EN_CHAN_SHFT);
@@ -1275,26 +1270,6 @@ static void *qcom_swrm_get_sdw_stream(struct snd_soc_dai *dai, int direction)
 	return ctrl->sruntime[dai->id];
 }
 
-static int qcom_swrm_set_channel_map(struct snd_soc_dai *dai,
-				     unsigned int tx_num, const unsigned int *tx_slot,
-				     unsigned int rx_num, const unsigned int *rx_slot)
-{
-	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
-	int i;
-
-	if (tx_slot) {
-		for (i = 0; i < tx_num; i++)
-			ctrl->pconfig[i].ch_mask = tx_slot[i];
-	}
-
-	if (rx_slot) {
-		for (i = 0; i < rx_num; i++)
-			ctrl->pconfig[i].ch_mask = rx_slot[i];
-	}
-
-	return 0;
-}
-
 static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
@@ -1331,7 +1306,6 @@ static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
 	.shutdown = qcom_swrm_shutdown,
 	.set_stream = qcom_swrm_set_sdw_stream,
 	.get_stream = qcom_swrm_get_sdw_stream,
-	.set_channel_map = qcom_swrm_set_channel_map,
 };
 
 static const struct snd_soc_component_driver qcom_swrm_dai_component = {
-- 
2.43.0


