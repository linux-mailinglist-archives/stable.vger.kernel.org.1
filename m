Return-Path: <stable+bounces-161249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9CFAFD47D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F323D189CF8B
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A1D2E717D;
	Tue,  8 Jul 2025 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bIzxD1Ar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E052E62D6;
	Tue,  8 Jul 2025 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994028; cv=none; b=KLz2Tx5s/2D12ksHojq0LyEs+VEsdA1CNnb6081K+dcwsq34ddVce3da2K3rsFDsU+yjuJUvfezxO4S7HXuiA/Qg/uSYKt8VaOMxc1WzMEl1yMLwZQUxNFeCLruDJgwSReJ3LD9fEH3cpA5JJap9lqdFLmcFBI/mB3SaaVukE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994028; c=relaxed/simple;
	bh=Fx71O8grqpqHhaEV84sQWEEMHQBs5ACkCktUwiGMrEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRnbfe4N3hn/e/HKC+Jgpm4HTBeJbxBhgJdHq+VZyS6L6VfKvdOsJFoHOKKOVGYp3egH/QOnyR4gUtagggBRVIozZ0gSnLpJ9fsKW/5MO7VWyWDQVm1R1Ml/QfHApgmzKwke73r4gfpRBGH7sc5p1BVZCXR1jUX3JctQIJEaVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bIzxD1Ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87258C4CEF5;
	Tue,  8 Jul 2025 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751994027;
	bh=Fx71O8grqpqHhaEV84sQWEEMHQBs5ACkCktUwiGMrEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIzxD1ArgXZSxZ3Hfj+WIHoCCb+0Asx94pcSQ1JNVR7ddRR/88u/otc/+f+jWlB3d
	 n4i08VKtIjbnyocRWEqECWdZZve6O7/Pz1gDEl5dFebj2VKUvMJtkLBGAupZoUA0XZ
	 g1Wj6omtP4u/d7PNPZ5imWDffZSOw3+bBF/CL3+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 099/160] mmc: sdhci: Add a helper function for dump register in dynamic debug mode
Date: Tue,  8 Jul 2025 18:22:16 +0200
Message-ID: <20250708162234.242650513@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Shih <victor.shih@genesyslogic.com.tw>

commit 2881ba9af073faa8ee7408a8d1e0575e50eb3f6c upstream.

Add a helper function for dump register in dynamic debug mode.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250606110121.96314-3-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -816,4 +816,20 @@ void sdhci_switch_external_dma(struct sd
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+#define SDHCI_DBG_ANYWAY 0
+#elif defined(DEBUG)
+#define SDHCI_DBG_ANYWAY 1
+#else
+#define SDHCI_DBG_ANYWAY 0
+#endif
+
+#define sdhci_dbg_dumpregs(host, fmt)					\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) ||	SDHCI_DBG_ANYWAY)	\
+		sdhci_dumpregs(host);					\
+} while (0)
+
 #endif /* __SDHCI_HW_H */



