Return-Path: <stable+bounces-198224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37100C9F31F
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 14:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E5E4348CBA
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3242F90CA;
	Wed,  3 Dec 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj5ilBPc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C72FB963
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770044; cv=none; b=mrqOrTj91WDHi4UNmJHmCgp9RBZQLLOErFNYptQplIOe0f6hQ/FqOz8q/CErDsHpR/67C9Z6iFiHHcKzzmgiaz2H7/oNwLC6TTwJdxp9pDwSEUpbKCrY//jkCxHahnefXwEYk60yt3Q2tidgJMlbG6c1z3E98uHyyUSv4tHcHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770044; c=relaxed/simple;
	bh=zH2PKrfPlxwtdF3X9LqBt5Z/eXC9XeGkjygYrrB/tYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuh+wrgd1rmB6N+0QhZYSd76RyfHCZ3uo5ddtkuBNJiNSNDx0VyP2RKMHZhVoJa3pMt52BZx6PHQWtkVuwrVKE1CsYh2zI8ZzhB3xIzkobBujSiuvd7vn5MUrp6z14artTKcStGM7KaqQ4n5w4r6P1rC5adR55HTpDEahzHqv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj5ilBPc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso51425475e9.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 05:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764770041; x=1765374841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gmAM79L0urJOkGk5BdJYyX+Tz0Pp5q3Q6ArqpzSYNE=;
        b=Sj5ilBPc/4ajbmOHXTuHDU9GM3aKusutiJyJfgBkZZubc0jPFVh/h9UPrrN45GFYTB
         Pahsz63L/RDNochMcxonPj8ZwE67DlFZgFoCp49I5ag5KClxRu9ihT/ksKx0+JfuFezd
         AcbVFCfkete0kTQLmawb+EeKOsraxVpSct7jnE7Fmsd8xyOe9xoVgM6m6Oc1TZ3wGamd
         IrfnSqQFGKMLJSb770G5BfG3k2/ekpqDOoDoBLNQ1dnkKZdgFVLfo67AbtDsVNKDnHX8
         4lMMMb2ypUvStaAoVJ5VtPcRMtfpBRBz//xObjAmpLQ8MtUeXiGbYGBu1zQ9Owr/70CE
         Op2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764770041; x=1765374841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6gmAM79L0urJOkGk5BdJYyX+Tz0Pp5q3Q6ArqpzSYNE=;
        b=IGQxUrA7ewv/X/sS1Qv20wwrAG/rPyzbAHwHuTsOzx9zTu0Bcj7My7Ds8FtCtA4mHX
         VyNMHUvjeGpi9zwAkYUoSNJys+MBWJv3JFx26QjjeIWsZXLmk8EHWmAG2IwaxIu5Zmun
         g8T9yxHLm8cUygMuU6Ks9hc3mpiOPSaFy81gjhn+Zo/wMHwLSH+AbEKViC3bUvZF9jqd
         jXTtf7w8pOru8gHsjkzfvH0xwusCDBj5jLCwbwej8FPHRwzOk7gsrFujBJ3Mar7LFgCn
         QfWm3eCZbcwcJp2ov1bNHjvk+/auNhkpu9+QYtts0yqk0rpvAHE2hD2EoHp6MOWCpiD+
         NgjQ==
X-Gm-Message-State: AOJu0YwIrmLFlsoS2AgM8TItfA4BUOGU3/g77pv5eon52oiis4nbbpu2
	XAjEtrt0MPFFQ8MIBihfSTqKuYF33Q2edjd+1xjUOwG7HeCW8NRfiex8c6PNog==
