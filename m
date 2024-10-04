Return-Path: <stable+bounces-80803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03657990B3D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F951B20F1B
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6292220804;
	Fri,  4 Oct 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxFbClRC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D121F43D;
	Fri,  4 Oct 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065949; cv=none; b=FjpkierekeYftal6vNI8fVj63cOIHdrjKmmiTxFtTrFpgta1wOzITpZ6k2fbeuZWnc9Py3clnFWGQFagqp4jlUT3ipPWXCL8unxmKOG3wUKw6j731WdkEvQxLCi7rZLs9CuIWm3u+SG1udbyozU8EeftaYw1QjAQauZZPowr7yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065949; c=relaxed/simple;
	bh=zFGRWmzPjvT+BFrOywJyXmGGGyxxZQ2sKp+3A7Wgg/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSXrIa3+S0OcUMqOklhkMs+dm24xwlpjZ5+agRsFnruF8f4QnwLvrpJ4+aTUookgiBPUtcCiwdOaBSzn/YKnXKffEaln8Ldt4knAPpfI4yPyj2z1AoReXEwNnmgMKFXmpu2W9j7HLf70g1YvN+6LcIfTrzYSj5ZclPJ92vEtnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxFbClRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F34C4CECD;
	Fri,  4 Oct 2024 18:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065949;
	bh=zFGRWmzPjvT+BFrOywJyXmGGGyxxZQ2sKp+3A7Wgg/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxFbClRC90AiDjR7S2S6xHLPKMKXIqkWqMdKaOD4x8jifqd+J1vKjhu8Zx7dBH3A5
	 aCMjGhxoT/xh/PaD4jnpjlcQrnHCSPIPXx02dO6dr/DTTfkaOlZd9iqgNzd/0LW6wF
	 rh7Ibky6hE0WWAryz/FjlRMujc/3c4QYVUMmh1y3qsXH2y09uINVRDfQzuTqMUCAK5
	 /KjEtTETfEx+ZGQXbTjeyDWUIKFzHYRYxmP34cCUywpisL3UrmUVkPFHF9E0F7dXBE
	 otTMWOZdXFetUSSSJqMe9XHVSzknXQHNISG59RAitS7ZkxB67xBNU/ohi77VL6OMJ7
	 rckcslELD1aNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.11 23/76] soundwire: intel_bus_common: enable interrupts before exiting reset
Date: Fri,  4 Oct 2024 14:16:40 -0400
Message-ID: <20241004181828.3669209-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index df944e11b9caa..a75e5d7d87154 100644
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


