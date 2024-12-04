Return-Path: <stable+bounces-98412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7709E4119
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C522822BB
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A2219BC6;
	Wed,  4 Dec 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV0tfIm6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08743219BC0;
	Wed,  4 Dec 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331710; cv=none; b=g5ITUAyLlDig/VQ51TkBsxhfwc3LYTsTkZMsFlrlrPRU1b4pRBj9TTs1/i9fqPYRaZM9IFDVfrCYGDUl20RFmWXCyTlu0ClHW4rkB/8nlZfoiH4sVTOAA/pTN3TyaFiEOOrSknG4tRXtd23Ann3cNj4/3a23Nwa6n/F4rMQfW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331710; c=relaxed/simple;
	bh=CHmYRMfN0T5MGcVyKgUebgGPneZnb42a916FBaDKZy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBkBWQyRO3bN6eGThOwj3k82aiIm40UYrkqFkeF7vlMQNEqR+UrxgcMzLBfuHYaLDKm4jE9Ff8j0AUdodaeXTFfweA5+f683K4ZAfZm8Sp5ZPlJO0Y6HGdiRtY6ZF1b3Jdqy3DUdCg0CKOo+omxPXTVyQLosRCVRqhvLaborjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV0tfIm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7997C4CED1;
	Wed,  4 Dec 2024 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331709;
	bh=CHmYRMfN0T5MGcVyKgUebgGPneZnb42a916FBaDKZy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GV0tfIm6qCeUYeGED63Wc72+KxM8jIotCs0VLQTStXZUI5rDf+Lyo+KgaYOKjEs4y
	 63V6vLyUj8+jG0cPLDcbxAzkVt+sPUNSWOxfoZiVb2QE2fqJjFuiaJvdruPM6TGylu
	 eRuei8mp/pQDjM3+5NLjhcei/3LviBSJSqhPxJL5Z0Ob8kLQqwk1TzF6cU186JmjOT
	 NJ5R5Et0JOO7iJMjjRxWESH+4W3DKUq4uVVrjLx8EMFyL0kNc3gRs7Jwf9IhckRVqK
	 5+v5urQMQ9mKnPTRCKrdkzMKOaY3qZRK4saoTKDd/FFEzc6V2QPefIFGYkKSKUfsaQ
	 uADLr5f8WHpRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 10/24] mfd: axp20x: Allow multiple regulators
Date: Wed,  4 Dec 2024 10:49:30 -0500
Message-ID: <20241204155003.2213733-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155003.2213733-1-sashal@kernel.org>
References: <20241204155003.2213733-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit e37ec32188701efa01455b9be42a392adab06ce4 ]

At the moment trying to register a second AXP chip makes the probe fail,
as some sysfs registration fails due to a duplicate name:

...
[    3.688215] axp20x-i2c 0-0035: AXP20X driver loaded
[    3.695610] axp20x-i2c 0-0036: AXP20x variant AXP323 found
[    3.706151] sysfs: cannot create duplicate filename '/bus/platform/devices/axp20x-regulator'
[    3.714718] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1-00026-g50bf2e2c079d-dirty #192
[    3.724020] Hardware name: Avaota A1 (DT)
[    3.728029] Call trace:
[    3.730477]  dump_backtrace+0x94/0xec
[    3.734146]  show_stack+0x18/0x24
[    3.737462]  dump_stack_lvl+0x80/0xf4
[    3.741128]  dump_stack+0x18/0x24
[    3.744444]  sysfs_warn_dup+0x64/0x80
[    3.748109]  sysfs_do_create_link_sd+0xf0/0xf8
[    3.752553]  sysfs_create_link+0x20/0x40
[    3.756476]  bus_add_device+0x64/0x104
[    3.760229]  device_add+0x310/0x760
[    3.763717]  platform_device_add+0x10c/0x238
[    3.767990]  mfd_add_device+0x4ec/0x5c8
[    3.771829]  mfd_add_devices+0x88/0x11c
[    3.775666]  axp20x_device_probe+0x70/0x184
[    3.779851]  axp20x_i2c_probe+0x9c/0xd8
...

This is because we use PLATFORM_DEVID_NONE for the mfd_add_devices()
call, which would number the child devices in the same 0-based way, even
for the second (or any other) instance.

Use PLATFORM_DEVID_AUTO instead, which automatically assigns
non-conflicting device numbers.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20241007001408.27249-4-andre.przywara@arm.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 87603eeaa2770..1e7cfd5bf2445 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -1317,7 +1317,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		}
 	}
 
-	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
+	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x->cells,
 			      axp20x->nr_cells, NULL, 0, NULL);
 
 	if (ret) {
-- 
2.43.0


