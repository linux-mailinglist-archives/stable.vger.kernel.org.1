Return-Path: <stable+bounces-85873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415C99EA9A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3133B2291E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8396D1C07F4;
	Tue, 15 Oct 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UWKLBHlh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439551C07C4;
	Tue, 15 Oct 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996978; cv=none; b=eD8jIoKJ2r2nVCOxQZfK4a3jWSATxJ/ryusP992DE5EDAvkABBs8RAzFI0GfTvHe584J3h61pH5i7/ACVLU9pzBjWk6iiskss2f7CmdOJ9KhM5tvO1nJhpLmapSoNtQJWUgeJpl4gc30eRYUfAjc7sGzzxMvCMfU4TBQJgMJWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996978; c=relaxed/simple;
	bh=MI1kOLrU9s09e8SVVXcBj9eRLcR1wFQ6jn26w84QWA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb22N4LzMX6xT5QCZoOLKmy/+tSA6wrDw7AYSs9WgexpePdr4+b9hx1yBRASvc4nAwr3bpCoYEaF7QguaDkmT32w29q47mHpWOxJcdfpt31/1jx5n9FUAH0H060xX/8FTKKaLSUsbkMEuvg4Fum8fkOYMNAtRIS6DfIT2HwdvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UWKLBHlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB8FC4CEC6;
	Tue, 15 Oct 2024 12:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728996978;
	bh=MI1kOLrU9s09e8SVVXcBj9eRLcR1wFQ6jn26w84QWA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWKLBHlh+iNgmY7b2LtzstVGQUyLaMV3o4x6LG01VYTvSfx+YFebT/l0TxYD2HuUu
	 XnDGSQLTv/kFCFJnh5tdZlvBBsc/XzlRZ6BVEXYsOmAIrPfmtaOAqmapGZqgusxOiH
	 07SeYNbJw/osOCIhJ569b5QuAvDB50vEE/qF/NP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 5.10 054/518] gpiolib: cdev: Ignore reconfiguration without direction
Date: Tue, 15 Oct 2024 14:39:18 +0200
Message-ID: <20241015123919.097556435@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kent Gibson <warthog618@gmail.com>

commit b440396387418fe2feaacd41ca16080e7a8bc9ad upstream.

linereq_set_config() behaves badly when direction is not set.
The configuration validation is borrowed from linereq_create(), where,
to verify the intent of the user, the direction must be set to in order to
effect a change to the electrical configuration of a line. But, when
applied to reconfiguration, that validation does not allow for the unset
direction case, making it possible to clear flags set previously without
specifying the line direction.

Adding to the inconsistency, those changes are not immediately applied by
linereq_set_config(), but will take effect when the line value is next get
or set.

For example, by requesting a configuration with no flags set, an output
line with GPIO_V2_LINE_FLAG_ACTIVE_LOW and GPIO_V2_LINE_FLAG_OPEN_DRAIN
set could have those flags cleared, inverting the sense of the line and
changing the line drive to push-pull on the next line value set.

Skip the reconfiguration of lines for which the direction is not set, and
only reconfigure the lines for which direction is set.

Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
Signed-off-by: Kent Gibson <warthog618@gmail.com>
Link: https://lore.kernel.org/r/20240626052925.174272-3-warthog618@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-cdev.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1110,15 +1110,18 @@ static long linereq_set_config_unlocked(
 	for (i = 0; i < lr->num_lines; i++) {
 		desc = lr->lines[i].desc;
 		flags = gpio_v2_line_config_flags(lc, i);
+		/*
+		 * Lines not explicitly reconfigured as input or output
+		 * are left unchanged.
+		 */
+		if (!(flags & GPIO_V2_LINE_DIRECTION_FLAGS))
+			continue;
+
 		polarity_change =
 			(!!test_bit(FLAG_ACTIVE_LOW, &desc->flags) !=
 			 ((flags & GPIO_V2_LINE_FLAG_ACTIVE_LOW) != 0));
 
 		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
-		/*
-		 * Lines have to be requested explicitly for input
-		 * or output, else the line will be treated "as is".
-		 */
 		if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
 			int val = gpio_v2_line_config_output_value(lc, i);
 
@@ -1126,7 +1129,7 @@ static long linereq_set_config_unlocked(
 			ret = gpiod_direction_output(desc, val);
 			if (ret)
 				return ret;
-		} else if (flags & GPIO_V2_LINE_FLAG_INPUT) {
+		} else {
 			ret = gpiod_direction_input(desc);
 			if (ret)
 				return ret;



