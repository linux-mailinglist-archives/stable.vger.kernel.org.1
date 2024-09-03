Return-Path: <stable+bounces-72819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1513969A73
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EFB8B22F6F
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1FA1B9849;
	Tue,  3 Sep 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uGOLDWEc"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014919CC3F
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360135; cv=none; b=KPeNDpiU38GuAFgpwIHnNLavKXB/Tv6kHDWXeJbchVA5eWSeKCp0Qsyu7bjzxn8xLk/dz3Twt92uKVm1OOLw773KlSx0p7RrjB5Rzdb6la7tiN/j55TS31OZJtZS0mIpzf8URmOwbTFraVi5zy+akCvG7WwlxEaUpYItC6I65F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360135; c=relaxed/simple;
	bh=zQmgGLFUQ1O2NYcdXPEeh07eLJcrMfziVPmCfIAlr0E=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=s4H5jOVpiAGQyZhYT3FgwbgL7A6Hb8sMgLWyPLsrokwEIclTp8qQQTwP7BBKpo16/oZhnHoWuXVdRV7ca35Kf9QDRlNMaXstz1BU/nVCS+QwHZAUouYDTo7hb9sOl5FAonR5wzNrjqYIt3Le7BQCzMIdPMMc/BopFd3j9XoyFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uGOLDWEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE31EC4CEC9;
	Tue,  3 Sep 2024 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360135;
	bh=zQmgGLFUQ1O2NYcdXPEeh07eLJcrMfziVPmCfIAlr0E=;
	h=Subject:To:From:Date:From;
	b=uGOLDWEc2yrZD/Uy1ILkV7px+7uhl4jNYHcxC269DnrPRkZpRsXilYPL5YGxHUq0y
	 9+C2igtViXZqNOdJtA0dUKumaqGedJebjkPKaLKtTXadnaW7LWAUQ6kxs2bZOuuOTX
	 Vohghm6J/xOtTAdDJj2OtPzH/uTplcHSQv/sK878=
Subject: patch "iio: adc: ad7173: fix GPIO device info" added to char-misc-linus
To: mitrutzceclan@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dumitru.ceclan@analog.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 12:18:07 +0200
Message-ID: <2024090307-upheld-flaky-f644@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7173: fix GPIO device info

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From f242967f4d1c024ac42bb47ea50b6360b4cb4556 Mon Sep 17 00:00:00 2001
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
Date: Fri, 9 Aug 2024 16:49:08 +0300
Subject: iio: adc: ad7173: fix GPIO device info

Models AD4114/5/6 have .higher_gpio_bits = true. This is not correct as
the only models that have the GPIO bits to a higher position are AD4111/2.

Fix by removing the higher_gpio_bits = true from the AD4114/5/6 models.

Fixes: 13d12e3ad12d ("iio: adc: ad7173: Add support for AD411x devices")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Link: https://patch.msgid.link/20240809134909.26829-1-dumitru.ceclan@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7173.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a854f2d30174..0702ec71aa29 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -302,7 +302,6 @@ static const struct ad7173_device_info ad4114_device_info = {
 	.num_configs = 8,
 	.num_voltage_in = 16,
 	.num_gpios = 4,
-	.higher_gpio_bits = true,
 	.has_vincom_input = true,
 	.has_temp = true,
 	.has_input_buf = true,
@@ -320,7 +319,6 @@ static const struct ad7173_device_info ad4115_device_info = {
 	.num_configs = 8,
 	.num_voltage_in = 16,
 	.num_gpios = 4,
-	.higher_gpio_bits = true,
 	.has_vincom_input = true,
 	.has_temp = true,
 	.has_input_buf = true,
@@ -338,7 +336,6 @@ static const struct ad7173_device_info ad4116_device_info = {
 	.num_configs = 8,
 	.num_voltage_in = 16,
 	.num_gpios = 4,
-	.higher_gpio_bits = true,
 	.has_vincom_input = true,
 	.has_temp = true,
 	.has_input_buf = true,
-- 
2.46.0



