Return-Path: <stable+bounces-110729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304F9A1CBE6
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0051886DB8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973522F385;
	Sun, 26 Jan 2025 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDaK7m5I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF02A22F17D;
	Sun, 26 Jan 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903932; cv=none; b=VJ2OA7iwWNg+RmFtgmmrf+vQRdPfjCFeTPJWSqdyumrUkQKlwmyzwIciYLyZGA3qB5a8UisMKkjfqRSgsVlgJwAQOLUGSgGEbgctw7E0cPPLB3GDZ09P6O+jDVl5Z/lk+6RP0gATSTTsL1zrPORQz3JUKyW+zfQiFSuCD9cGc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903932; c=relaxed/simple;
	bh=yZFM+Q/nJIaJoYU1bQxz4kIMgMsKosBL3k21lXRxsGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAntzLEy/Ft+4xkgVtb8urRLFG1o2LqDIo5H5kBe0/GF2yU9Y5OOaSVO8oopFWiGFi9XJxYeOOZYit7xHy9DtrpQkt/llBBVLEHYx4NIlMjvRimzb33mitLUbDLscVErpJhBsm1CMrWvozPxXGVUBIlxI8UQ0DwD6m3Gz3XXYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDaK7m5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94140C4CEE2;
	Sun, 26 Jan 2025 15:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903932;
	bh=yZFM+Q/nJIaJoYU1bQxz4kIMgMsKosBL3k21lXRxsGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDaK7m5I1UknaGNZGib+Hp3LckKkSLhGy7cHKceOmTVFjEvtLfeb+E8rNQEIrFd1T
	 4rGCXnjjQ5l9STH/lkU32xoOzN6rSGZVQQRAHMZamDTcDgSs+Qde6OJtao9ckQwfgo
	 RMK+3j//dTmRirNCldqdEf/GhJhiVyIE0DlPVO/WkMEv9n6kI44adhFQ/yVj3jWYjB
	 ALZ90EkHoMMSWRhShRHa1Q+YxvTocYTnvXo1vykQIX5sU0GzRV6G4q3CfFRfAMPkKx
	 LPBuaMBBClTAb/dmD2jXZkrr6GTCFcoQWBzm9rQs2WVc5ouINZZ95FFEXV7pwXDd1i
	 Q0nHxJTOH277g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	ricardo@marliere.net,
	avri.altman@wdc.com,
	adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/7] mmc: core: Respect quirk_max_rate for non-UHS SDIO card
Date: Sun, 26 Jan 2025 10:05:22 -0500
Message-Id: <20250126150527.960265-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150527.960265-1-sashal@kernel.org>
References: <20250126150527.960265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
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
index e614fd82a32a4..2362a70460f1c 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -379,6 +379,8 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
 	if (card->type == MMC_TYPE_SD_COMBO)
 		max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
 
+	max_dtr = min_not_zero(max_dtr, card->quirk_max_rate);
+
 	return max_dtr;
 }
 
-- 
2.39.5


