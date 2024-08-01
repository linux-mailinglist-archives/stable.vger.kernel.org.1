Return-Path: <stable+bounces-65026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CD7943DA9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2418285A04
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58D1A57DE;
	Thu,  1 Aug 2024 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQEXEjXR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217F1A57D1;
	Thu,  1 Aug 2024 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471967; cv=none; b=gpPI/j4HnU4odZ2xKafXFyEJimGVSy51tntWchhnZmAl6p8ZbTscdaVObRxKRJfZ9KWHMc/5ivKFjsl9gDYMwMd+Yw4wOexshPnqOnhY5B+Wwh5n3efLnK/D8hQCfXSkV+pZRbTkiy6C7X6NY+lhM23EKsGp5MNIFv8Lnllojfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471967; c=relaxed/simple;
	bh=EnUEvHvbyAQWtZYVX6zVsMAma+OH+8r/lAB2a2IlOU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7cqoFyQ56gTzL4mCShEyPxwBWk/weKK5dSk3h2c3MI37F9CII8WAiMzz+0v5W+x5knWnn7K5kdS9pZfxwAQJe3xGOlf9sVLRG4xYGbupBZh6DLD257wsrSkjZ9z6EsNjhBn4rqFLIvZR3pK8iFia/3pvVQqQ7VOBk22rwuu6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQEXEjXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EDEC4AF0E;
	Thu,  1 Aug 2024 00:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471966;
	bh=EnUEvHvbyAQWtZYVX6zVsMAma+OH+8r/lAB2a2IlOU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQEXEjXR5LUeLcf+BKoAG8A/4a7RvlS5Nmbbai9y6JI/4zjw7XEheZGwV8dBSjxx/
	 yKtTZfnb0k5Qiqup7UVc+bar+4E2jMNPAryWHddKLt3fdeeIF4rtGQWUJPp+WzcSPd
	 /PnLayYinUPhp2Grvw84s4nZaAwH50FioY3I0TDMtx9zdtMVLfKgEHD8eDpRAbCdhL
	 SgdPIBycYjqUFuGQVU6Yy3f4T0qnioGCZPqXoKscR4G3qWS9MVBgfd8Ry3WxufxY+u
	 Y4M2h/qBSAB3JFt7Ab2sFY6b1FZmBcs5Q6Vb3QFHBT0vz9EAHeP65Q+GxmFvReWsWJ
	 ES7+wam9kGFZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 80/83] hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:18:35 -0400
Message-ID: <20240801002107.3934037-80-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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


