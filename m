Return-Path: <stable+bounces-214929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMHXIgfbiWlFCgAAu9opvQ
	(envelope-from <stable+bounces-214929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 14:03:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 396D810F5F4
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 14:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2AE30086E9
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C742225408;
	Mon,  9 Feb 2026 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXm0byws"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA923EAB2
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642170; cv=none; b=NEWxBP3L/nf5etqpc6nXaGAvmnPRt03DGD9GQ2OCr1AQOmiIqsWFZdm+NS5ijX8WFwLpLAEKGn9tUxzUI3+PAO5xINpb9yOJgTl6O9D2yXYC0FaxO4TZg165ftuFRcn3CE0Ljkiff+kER+2sXF0gbcHK/UIemoDI5GTSc2PQ5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642170; c=relaxed/simple;
	bh=vk96p5s19CHeHXoa40H2jfcDoGL9EZL+Ry+DzAxsOQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftJ5LJNDuupo06Ck+hdpXddtOrx8B6BPDty3RZQJNYpWnFN0gtzsrak87GkQv0qGasaRyYkZQqWEbF8SpF4kcPyWDSt+X/y2ArR2Anso1W8LISLwlFzYFZvsR5TS68CFjaiRPvVpWYBdxgm0xAinA1rTu/GIIuRYi7obKTMTiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXm0byws; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so36687715e9.3
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 05:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770642168; x=1771246968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K104M1EIvczT9i5pFYNzZQw8w2hNxTXiWMIDYaFvMKE=;
        b=eXm0byws707Bv3F/Nl5tXEp4k8hOZ4sr29p7ZCekcXl4BEtu0Mm+FvXq0bFmerVTyR
         BYAcwz1uHZ13Yta//pY7AKpz3VlycgumACnDL0z+e931rMOHj/igM6n7+Go5Pg73+nn1
         vtFx4xw1oNkbVVnml4XDsjwur5jngEm0N5ogi8QU5s5C8GenE2BHaSCcPg2TqiGC7HMs
         +N/MLxlOXncY0sjXoi4tm+7VS4JAfn+itvxTFMOwqMARKkf73R91GlDstYquyB35RqzU
         i9QGbklX+95H7bAJFmNjt7tyvuAv54Ude8JkfEzDTifqWV79Ce+u72WCFnM7HXnOzUId
         m3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642168; x=1771246968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K104M1EIvczT9i5pFYNzZQw8w2hNxTXiWMIDYaFvMKE=;
        b=l1S7cXat+UCi8Wy/k87MAN7BNozh+3aWLptCkzjZD9zPn2QU94g6v7DxCa3X1/mXWS
         PbLCPAJXppa2w6ojtHnIkPIVI+DozVn7VdnIJLmyEvZP6eGPglEBqIU6nu+MphKZncaA
         mtCje4Fa+FjAt4DHLm0flKMxp8VrsnqA8fVoRshiB9VbnzehRgH8hWNX+oN6ZMOJfPqB
         VDDwF3BCsYSpRwAVkm1dSiAN3n680GnbKuBPxaOcTyY7dQ64xY6tXTomngiUwITsri5b
         krKuTgVoHDGqpNdOF6nnXLAAPn7lYYGyeJwkLTddGXmQa4EbgNbok7tBtuej6E1WPwhn
         GGww==
X-Gm-Message-State: AOJu0YyoE2MOIEM3/uh6TMxVzuHKniVRed3G6W3NAlqhWvNkn7bXlPHv
	+csrcsytXjJydxGC7bUGRJ/9dymUccv1SLdJoMyFfd8p0gwDK4HQNeMKH+BWfQ==
X-Gm-Gg: AZuq6aKK4mXaxiRAqf8xiYrydKul2KZ6mPS9eyzuR3K9IE9rEfJvo4gr55+apy6pTSU
	ckPvcMFEZy+CwYDIceyBx5OFt+q9kuLKbg8nn1gWVSbDMpBECFr4P1SknS0QD+cXXVVf0xN0LvX
	cFAf2TF1M1GhwJhlK/rzCdNJSVUsJiI/Zluu8KAvOlkqMJlzP81n1vuMzwOsta4LyThCNeYeE4w
	n7Wy4Q5qOVLD/2BZq+rwGSdCN3kOsVR1cbdI/oVYpgefT3rOmoaWu2y8XQVFPOTk5G9uAoqJzRG
	R+mTCOCvwt1TBBL72WMyLSZm2Nffxuv/42X/RxToLUY+2/pg6wFmxFxuxZ+LXubj9irfCiev31M
	KoNJdyBHfAVlicOTFpFKEOEcAi7zNBRLM2WxEFyrVLscgyubcKZBV8YWOGiKctI66jvsjo2TN2l
	9QdvWWBLmknagnC4dhCONvGjgopWQpThbU8Zdmj9wFc0HqjGUDG+CyhMzFr8YGV73/1+2HZkqox
	hvvE83DV5IMuPbUXx0MUTKnzdiiKdk=
X-Received: by 2002:a05:600c:5253:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-48320212d6emr149743655e9.22.1770642167596;
        Mon, 09 Feb 2026 05:02:47 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320719bf4sm236847465e9.10.2026.02.09.05.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:02:46 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: stable@vger.kernel.org
Cc: Daniele Palmas <dnlplm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH 6.12] bus: mhi: host: pci_generic: Add Telit FE990B40 modem support
Date: Mon,  9 Feb 2026 14:02:41 +0100
Message-ID: <20260209130241.1319066-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214929-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com];
	RSPAMD_URIBL_FAIL(0.00)[msgid.link:query timed out];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabioporcedda@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 396D810F5F4
X-Rspamd-Action: no action

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit 6eaee77923ddf04beedb832c06f983679586361c ]

Add SDX72 based modem Telit FE990B40, reusing FN920C04 configuration.

01:00.0 Unassigned class [ff00]: Qualcomm Device 0309
        Subsystem: Device 1c5d:2025

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://patch.msgid.link/20251015102059.1781001-1-dnlplm@gmail.com
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index abf070760d68..73889a7dcc13 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -744,6 +744,16 @@ static const struct mhi_pci_dev_info mhi_telit_fn990b40_info = {
 	.edl_trigger = true,
 };
 
+static const struct mhi_pci_dev_info mhi_telit_fe990b40_info = {
+	.name = "telit-fe990b40",
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
@@ -792,6 +802,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* Telit FN990B40 (sdx72) */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x201a),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990b40_info },
+	/* Telit FE990B40 (sdx72) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x2025),
+		.driver_data = (kernel_ulong_t) &mhi_telit_fe990b40_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
-- 
2.52.0


