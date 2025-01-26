Return-Path: <stable+bounces-110703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76083A1CBA0
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BBB16B8D1
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA91E227BA0;
	Sun, 26 Jan 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5ch4Wp9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557C227B96;
	Sun, 26 Jan 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903875; cv=none; b=sE5I49r+L/a2uhk/WUmTs1X6XAfy3GaWWBXpoeAddOUqslUmzIOB1jgK+JjYhYx7SxV8u+ltQnOIunfZzqwGZZRs4MrD+XiQIx06a3xq53uhi1o71Y8WxnNjlW+VJL2Wa8IfCPbSKq86df1SVog5mvXrOUaRmvJ/fwPwkSaSZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903875; c=relaxed/simple;
	bh=ZN/RJ1vzR63F96zyFbY6AJQzBkH0gDvTZLYo2npzLsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pE/CChIXstdi0kKhVBAO/bjwuiqvTnGPvWWO+dx4N3oVgF1xa7v5tnVUzsOovIK/7c1QEpPpFbPHgDNemsId+AAl6IXzH+tYiQQuEHLMAdZ3PPg0IJABRYqrNWc/k6tDD4CUWuhXF8JWxMqzdl6BAAcS+6LxsP/58TBqifI18c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5ch4Wp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E43C4CEE3;
	Sun, 26 Jan 2025 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903875;
	bh=ZN/RJ1vzR63F96zyFbY6AJQzBkH0gDvTZLYo2npzLsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5ch4Wp9M8WUQNh1EshV99oGkEHijKSQ8oLWl2exgalr37cLxPkwRh35cU3pujF3h
	 pLuqBvZoXmn9w7jWskq3epur5baOyFbFolUzFA1wNzN+7llKMuCXn5qxt2K/Vg7rJl
	 Q8PNTkjr0NHMTuQZfdh1moiORUeoX9BUJ4/s068QPCPc4CwUT8oHrRs8qP13wwPK+h
	 4yIt4h/VAHZD+/Lcie661ihv6CrMWWeRqsTZzAQ9t11kR4kI8Wp+uObUYMb/Zl5r4l
	 G2iPcykl6IepuSw35FjiDO6lPv/ZtpZZbAPmIRvEn8GzfMBrj2gD3DDYynUOpnpktj
	 pTkQk7HhJLJdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	avri.altman@wdc.com,
	adrian.hunter@intel.com,
	ricardo@marliere.net,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/14] mmc: core: Respect quirk_max_rate for non-UHS SDIO card
Date: Sun, 26 Jan 2025 10:04:18 -0500
Message-Id: <20250126150430.958708-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150430.958708-1-sashal@kernel.org>
References: <20250126150430.958708-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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
index eda2dbd965392..a0cac8c87ef2f 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -443,6 +443,8 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
 	if (card->type == MMC_TYPE_SD_COMBO)
 		max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
 
+	max_dtr = min_not_zero(max_dtr, card->quirk_max_rate);
+
 	return max_dtr;
 }
 
-- 
2.39.5


