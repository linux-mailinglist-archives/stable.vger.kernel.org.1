Return-Path: <stable+bounces-140200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8DAAA612
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9DE1887A39
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844731E196;
	Mon,  5 May 2025 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joolm5cG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228731E189;
	Mon,  5 May 2025 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484322; cv=none; b=HcKAeJsFzi0+wdWsM7LRyviW1gCimQ4v2kKFMGW5xygvQ9/DBAQZPdTxxdTg+ZEzTEyVL7wkWeNJ0ztKJzvP2rfz093Y2J4UspFiI/8T5BD62ayk51AlnSHOk3nhx7FMcTcrnRFqs47elcMBA86uSXhyR8HW87qwG5Kfzcvwojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484322; c=relaxed/simple;
	bh=OK5w95Nse59DVky2ulT2T5RXOsc+12UJ+6u/Roqj2Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqKXLZRsjjSsKrV+jEZjG2Z0aHdYM8Y+pWC+9C18x5hV/Du+hZC5IM+clkNrfbMdArCadUxcgasr3dhL2qAVKGoL3wi1E2qloZfRLrwvrLjGFIwtzt7bhYUKJaNryuif39wSk5fU5TTqbT9RIsAxMVFCmmu3xYyBVK40zLQmEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joolm5cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CD2C4CEE4;
	Mon,  5 May 2025 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484322;
	bh=OK5w95Nse59DVky2ulT2T5RXOsc+12UJ+6u/Roqj2Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joolm5cG/tOOrDAPkMCSXJGtyemQdUKdoCUVhziTNJuzWL1W6ytPS7y/4Z5m3e1Kk
	 gUrLyuxU2334JstZltBfomkDkkKJOaCLtSnJDPXVxPm11Lf4PTiRbsCS9tayGHADCx
	 Q2Ys8gut3OZtgbO+bSdQ/09J3jEn0WK8xGAoymRRBYqAFisHUTPrWQSa+8yQUzRXGc
	 DzTxJFL+hDEWtBMQQq2rrBXurYkxBapnlMAb+YlzTs/UTI4NN6KJs9QmcBwMAYtqZv
	 D4uPb4ceK8Jfx/lT9FyXzfZX915cWDUrdJtLbzTzPeRRKYyzDJC8t10Xh9G4i/gDyQ
	 OB713VdL1LSsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	yung-chuan.liao@linux.intel.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 453/642] soundwire: amd: change the soundwire wake enable/disable sequence
Date: Mon,  5 May 2025 18:11:09 -0400
Message-Id: <20250505221419.2672473-453-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit dcc48a73eae7f791b1a6856ea1bcc4079282c88d ]

During runtime suspend scenario, SoundWire wake should be enabled and
during system level suspend scenario SoundWire wake should be disabled.

Implement the SoundWire wake enable/disable sequence as per design flow
for SoundWire poweroff mode.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20250207065841.4718-2-Vijendar.Mukunda@amd.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/amd_manager.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 5a54b10daf77a..9d80623787247 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1139,6 +1139,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		amd_sdw_wake_enable(amd_manager, false);
 		return amd_sdw_clock_stop(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		amd_sdw_wake_enable(amd_manager, false);
 		/*
 		 * As per hardware programming sequence on AMD platforms,
 		 * clock stop should be invoked first before powering-off
@@ -1166,6 +1167,7 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		amd_sdw_wake_enable(amd_manager, true);
 		return amd_sdw_clock_stop(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		amd_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-- 
2.39.5


