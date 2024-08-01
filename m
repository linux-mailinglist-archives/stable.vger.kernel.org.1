Return-Path: <stable+bounces-64943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1271B943CDC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B8928206B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AD205E2D;
	Thu,  1 Aug 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYmdLwqf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192013A3F0;
	Thu,  1 Aug 2024 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471506; cv=none; b=GDfRp/LAge1w6Lt/PM340lA0ILHOkrl34ILPbAi9+vlR6nq/gTa7YSiJyUCkGbaDDnKo1QjMHZ4+dDLRdinR3PDbpT4E0EVR+i74P+juh/y/BsQWfHa57YN7BbyfybcwTbo+FWVZn7HsJMGnqCksir5hYDr7HhZfuX4V21Xt2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471506; c=relaxed/simple;
	bh=EnUEvHvbyAQWtZYVX6zVsMAma+OH+8r/lAB2a2IlOU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwuoQi/1i1wrvHD1z9j8oYnpLJB9mIknx+ATUfAKxb8T0pJIoFH92T80eZYkgso0lJLb5mY7ElliNGTXTYR3TMePF4YOeG2GOuoV5RJ5sQnFMi0elrtCOzzeM/dkheTzDWARSxfV+QWSpjp1HQ0PYfQzS/kbyYA1/rSn64Skt14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYmdLwqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AE1C116B1;
	Thu,  1 Aug 2024 00:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471504;
	bh=EnUEvHvbyAQWtZYVX6zVsMAma+OH+8r/lAB2a2IlOU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYmdLwqfylmUyeMvh4hcWmh+f/+NeAOfoMbonHfbFMwagz+QQbD/Gyq9yfvRm9Vc3
	 y0R/LSydo9tSklZPOwMLVxS65Ggc0IAfxa2gSHe5IWt/X/kwm15hAIsNm0/4vfCsZh
	 eRV7pzH2fmOczIkpJORS1nMIzTjy5dB0KQOA9b9WEGxlaWVi0q2cU3PI/bKrurGMWp
	 nZcrUkAJp6pCY08gsycPUFalYz3kBEnGzUoswZ92HihC00XF7fPQdcsbUUlC3x2EV0
	 hwWRO8cZ+ZU2SZOXvs+0gXVZDa1j4BJqvTQVoY41/6TMJ8NBXki7ps8tnPpPgOCbHB
	 MONT4L61FZ51g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 117/121] hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:00:55 -0400
Message-ID: <20240801000834.3930818-117-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index fe960c0a624f7..7d7d70afde655 100644
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


