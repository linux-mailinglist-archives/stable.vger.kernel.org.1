Return-Path: <stable+bounces-27601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1414287A971
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 15:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459061C21503
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75324652F;
	Wed, 13 Mar 2024 14:29:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB741238;
	Wed, 13 Mar 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340149; cv=none; b=Vt0/x3mWNX4cpj2Uzc+B03O1rE5HEvV625AowrXPjhaTBX6WF0Eh/hXFySA9Qw2/GgpZhP7Rgm6pjkrwbSSNrEm7WkgvKf1U4wUocfAU714n4vw/siXTiQC89lNWy5l1aOEX/gZVYMa5aHu5ryqaajPFrELhackxicuIrjkglFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340149; c=relaxed/simple;
	bh=+SzE9YhmbZq0ZkHDLA2Is5ynCd9pXgBS2FEXqZp09Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p8l2EierqsmZej5Ljia9c6daZXVUr9xC8cdhJvhy6OkmgsnzSsui1grg8yxFEjUV5Or7D+AjrOwP/OGKSh7WNTFmqn653x07qAiefXf1eQ5cN2ROJ1yzE1qZSdy6FcS8LCzZCSpAnd/fp4VGaH8ZOBHie0DxVxwHS+Bj4YE59A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=lakka.kapsi.fi; arc=none smtp.client-ip=91.232.154.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lakka.kapsi.fi
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1rkP6Q-007fpl-1T;
	Wed, 13 Mar 2024 15:57:06 +0200
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.94.2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1rkP6Q-00AVj1-6D; Wed, 13 Mar 2024 15:57:06 +0200
From: mikko.rapeli@linaro.org
To: linux-mmc@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mmc core block.c: avoid negative index with array access
Date: Wed, 13 Mar 2024 15:37:44 +0200
Message-Id: <20240313133744.2405325-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.4 (-)
X-Rspam-Report: Action: no action
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: DMARC_POLICY_SOFTFAIL(0.10)
 Symbol: MIME_GOOD(-0.10)
 Symbol: FUZZY_BLOCKED(0.00)
 Symbol: R_DKIM_NA(0.00)
 Symbol: R_SPF_ALLOW(-0.20)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NO_DN(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: NEURAL_SPAM(0.00)
 Symbol: RCPT_COUNT_FIVE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20240313133744.2405325-2-mikko.rapeli@linaro.org
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

From: Mikko Rapeli <mikko.rapeli@linaro.org>

Commit "mmc: core: Use mrq.sbc in close-ended ffu" assigns
prev_idata = idatas[i - 1] but doesn't check that int iterator
i is greater than zero. Add the check.

Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")

Link: https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/

Cc: Avri Altman <avri.altman@wdc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0df627de9cee..7f275b4ca9fa 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -488,7 +488,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->flags & MMC_BLK_IOC_DROP)
 		return 0;
 
-	if (idata->flags & MMC_BLK_IOC_SBC)
+	if (idata->flags & MMC_BLK_IOC_SBC && i > 0)
 		prev_idata = idatas[i - 1];
 
 	/*
-- 
2.34.1


