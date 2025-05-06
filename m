Return-Path: <stable+bounces-139976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A152FAAA33F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB2C3B0893
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4CD2836B9;
	Mon,  5 May 2025 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7PL4t7+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8BC2ECE5C;
	Mon,  5 May 2025 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483812; cv=none; b=YlWQ/Lf1DF+uw2G/rEVIkZw1nO/Gn9/4aKCjh3RXUrCCVr4wgJSSe9ByaPkELeo3pdhQp4s5KEl3zfKF6ivkqiYbb/TeLgIZ9xKp28XN3Clc2GNMLqvIKXk1DmGOf68a3hU/MPgm8cHRUJJ2GF37fgASsm634XMp3d2dq2NZiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483812; c=relaxed/simple;
	bh=Ztz+nIN4jVsm5dk1LbPMMQ3xifHEySLYwovq03zpYkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sR/E+JSbidZxs9+/jOhEjrNQWmSD3aYsxJkKZDyEvcte10Wl6Lh90YoQQiCN+rs/3Jd5y0T9xFBYXfU2++CQYAf8uyFG3Oj3tnrWuDg4wHJNJlXAe6pbu7bGYqcLBCpuRTib24G1b8vtiWvJv8MMTPY9eolWc8g4iPrgklbyOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7PL4t7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A789C4CEEF;
	Mon,  5 May 2025 22:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483812;
	bh=Ztz+nIN4jVsm5dk1LbPMMQ3xifHEySLYwovq03zpYkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7PL4t7+HxExAFig328KyIGyagdVHV+0l7H6Uers1RQuY67IRxNT5SgoN6+EhGkRw
	 RDj4JDaxF/DbkFRxq+49zZFUlMxBBKENzSpUU/GhK8BBCjbgFrB/IGiBmDwv/9RJPs
	 8JEjViSTh4/to8+dD7gzsihGtYC/I1SCJgVItVo5wOwDpmMYI1PRIpeO5xgJKpmvcN
	 abIZjh57Ln+tahAkzvL1JXtJ8Hyn84etA5xEfUTwosNSvQiTwFdYUmGVQBJdUkqgDn
	 NeFWP2bNYNt8ubvwIBg92bYf6jxTGTKbGDky4Pt/DTTYdD5hyiE4E8ztlop+BvXFFn
	 EbyMqCR7Qc28Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 229/642] rtc: ds1307: stop disabling alarms on probe
Date: Mon,  5 May 2025 18:07:25 -0400
Message-Id: <20250505221419.2672473-229-sashal@kernel.org>
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit dcec12617ee61beed928e889607bf37e145bf86b ]

It is a bad practice to disable alarms on probe or remove as this will
prevent alarms across reboots.

Link: https://lore.kernel.org/r/20250303223744.1135672-1-alexandre.belloni@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-ds1307.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 872e0b679be48..5efbe69bf5ca8 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1807,10 +1807,8 @@ static int ds1307_probe(struct i2c_client *client)
 		 * For some variants, be sure alarms can trigger when we're
 		 * running on Vbackup (BBSQI/BBSQW)
 		 */
-		if (want_irq || ds1307_can_wakeup_device) {
+		if (want_irq || ds1307_can_wakeup_device)
 			regs[0] |= DS1337_BIT_INTCN | chip->bbsqi_bit;
-			regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
-		}
 
 		regmap_write(ds1307->regmap, DS1337_REG_CONTROL,
 			     regs[0]);
-- 
2.39.5