X-Gm-Gg: ASbGncsTV40z1neQf18aH/FCWEMz43zXcQe2KB/v6XaJcaAKKioSAYskKhsv5ly8mj2
	xCtSqT59Ttl55w0jGO2KB8k/ZncLkDzq7a7vu/Bie+9y1ZVm2ck5AjGNn53zsEU2C0QNBhBU8AY
	2vUwmH3Xm/73wICeDSk/mpNH3pLUww0Eh3MwbTDW0VysiFM51MLquOfZIjnuGq+1wTZWPHQW5Hs
	/8Fj9XtcKA+s1CLhxZFFRyA9P3ZVcOTAl4au7cv2rvW/kDcMF5RWmV5fm5uOBkHbCKrakJNfFEO
	0m9LuEqsVSwY407Z2/tIxEIGO2pKF3mZVpXXp/5pR0i7gdYkMo/yvOQHrvh6cjeA5GBCi0ipOG+
	MY3UHIjYI6Pkf7NKZIXnrywBwf5QgUrEAvIShwMkrkxCfmzMPnpRqsdUC1yD1Cul9ij9E4L24zy
	yG4MrNjEsaelewHhy81GmjyMGfq3SgdNYJ83R5sggTlG9ycsnn3dyzuqhBQlDVfdKhMSAy0oNMO
	CdcVLtP8DDTp37v/n5p++GhFB9muZg=
X-Google-Smtp-Source: AGHT+IFNsQjyU64y9iSDrc/RmB+GP+KFMTNCOG7l14/Rm9rfloIWa0YLlJjHBN7TJSs2QojrjfBpqg==
X-Received: by 2002:a05:600c:8b16:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-4792af31394mr23140715e9.21.1764770040594;
        Wed, 03 Dec 2025 05:54:00 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca8e00fsm40433575f8f.34.2025.12.03.05.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 05:54:00 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev,
	Daniele Palmas <dnlplm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH 6.12 1/2] bus: mhi: host: pci_generic: Add Telit FN920C04 modem support
Date: Wed,  3 Dec 2025 14:53:52 +0100
Message-ID: <d2b91b3097c693f784393a28801a3885778615df.1764769310.git.fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764769310.git.fabio.porcedda@gmail.com>
References: <cover.1764769310.git.fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniele Palmas <dnlplm@gmail.com>

commit 6348f62ef7ecc5855b710a7d4ea682425c38bb80 upstream.

Add SDX35 based modem Telit FN920C04.

$ lspci -vv
01:00.0 Unassigned class [ff00]: Qualcomm Device 011a
        Subsystem: Device 1c5d:2020

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://patch.msgid.link/20250401093458.2953872-1-dnlplm@gmail.com
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/bus/mhi/host/pci_generic.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 6505ce6ab1a2..b8520ca40e8c 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -698,6 +698,42 @@ static const struct mhi_pci_dev_info mhi_telit_fe990a_info = {
 	.mru_default = 32768,
 };
 
+static const struct mhi_channel_config mhi_telit_fn920c04_channels[] = {
+	MHI_CHANNEL_CONFIG_UL_SBL(2, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_SBL(3, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 64, 1),
+	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 64, 1),
+	MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(92, "DUN2", 32, 1),
+	MHI_CHANNEL_CONFIG_DL(93, "DUN2", 32, 1),
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
+};
+
+static const struct mhi_controller_config modem_telit_fn920c04_config = {
+	.max_channels = 128,
+	.timeout_ms = 50000,
+	.num_channels = ARRAY_SIZE(mhi_telit_fn920c04_channels),
+	.ch_cfg = mhi_telit_fn920c04_channels,
+	.num_events = ARRAY_SIZE(mhi_telit_fn990_events),
+	.event_cfg = mhi_telit_fn990_events,
+};
+
+static const struct mhi_pci_dev_info mhi_telit_fn920c04_info = {
+	.name = "telit-fn920c04",
+	.config = &modem_telit_fn920c04_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.sideband_wake = false,
+	.mru_default = 32768,
+	.edl_trigger = true,
+};
+
 static const struct mhi_pci_dev_info mhi_netprisma_lcur57_info = {
 	.name = "netprisma-lcur57",
 	.edl = "qcom/prog_firehose_sdx24.mbn",
@@ -720,6 +756,9 @@ static const struct mhi_pci_dev_info mhi_netprisma_fcun69_info = {
 
 /* Keep the list sorted based on the PID. New VID should be added as the last entry */
 static const struct pci_device_id mhi_pci_id_table[] = {
+	/* Telit FN920C04 (sdx35) */
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x011a, 0x1c5d, 0x2020),
+		.driver_data = (kernel_ulong_t) &mhi_telit_fn920c04_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_QCOM, 0x010c),
-- 
2.52.0


