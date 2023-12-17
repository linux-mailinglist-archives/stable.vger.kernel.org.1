Return-Path: <stable+bounces-6903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C49816158
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 18:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3793C1F204E2
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AFB4652B;
	Sun, 17 Dec 2023 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+oBut1g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098F45014
	for <stable@vger.kernel.org>; Sun, 17 Dec 2023 17:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A99C433C7;
	Sun, 17 Dec 2023 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702835040;
	bh=bY6b00caL2SBIc4e+bsaHkdr/Ml2SZEzIvrxqsB3Kz4=;
	h=Subject:To:Cc:From:Date:From;
	b=i+oBut1gUqLq76uVi+wn2mvBz7g05/eIoQhsW0EWwG9rNeLKZsQ+rZislmFJSnTGh
	 x+uaLpHCKvl3tGg+iUcdyQvuRK4NzgY2g0EHPVGcxjzA4Ma1Ye3Idahl34mzA5L7Yt
	 B2xBbMbKxd7MCvq+nMM9ZhRTLs+XecMVpGw32NnI=
Subject: FAILED: patch "[PATCH] HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]" failed to apply to 6.1-stable tree
To: mario.limonciello@amd.com,jkosina@suse.com,marcus+oss@oxar.nl,mark.herbert42@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Dec 2023 18:43:57 +0100
Message-ID: <2023121757-acclimate-seizing-d33a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a9f68ffe1170ca4bc17ab29067d806a354a026e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121757-acclimate-seizing-d33a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a9f68ffe1170 ("HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]")
4122abfed219 ("HID: i2c-hid: acpi: Unify ACPI ID tables format")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9f68ffe1170ca4bc17ab29067d806a354a026e0 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Sat, 2 Dec 2023 21:24:30 -0600
Subject: [PATCH] HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]

Users have reported problems with recent Lenovo laptops that contain
an IDEA5002 I2C HID device. Reports include fans turning on and
running even at idle and spurious wakeups from suspend.

Presumably in the Windows ecosystem there is an application that
uses the HID device. Maybe that puts it into a lower power state so
it doesn't cause spurious events.

This device doesn't serve any functional purpose in Linux as nothing
interacts with it so blacklist it from being probed. This will
prevent the GPIO driver from setting up the GPIO and the spurious
interrupts and wake events will not occur.

Cc: stable@vger.kernel.org # 6.1
Reported-and-tested-by: Marcus Aram <marcus+oss@oxar.nl>
Reported-and-tested-by: Mark Herbert <mark.herbert42@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2812
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index ac918a9ea8d3..1b49243adb16 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -40,6 +40,11 @@ static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
 	 * ICN8505 controller, has a _CID of PNP0C50 but is not HID compatible.
 	 */
 	{ "CHPN0001" },
+	/*
+	 * The IDEA5002 ACPI device causes high interrupt usage and spurious
+	 * wakeups from suspend.
+	 */
+	{ "IDEA5002" },
 	{ }
 };
 


