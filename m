Return-Path: <stable+bounces-172656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FEB32B2D
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67FDAA5831
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1E82580EE;
	Sat, 23 Aug 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N82PDJg6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019981720
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755968109; cv=none; b=emdylWVMm5XK6e715q1qHaXOxjfxsu3FSXMwtEEVSHA7ArWE9n98hLZTuZNSlb1Zhhc5Lz9OTI/gLfBtvQEtdfENqidp0YyMprZWMvg+3iocU4CBYzVhfKs77Mp64findi7pE23jnAA9fFgGayHhnKWhvEpX6QI9bp4KEvARuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755968109; c=relaxed/simple;
	bh=n2uEiEyKilLyPFfPxy+EzPjiX64ey/rc53nZ8VgSqW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW5Rf+EoeiE1CtDpT5CMkRXXJGZHlUAEl3O4qKLa56GQ/xjcHlAleGsZMwPaUIJN0qZ9gXO76nxJr4HnFH9MwMrlyOH8Br1IyyplTvEFRJ1loqxa2FJPZQP2akKhJyr5n9sOlKzVIAjZpGo30LnWczuugsrZVIt2lwf8TSGCYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N82PDJg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88D1C116D0;
	Sat, 23 Aug 2025 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755968108;
	bh=n2uEiEyKilLyPFfPxy+EzPjiX64ey/rc53nZ8VgSqW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N82PDJg6h1/SVxlHO0WhFD5ppQr/+d3fGNqMhkNQqzFQnuQ3pAuT6A2z+NOcoJdFl
	 n3l28QY1M6aq26D3bdCX0rRyXQ13CMOR98S5tx23xAMNpjSGtIvJ76AL9TQw49Srvo
	 jfIGjuZE7cAQf39ocT9R6rxvwa3Jg3S7BCZ30ig8CKpqaoLMv1DprnmWYEuC0rclfM
	 AWDrCos9Q7CCcSoGqWpoEalHUHe2En/p+nx7ID4odjoCyt4T6ndUw5VlukQnrv0Zs2
	 Dt1a5XttSvPTLznFAjAFoVQFC3hcPLEfc4aE8S3yUi6Tdu2NLys1lGeEerSIGFtLgm
	 8eVM23CE4xkVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
Date: Sat, 23 Aug 2025 12:55:04 -0400
Message-ID: <20250823165504.2340548-3-sashal@kernel.org>
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

[ Upstream commit 340be332e420ed37d15d4169a1b4174e912ad6cb ]

Due to a flaw in the hardware design, the GL9763e replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9763e
PCI config. Therefore, the replay timer timeout must be masked.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250731065752.450231-4-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-gli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 0e19e15ed356..9b03450166ae 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -988,6 +988,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
 
+	/* mask the replay timer timeout of AER */
+	sdhci_gli_mask_replay_timer_timeout(pdev);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-- 
2.50.1


