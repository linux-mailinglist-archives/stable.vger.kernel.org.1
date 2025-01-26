Return-Path: <stable+bounces-110640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F779A1CAC3
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDD118837D8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8432620A5D3;
	Sun, 26 Jan 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce1MNI1P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD3209F3B;
	Sun, 26 Jan 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903739; cv=none; b=nNGT+dqVwakCyV8XgnwL5fB1HgyaSOLzBMGDDl1EBBNEfVOlbxubE740UPNcrRK9VNLxRXpwdIl+gdIJEvoFPH2H6JG1JnPtBTSgqNQK5a6TZDPuBLfdQDo6+7o+d7qc8iwk5JaoY6rVAuIA0Op+g+vYUW9ix0WAm437CQZQsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903739; c=relaxed/simple;
	bh=WUU5DtfN0aE3KW7oIl1FfUVR1fU5tIs7Hrz0gwxCS5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oE+6QdTTn/V3C7yavCI8u1i4/jnBxcHbiW01VcCv5ucgM3T3g0vZX5S2iF4GkpLCQmIsH6VkXqoUfBhz09tMufjkaRR5F8oSb6AguVYppAqZjXb+K0A5xI4WwbCx3kSawiitowtP1LCfakQktqc3i+Rar3xIyJIYbhERqzIYWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce1MNI1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A86C4CEE2;
	Sun, 26 Jan 2025 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903739;
	bh=WUU5DtfN0aE3KW7oIl1FfUVR1fU5tIs7Hrz0gwxCS5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ce1MNI1PLYVyNKJ0go8W451GqVE9rAdc3z2sWS4h85qoOLaPiU0xrcdU5VMPAg1/N
	 6ju4IzmuUvc4yjE/ziEgO1Cqw4Icfzb74cEImxWA8Q7YbdY+LEG0hv7t5Qa1CDsSOC
	 YsOSl4NABTTHLR3lucjnm7TzCrOUiBu9mLjWanqAk47/YKEHPl+DN6MaCLs4XboZZ9
	 OKKw4zSwNm3Cj/wGA9YM46VRzmv4fYqHzsBCzIWY0Sl9ocNfjDPzuX23nPujAeLQ07
	 VdD4B6JJSfZsd8ztedQYFkC94fhQt+lsAak7bsig3O1vq2W+6dD8yrL5oreYG0PWmv
	 bjWX2Iw1Hg09w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 04/29] mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk for S32G
Date: Sun, 26 Jan 2025 10:01:45 -0500
Message-Id: <20250126150210.955385-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150210.955385-1-sashal@kernel.org>
References: <20250126150210.955385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

[ Upstream commit 0202dfbdc5dea70e213205aa42ab49a1a08aad3a ]

Enable SDHCI_QUIRK_NO_LED quirk for S32G2/S32G3 variants as the controller
does not have a LED signal line.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Message-ID: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ef3a44f2dff16..d84aa20f03589 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -303,6 +303,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
-- 
2.39.5


