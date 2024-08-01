Return-Path: <stable+bounces-65025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4B943DA6
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712371C20A48
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B81A57C0;
	Thu,  1 Aug 2024 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQlknyds"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2FD144D00;
	Thu,  1 Aug 2024 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471965; cv=none; b=JGAe2QdFN8ZJh1cpn3sH4Rv5dcjWBsRV9Ypo/Cwhk8E73nNkblDrcJeOpBSBQn+36/hYtM9g20575tNZ/sFr9j7uf5qqwGDKEGdVNI5K9FIPNSC5idOnHwJ/DFwYREemmA6+JUBIjseicVAMxor+2ARuqODUKtag9VuQq2R6OUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471965; c=relaxed/simple;
	bh=RuyC51unbIIOGqIYEYttKGcUAK3WTed0bROPSWS2hxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaSQ2KtyFNLxw5xlwk5EwZUyKOZPDoiX36dDszLwA3zJlliAfh9acG+/NfyO4jG9DmO5x5nX1QPGtvxOHWIsKITeIC6CVXJc2VS+CxcvNemxyiVzegek59qBtxRLXIccrWaSknrsplrUABsx6n1LGCA+lZ/UVbAV/8k3vglSaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQlknyds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECCAC116B1;
	Thu,  1 Aug 2024 00:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471965;
	bh=RuyC51unbIIOGqIYEYttKGcUAK3WTed0bROPSWS2hxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQlknydsnRd4EG9AnnXLGmYbrmesQEYovgERZSpTkVWdbuRbirT+V82dX45GeiBvM
	 hyemiOcAHVBS4hOVISXOT+1p7KzcASnB9EnZcKyn9NBu2uyTSEaF6A1EatnqX+leCM
	 ZeKjy4KwBVW3a99lTrAtx/2zGvLadZfTTnv39mC/BAiPy+g5lQ16/9HCR9dUunJVWQ
	 sYOKlEsawaM0hvOWnOGtKvSL7gaZZWu2mov/NSJwbaqa9bA6FmA82FmcizFsetXGa5
	 WHwMIFyg53keoIllzzcJ3PC5WqZCbekOeJHuQofV/UuDCPy0vJkAFYkpOZt2GvjmWP
	 1JFu3A/tdVcmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 79/83] hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:18:34 -0400
Message-ID: <20240801002107.3934037-79-sashal@kernel.org>
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
index f3bf2e4701c38..8da7aa1614d7d 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -2262,7 +2262,7 @@ store_temp_offset(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = val;
-- 
2.43.0


