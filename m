Return-Path: <stable+bounces-60482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ED09342E7
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 22:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9480CB21B7A
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE518411C;
	Wed, 17 Jul 2024 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RH3+xGAa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAFD17F385
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246629; cv=none; b=DjXPYeY1DqvgcSgOZkVfF+2xR9GF7pM4UO9UvIfMp67VGiBJjBk09txK/RfTWSjADdE/S7Gk9UIQriXKFL7Imtufp5Xg7NbqEQlE/zOQlbTZCiJgblO8/mTMl9wvw/Zg59GUfOINc18pLtFGPOD7slCTHDjDK1nejB2/OuHgKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246629; c=relaxed/simple;
	bh=vMGDxu2RKF5jKma5R4sq0owsnuwyN3/lYJkehAE2H4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJGIK5dIOm8qZBq88/mA9gx8E75YAlosYkQQa6SbJwClTNkLapcZSA/4H1tC7lNG7YezTm/VV/WjP8iVM7anbe1hWZOCdhC+0SD9VENXEQX9q/BcXVzgUgPTmqduOoCgFBa7H6ATJ5QZvmODSe87A4XGhZeEdmw68mz5Vr8iutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RH3+xGAa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721246625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z/C3IQpGtU2AGOPpwHOlmqXZMKLhljDesKCWgyYBh64=;
	b=RH3+xGAaCKe9M591sQrD0fFdllfAUQxDhfchFmavn325sTn+NxmmGWld9QgyFAvlF5Uq61
	zejsldFm3tKXIEOVVNPw82e/2FA9bppXBcs6empooeeFy4mYaG8F5Bd+VVx7o7lJw/ntNo
	feFOd/ZXB9ML76DZRgLFYnJwxrV8Zqw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-W8i5cfvMM1G_XRlrwBZO7w-1; Wed,
 17 Jul 2024 16:03:42 -0400
X-MC-Unique: W8i5cfvMM1G_XRlrwBZO7w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F8FD1955D47;
	Wed, 17 Jul 2024 20:03:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93A4F19560B2;
	Wed, 17 Jul 2024 20:03:39 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] power: supply: axp288_charger: Fix constant_charge_voltage writes
Date: Wed, 17 Jul 2024 22:03:32 +0200
Message-ID: <20240717200333.56669-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

info->max_cv is in millivolts, divide the microvolt value being written
to constant_charge_voltage by 1000 *before* clamping it to info->max_cv.

Before this fix the code always tried to set constant_charge_voltage
to max_cv / 1000 = 4 millivolt, which ends up in setting it to 4.1V
which is the lowest supported value.

Fixes: 843735b788a4 ("power: axp288_charger: axp288 charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index b5903193e2f9..aea17289a178 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -337,8 +337,8 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
 		}
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		scaled_val = min(val->intval, info->max_cv);
-		scaled_val = DIV_ROUND_CLOSEST(scaled_val, 1000);
+		scaled_val = DIV_ROUND_CLOSEST(val->intval, 1000);
+		scaled_val = min(scaled_val, info->max_cv);
 		ret = axp288_charger_set_cv(info, scaled_val);
 		if (ret < 0) {
 			dev_warn(&info->pdev->dev, "set charge voltage failed\n");
-- 
2.45.2


