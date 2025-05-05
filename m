Return-Path: <stable+bounces-141421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E00AAB364
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F883A5EA4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFD22F746;
	Tue,  6 May 2025 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH7hJ2fF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449C2E3397;
	Mon,  5 May 2025 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486234; cv=none; b=rWZrnhYNPhc1J5R32XFSCso1OH6VpyxQiaoVIBYrGzY0kT1tcgkEzx66+F17e6Y0HqYxNHCZ20J1tzKSr1mCAtADFUUUlhUA7VYg62aPXIEqFlZBMDwCW8IYFHxnJVEcjfnEkpdIo2ttjuHz9pJ7wf0zvZkLW0drRi8ftexF7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486234; c=relaxed/simple;
	bh=I0C6suGkAqWWKOlyoHK9Oa6XU47EuCa70xa5hNDgPuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryxmuE+d0ngGuiY3/00/20WQqF2ttNKBrh2yfq9PgxO+0t3AOXdDsaiIECrcnDIVCdnldfuq9pppHN7K5n8BM8855pBF5MxRhpDQsu/a6bBmmop1Xyn8hYQdXYZuRiK8Kcgaqappb4GgDtnLMDxt8KNjD863k1Iwhx3l6nvQMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH7hJ2fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2443EC4CEE4;
	Mon,  5 May 2025 23:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486234;
	bh=I0C6suGkAqWWKOlyoHK9Oa6XU47EuCa70xa5hNDgPuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KH7hJ2fFWmL9ITcHRM4CwjVVUQ2lr7tLTx1HxdjT0rcbywCb8yXy/H40S3uF5MDmb
	 EKcQHbHvYX+6yeOAWbLOThXXd6+sbTXe0MyvTqtABeawyH7kD4SSAb18sDA/R0WAV3
	 HWTM9rUbsxMf5zV9ywBVg5CYMwh3uv7e9T2GPO9ltRN7NYp3nHKhcUuDK0VvJ9YLN5
	 z5ZDh13cOL/B+3RB2cJCkSFpUEWOPj2xcHnorDh3XZBHzzc9NJ+5iz6xVvJxl4S7WJ
	 CT+l5p4OBiMsqdOutG8+kWZDUz8o1eqhVhJJrGPAvXsNJ9vh2hbzWpzglCugeNBbKL
	 PJ9nbsQH8h7yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	yung-chuan.liao@linux.intel.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 221/294] soundwire: amd: change the soundwire wake enable/disable sequence
Date: Mon,  5 May 2025 18:55:21 -0400
Message-Id: <20250505225634.2688578-221-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 79173ab540a6b..31b203ebbae0c 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1138,6 +1138,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		amd_sdw_wake_enable(amd_manager, false);
 		return amd_sdw_clock_stop(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		amd_sdw_wake_enable(amd_manager, false);
 		/*
 		 * As per hardware programming sequence on AMD platforms,
 		 * clock stop should be invoked first before powering-off
@@ -1165,6 +1166,7 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		amd_sdw_wake_enable(amd_manager, true);
 		return amd_sdw_clock_stop(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		amd_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-- 
2.39.5


