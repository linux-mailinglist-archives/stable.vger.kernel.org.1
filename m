Return-Path: <stable+bounces-65087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62B943E39
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C72282835
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5835E1B9B22;
	Thu,  1 Aug 2024 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq3qShFS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051D19FA92;
	Thu,  1 Aug 2024 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472287; cv=none; b=GiNjrwyMAjRMU/3LV8y5+DXYy3pYdICSMNL9FIxOVC5dj7NAQvwHGZsnfct1yyedwETB4Q3EZ3rqp6dkltjXwXaHY6n4qybqJxdWjKKilvNsvgyRKdvAPdwzzJNAO7hif1gQS1lsSLE9xTqVHY7Pep+KAb1+SeGBE6dEQvGcLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472287; c=relaxed/simple;
	bh=pbrOycGROnHF/gVl0l6dhKLxjzzfJ1G4zcDi3NlzeBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sx74s9/lDegkBTFER4m9H8Rx/mbUnwuOA+oSR1xGU8bxMUx0Vqy+blAfgLWEXh9hEj4nHPZwTzaa16JhTdRFBu6Lbn54yf2h7DoxlvojaKtNamaPUqq6u5MQKfcRDIFxe31todaSEIAXHFhbH+lIPLI1Yd8W+HZeK+jwbOQHTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq3qShFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F46CC32786;
	Thu,  1 Aug 2024 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472286;
	bh=pbrOycGROnHF/gVl0l6dhKLxjzzfJ1G4zcDi3NlzeBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hq3qShFSGvW39LI1FW8fZkYq7kGmeg56aGBrKITRu7/GSDPcMt2k0FWnqEbRpWOdk
	 T0u6J6vco9yThNMiXpQM6XpXpNRhh70u1kZSHVOJ5MeWFhIABJPx2z/t7sxwIAmyLu
	 GXdRlWRws88CT5JTr8vB/XvTwVa/ltnyj68JCJUUcKKR0eGv1vWf6dEy5ZsvacDXQ8
	 UVpfXkwBtSsHnpuKSwLWJmW/kfMerViYYKNvcPe4KAPPrO5hMraltuXV7XBo4O5UVJ
	 8mWgE9ALx+tshQJBaG5BOfphaetnf5+d84xkaXVlwghWmJsTM7FMi13C7mMYN3CMj0
	 eUkDjOxqHIaEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 58/61] hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:26:16 -0400
Message-ID: <20240801002803.3935985-58-sashal@kernel.org>
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

[ Upstream commit 5c1de37969b7bc0abcb20b86e91e70caebbd4f89 ]

DIV_ROUND_CLOSEST() after kstrtol() results in an underflow if a large
negative number such as -9223372036854775808 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/w83627ehf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 939d4c35e713c..66d71aba41711 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -895,7 +895,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -920,7 +920,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit the temp to 0C - 15C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 15000), 1000);
 
 	mutex_lock(&data->update_lock);
 	reg = w83627ehf_read_value(data, W83627EHF_REG_TOLERANCE[nr]);
-- 
2.43.0


