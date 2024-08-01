Return-Path: <stable+bounces-65134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A38E943F05
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106A11F217DC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BCE1DE854;
	Thu,  1 Aug 2024 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THWmRxgJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8B1DE847;
	Thu,  1 Aug 2024 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472533; cv=none; b=aoHgGWQ8l0SCPFXijY/cV8CZL6lBz0gGKcsURYvZwAnnO7573fFjiNtHPRrWv0UnoSlYkZYxWjF4IkumA2+0hzay5a8x97ZVGcZxYcO3Ci3XjA4FlA2JP5tQpyG0FUEx4s75SWD7RRT67mhL6bD7CfzagxHUpK2CNfZwlRHT3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472533; c=relaxed/simple;
	bh=IcSwx/f1ZlyKwtv1Llxa1H7h6NhG96+nsaNLIEbKm0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4etJH2y+Gf91EReTN8xEC9RiRE6HFB6ZwQxbkdSa1ePYMycZQVTnxTJpez5+Dw6wc2g11QS2nG7CN4KsrmtvOCyAFgoMWNcV3gSnhZ/vFOszDQrLP9SIXOboIfYxTr/tE9w2Q/YR1A+rmfq1QPBbNL8apZbu9e74q/bkbSXuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THWmRxgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B422C32786;
	Thu,  1 Aug 2024 00:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472532;
	bh=IcSwx/f1ZlyKwtv1Llxa1H7h6NhG96+nsaNLIEbKm0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THWmRxgJArQqJ9i9Nf3IowNboYQAhw38CxPjs90hVtfzQRObbTzoykAn+XUybk4Wl
	 Ighq3sLuFM8P35PtkCghRkEXF9H2SXljCgLBWyq3EMKmar49s0MkqzGPygEMyDFUV7
	 in8yZT3g7iBK2YPci8+5U9Kq79PvlZXUuLvfSYenOctgozBNmtTi2o0k83IKl2TF3a
	 BniP8OklH0sbHcAcb7yJ7L/TnlLO/qlpzYMhw7nUYJXThJvBYtgCoNEp1/LPDVLFya
	 6K5i0Gjmb9GSDBV2oZuJMnTLDATKRN5nLZvu3p8JQ2N+w1rlKGlx+tEiLkZYdXq+Nn
	 GTlVbC7iYddSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 44/47] hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:31:34 -0400
Message-ID: <20240801003256.3937416-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 705a59663d42c..b6bae04d656ed 100644
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


