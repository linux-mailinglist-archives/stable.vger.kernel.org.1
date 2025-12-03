Return-Path: <stable+bounces-198225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F08BC9F325
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCE4A348A7E
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652C2F7AA4;
	Wed,  3 Dec 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKAty9kX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7E2FBDEB
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770048; cv=none; b=FgK0HCYdQJ+RoxcU28Lt4+dgGkuyLEmF2XflCUobcmrMnQRu4mmoEKJBND0guKtS6WK6PU7sv6VyllKwBtu9pfbsNanhjDo8N8IFlM6Yq55lyilA6JEL9KC+IQdZdvvvvOasVz9Ac/3UzVSTasOpKSOOVQqnvPiv1pjR4K9GVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770048; c=relaxed/simple;
	bh=DF6G/XFdIfJQ7qeQs0VYU3rAkTrUx9BZ15KmoHCPoLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GutkTUnOdc3vmUdk+Secaqw8Oqb2X5orwDl/ID4ApzmLqX5dyoYTNKOMUKzK8Qk5UXtp9ArPYOAQ7U8KLs6BgH6x0RWE+puoWRMF33qQ9ay2cDtTLv1NVefzOzst/fGEhPGxQn0lHL7madEdRgcZkTYKK24SHMqVcnyy9BKlGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKAty9kX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso51426105e9.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 05:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764770044; x=1765374844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU5E10zMYIkw7ZF/4aNGAYwgRL3UWcgkSyY4TJegpo0=;
        b=jKAty9kXCw7FtGhUxU6i/YkBqAtihXDoZc+bYNU4BDccya2pAg/i6TkoOpSZzOdK3F
         OF1ufFJl8uWYHedeIAwt0s7v/1uYizz5tUutcK7fHpwhNzAzqkBFJg+qs2NU7wQvm3pz
         bn79LnenpiHDnUpnch270XbmBuFzdUa4TAeqJBHXQpr+8t2IzUOCKhniOUkg3HuoThqH
         NEFatmw32+GrbfrkYq5Ew83bFM9obnTIPOqv2CGL4FQY4pqoTmCau63M8ZX0RYvPEeSz
         0N68W7yInOPlJ9iwtTTIIT03zfOYO8p0Bb585d6asxYjuUqjSxzFuONFzdD7MgH9JvFH
         Z8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764770044; x=1765374844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kU5E10zMYIkw7ZF/4aNGAYwgRL3UWcgkSyY4TJegpo0=;
        b=ghPVM19t8t8k4TPLMLOe7Wx24yjBcuKcr/nQy5wfnnRgdWLYiv35nx+Zws8FQslbRL
         hQ3pDGsqstp4Bh0m2ssPUx6E6xIZNaBTl1EafoCvlTiSWWCkbjV5SPiUNdqSkHZHKR2F
         6a6iZvoZZSyS48Zf0QVVJuJ96p0LGEXLu0q+JwCYCiF7iy0Rr+Q/JH0/tQVMk4cIhyAx
         OjGhMjyG2+plnGF4GFPHWcuzfXAdR7kO2Ba8unetp1aNq7JPg23zisMQpRDV9PsOQsSO
         A69z5jADEAUYxnCejrevyXi9G49+/foGNtGyyJS8vOQiSk9mI8XWJNVNR3dqon1PJ/B3
         ppxw==
X-Gm-Message-State: AOJu0YznjRDxYVDBkZzGvRl5RoAf8R6oiO5TTU7SHDSVi3mwXB0vqjx5
	dvaADR5KcwUZOpxrHXLMkbZGUMDRMohlfSmAJLNopoVVweT2U4AaO64k6rvwLw==
X-Gm-Gg: ASbGncs9KD4SiK0l2cGpLMADeG0BDrHjdD5hCV5/a3K+6bmshUNi50Y9+dm23mqnRuP
	NR5FnuxP+qJMvnGXgPF40CqZWqfu0oyFFHeNiciBWAAEaSC3AglHljOVUhdL2683gZUT3Lej0yW
	+x26cpJSeMZfHJCWBpwnSFmTluXTgRCJUiNSexY41TF3Mu5G5sd6oEo0PB6QaaUCpnh04WF6V4H
	m8g1deNS7rHS+uERlzKU9UzUfffw9L8M5uvY+eE6RVHNOuI+QeqfIwUXnqkoZDGzE+Y3RyMELAA
	ykLrxhLnye07UC8EubJUIRXo/UklJ9dM3jbT8RPLkctcF4GdgZC+DYY/2MrTbRv3mZ0hFJqr4Kl
	6yP99vk65VJur44r/CH/81Inm7N+T6TC9R80fiyBPWzysoTzA7646rDGF6OcjhqbZIihNPDHZtP
	w4Bjjo9NSFEI1UosX3QZPDgYpDC2eAh3CX/Jno1Jtre1TeGVKU1g1mEliuC/Hr7VxqqRRoJ3ACl
	mObyRjwQCdgfRwz1DiW8jtfsFHnBQX/wVdmgH5pYw==
X-Google-Smtp-Source: AGHT+IFXgqjYg+s9C0ZBpSRfYz1JGeFjdbj2Fq/FubajeWelCOReDZbc8uwYFRx72hU/FuPHbhayig==
X-Received: by 2002:a05:600c:524d:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-4792af30ea0mr22550265e9.17.1764770043606;
        Wed, 03 Dec 2025 05:54:03 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca8e00fsm40433575f8f.34.2025.12.03.05.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 05:54:03 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev,
	Daniele Palmas <dnlplm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH 6.12 2/2] bus: mhi: host: pci_generic: Add Telit FN990B40 modem support
Date: Wed,  3 Dec 2025 14:53:53 +0100
Message-ID: <5091bf715f9ecf449b270af23352be15e4560df7.1764769310.git.fabio.porcedda@gmail.com>
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

commit 00559ba3ae740e7544b48fb509b2b97f56615892 upstream.

Add SDX72 based modem Telit FN990B40, reusing FN920C04 configuration.

01:00.0 Unassigned class [ff00]: Qualcomm Device 0309
        Subsystem: Device 1c5d:201a

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
[mani: added sdx72 in the comment to identify the chipset]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20250716091836.999364-1-dnlplm@gmail.com
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index b8520ca40e8c..abf070760d68 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -734,6 +734,16 @@ static const struct mhi_pci_dev_info mhi_telit_fn920c04_info = {
 	.edl_trigger = true,
 };
 
+static const struct mhi_pci_dev_info mhi_telit_fn990b40_info = {
+	.name = "telit-fn990b40",
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
@@ -779,6 +789,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_telit_fe990a_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
+	/* Telit FN990B40 (sdx72) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x201a),
+		.driver_data = (kernel_ulong_t) &mhi_telit_fn990b40_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
-- 
2.52.0


