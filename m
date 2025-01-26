Return-Path: <stable+bounces-110717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00820A1CBC0
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D371882075
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9FE22B5B9;
	Sun, 26 Jan 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqaTdbMj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7121F5610;
	Sun, 26 Jan 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903906; cv=none; b=baFyFXYQVRB3muxeBtdqHvBa9VKaptoNI1AXc26VhlhmbFGlM6mmunLtowPkdmvSttB4d960Q6ed/gZrZiX4COzLno2waHsEB1oOX4U3whWDVmN4zDRLvVWvQdZtKPz2lIT1qiO1i4kH6Gyx6cxmmLe45kxmjtfR3KkBcO0F0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903906; c=relaxed/simple;
	bh=kpDKFYMeWVeUl0XPUsD8BfNZjWVrVtdRGORSMXsNJ1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkKFkuc2Mz5A9WOrV10VqDF7eoEIXr53B0bLzb58AAE880fsvVC299QKsunzUi+z4OcboUrXtaotFRBrCEuVEK5i5RXCoQN4OIA3pED/WTr60+AqrFUAdF2ucogVDE70rhBVM0JU0MomryXKuioJjj6lX9pBrDTHHyeVYWcb1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqaTdbMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CD2C4CED3;
	Sun, 26 Jan 2025 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903906;
	bh=kpDKFYMeWVeUl0XPUsD8BfNZjWVrVtdRGORSMXsNJ1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cqaTdbMj3z76dRipeXrwSJ3zBcT7cDCcpsbi2m/apNXvdi1xkipNxw9FA2YhvoJOz
	 wqJ6RD5QAztDMGGPUONPb4LQfZEifPiu4T7rU8Inz1SaIEtP0UIEvyNPYdUqJ3+NKx
	 RB/ZH3VRee2whyrs67dLhMpUFe7Su3427o7SOfNYeavYasNdlafSIbttAD07doFicV
	 FxgxtRbDdzWa685GzzlJYqaZ4T+DBXy7WwTc8vKun2nj6Fh1KwUu7WIy8zzc+yejsL
	 Gxt1JN8ckOuHov5wIr3pBJIBFIBi0SpzFIk5hxnhCzimSC7l6w7+H416jcQ8ffoG1K
	 dfge6hHfNcA8A==
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
Subject: [PATCH AUTOSEL 5.10 02/12] mmc: core: Respect quirk_max_rate for non-UHS SDIO card
Date: Sun, 26 Jan 2025 10:04:50 -0500
Message-Id: <20250126150500.959521-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150500.959521-1-sashal@kernel.org>
References: <20250126150500.959521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index 85c2947ed45e3..a719f23fa1e95 100644
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


