Return-Path: <stable+bounces-43381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302B8BF240
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D76728756D
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331218411C;
	Tue,  7 May 2024 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dATvq3H0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5051836F2;
	Tue,  7 May 2024 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123562; cv=none; b=LGeNH4k2ytURUlTUA1XISC0Y/CAcE3MSvcPU5eJksUsEQBu5N9eLOWn70qxqnkApj8iZDgntYHLL/RW6qoQ9sglm1d/TWjVnwgsATYz8HP/oGTVm+qVBWWlTM8V2QrXMg7Cp9uWo+l7u5mP82ciM3OqU6mD7N8LiMJ6TjbWQfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123562; c=relaxed/simple;
	bh=zkELOI9O64LD5jzBowEzb4myEdmcyY37JkD+dD3ZeOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gONr+vwKzDB453BZmzb2oONRqsb04Lhj4PASsrPACkEEtiuvqZUaaZ3Exrsy+2cHowKUvu52ByYihCnfScRxzFjVGThkNDzy9RkPifKHOEnsaUK7G5Ghjy9hXYY/7DV+wn/wtR+mzEfK6TKrkOM05VIQhS0+za7U1uuKVWvjUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dATvq3H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AC9C4AF17;
	Tue,  7 May 2024 23:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123562;
	bh=zkELOI9O64LD5jzBowEzb4myEdmcyY37JkD+dD3ZeOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dATvq3H0WSTuAbbMlAw2SFev/gv8XGV/qVPC6czPuhFQ9UJC7C66Pr5RJxROXWceG
	 UpBvZMHVpY/Vdf5dvj9krSrL2oPYDmMggrEHrYdc+g5mhPU+0lmYVMiGdxVYGSUNt2
	 5ao9IU+pPhNSPm/3N4Pn090AnwRf1yltc0OgBpTWpefoi0SMnO0QUpukp89tBbuOxv
	 TkU3XTeC73A0bk/G10y0RFFaYSK2mCCQCsYw8ptTfipokjtpt/v7NEw7QCh7KmSg4h
	 LnuZqnZI/Lh4bCRO4sZ7C+mTjlnGsUn7YueJduTguy4lWOwUnI5Lc+mZl8/FXHVBnD
	 AyH1jK2TN2TfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/25] ASoC: rt715: add vendor clear control register
Date: Tue,  7 May 2024 19:11:53 -0400
Message-ID: <20240507231231.394219-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit cebfbc89ae2552dbb58cd9b8206a5c8e0e6301e9 ]

Add vendor clear control register in readable register's
callback function. This prevents an access failure reported
in Intel CI tests.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Closes: https://github.com/thesofproject/linux/issues/4860
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/6a103ce9134d49d8b3941172c87a7bd4@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt715-sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 4e61e16470eda..4e35b67b01ce8 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -111,6 +111,7 @@ static bool rt715_readable_register(struct device *dev, unsigned int reg)
 	case 0x839d:
 	case 0x83a7:
 	case 0x83a9:
+	case 0x752001:
 	case 0x752039:
 		return true;
 	default:
-- 
2.43.0


