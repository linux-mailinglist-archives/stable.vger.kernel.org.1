Return-Path: <stable+bounces-65210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B822943FBF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B341F21798
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C7170A16;
	Thu,  1 Aug 2024 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD56RAYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C4170A0B;
	Thu,  1 Aug 2024 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472865; cv=none; b=pkBDa5fYxo7kJCi2blphNguyMXavAxlzd2y69YZX0bKEiJG814iEPsdp38oSIQaRtdb8QLjOiG++j8CMFDT7h+uv0EQdJubHSuoTi0rWvnTX0oB4WCGMZDteU+rSwa+LNJStvy7hXPewbWpFwBeIJ3XpNVoarOXr5E4GaxWkQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472865; c=relaxed/simple;
	bh=m8azvAv8JyoISEBql/CSvTpQWUmJ7QETCRCUvThPEgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1tInckOdt96PtYCabI3Z8KIRkgDdF43UU0yB2AREkNLq8jIcpQwoJBVc4k9P8gVPW8uXFr20yHEWd78OMDopGZHH8CLSh10Nxg5aMk4OkvobH0XKMGBAWdywh7T/y5Aeti1EgDyLSywfS3dGmYtbl7bcfKvpk9/vBs4VbYyPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD56RAYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD41FC116B1;
	Thu,  1 Aug 2024 00:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472865;
	bh=m8azvAv8JyoISEBql/CSvTpQWUmJ7QETCRCUvThPEgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kD56RAYysIjjaOLiuEtduEIkyGipMlPzMsHcdxsuTIRzRu38CucXx4btwKsXbxw7y
	 4DkWqjHpaxB7eIi6526GBfG3liavJGjtOcMfRgo+ehOrKPvvxvH4YYG2e4QlNtMJ0q
	 ADq3/nTXEYAcq/kYlX00cKr4EZMd8b5Xg/3bVeZHU7a4BI7aPXFVEfjhZvSV9g+jKO
	 Fxp5PMaNuNamoKjRwE9j8GcJ/DvBcMbeVvX1MOAJSWp16M4SicG904ZhtEWcpw8VvJ
	 IS3Ypr9/qund8GdwIc1pW4C+0LVwd0jm2BNO91twguuPk6zB72/PYhq3OZBYgsQfQ9
	 VMO4IfBWDr/EQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/14] hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:40:21 -0400
Message-ID: <20240801004037.3939932-13-sashal@kernel.org>
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
index ad68b6d9ff17e..8da5f77b8987c 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1519,7 +1519,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -1545,7 +1545,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit the temp to 0C - 15C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 15000), 1000);
 
 	mutex_lock(&data->update_lock);
 	if (sio_data->kind == nct6775 || sio_data->kind == nct6776) {
-- 
2.43.0


