Return-Path: <stable+bounces-166399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C947FB199AC
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DA43AD84B
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863419F424;
	Mon,  4 Aug 2025 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6o+RDi4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0F1D555;
	Mon,  4 Aug 2025 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268146; cv=none; b=Lxw6/mwj77cXGLowhgqN1eCCbi60VGDMXpvBCzR1kaqgmr0kz+t8uX4J3KCiZW86rJDcAjRJEHDm2N1Ibo2Z7magT2w9MR+nU629curMFBgM+Npkx1LkZ5/Bd56dir/0gAhxPxg6YZ2Vri43Zh1A5e9WN7otHxP6u1kB0c+Mayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268146; c=relaxed/simple;
	bh=xjbQ2vz04xdubLL9em34KHZWy/iaLyM1Oo1xjUjeltw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myHCnOHuxSsq7/SkJRf2RHe89rBBSvG1Wb1bQc2cFTtqDRseI/ggpjVfUW4GPQJ4KgLbs1YstyT5eOEVJ0YSxkO16kHydS00Eo1ldoR6MbLRAL2bJ26AGW7EIn1fKEkg9JF6wtBWCVa0gGQRlZr5bhC3eDc4Ta1sRY7U9Kk5/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6o+RDi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5885AC4CEEB;
	Mon,  4 Aug 2025 00:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268145;
	bh=xjbQ2vz04xdubLL9em34KHZWy/iaLyM1Oo1xjUjeltw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6o+RDi4kjJsVbvlahX9KgtDOqrV3NxG6NC7JhCYSnyM8CVP8GMnjK3KdYyxRdX+3
	 FCzM4z0o6qGNo7v3/WY2wUo71+FUqB5DArGkMqf1pv0IefuCMytiFLC9b7rhTfcOaz
	 5BT7tUsE1Dmy9N6qmTb+TdK6deWd+cpLuHW5XFn7wrvtXbHXUXp3N6OTQNRgUqwOCW
	 zqpxU/BTZ+M+KB1q4euaSyqlNzvQrUXD8ZZ3kuW391Jf5w8VG5mfKaUrVRTsfIUCOy
	 7kYOg+FimA6LFrezJziRhFJsEm47a3RhDDBgrIo+NADRcIqYPnnsX4TcEgkc9wbjXV
	 xgz+qZj84Cn1A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Xinxin Wan <xinxin.wan@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com
Subject: [PATCH AUTOSEL 5.10 39/39] ASoC: codecs: rt5640: Retry DEVICE_ID verification
Date: Sun,  3 Aug 2025 20:40:41 -0400
Message-Id: <20250804004041.3628812-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004041.3628812-1-sashal@kernel.org>
References: <20250804004041.3628812-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
Content-Transfer-Encoding: 8bit

From: Xinxin Wan <xinxin.wan@intel.com>

[ Upstream commit 19f971057b2d7b99c80530ec1052b45de236a8da ]

To be more resilient to codec-detection failures when the hardware
powers on slowly, add retry mechanism to the device verification check.
Similar pattern is found throughout a number of Realtek codecs. Our
tests show that 60ms delay is sufficient to address readiness issues on
rt5640 chip.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Xinxin Wan <xinxin.wan@intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20250530142120.2944095-3-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
detailed analysis:

## Analysis of the Commit

### 1. Bug Fix Nature
This commit fixes a real-world hardware detection issue where the RT5640
codec device ID verification fails on systems where the hardware powers
on slowly. The failure results in the driver returning `-ENODEV` and the
audio codec not being initialized, causing complete audio failure.

### 2. Small and Contained Change
The fix is minimal and highly contained:
- Only adds 3 lines of code
- The change is isolated to the probe function's device ID verification
  logic
- No architectural changes or new features introduced
- The retry logic is simple: if initial ID read doesn't match, wait
  60-100ms and retry once

### 3. Clear Purpose with No Major Side Effects
The code change:
```c
regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+if (val != RT5640_DEVICE_ID) {
+    usleep_range(60000, 100000);
+    regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+}
```
- Only adds a single retry with delay if the first read fails
- The delay (60-100ms) is reasonable for probe-time initialization
- No impact on normal operation when hardware is ready

### 4. Follows Established Pattern
The commit message mentions "Similar pattern is found throughout a
number of Realtek codecs," and the probe function already contains a
400ms delay after enabling LDO1 (line 3004), showing that power-on
delays are expected for this hardware.

### 5. Minimal Risk of Regression
- The retry only occurs when device ID verification would have failed
  anyway
- In the worst case, it adds a 60-100ms delay to failed probe attempts
- Systems where the codec is ready immediately continue to work without
  delay
- The pattern is conservative: only one retry attempt

### 6. Important User Impact
Without this fix, affected systems experience:
- Complete audio failure on boot
- No audio codec detection
- Requires manual intervention or multiple reboots to get audio working

### 7. Stable Tree Suitability
This fix meets all stable kernel criteria:
- Fixes a real bug affecting users
- Minimal change with clear purpose
- No new features or APIs
- Low risk of introducing new issues
- Self-contained within a single driver

The commit represents a classic hardware quirk fix that improves
reliability without adding complexity, making it an ideal candidate for
stable backport.

 sound/soc/codecs/rt5640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index a5674c227b3a..c12966025cfa 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2810,6 +2810,11 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	}
 
 	regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+	if (val != RT5640_DEVICE_ID) {
+		usleep_range(60000, 100000);
+		regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+	}
+
 	if (val != RT5640_DEVICE_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5640/39\n", val);
-- 
2.39.5


