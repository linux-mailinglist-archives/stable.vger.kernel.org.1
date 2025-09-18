Return-Path: <stable+bounces-165979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1180B196FC
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0683B630C
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCC7129E6E;
	Mon,  4 Aug 2025 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwHxzaa6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC4481DD;
	Mon,  4 Aug 2025 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267051; cv=none; b=OS0zqmWQ/e1rq6i6b5oBrdjnAnxZv/Oqr0APwFDOpZH11FYahQtK4v3xBO6FArhLju6TBA6NoIp03FqWl08wbEC2uChszGYrm89unahE/UA1Fdz6Q0RAUQUASiKEW7K7dfX80Eeu+JBmmyS4I2gCUF2VZ9GRAHgc+5Eegm9a5DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267051; c=relaxed/simple;
	bh=L3afjqCzpdfZT8/wqFNVDEpuWOwL2SuP7Op3WUPYEgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SfigWEY9S4D76Ps7/UTmYJEtHwjwJNIm1S/Ym7xiyOWyx+t2VFtera7gn6SORnzo3Qvdem0LZeXrbQzcdi8ofTzK24ikTQCmO3d2n6Klkf1vWporNp4o0iY3k/bXrKbqBA3Wv1I+cP2PRiS37jnsRqAFDV3tFQBGjotTK8nDX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwHxzaa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0CEC4CEEB;
	Mon,  4 Aug 2025 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267051;
	bh=L3afjqCzpdfZT8/wqFNVDEpuWOwL2SuP7Op3WUPYEgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwHxzaa6SS7XQycJhSxsUIa98tTYgrd4Izh/POvm1DN3ABaXy8P8qdwFQX1TFh2gp
	 yx3ka3xKxoczyoc0CeiABbUva4CHT1XB05cHKuulSIpY0qg9pSQRaBGEgts7HqeOV2
	 W9mY2Qrq1w2uPEedaIsXsSm+zBu+jyfb/Blz3p0wTMrj+Z2Ka3CnVH9lItTzj6ftTj
	 K+4OiR5cHMQlsXyZwPjlGyBYZ8insVXVwU5jZk6c/Cbhk1D+wSdHU2iCpd+SWw5nhg
	 bUSK7A4SiQ5zpjaI1XvpaqffA5q2mRdiExtKT9yqZ281bNiuxuL6Ifp3X8Tdwl6Abo
	 0vLLo2ONao58A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Daniele Palmas <dnlplm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	slark_xiao@163.com,
	quic_vpernami@quicinc.com,
	tglx@linutronix.de,
	johan+linaro@kernel.org,
	quic_msarkar@quicinc.com,
	mank.wang@netprisma.us,
	quic_skananth@quicinc.com
Subject: [PATCH AUTOSEL 6.16 08/85] bus: mhi: host: pci_generic: Add Telit FN990B40 modem support
Date: Sun,  3 Aug 2025 20:22:17 -0400
Message-Id: <20250804002335.3613254-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002335.3613254-1-sashal@kernel.org>
References: <20250804002335.3613254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit 00559ba3ae740e7544b48fb509b2b97f56615892 ]

Add SDX72 based modem Telit FN990B40, reusing FN920C04 configuration.

01:00.0 Unassigned class [ff00]: Qualcomm Device 0309
        Subsystem: Device 1c5d:201a

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
[mani: added sdx72 in the comment to identify the chipset]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20250716091836.999364-1-dnlplm@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's the
extensive analysis:

## Analysis of the Commit

The commit adds support for the Telit FN990B40 modem, which is an
SDX72-based device. The changes are:

1. **Addition of a new device info structure**
   (`mhi_telit_fn990b40_info`) that reuses the existing
   `modem_telit_fn920c04_config` configuration
2. **Addition of a PCI device ID entry** in the `mhi_pci_id_table` for
   the new hardware (PCI ID 0x0309, subsystem 0x1c5d:0x201a)

## Rationale for Backporting

1. **Meets stable kernel rules**: According to
   Documentation/process/stable-kernel-rules.rst line 15, patches that
   "just add a device ID" are explicitly allowed in stable trees.

2. **Small and contained change**: The patch adds only 11 lines of code
   (well under the 100-line limit) and is purely additive - it doesn't
   modify any existing functionality.

3. **Hardware enablement**: This enables users with Telit FN990B40
   modems to use their hardware on stable kernel versions. Without this
   patch, the modem won't be recognized by the kernel.

4. **Low risk**: The change reuses an existing configuration
   (`modem_telit_fn920c04_config`), which minimizes the risk of
   introducing bugs. The new device entry only affects systems with this
   specific hardware.

5. **Similar patches pattern**: Looking at the commit history, similar
   hardware enablement commits for MHI modems (like commit 6348f62ef7ec
   for Telit FN920C04 and commit 0724869ede9c for Telit FE990) follow
   the same pattern of adding device IDs and configurations.

6. **No architectural changes**: This is purely a device ID addition
   with no changes to the driver's core functionality or architecture.

The commit perfectly fits the stable kernel criteria as a simple device
ID addition that enables hardware support without any risk to existing
functionality.

 drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 589cb6722316..3fde90fe660d 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -818,6 +818,16 @@ static const struct mhi_pci_dev_info mhi_telit_fn920c04_info = {
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
@@ -865,6 +875,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_telit_fe990a_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
+	/* Telit FN990B40 (sdx72) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x201a),
+		.driver_data = (kernel_ulong_t) &mhi_telit_fn990b40_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
 	/* QDU100, x100-DU */
-- 
2.39.5


