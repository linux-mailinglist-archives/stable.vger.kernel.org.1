Return-Path: <stable+bounces-65173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E993D943F67
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FA5281720
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF86E1E4EE7;
	Thu,  1 Aug 2024 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYCPBV9+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B01C2310;
	Thu,  1 Aug 2024 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472725; cv=none; b=M//l3Sqp1M0WVsYf9AGr3ZWHSReP+bSYHAoJWRxbi2QFNpF/ZrvgddPGY+5g7Tlnr0ziHjidASHAqNIxAQmGl/4lo6IftlDSzzI3cmJqBTtVZkAgPuhFIPtntx1LOQnkss0B2NE7CLalhyuH8RRxfzPg3ABnTs6DpmWJd5JVpsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472725; c=relaxed/simple;
	bh=8F+SyF1OGxqqCe9ZnvpAU4P1HmB5uCYj6NnFjBgvBMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgQs2MQTVP4bvaX9itLVmaf+Z3VHruTrTBPeOoCzug7uOVvZQB3zSgPgMDgo8xNR5nUFtzr0MOaAS0i0p1Z9nHs85J/IJhnMviH5Qj7baHzQ8PPfa/dJc41GpNRZdCMxMqjx9+MZp/BfavKWCjCbiwDXGdsrMR7wkCnhs1fsT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYCPBV9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2DDC32786;
	Thu,  1 Aug 2024 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472725;
	bh=8F+SyF1OGxqqCe9ZnvpAU4P1HmB5uCYj6NnFjBgvBMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYCPBV9+8sxT41/jLN2x/34dEHFBcD+QLq16K3+31fue8aftI36neYK12ND2XWuj7
	 tALdt6jlXG0k/LG9xKCD1lnfDLMNwqgZ+qKS6SKfWwpJoSJ+UzSSmxrCyq46NadRRO
	 FjTg5jyDPOukv0kIhBXLyYVJGnULxn3ErktgJJ6w/X02RYJloc+mw/D/L+tCMtS5ta
	 HOCsZ/OQfCBxYj/nhLrWZjhxAFwGGS0+RtB+DvecTAZndbQMij9H9OHLdYAHD5GL01
	 s6yVH3aA4dy6dVC6z/qt/PUpskn3nYg7Op1kEYWFk6o5C38sluJaWf0rNXFCWJsXVO
	 R0HtMnjSP7+YQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 36/38] hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:35:42 -0400
Message-ID: <20240801003643.3938534-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 3964ceab2817c..acf36862851ad 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -897,7 +897,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -922,7 +922,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit the temp to 0C - 15C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 15000), 1000);
 
 	mutex_lock(&data->update_lock);
 	reg = w83627ehf_read_value(data, W83627EHF_REG_TOLERANCE[nr]);
-- 
2.43.0


