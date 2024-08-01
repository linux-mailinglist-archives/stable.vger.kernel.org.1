Return-Path: <stable+bounces-65209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1D943FBC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FB21C22672
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C189170A00;
	Thu,  1 Aug 2024 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2XsncOT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7C1C9EB1;
	Thu,  1 Aug 2024 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472865; cv=none; b=fzwwBiRe9Frrt2KFW3kvufkVIlLnsoQf2mLcaJy3u/ARUHQb9avN3RNCNT/dIq8KyuMMpgLNkJdUB0wBvMK55l+qbRJPzikGfNU3Wnkx3d2eC2XsK4GVoq8yVg3TLmq68NK6khnTTvWry13ePDGiPDdukw7KcdGJZx3GdFgggQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472865; c=relaxed/simple;
	bh=EXY8elrPXqDLlgNZmlPFL3zFn0gftBjtRSwczpDErVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0PouFhvTFpOuK5dHCsjaZkdHZGiZ5cSOFkU6kZDilO8HW2Kn7Q0ecSuvfNNgMau/14oXF/yCaDnr+2rrMKhQXc5m4HARIC3vtEIz4quJjHDf6bZwmgH/MZW3tlEXx/2nPoXxCMxGqQj98UqGqaEmLwWJBuR1c9TI4PeOCx4JYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2XsncOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966A0C4AF0C;
	Thu,  1 Aug 2024 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472864;
	bh=EXY8elrPXqDLlgNZmlPFL3zFn0gftBjtRSwczpDErVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2XsncOTPmbiZ3P2Bm46LauRCrXZXiTz87pXzPBHdziBLfkbCh/dN0ewPTl4gpt/B
	 xI47BsLmH6faUVeS0iTH42sNRHWZ65gWk7e1JbYyHzGOqjvubDGeWpnK/rpoy7GzLG
	 qmA9nF/AMObzPsao7PdE9ThOMxp34UbpybWvJnfyVx4e5Js2Bq4fHrRy3jkR4N88Fx
	 yRcJJ+BU5OvytoobuO3O0T5/8FDdaHqFSW6p0wRWcKu30RN7CtmAZ5r3FaANoIjiYI
	 wISEwm4yX3zSsSF65ZdjC3X+X1e4QA9/5T92T0qM3kHfOTPaGkpuu2YP7qJHj3qiEI
	 2+Ak3f5IklJkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/14] hwmon: (lm95234) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:40:20 -0400
Message-ID: <20240801004037.3939932-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit af64e3e1537896337405f880c1e9ac1f8c0c6198 ]

DIV_ROUND_CLOSEST() after kstrtol() results in an underflow if a large
negative number such as -9223372036854775808 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm95234.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index c7fcc9e7f57a2..13912ac7c69fc 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -310,7 +310,8 @@ static ssize_t set_tcrit2(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, index ? 255 : 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, (index ? 255 : 127) * 1000),
+				1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit2[index] = val;
@@ -359,7 +360,7 @@ static ssize_t set_tcrit1(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 255000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit1[index] = val;
@@ -400,7 +401,7 @@ static ssize_t set_tcrit1_hyst(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	val = DIV_ROUND_CLOSEST(val, 1000);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -255000, 255000), 1000);
 	val = clamp_val((int)data->tcrit1[index] - val, 0, 31);
 
 	mutex_lock(&data->update_lock);
@@ -440,7 +441,7 @@ static ssize_t set_offset(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	/* Accuracy is 1/2 degrees C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 500), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -64000, 63500), 500);
 
 	mutex_lock(&data->update_lock);
 	data->toffset[index] = val;
-- 
2.43.0


