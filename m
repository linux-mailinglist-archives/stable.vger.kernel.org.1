Return-Path: <stable+bounces-172076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AF3B2FA5D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBF11BC609F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D75334393;
	Thu, 21 Aug 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bz52xzo4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF73277AA
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782707; cv=none; b=FrzmFIi2DmdaRgqRJKs4c1562lCqSy1MEC4QM7HYsIV7z1CRtTIiAIrn7DHhyqqtE+l6G2M4492L1H1aNhdSsx8fK5wEbxXGLrcxvJLbvZ7g3RM7qwrKjHiOmAPU/tXDnUNUBNqc5DIXClfQ1lw8wZC/MXc1FgVpDE+biWK5DH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782707; c=relaxed/simple;
	bh=diVqFPXopOsE55BtG2S0XrJYykPjrHpZIOaZ2wdsE1Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CCswurDkz1bQYCBMS/Zd4UgMueLv4EO9FH2xNX7rP+THqUwsOLy7UUfuMWdUOp82Rqz3+ry+5fLyDwi3FWtg3hgwiLvMxjflJcRMff9TD3tpptVfPTaSei3Ib9/tAcNS/BlbPQ5Cs9IviA7Chyl4nzr1kdSWtRXLVTnkIYGtgxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bz52xzo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1442DC4CEEB;
	Thu, 21 Aug 2025 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782707;
	bh=diVqFPXopOsE55BtG2S0XrJYykPjrHpZIOaZ2wdsE1Y=;
	h=Subject:To:Cc:From:Date:From;
	b=bz52xzo4EAmmTCSSahvTzVKDs6vvqlRiKmYMkU70a9mFrGFQcKj3JT/8jJtKhA7Tm
	 gMZyGZlFZ35cmtlvMHraB1Coqcn43wxGfE9udZgCFHjUBIUTRxknxJjqWNFR9E0Php
	 W0iBx/gRipHAsShAt6TIU5LpsyYc0rDAXUc+emPM=
Subject: FAILED: patch "[PATCH] mfd: cros_ec: Separate charge-control probing from USB-PD" failed to apply to 6.12-stable tree
To: linux@weissschuh.net,lee@kernel.org,linux@tlvince.com,tzungbi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:24:56 +0200
Message-ID: <2025082156-maturity-mutilated-6f8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e40fc1160d491c3bcaf8e940ae0dde0a7c5e8e14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082156-maturity-mutilated-6f8b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e40fc1160d491c3bcaf8e940ae0dde0a7c5e8e14 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 21 May 2025 16:42:51 +0200
Subject: [PATCH] mfd: cros_ec: Separate charge-control probing from USB-PD
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The charge-control subsystem in the ChromeOS EC is not strictly tied to
its USB-PD subsystem.

Since commit 7613bc0d116a ("mfd: cros_ec: Don't load charger with UCSI")
the presence of EC_FEATURE_UCSI_PPM would inhibit the probing of the
charge-control driver.

Furthermore recent versions of the EC firmware in Framework laptops
hard-disable EC_FEATURE_USB_PD to avoid probing cros-usbpd-charger,
which then also breaks cros-charge-control.

Instead use the dedicated EC_FEATURE_CHARGER.

Cc: stable@vger.kernel.org
Link: https://github.com/FrameworkComputer/EmbeddedController/commit/1d7bcf1d50137c8c01969eb65880bc83e424597e
Fixes: 555b5fcdb844 ("mfd: cros_ec: Register charge control subdevice")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Tested-by: Tom Vincent <linux@tlvince.com>
Link: https://lore.kernel.org/r/20250521-cros-ec-mfd-chctl-probe-v1-1-6ebfe3a6efa7@weissschuh.net
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 9f84a52b48d6..dc80a272726b 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -87,7 +87,6 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
 };
 
 static const struct mfd_cell cros_usbpd_charger_cells[] = {
-	{ .name = "cros-charge-control", },
 	{ .name = "cros-usbpd-charger", },
 	{ .name = "cros-usbpd-logger", },
 };
@@ -112,6 +111,10 @@ static const struct mfd_cell cros_ec_ucsi_cells[] = {
 	{ .name = "cros_ec_ucsi", },
 };
 
+static const struct mfd_cell cros_ec_charge_control_cells[] = {
+	{ .name = "cros-charge-control", },
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -148,6 +151,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 		.mfd_cells	= cros_ec_keyboard_leds_cells,
 		.num_cells	= ARRAY_SIZE(cros_ec_keyboard_leds_cells),
 	},
+	{
+		.id		= EC_FEATURE_CHARGER,
+		.mfd_cells	= cros_ec_charge_control_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_charge_control_cells),
+	},
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {


