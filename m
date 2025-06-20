Return-Path: <stable+bounces-155086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CAAE1901
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B407A528D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8FC28137A;
	Fri, 20 Jun 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SfxqP4bD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A1101EE
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415683; cv=none; b=nCwHfwNkxlUZseuQeZe3pRtRnGPGJWLmOCXr7v3GV4BwnP0mFKvs2Fi2Yl3knkBVGpuolTzQXk3zGv+R4wqAMXtSs0IhK/z9EtGu1YVp0rCYZCL6793KkLsi0pku6rudGW5xVErRFXcS3slTccDGn6m1W+wLiR/wH3blmzmeoM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415683; c=relaxed/simple;
	bh=8bx58q3lGekk7piPAh0ig3JJT8/EbEXMklGBVYc24zY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OaW0N8CmePAs5Sy4Du5KK56+ZNeni4/f7o8+6RsMa80yJsb2V/1h4l1mhvS6tT5q3C2NgpaizvkgYIQ20yPtQmaeMINFPsM87xfPCJiSb4ncaiuShMGARLtypwuIbeJ2IjmUesH5vD0oFbWao8zHVVJ5MdZR7p/UpK4F3xLi3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SfxqP4bD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7162BC4CEE3;
	Fri, 20 Jun 2025 10:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750415682;
	bh=8bx58q3lGekk7piPAh0ig3JJT8/EbEXMklGBVYc24zY=;
	h=Subject:To:Cc:From:Date:From;
	b=SfxqP4bDMPn9pfWB8lX/3YdfOhWyAbPMtUSyj8pHGHD909VRvpKl3rcfNS2YAOCFd
	 rC09EQExQUnnmqQOcOjToeCOER4vYuWPHTplk6seuyWaZYGQvr7GUBOcKHaN5DqKLv
	 ul0SBrinWD5bn7RHa/AWdP4Fzp+GWENVGXZDDprg=
Subject: FAILED: patch "[PATCH] dummycon: Trigger redraw when switching consoles with" failed to apply to 6.6-stable tree
To: tzimmermann@suse.de,arvidjaar@gmail.com,hdegoede@redhat.com,javierm@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 12:34:39 +0200
Message-ID: <2025062039-serving-unbutton-6eaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 03bcbbb3995ba5df43af9aba45334e35f2dfe27b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062039-serving-unbutton-6eaf@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 03bcbbb3995ba5df43af9aba45334e35f2dfe27b Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 20 May 2025 09:14:00 +0200
Subject: [PATCH] dummycon: Trigger redraw when switching consoles with
 deferred takeover

Signal vt subsystem to redraw console when switching to dummycon
with deferred takeover enabled. Makes the console switch to fbcon
and displays the available output.

With deferred takeover enabled, dummycon acts as the placeholder
until the first output to the console happens. At that point, fbcon
takes over. If the output happens while dummycon is not active, it
cannot inform fbcon. This is the case if the vt subsystem runs in
graphics mode.

A typical graphical boot starts plymouth, a display manager and a
compositor; all while leaving out dummycon. Switching to a text-mode
console leaves the console with dummycon even if a getty terminal
has been started.

Returning true from dummycon's con_switch helper signals the vt
subsystem to redraw the screen. If there's output available dummycon's
con_putc{s} helpers trigger deferred takeover of fbcon, which sets a
display mode and displays the output. If no output is available,
dummycon remains active.

v2:
- make the comment slightly more verbose (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Andrei Borzenkov <arvidjaar@gmail.com>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1242191
Tested-by: Andrei Borzenkov <arvidjaar@gmail.com>
Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Fixes: 83d83bebf401 ("console/fbcon: Add support for deferred console takeover")
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.19+
Link: https://lore.kernel.org/r/20250520071418.8462-1-tzimmermann@suse.de

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 139049368fdc..7d02470f19b9 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -85,6 +85,15 @@ static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 	/* Redraw, so that we get putc(s) for output done while blanked */
 	return true;
 }
+
+static bool dummycon_switch(struct vc_data *vc)
+{
+	/*
+	 * Redraw, so that we get putc(s) for output done while switched
+	 * away. Informs deferred consoles to take over the display.
+	 */
+	return true;
+}
 #else
 static void dummycon_putc(struct vc_data *vc, u16 c, unsigned int y,
 			  unsigned int x) { }
@@ -95,6 +104,10 @@ static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 {
 	return false;
 }
+static bool dummycon_switch(struct vc_data *vc)
+{
+	return false;
+}
 #endif
 
 static const char *dummycon_startup(void)
@@ -124,11 +137,6 @@ static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
 	return false;
 }
 
-static bool dummycon_switch(struct vc_data *vc)
-{
-	return false;
-}
-
 /*
  *  The console `switch' structure for the dummy console
  *


