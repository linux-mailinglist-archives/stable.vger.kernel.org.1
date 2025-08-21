Return-Path: <stable+bounces-172075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F38B2FA6F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E6D3B8D00
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E5A3376B3;
	Thu, 21 Aug 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTuXPe1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C513376B1
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782699; cv=none; b=QUuUpCMojsDqs/gTpYb+2P2Wm9EW7MibreE3QWazTRWPmO0Ku+VsewrMMpCgMYYSMO4XFcTnUfggjMtTwKY5Oo4iM2vt0jssdBFhPs4hBgG8xXD5h+v9OufuwkHr4MimFYo7/L0tShKKvzpfE96YI4Qf+2tr8Orv4X8H74qNOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782699; c=relaxed/simple;
	bh=RW0u/AFlwsWFNHFCMrMOUq3lCpnW7YEYFwDN8Wp0SWg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YeO+L53mDAATiuj4rV3qRd/PwDZiBqs7yO9wLKatuKlMstMXVc2WddNyJ4jRA82zL6Lj+sUWE0Z1AuFJW+MpSkZ4kNl/4QgDVh+dwfTzIJXCmIOi0/p3wyFSXDlbJf+6IkmM2V3rLsJm/s7r5TrTe8ZLE85+xvWZU/3Llk3ktv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTuXPe1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CCFC4CEED;
	Thu, 21 Aug 2025 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782699;
	bh=RW0u/AFlwsWFNHFCMrMOUq3lCpnW7YEYFwDN8Wp0SWg=;
	h=Subject:To:Cc:From:Date:From;
	b=JTuXPe1vLItKGc/JAN0eb05Lnt+D76VBVJORv9kTn1PTS9XZWV8mRfrAZ+q99UbEF
	 niCSSxTAFUsqw70U/oJYqIAKIsPZiWDXfKyaZEkpBq73MopEb9SMTUayMgDYk2uZcP
	 s7L5DxWCJlMRH7fARVZmu2qbdbAdTA2yV5u38yRE=
Subject: FAILED: patch "[PATCH] mfd: cros_ec: Separate charge-control probing from USB-PD" failed to apply to 6.16-stable tree
To: linux@weissschuh.net,lee@kernel.org,linux@tlvince.com,tzungbi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:24:56 +0200
Message-ID: <2025082155-turf-thinly-ac0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x e40fc1160d491c3bcaf8e940ae0dde0a7c5e8e14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082155-turf-thinly-ac0e@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

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


