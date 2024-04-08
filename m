Return-Path: <stable+bounces-37094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E7C89C349
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A971F211D6
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44D82D66;
	Mon,  8 Apr 2024 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I6ipT3sh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E07C0BF;
	Mon,  8 Apr 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583232; cv=none; b=MxxiJfvUG+BTNO1+ESW5u8WXcAjzBtGYFRDyetPzupuwkVgSnBcHk8vvZcY+ZE59NGzSaDfhjvBFe0YHM2d36r80QyRbLAT/9FB3oYXbnntTx0T2yDQBD7jtjdmkbAbQfYbDiGBiSL9udg6UC7BNliQuXPnb5RpK0WXxSoSSxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583232; c=relaxed/simple;
	bh=ji3GTCzdGsoPHwAfX6CXK9zmw8m+YK6sJoyteMCm1rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfXPeru8mZPrI7X62VWA0JXYA7ynfj2DsxNM4b3Y3XwHu6mqTbIf33bwuEK+u1IAYcFPHV5C/3c5Zq7alKo88eRxSE/sGZDPdRSR5+5l5Eh7AJxje3YxJeqMLboiAJy71DDc0L9tbvVZjzkS/y+9r67cTdVwQEyJ/w7KjoZ6Now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I6ipT3sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3C9C43390;
	Mon,  8 Apr 2024 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583232;
	bh=ji3GTCzdGsoPHwAfX6CXK9zmw8m+YK6sJoyteMCm1rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6ipT3shL9VCPhO5XtzyggjpX1urDHBHaNnKnVs3nwV3xX9UhNOLEiEzwmiMB6e/D
	 /+FRtVUFmUwdHSrA5kwNlFbfjhkaR5TRQRmY5yTVyI2ysnGDmdTjy/B4a+ts6vRvCK
	 SiGPSWcJb2B3zVt3jkqPztx2W5FgUPwoeaybhwA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Chao Song <chao.song@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 172/252] ASoC: rt722-sdca-sdw: fix locking sequence
Date: Mon,  8 Apr 2024 14:57:51 +0200
Message-ID: <20240408125311.997586746@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit adb354bbc231b23d3a05163ce35c1d598512ff64 ]

The disable_irq_lock protects the 'disable_irq' value, we need to lock
before testing it.

Fixes: a0b7c59ac1a9 ("ASoC: rt722-sdca: fix for JD event handling in ClockStop Mode0")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Chao Song <chao.song@linux.intel.com>
Link: https://msgid.link/r/20240325221817.206465-6-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index a38ec58622145..43a4e79e56966 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -464,13 +464,13 @@ static int __maybe_unused rt722_sdca_dev_resume(struct device *dev)
 		return 0;
 
 	if (!slave->unattach_request) {
+		mutex_lock(&rt722->disable_irq_lock);
 		if (rt722->disable_irq == true) {
-			mutex_lock(&rt722->disable_irq_lock);
 			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK1, SDW_SCP_SDCA_INTMASK_SDCA_6);
 			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK2, SDW_SCP_SDCA_INTMASK_SDCA_8);
 			rt722->disable_irq = false;
-			mutex_unlock(&rt722->disable_irq_lock);
 		}
+		mutex_unlock(&rt722->disable_irq_lock);
 		goto regmap_sync;
 	}
 
-- 
2.43.0




