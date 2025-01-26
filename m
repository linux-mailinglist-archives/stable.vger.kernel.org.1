Return-Path: <stable+bounces-110668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F423A1CB5B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865E53A0FAC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D944D217F56;
	Sun, 26 Jan 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Scn4rfvR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D341E1A33;
	Sun, 26 Jan 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903801; cv=none; b=tbPtFE7zgd+XHzGwkNDdc46VtbidKOt4bEozWY4VciZIEhg4DlcNegEDywgXb9hFSb/gGUpgJBhHb6y48CKIwMqQMjnlBwDHdVnEnFAb1MgQd72JaxnrFOyxbeKzW1i0dxH5U9CyzXOB71S2q7p6jT47sHUrY+1VIt93ExYvvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903801; c=relaxed/simple;
	bh=EFmztxLp1CwDBi7bVNcFMBozWrQRTWmNoeow6rV16sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h052fVPbeGPpO44tF07P85pJLBppv5lWWC5gP8qYEuw6R0kxoOA7wxrJH7eGhI2asS8ZftoeC4c0T5vvm3QoKdcGyxdxH/420VfI/L8KC88YOAyynuqWrkROoJiBXe/prEQprfc25usZg8ozJV8e1KAsYi1YhLKaqpqrp24vn7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Scn4rfvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA1DC4CEE3;
	Sun, 26 Jan 2025 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903801;
	bh=EFmztxLp1CwDBi7bVNcFMBozWrQRTWmNoeow6rV16sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Scn4rfvRX8Pc5eqXhkrZCiEf7f1L5MKqK9DaIfB7EefGoPzzcLaFrW0OC2wJgmwYg
	 4Ai46Rch6Sr8yw+WEXkS9zjJWMXD/6IA8g1OCeJRQi8hqz2sa6Oubn8KfTPJMapOqt
	 Y+CwhpkiepB37m3xXotZvNTEPiq5Rjsf80U5PO66y4OMxK3LSDi6YTuF2aKviuUFt2
	 biYT7U3pC5A1u4jEPo9U1ppAc1mJJ1LzwJSosXmgyO5kvM57eWy3QUVHuC3IYSOJ19
	 /OjBnWunJH895GU+WamgEHMQa56iBQ7y2UxVJqVanyh0qax6VDQcxE8NV/ORc787V3
	 XafNe1YEszgtQ==
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
Subject: [PATCH AUTOSEL 6.6 03/19] mmc: core: Respect quirk_max_rate for non-UHS SDIO card
Date: Sun, 26 Jan 2025 10:02:58 -0500
Message-Id: <20250126150315.956795-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150315.956795-1-sashal@kernel.org>
References: <20250126150315.956795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index 5914516df2f7f..cb87e82737793 100644
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


