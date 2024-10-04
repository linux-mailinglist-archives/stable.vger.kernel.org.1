Return-Path: <stable+bounces-80946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE5E990D17
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0191F20CE2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69142040BC;
	Fri,  4 Oct 2024 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAzGUpMo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C282040B4;
	Fri,  4 Oct 2024 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066339; cv=none; b=F8UOS1XfY6fV0PMiTc3NYs1/C6i/qXN7FE2RosYSgP7+VWf74lapOOqTn07YpyHaA18PzzicgCFY1piGc3/qmKa+YIIc2qTNKSRK4Z7/bBggLtpmZFH3QEw9CF6IyvPSMim/DngHK0xUKTTs1al7JZc1uF4dcQdDxQuYkGka9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066339; c=relaxed/simple;
	bh=Gce2tJSrY6NSysKhzi+wgb+psFG3TpJppphDMZmKAUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMM60kKVgPrOsC6DweN53x5eV8wXu7fC2j8urRCthX1LnPXIz0XveXGjZse0bXU0escEycBbycitnIz0VjuixajF5nAsDrZxASQZOYze9b0mNnhZZ7atO92xFNw4+v/A6zgwFGrPB5XotzJJUXAAKZDnKIsJcj2TGpfwfGyK20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAzGUpMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86487C4CECC;
	Fri,  4 Oct 2024 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066339;
	bh=Gce2tJSrY6NSysKhzi+wgb+psFG3TpJppphDMZmKAUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAzGUpMo4rcPuK+5sImXf6DJzeZJnI28RDzWrgxXfPAcUPPSavuX2RHoJXhSv23Ov
	 Af4cPbb0rjfJWbpI4++Ec7mtP0RN79OjQshru7fhcPbZizRVAY2Sw3tM822nttVUxg
	 e1Fh9vzvbNkv6B5UHi1tteYBp0+s547z8jM8WseojmabRSJcD8NkQnIMna65qnpNI/
	 2H9uxlql2b7HEMH6U16a6sN6y5+DiOCLZPiOXtLz27IYwaKXFhoymc02TfcX1eLLdL
	 b2DCihTsX6UePNFGpMZ9v19DrsStbYSCZzAhVAQ6ZmV2YSuslgRLdKCUx3A2CsHUJ6
	 KOJOL4ZJpWLBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.6 20/58] soundwire: intel_bus_common: enable interrupts before exiting reset
Date: Fri,  4 Oct 2024 14:23:53 -0400
Message-ID: <20241004182503.3672477-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 5aedb8d8336b0a0421b58ca27d1b572aa6695b5b ]

The existing code enables the Cadence IP interrupts after the bus
reset sequence. The problem with this sequence is that it might be
pre-empted, giving SoundWire devices time to sync and report as
ATTACHED before the interrupts are enabled. In that case, the Cadence
IP will not detect a state change and will not throw an interrupt to
proceed with the enumeration of a Device0.

In our overnight stress tests, we observed that a slight
sub-millisecond delay in enabling interrupts after the reset was
correlated with detection failures. This problem is more prevalent on
the LunarLake silicon, likely due to SOC integration changes, but it
was observed on earlier generations as well.

This patch reverts the sequence, with the interrupts enabled before
performing the bus reset. This removes the race condition and makes
sure the Cadence IP is able to detect the presence of a Device0 in all
cases.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20240805115003.88035-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/intel_bus_common.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index e5ac3cc7cb79b..179aa0d85951b 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -45,15 +45,15 @@ int intel_start_bus(struct sdw_intel *sdw)
 		return ret;
 	}
 
-	ret = sdw_cdns_exit_reset(cdns);
+	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
-		dev_err(dev, "%s: unable to exit bus reset sequence: %d\n", __func__, ret);
+		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
 		return ret;
 	}
 
-	ret = sdw_cdns_enable_interrupt(cdns, true);
+	ret = sdw_cdns_exit_reset(cdns);
 	if (ret < 0) {
-		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
+		dev_err(dev, "%s: unable to exit bus reset sequence: %d\n", __func__, ret);
 		return ret;
 	}
 
@@ -136,15 +136,15 @@ int intel_start_bus_after_reset(struct sdw_intel *sdw)
 			return ret;
 		}
 
-		ret = sdw_cdns_exit_reset(cdns);
+		ret = sdw_cdns_enable_interrupt(cdns, true);
 		if (ret < 0) {
-			dev_err(dev, "unable to exit bus reset sequence during resume\n");
+			dev_err(dev, "cannot enable interrupts during resume\n");
 			return ret;
 		}
 
-		ret = sdw_cdns_enable_interrupt(cdns, true);
+		ret = sdw_cdns_exit_reset(cdns);
 		if (ret < 0) {
-			dev_err(dev, "cannot enable interrupts during resume\n");
+			dev_err(dev, "unable to exit bus reset sequence during resume\n");
 			return ret;
 		}
 
-- 
2.43.0


