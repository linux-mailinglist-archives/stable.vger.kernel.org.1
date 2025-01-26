Return-Path: <stable+bounces-110639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB16A1CB0D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE693ADE64
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87103209F48;
	Sun, 26 Jan 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N902creL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40041209F3C;
	Sun, 26 Jan 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903737; cv=none; b=c0BqMU9gf3+4/K9Lrib3dWfkUsKyvKc8/xJQOIyHOy4DU4o02hsZjxYZBpaaE5tg+rQcJcXvMll9lgghhcOwxVTtA0pU7vAYputGg7V26VvinskzSyy3CvSttUEXwlUcSCT87mnJ/wQzBgfCCF12k5LjwS/G8z1XAv0jLxTEWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903737; c=relaxed/simple;
	bh=sc2NPOsle/Q4xssA66MJy5z460TxA9BJEpX4TZHDik0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5qLeICrOv3Pl+Q5osH/nWDX7UWARtG0FCUfWAifles8kUtoOkkArM0dSL8VIQSVd1FLjIlct65DyHL7UdHI6gJEHgv9zp+1PVUJBO7EWLEquZVPj0hAu+4z8ZUBagG3uJ1+wwVqGjshAE6O2bOKH+HpgODHPgzQhBL9ni7gk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N902creL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2148AC4AF0B;
	Sun, 26 Jan 2025 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903737;
	bh=sc2NPOsle/Q4xssA66MJy5z460TxA9BJEpX4TZHDik0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N902creLYNwqR3gb9dgyZ1diax5mFwTmF2f64wRHO2efUnJBz5ITN47chiXkw8VR+
	 Hrz52GA0AYOZFjxCmfxjdGZa6rvdWdwMYxKMm+MIRW19HbXJejM4+mNvKUZeZ6x+JN
	 06lXXxH4Rve4X3ecf9jfLd7U95I8NmMXNLkSAW0hv2HX312dSn19B3QCSyruiG8Tw4
	 6jGUkiRjXMlmvxoLtssXaZ5FKe4TR5PoZ+JqiJiJ4/dzbyyZ0IhjL9yVryKxFVT4Jb
	 I4CUoErYJ8B0OfN2Ohyh5CmyR1uvIcrdngooD/8g34bLHAGrG4TFqSvhyqMa8waN1L
	 pHL9B6vTfdPsw==
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
Subject: [PATCH AUTOSEL 6.12 03/29] mmc: core: Respect quirk_max_rate for non-UHS SDIO card
Date: Sun, 26 Jan 2025 10:01:44 -0500
Message-Id: <20250126150210.955385-3-sashal@kernel.org>
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


