Return-Path: <stable+bounces-110686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5A6A1CB7B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539643AA76F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126F22332B;
	Sun, 26 Jan 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uReXkTs2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC822332C;
	Sun, 26 Jan 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903839; cv=none; b=Civuwx8Z2uIHENm6kE2hj68tOJNSxxXBn+4gG486hUgnC4E3OZhOqgksbpbH+rMrDZf9K/opr36lCqM3EfRN55oeW6UIL99r2QcuK8lpqJVaDkNT6u29xRqgaumu3iIZ2fcfy0f3FR7/T1H9p1AZBdApLfGrU+rcK7sHa2ZNcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903839; c=relaxed/simple;
	bh=EFmztxLp1CwDBi7bVNcFMBozWrQRTWmNoeow6rV16sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGhytAl8giV3MTVd2n505aBwoc97yxYphkHLM6OKwxaAOmWOMQ7SvkuFZ9P3ccigB7nc+OGttKnM1xLTsN2vCU9FOwxWxDqm8O46NSHJtJtqSXhQ0uvJ6c+czDdiUxrpde66FPgkpbUTpr3FTVbeJHVlxoU9me7L+fNw+moNg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uReXkTs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE319C4CEE2;
	Sun, 26 Jan 2025 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903838;
	bh=EFmztxLp1CwDBi7bVNcFMBozWrQRTWmNoeow6rV16sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uReXkTs2RBln6ENIuTp/sfer1wgI5kobwdi6x2vnu02KZWeYzl8ivcfD0XAfRhsb3
	 lApQ43gMvi7Qcknm0DABBGN8XSmrG8/ogkqunYJT/m5MJZMau6mL41/mDE4XRIl8Yb
	 laAr4VakMh8/lkmByWCMyEiVmeQehC7Iah/J13wwolqKbQiRyZof5vhQOz8IQEIzj+
	 dY0ePZw+N782hZvjCh65cREf3v/CmjEwCxlX2FiKY8x0ao5Ctfo3nJINlX8toQb0iY
	 rdclLSaGgftHpTZIHQLcnVh5aX3FPm/HourdVFGyHPD456t+rCr7d20ZXA84GxVZWG
	 cU6yQNTil3rRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	ricardo@marliere.net,
	adrian.hunter@intel.com,
	avri.altman@wdc.com,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/17] mmc: core: Respect quirk_max_rate for non-UHS SDIO card
Date: Sun, 26 Jan 2025 10:03:38 -0500
Message-Id: <20250126150353.957794-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150353.957794-1-sashal@kernel.org>
References: <20250126150353.957794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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


