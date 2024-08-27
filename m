Return-Path: <stable+bounces-70982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E344D961103
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F60B247E0
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1817C96;
	Tue, 27 Aug 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zlgHrmZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFA1C7B9D;
	Tue, 27 Aug 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771707; cv=none; b=nM7Z/jd9rn9loKO8d4sEeclzs5Wo4+5wTzBshBYtrDHFrojfzMLqFqg6cUBYMYSZsGi+BCB6exUOuejiFVh+eVsL7/adK9q74Hg5ofYcX+G2IbLtOv6wl2lxOdfkIL+eI2txpIVaatFF0ZgfjgsILSg5VeVfpWY42EMhPMgtcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771707; c=relaxed/simple;
	bh=IfM8ohYfP1SkaA4pSHdq8QVTZrATo2PdOzVsiX53H7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlK6+JOGO6lnjnIFfqczEEzhQ/YcXtVOB7H5XpT73MdsQ7Zb8L8r/abNsa6Jsm1fgO+83o/TmyUTDGJ07HZfijYJwFlVuLMOEogiual2PGLYDUaD4F/DGWoqwSJbHieSMu/mvfDvWcXZMur2uxlLRL8ZoxJ5t1lZrJ/ac9iN9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zlgHrmZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B46DC4AF50;
	Tue, 27 Aug 2024 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771706;
	bh=IfM8ohYfP1SkaA4pSHdq8QVTZrATo2PdOzVsiX53H7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zlgHrmZf0b0xeqDYNbCEvLF7ReUyEFWUIwy9mrGK+ixMAEpnABEDnrN6VjiY7aKrS
	 yu4MhcSLn56EAuvtvrDs1yV3wQ42Bnuqz4R3JXtResD7fXEBlhbdXwiAvWr60DbXNb
	 mtTSL4yfFKswrDIF7ue7AKkZ8H1UqVZ6HXFksOq4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Werner Sembach <wse@tuxedocomputers.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.10 238/273] Input: i8042 - add forcenorestore quirk to leave controller untouched even on s3
Date: Tue, 27 Aug 2024 16:39:22 +0200
Message-ID: <20240827143842.460781472@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Werner Sembach <wse@tuxedocomputers.com>

commit 3d765ae2daccc570b3f4fbcb57eb321b12cdded2 upstream.

On s3 resume the i8042 driver tries to restore the controller to a known
state by reinitializing things, however this can confuse the controller
with different effects. Mostly occasionally unresponsive keyboards after
resume.

These issues do not rise on s0ix resume as here the controller is assumed
to preserved its state from before suspend.

This patch adds a quirk for devices where the reinitialization on s3 resume
is not needed and might be harmful as described above. It does this by
using the s0ix resume code path at selected locations.

This new quirk goes beyond what the preexisting reset=never quirk does,
which only skips some reinitialization steps.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240104183118.779778-2-wse@tuxedocomputers.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/serio/i8042-acpipnpio.h |   10 +++++++---
 drivers/input/serio/i8042.c           |   10 +++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -83,6 +83,7 @@ static inline void i8042_write_command(i
 #define SERIO_QUIRK_KBDRESET		BIT(12)
 #define SERIO_QUIRK_DRITEK		BIT(13)
 #define SERIO_QUIRK_NOPNP		BIT(14)
+#define SERIO_QUIRK_FORCENORESTORE	BIT(15)
 
 /* Quirk table for different mainboards. Options similar or identical to i8042
  * module parameters.
@@ -1685,6 +1686,8 @@ static void __init i8042_check_quirks(vo
 	if (quirks & SERIO_QUIRK_NOPNP)
 		i8042_nopnp = true;
 #endif
+	if (quirks & SERIO_QUIRK_FORCENORESTORE)
+		i8042_forcenorestore = true;
 }
 #else
 static inline void i8042_check_quirks(void) {}
@@ -1718,7 +1721,7 @@ static int __init i8042_platform_init(vo
 
 	i8042_check_quirks();
 
-	pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+	pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
 		i8042_nokbd ? " nokbd" : "",
 		i8042_noaux ? " noaux" : "",
 		i8042_nomux ? " nomux" : "",
@@ -1738,10 +1741,11 @@ static int __init i8042_platform_init(vo
 		"",
 #endif
 #ifdef CONFIG_PNP
-		i8042_nopnp ? " nopnp" : "");
+		i8042_nopnp ? " nopnp" : "",
 #else
-		"");
+		"",
 #endif
+		i8042_forcenorestore ? " forcenorestore" : "");
 
 	retval = i8042_pnp_init();
 	if (retval)
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -115,6 +115,10 @@ module_param_named(nopnp, i8042_nopnp, b
 MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
 #endif
 
+static bool i8042_forcenorestore;
+module_param_named(forcenorestore, i8042_forcenorestore, bool, 0);
+MODULE_PARM_DESC(forcenorestore, "Force no restore on s3 resume, copying s2idle behaviour");
+
 #define DEBUG
 #ifdef DEBUG
 static bool i8042_debug;
@@ -1232,7 +1236,7 @@ static int i8042_pm_suspend(struct devic
 {
 	int i;
 
-	if (pm_suspend_via_firmware())
+	if (!i8042_forcenorestore && pm_suspend_via_firmware())
 		i8042_controller_reset(true);
 
 	/* Set up serio interrupts for system wakeup. */
@@ -1248,7 +1252,7 @@ static int i8042_pm_suspend(struct devic
 
 static int i8042_pm_resume_noirq(struct device *dev)
 {
-	if (!pm_resume_via_firmware())
+	if (i8042_forcenorestore || !pm_resume_via_firmware())
 		i8042_interrupt(0, NULL);
 
 	return 0;
@@ -1271,7 +1275,7 @@ static int i8042_pm_resume(struct device
 	 * not restore the controller state to whatever it had been at boot
 	 * time, so we do not need to do anything.
 	 */
-	if (!pm_suspend_via_firmware())
+	if (i8042_forcenorestore || !pm_suspend_via_firmware())
 		return 0;
 
 	/*



