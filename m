Return-Path: <stable+bounces-110606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29DA1CA85
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879BA3AA7B5
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD0A1DC98B;
	Sun, 26 Jan 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brGB440Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597C16DED2;
	Sun, 26 Jan 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903639; cv=none; b=uOZf6orUpM5rA/vFpxuWLXnmukm7X7IJFDptqeMd1l4bgvqboj4iVSWfpZP+M+JS3OkWNf07x2dCIxQCqtegpdt8rGfDyUz0HevU/VfzGnaxWV8+cgp+PspT2spyZaXeaXV/5KMUVTV9nD38SFrm12e7YQnfWmhD9L2N1Dz7FSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903639; c=relaxed/simple;
	bh=sc2NPOsle/Q4xssA66MJy5z460TxA9BJEpX4TZHDik0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ln5itc6e/ey5qV4ns61UxLBPWmGahAd29q2KO8hEmDliMi6yo9y0z0SWHRwfsaWyGejaX4K8AtYTIDs38M3kadtri+bPpbgy5SuujGdWQ4Qn4KTByjwzdbKlmGQXxJr+QYFi5Wz7JsWGJRucTe30l6o77Rpn4PVNe5MFpmsV8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brGB440Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E9DC4CED3;
	Sun, 26 Jan 2025 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903639;
	bh=sc2NPOsle/Q4xssA66MJy5z460TxA9BJEpX4TZHDik0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brGB440ZOC3W1qvv5ORsIkGeRCBpiUxdl0+pFJB10Wd6ehaeYJ5a99FmBadbRhC25
	 XivQdMvywhZp9e8fpm/o4046X1WimHWsMxZV1/Tlpdmm5CPeCDGAZmilOM52/0Ya9x
	 JFg15UTEtu002h/01FZlaIyKBSD6OaQBweD8wXRUbc2g4BvI8fm6oVp3ePweftY31f
	 wE+J8KEgDbhzX3qiZS34/hT/NxSCgZzPxwX6amASgY62iaySyUN2+2lUIm6LkhmDbP
	 sYa41F65wQKMiZ1s8XYquhBvOcgusH4nZAxrLM/mgSKdF9TRoe1bvnmf2ckvYGsXZU
	 IHHG7xUpBaP4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	avri.altman@wdc.com,
	ricardo@marliere.net,
	adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 05/35] mmc: core: Respect quirk_max_rate for non-UHS SDIO card
Date: Sun, 26 Jan 2025 09:59:59 -0500
Message-Id: <20250126150029.953021-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit a2a44f8da29352f76c99c6904ee652911b8dc7dd ]

The card-quirk was added to limit the clock-rate for a card with UHS-mode
support, although let's respect the quirk for non-UHS mode too, to make the
behaviour consistent.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <1732268242-72799-1-git-send-email-shawn.lin@rock-chips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/sdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 9566837c9848e..4b19b8a16b096 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -458,6 +458,8 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
 	if (mmc_card_sd_combo(card))
 		max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
 
+	max_dtr = min_not_zero(max_dtr, card->quirk_max_rate);
+
 	return max_dtr;
 }
 
-- 
2.39.5


