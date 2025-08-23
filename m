Return-Path: <stable+bounces-172655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99625B32B2C
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE27AAA5458
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C31D232785;
	Sat, 23 Aug 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECId0sA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22081720
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755968108; cv=none; b=LHwlvzifC8a3fm8Gkcx2qxglIvPowxCFqZqo21GLdSkDAv0F/dtbPsjhJnqDf4a2LuTHPYehmlaKomJDMndLija4sfnj4Jw16BjW3Q5ZY3h9qY+cH7hm4d1k2Fb9A07LgU1lEl5F9XBHXCklG5p0iGgDII40GnjnaSxM8Sd2+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755968108; c=relaxed/simple;
	bh=p8UjrgxjDwLDf1QpNfcyF7eZqjHg0roZLH2ImWdwN/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rivTFN9DXdQg91Xv7hU4wNct9kuvITB05MlyV+gkH+mTe5a8fQJACcHIyZUavM+D4lP2AXjUYX6cYMHC66uZoBLp3T4VhjXncY3vLjVOsCVnk8Rm2snok5KdKZWIIIBeNB2ixgDQOZoIseMYv5bczIjNeDWHmwdEkZ6qY3g/swA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECId0sA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C849C4CEF1;
	Sat, 23 Aug 2025 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755968107;
	bh=p8UjrgxjDwLDf1QpNfcyF7eZqjHg0roZLH2ImWdwN/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECId0sA8fyKt+ICAJW433cZ1qTqWsUddcLU9GwgAQk1xma1QkON55PwHllGlLDU50
	 dzaDHPAxRJTiAYm/LMBTDE9nsS8/5QNdRs91ITgD/1CgwvzrNMfDDSNt/pWLz6/B+l
	 suY84sSPPYr4BixWGTvG+O/KuxqrWqZzQq4nL5SgyLGlRzR8aeIqHl1tIFnW4nf7os
	 oVoSY9B+8UF9BXy0M4qaEp+5vshQAg3FR3Xkz1pzDgD+Y6asRoBJdkj7pwRb9EeRFl
	 varyuawvd69lBxPcFNn8Tf0ReF+qqu8NMshi3rxblx78Zz/Y+c0ZEQwcAjvSmLPxox
	 A95ebTlyHjwbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] mmc: sdhci-pci-gli: Add a new function to simplify the code
Date: Sat, 23 Aug 2025 12:55:03 -0400
Message-ID: <20250823165504.2340548-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823165504.2340548-1-sashal@kernel.org>
References: <2025082221-murmuring-commotion-35cb@gregkh>
 <20250823165504.2340548-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

[ Upstream commit dec8b38be4b35cae5f7fa086daf2631e2cfa09c1 ]

In preparation to fix replay timer timeout, add
sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code, allowing it to be re-used.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250731065752.450231-2-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 340be332e420 ("mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-gli.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 52e716daddbe..0e19e15ed356 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -156,6 +156,20 @@
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
+static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	int aer;
+	u32 value;
+
+	/* mask the replay timer timeout of AER */
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
+}
+
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
 	u32 wt_value;
-- 
2.50.1


