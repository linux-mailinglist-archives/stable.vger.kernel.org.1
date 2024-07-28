Return-Path: <stable+bounces-61984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3BA93E1A9
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657E2281C85
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022BFF9F8;
	Sun, 28 Jul 2024 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXFme9W7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6475EEB1;
	Sun, 28 Jul 2024 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127667; cv=none; b=keWz2XFxLsZYjDdQj5s2Hct7PQ7Tzdu4/SyzMQru0P+iva3uDmWIvnxUfPE13Fn0DRwolNzEOfGOZiCOTuCvcU4K40THGCZdSgmF+SXdqI3uzPTGCXKFqkAPYi4V+UNuwE0auHNBpAUeFSm1+z+Gr3puqT58i54/pk4zIZO5Pi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127667; c=relaxed/simple;
	bh=w3FlVKxMbbv3EuRWb1BX7xihz/7lTVonfbO1GVY7dn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSq1K6g35WW2ibwjs/aylP/ybrIOAMT2ITZrPFfEgNF142X3wn/B44TkyIXd9oHnyuYJnc9rs1ex4qgF1/S40hTt14gKtbGvvWr1iviJpEntz4cZwLH6OeSwTIQGoMk6CSrhgXxTZwzbIZWy4FpY/w9kRRccx+lwCjcbKPQsI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXFme9W7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA61C4AF07;
	Sun, 28 Jul 2024 00:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127667;
	bh=w3FlVKxMbbv3EuRWb1BX7xihz/7lTVonfbO1GVY7dn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXFme9W7RKxsXzgWBC8yjbQyCyKwyTdiexXSvUAMh2UkFW/R1lrqSVk7hildUNo9N
	 xvwZVfJeTcvVhyOcLi06Z3vFZM2PilileyDQ+2uky9qBPLzDtz5cMCYfU0oimQPYoF
	 V0CA5dunun5vJkNQ2u+En2aLVP8hEHk6rip7uAffHBIc+RJTtuI6hIgmWAJ/6HO18E
	 Wgqv8MmEgtvkiNuMJzV9kzmNt/Wv2oyQSEKKwDm0yyxqMToVPzakYby5G457BXl7Ct
	 GvkDzmgsEyVHtaKdJ+2Q2AvrGBYBjtfzr5Vb8hG19OXp0X8F7dTrQ/oO4B0Hs3dwem
	 aTAnm8y6s3UKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wilken Gottwalt <wilken.gottwalt@posteo.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 04/16] hwmon: corsair-psu: add USB id of HX1200i Series 2023 psu
Date: Sat, 27 Jul 2024 20:47:21 -0400
Message-ID: <20240728004739.1698541-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004739.1698541-1-sashal@kernel.org>
References: <20240728004739.1698541-1-sashal@kernel.org>
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

From: Wilken Gottwalt <wilken.gottwalt@posteo.net>

[ Upstream commit b9c15c96ccb47ad860af2e075c5f3c90c4cd1730 ]

Add the usb id of the HX1200i Series 2023. Update the documentation
accordingly. Also fix the version comments, there are no Series 2022
products. That are legacy or first version products going back many
many years.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
Link: https://lore.kernel.org/r/ZlAZs4u0dU7JxtDf@monster.localdomain
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/hwmon/corsair-psu.rst | 6 +++---
 drivers/hwmon/corsair-psu.c         | 7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index 16db34d464dd6..7ed794087f848 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -15,11 +15,11 @@ Supported devices:
 
   Corsair HX850i
 
-  Corsair HX1000i (Series 2022 and 2023)
+  Corsair HX1000i (Legacy and Series 2023)
 
-  Corsair HX1200i
+  Corsair HX1200i (Legacy and Series 2023)
 
-  Corsair HX1500i (Series 2022 and 2023)
+  Corsair HX1500i (Legacy and Series 2023)
 
   Corsair RM550i
 
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 2c7c92272fe39..f8f22b8a67cdf 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -875,15 +875,16 @@ static const struct hid_device_id corsairpsu_idtable[] = {
 	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i Series 2022 */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i Legacy */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i Legacy */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i Series 2023 */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i Series 2022 and 2023 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i Legacy and Series 2023 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c23) }, /* Corsair HX1200i Series 2023 */
 	{ },
 };
 MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
-- 
2.43.0


