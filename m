Return-Path: <stable+bounces-64941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645CE943CD7
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962F91C21BE0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20D205E13;
	Thu,  1 Aug 2024 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4MCm4Hw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC2205E09;
	Thu,  1 Aug 2024 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471503; cv=none; b=O09KMQtRiSCuOVlZpPVt+y2OfUg3wimLNLGk7KHu8BSbcZg0E9w4pywxzDI8DbVu4p2srZtwhUbV2wduUn8ZYsFiznanczB45La9vVb8AaHk2eKYcQZ4eklBGK+Z0hIRgJyqe5yRqq+lGpsn5ZeZVHLpk16L8SOA0lHivMNqDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471503; c=relaxed/simple;
	bh=MN2emGxv2vmkRSmMEb9iqCVOZ1b55iC+yE8Lf86XzbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yxfa6HbIwvCelOSRF1Ae4R10urNNe5F3wVKl5eeDOSsHxa3IgibU0OEDemaQo16lvW5XGAzerf1uCkshGtDYsVP4nyYyb1CkaxxOupsSW7u7BZQqyrPWjbAnGdTnvJ0HDiF3WygsrkEcXAvvOqBju85Vkui8Tu58n4JYRBP2Nqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4MCm4Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50934C32786;
	Thu,  1 Aug 2024 00:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471503;
	bh=MN2emGxv2vmkRSmMEb9iqCVOZ1b55iC+yE8Lf86XzbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4MCm4Hw1fBKTQuQPdFfnU7Jg3bNhy8e7+++ExBdbmuPYt2aqeg3zAm97+S7VgJyA
	 q9pKuAYCmihdmYgk9nHawSbEuORSdq7T0LhD0t0iBWdFp3KjnJwEJohgAQYDkV0SKD
	 Hg45KiFhHR/OGxJzBZiMS5OVjS83zfNiv5GzcX+UOp9U7KYTjm2YJsY7CDb7RRyii8
	 oPAd9lvwzdfpk7Cuov+T/W9gCy/tAKOoOz6h1ZFBjoHKXmCbrpAd5xSPzjjS1YLSee
	 qvx1GBngEGCGMhSkeR93Ks20aJ4sZrSTbJHBItXAxrH7YnUTM0cGdYzb0Eh9+H7ba4
	 24AJD1ait8vVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 116/121] hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:00:54 -0400
Message-ID: <20240801000834.3930818-116-sashal@kernel.org>
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
index 9fbab8f023340..934fed3dd5866 100644
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


