Return-Path: <stable+bounces-141221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F1CAAB66F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C973A84A9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0B2D2688;
	Tue,  6 May 2025 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ/HEIWu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458452D1911;
	Mon,  5 May 2025 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485518; cv=none; b=C8isHF3JCupZy+6Pt7iu1sFSWfG9q5uWo0i40RMFURjGofnhfC6/E05jLzV2/pnySWMrqM0QFCcJadrSvpch+eMTf6fF4RTn//+arRlr5sGUXa9B2jVbm23O0ALa1DWmegSFlk0PW55fwIFn0fuwrPzyItGGm3p3GIkvTMpfnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485518; c=relaxed/simple;
	bh=TLICFF25+qv6NQ98MajtS61MRmvmcv3cv/0SCr3TxSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZzKqweh2m4x5ci8zjqbzDru44UJrbVMJXvGDv+iPEXwc3uFuon1Wj7aEsJx1RmsN0FPyw57lP6SHi2OTqIftHJZlvyXpIfWDKDjFNF3By7y4T1M/c/I7WSKjl7G4WG84MoMjPpPGC3ebP/NxsqaaCvgKmVW69a8/y28VqFcvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ/HEIWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BBEC4CEEF;
	Mon,  5 May 2025 22:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485518;
	bh=TLICFF25+qv6NQ98MajtS61MRmvmcv3cv/0SCr3TxSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJ/HEIWumNLLZthWkEpf22nkkko/m7XEKsTD/VzHncWnrpkyX7xLsWNUcw2u2E8V7
	 J2WuQYGbJNAnrELb8t4ARiWgAVtK9a3U3L7TCZa798JZFWnYK9D9Bmr0K/MPV/4YJy
	 /xLpr0IK9k4K/nR4Uxea/PFt6LC7SLYp+RZnT1hXvkjj6gObF82gHr2LhP9SZCq7Zj
	 f6iFa5MKIHHdVTP2FztkbWRdo99DrlUmKv8Q4JjBf+/7UDnzlOqnNghAyYt38PGeyF
	 mRJQogVvmf6vWwBz1Vud/gimUfJz13tFVVw4hzUPV1oUCVP4p+0WRPfpc/JP/qXbxD
	 QCplTMeIMlORQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	yung-chuan.liao@linux.intel.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 357/486] soundwire: amd: change the soundwire wake enable/disable sequence
Date: Mon,  5 May 2025 18:37:13 -0400
Message-Id: <20250505223922.2682012-357-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 0d01849c35861..e3d5e6c1d582c 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1110,6 +1110,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		amd_sdw_wake_enable(amd_manager, false);
 		return amd_sdw_clock_stop(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		amd_sdw_wake_enable(amd_manager, false);
 		/*
 		 * As per hardware programming sequence on AMD platforms,
 		 * clock stop should be invoked first before powering-off
@@ -1137,6 +1138,7 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		amd_sdw_wake_enable(amd_manager, true);
 		return amd_sdw_clock_stop(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		amd_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-- 
2.39.5


