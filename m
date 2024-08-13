Return-Path: <stable+bounces-67496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D2950774
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AAE1F259BD
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B519ADB9;
	Tue, 13 Aug 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CiUg6n21"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619AE13C8E2;
	Tue, 13 Aug 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558953; cv=none; b=G71CdwURQkme/qnjc4veJr34Ngt28OaZN0oVqaHtimJK1vMPLucistKlAANwubCUsvO3Tb8ZVuMVJY+H/PKjIaa2E6mC7uzLzT5dp/GGpGyN5ZFFZE5exDN9iRS9K0teHbGxXPYwm3vCAgmR4Wle7n/MUysLrbN2na0+RdX9sOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558953; c=relaxed/simple;
	bh=N2HCZMTPDbQGAMtESCInZWG3AlHIsd8D24G8qzn2c1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fip8escMkH7QgkgGRQPw/Uzj2NClJBAzcVA/S6acyFqywtydB/lItN5iW9az2UDgw31Q4b+xy9lyKIJOoovULTZapXpEFN2/kvFsFOHnUzn1kloJNw5vN72xsam5cPSXSopEO+0UyDFckemDHCrjWxqdMH7oq0up84KM99lqOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CiUg6n21; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D5MJ31022885;
	Tue, 13 Aug 2024 09:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=mlSxnjkh7hHnJRaQ
	u+AhzCUGfyB/JhebFd293n+kGpE=; b=CiUg6n21rEDTZ2zeSrnienuUaXf5SZRH
	gJ7cd6Cb31czghA3UPmIgZEuuh/zieEXlYCXlzayLqgnKHQWa2baDoO+XQtd0fmv
	QneYQOeE536fmMPxLfhllFu74UxH0b3FUpnPwOkHR8jlcVVuQNtlUw+U0O10gCHC
	1mqKw9zbc4ItuFxMz7NcP2zGp2/iCavfQDPN1tUICyi/85bZAFsyQm1LMA6+N8Gs
	zWwHW7g7ZeiwWQb5PPyXhcQcbGKyFPoqMZRcnQOhF+NnC46fG7SrpCEax9ZOdRiQ
	KnaItr2UesgMiEY0AoVOw5CQJ/ocfQDgrw3kvK/3DsXnqqwm17gZew==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40x5kwkbyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 09:22:20 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 15:22:18 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 13 Aug 2024 15:22:18 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.170])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 36C5F820241;
	Tue, 13 Aug 2024 14:22:18 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <stable@vger.kernel.org>
CC: <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH for-6.10] ASoC: cs35l56: Patch CS35L56_IRQ1_MASK_18 to the default value
Date: Tue, 13 Aug 2024 15:22:16 +0100
Message-ID: <20240813142216.17922-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UD47gIUKrWPXi3ogQzXYYbRRYqlj-zk-
X-Proofpoint-GUID: UD47gIUKrWPXi3ogQzXYYbRRYqlj-zk-
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit 72776774b55bb59b7b1b09117e915a5030110304 ]

Please apply to 6.10.
The upstream patch should have had a Fixes: tag but it was missing.

Device tuning files made with early revision tooling may contain
configuration that can unmask IRQ signals that are owned by the host.

Adding a safe default to the regmap patch ensures that the hardware
matches the driver expectations.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Link: https://patch.msgid.link/20240807142648.46932-1-simont@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index f609cade805d..58b213722e4e 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -24,6 +24,7 @@ static const struct reg_sequence cs35l56_patch[] = {
 	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
 	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
 	{ CS35L56_SWIRE_DP3_CH4_INPUT,		0x00000028 },
+	{ CS35L56_IRQ1_MASK_18,			0x1f7df0ff },
 
 	/* These are not reset by a soft-reset, so patch to defaults. */
 	{ CS35L56_MAIN_RENDER_USER_MUTE,	0x00000000 },
-- 
2.39.2


