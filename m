Return-Path: <stable+bounces-166710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E20B1C8CC
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E52F188EEA9
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C061290BAB;
	Wed,  6 Aug 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="skleuETo"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97756AD5A;
	Wed,  6 Aug 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494467; cv=none; b=oKmit+y5L26yOXK7OhA8vK++ZH7IKVrqUm8XsoClxsqqT4neETmk9pC/FHs1kFngip0tBr3+ICeTtM5/XG+sGKblAe2L6Hcom3tr+YzRveN8hGcj0lSz3sQ+5Wzv2HZhFqLWkLGaWg5M2uxFp7S+gmDS4mXfc9HBzXnonnOopL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494467; c=relaxed/simple;
	bh=Jit/bnNHlQMDo9ewLxqU4Bc5KKfUzRCxyJ/cLnh1YNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=eBZLXAyWPtmMvwC9f/FNO11/rOVCxxCEr2eICtMFXCgsBZFYL1EgE7DNxOP0zhbL49LPOFmFkIeEJ98iybWDieAzD+byryTamsIZBMJY0Vsx9jX9aPFZ+5ohHyJGbdv2MQTmOAIoolq+TRi4jamkNFnK8AXXJCMAVs2egGSxkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=skleuETo; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576FTZjq001991;
	Wed, 6 Aug 2025 17:34:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=VGM4i/YY8L3GxVbjbzZ+E1
	wPLPAJDd6KHMtwpJhsXpg=; b=skleuEToU7r5Casj+OZTYun99QOB8DFNTFQ4gF
	yLZwcardz6CLAhXNpoFWCTjttw94meQyIvM0uUQQLkFzq0RLYX7Eh2QldUct1v1U
	LH5M7mMW7AUO2ceaRvyXOTuQmZsPChxoKmryoh5QA1okx2yKksGkG2Tx3oDVJItv
	SBxhNnvMiMKvUhecO0siRRIm4A9jcFl6+EGhd5Hdy8g+ufpHewostoxOEaaimwT9
	EDCVS3EApwDVWtrv3Sr7PwcF7J/RHT9MApWwNcl8QPilLpumde8stW2lxMSKsP5L
	apKUvkID04kAmGSIijAdsB47yYTqP6d8B447BtSxoVP8defg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48bpx8c1b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 17:34:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 551D240053;
	Wed,  6 Aug 2025 17:33:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1A45D7385C3;
	Wed,  6 Aug 2025 17:32:43 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 17:32:42 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 6 Aug 2025 17:32:42 +0200
Subject: [PATCH] memory: stm32_omm: Fix req2ack update test
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250806-upstream_omm_fix_req2ack_test_condition-v1-1-4879a1d7f794@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAJl1k2gC/x2N0QrCMAwAf2Xk2UJX0RV/RSTUNtMgbWfSiTD27
 xYfD467DZSESeEybCD0YeVaOoyHAeIzlAcZTp3BWXey3p7NumgTChlrzjjzF4XeLsQXNtKGsZb
 ErTfMNJGf7zaNx+Sh1xahbv9P19u+/wBG27kLeQAAAA==
X-Change-ID: 20250806-upstream_omm_fix_req2ack_test_condition-77e8fb0d13d8
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>,
        Patrice
 Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01

Fix test which allows to compute req2ack value.

Cc: stable@vger.kernel.org
Fixes: 8181d061dcff ("memory: Add STM32 Octo Memory Manager driver")
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/memory/stm32_omm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/stm32_omm.c b/drivers/memory/stm32_omm.c
index 79ceb1635698f6bc8bd4a39fdeaced1ec318e1f6..9efc56a85b5ecca49eb6dfc0ef83880f89591cd1 100644
--- a/drivers/memory/stm32_omm.c
+++ b/drivers/memory/stm32_omm.c
@@ -247,7 +247,7 @@ static int stm32_omm_configure(struct device *dev)
 		if (mux & CR_MUXEN) {
 			ret = of_property_read_u32(dev->of_node, "st,omm-req2ack-ns",
 						   &req2ack);
-			if (!ret && !req2ack) {
+			if (!ret && req2ack) {
 				req2ack = DIV_ROUND_UP(req2ack, NSEC_PER_SEC / clk_rate_max) - 1;
 
 				if (req2ack > 256)

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250806-upstream_omm_fix_req2ack_test_condition-77e8fb0d13d8

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


