Return-Path: <stable+bounces-155038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB477AE1725
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A1E1642AB
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78F27F75A;
	Fri, 20 Jun 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dD+1S20X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1902356C7
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410524; cv=none; b=jWJxhJnTlsGtHumfy6eJili55xjP8sPPZ9cCrxqf37bBUFz3vZGaFld3oupPW6H314Hy2OsTohHDNJxd4nNo4ezmD4+4Qe3YLxWJ+OqPpISi+yx+PCU4fbEkFrAMcBPEPlyxxnWxKBJ3Xl2CR++DTP9yKv/4OSedcytRsUBpmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410524; c=relaxed/simple;
	bh=yaX8cn3fSojv8cL8wXjwnq24K0+HcbZs0eJHI80YwzU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uKr4zQx7EvMvQKrzqQGYewpkRyxY8r5CuAEBPJYmwJMDoN+M1X3762MDMXnHghch7Gjiel2u9TsCT7JY8FlRfxXxlLjPJMRO0lvLHM3vsn6os/4tMCFhtU9nj6KB0IX853FBnp4tudxYdSC4Ki+h8ZoxEQTDsHi1mEnwnJIq2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dD+1S20X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CADC4CEE3;
	Fri, 20 Jun 2025 09:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410524;
	bh=yaX8cn3fSojv8cL8wXjwnq24K0+HcbZs0eJHI80YwzU=;
	h=Subject:To:Cc:From:Date:From;
	b=dD+1S20XiMY5bTf4Ae5CiGd2Mc459zjULC4jHeCqYxt2p27yj5hDTNcMUStJM4EVO
	 LeUMZTzTlLkidktNeaBjiQszS+ePsDQBK+6LRo5jmbn/gNxkpfCWKyHmE3q1U2sTsU
	 iLN600Un+w+iDKvRjPNLKeU+ZA0B+Y3cle7Pb8bk=
Subject: FAILED: patch "[PATCH] sysfb: Fix screen_info type check for VGA" failed to apply to 6.6-stable tree
To: tzimmermann@suse.de,alexander.deucher@amd.com,deller@gmx.de,javierm@redhat.com,soci@c64.rulez.org,stable@vger.kernel.org,tzungbi@kernel.org,u.kleine-koenig@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:08:41 +0200
Message-ID: <2025062041-rift-expire-c3d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f670b50ef5e4a69bf4d2ec5ac6a9228d93b13a7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062041-rift-expire-c3d4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f670b50ef5e4a69bf4d2ec5ac6a9228d93b13a7a Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 3 Jun 2025 17:48:20 +0200
Subject: [PATCH] sysfb: Fix screen_info type check for VGA
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the helper screen_info_video_type() to get the framebuffer
type from struct screen_info. Handle supported values in sorted
switch statement.

Reading orig_video_isVGA is unreliable. On most systems it is a
VIDEO_TYPE_ constant. On some systems with VGA it is simply set
to 1 to signal the presence of a VGA output. See vga_probe() for
an example. Retrieving the screen_info type with the helper
screen_info_video_type() detects these cases and returns the
appropriate VIDEO_TYPE_ constant. For VGA, sysfb creates a device
named "vga-framebuffer".

The sysfb code has been taken from vga16fb, where it likely didn't
work correctly either. With this bugfix applied, vga16fb loads for
compatible vga-framebuffer devices.

Fixes: 0db5b61e0dc0 ("fbdev/vga16fb: Create EGA/VGA devices in sysfb code")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Cc: <stable@vger.kernel.org> # v6.1+
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://lore.kernel.org/r/20250603154838.401882-1-tzimmermann@suse.de

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 7c5c03f274b9..889e5b05c739 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -143,6 +143,7 @@ static __init int sysfb_init(void)
 {
 	struct screen_info *si = &screen_info;
 	struct device *parent;
+	unsigned int type;
 	struct simplefb_platform_data mode;
 	const char *name;
 	bool compatible;
@@ -170,17 +171,26 @@ static __init int sysfb_init(void)
 			goto put_device;
 	}
 
+	type = screen_info_video_type(si);
+
 	/* if the FB is incompatible, create a legacy framebuffer device */
-	if (si->orig_video_isVGA == VIDEO_TYPE_EFI)
-		name = "efi-framebuffer";
-	else if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
-		name = "vesa-framebuffer";
-	else if (si->orig_video_isVGA == VIDEO_TYPE_VGAC)
-		name = "vga-framebuffer";
-	else if (si->orig_video_isVGA == VIDEO_TYPE_EGAC)
+	switch (type) {
+	case VIDEO_TYPE_EGAC:
 		name = "ega-framebuffer";
-	else
+		break;
+	case VIDEO_TYPE_VGAC:
+		name = "vga-framebuffer";
+		break;
+	case VIDEO_TYPE_VLFB:
+		name = "vesa-framebuffer";
+		break;
+	case VIDEO_TYPE_EFI:
+		name = "efi-framebuffer";
+		break;
+	default:
 		name = "platform-framebuffer";
+		break;
+	}
 
 	pd = platform_device_alloc(name, 0);
 	if (!pd) {


