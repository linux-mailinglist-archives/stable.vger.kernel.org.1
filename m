Return-Path: <stable+bounces-65086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 364BF943E75
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A3FB26C26
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6091D6DCD;
	Thu,  1 Aug 2024 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czpAtqaZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77281D6DC1;
	Thu,  1 Aug 2024 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472285; cv=none; b=gbDdZSwK83PDYgemmUrKKQeZqgFcz6FR+2Qv3kSndB38BenhdJ/kKJxjQP6nOE/wyYiiB/uV9GlnMuPXRJHXAwxrjBkk5LuC8N1qn7+oBdUzlD9wMr26er/p3nHg9dtx97ylczyNB4phkjVwgYWBufOW2HBG+UyAbzBXelRCEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472285; c=relaxed/simple;
	bh=xc7m9fOBgCu6Ayt/mGZGAJX8oQOR6eilO8PQBWSsH6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUqL2hLTc1vjcK8ESqPZn/jNSfJmhjmB0Z3v8G8VRNEgiFCnt0qMCgJZV1x+rHNyP3UPhO4T5eyY8reyNyAtFK1HJYqPAdtxh31LVmYbTvihmh8ikwalm3sRxVtG56i8kpS1XGs+rQznPyN3rfgoRyQ5XmkI5//PFvXAATYylVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czpAtqaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D58EC4AF12;
	Thu,  1 Aug 2024 00:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472285;
	bh=xc7m9fOBgCu6Ayt/mGZGAJX8oQOR6eilO8PQBWSsH6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czpAtqaZcaX/k3ULTjaoiGQANdafj109Q0WU6JlYoHJ42dw0uUEeGfEU80c+8TN0F
	 HhWHzoaUInd3b0xT4J1mr4VHVbPPQfkpm8UuifTfQG2diOuWu15RyAtbipdcRefEER
	 VBpM8H/LqfnKVICARFwChNS9qoCNbjKNfXAXo9Ot17hIdzpGTkoFaKfaQTvqTkhm89
	 4G7XeuhHDRUxywx/IybDRNzWn2sSX4K+oqoe+6ltQ6ESHS7rqlPFxwfU3OlU7VjITs
	 sDiNBy37O3P/sZs0muhMCCKQKdeXj+I0cN2m8STRLJAii9n4znq1WW9ba+syP1gckO
	 30W3sqlW+PFLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 57/61] hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:26:15 -0400
Message-ID: <20240801002803.3935985-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 0403e10bf0824bf0ec2bb135d4cf1c0cc3bf4bf0 ]

DIV_ROUND_CLOSEST() after kstrtol() results in an underflow if a large
negative number such as -9223372036854775808 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 9720ad214c20b..83e424945b598 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -2171,7 +2171,7 @@ store_temp_offset(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = val;
-- 
2.43.0


