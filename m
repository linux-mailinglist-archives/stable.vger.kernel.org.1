Return-Path: <stable+bounces-71625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E76965F83
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788391F21F5E
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960818E34B;
	Fri, 30 Aug 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQpe6j7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6018A950
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014611; cv=none; b=i0qhYduI7x8zTKXBKNwBJUzC7VIoivwZh+ey5eoVczvcDPsBcTLSXAgzXGgbT7Pc+GxfTLnvaz/OOnJXwQ0YFi+BFDgIHo1MOnyvkgIZdJeMHU3hDI84ekS4BsGxyDH/zHRjLOxQSgqthiyq6F76nV4kEI0XPSVINTPy8f4Z7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014611; c=relaxed/simple;
	bh=ghcJz0AbhlbMDcrzHE6XbN4rUIOfNnutFj+ENpNXG64=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sC/bvPCp4nNi2PuGhOVs2Z9rWPdgyHf3CRkKoQ0qDE1iSxNr5pks5fJCIlrYqFx0pJcDKdKVaiw02PUJSg/eyKcjuv9Fsuw25j6ksZXs2CkkrvOUQAvEHZEDgpXIx32Yd6XJ1zKiGtvFFI95n1fYFvSQtfJgUvQlUkUmLUCO8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQpe6j7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9211C4CEC2;
	Fri, 30 Aug 2024 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725014611;
	bh=ghcJz0AbhlbMDcrzHE6XbN4rUIOfNnutFj+ENpNXG64=;
	h=Subject:To:Cc:From:Date:From;
	b=TQpe6j7FZE+UWZGX6UaqfJ5EEnCVzmakPx7XHZTdNwlAGHqeNZLkZqdMLw3lEQ3rd
	 KT2Ql6xSyLGtwIKEYpJbV1xthjOwflA58ImJuwtpJyvxreeYViWkPcgCpYMlXDmszA
	 gBxXzrhHYsh8ckxJIINkTZGKJqdvQYXupTxacIT0=
Subject: FAILED: patch "[PATCH] video/aperture: optionally match the device in" failed to apply to 6.1-stable tree
To: alexander.deucher@amd.com,daniel.vetter@ffwll.ch,deller@gmx.de,javierm@redhat.com,sam@ravnborg.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:43:20 +0200
Message-ID: <2024083019-grumble-fading-91fb@gregkh>
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
git cherry-pick -x b49420d6a1aeb399e5b107fc6eb8584d0860fbd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083019-grumble-fading-91fb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b49420d6a1ae ("video/aperture: optionally match the device in sysfb_disable()")
4e754597d603 ("firmware/sysfb: Create firmware device only for enabled PCI devices")
9eac534db001 ("firmware/sysfb: Set firmware-framebuffer parent device")
2bebc3cd4870 ("Revert "firmware/sysfb: Clear screen_info state after consuming it"")
38814330fedd ("Merge tag 'devicetree-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b49420d6a1aeb399e5b107fc6eb8584d0860fbd7 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Wed, 21 Aug 2024 15:11:35 -0400
Subject: [PATCH] video/aperture: optionally match the device in
 sysfb_disable()

In aperture_remove_conflicting_pci_devices(), we currently only
call sysfb_disable() on vga class devices.  This leads to the
following problem when the pimary device is not VGA compatible:

1. A PCI device with a non-VGA class is the boot display
2. That device is probed first and it is not a VGA device so
   sysfb_disable() is not called, but the device resources
   are freed by aperture_detach_platform_device()
3. Non-primary GPU has a VGA class and it ends up calling sysfb_disable()
4. NULL pointer dereference via sysfb_disable() since the resources
   have already been freed by aperture_detach_platform_device() when
   it was called by the other device.

Fix this by passing a device pointer to sysfb_disable() and checking
the device to determine if we should execute it or not.

v2: Fix build when CONFIG_SCREEN_INFO is not set
v3: Move device check into the mutex
    Drop primary variable in aperture_remove_conflicting_pci_devices()
    Drop __init on pci sysfb_pci_dev_is_enabled()

Fixes: 5ae3716cfdcd ("video/aperture: Only remove sysfb on the default vga pci device")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240821191135.829765-1-alexander.deucher@amd.com

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 921f61507ae8..02a07d3d0d40 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -39,6 +39,8 @@ static struct platform_device *pd;
 static DEFINE_MUTEX(disable_lock);
 static bool disabled;
 
+static struct device *sysfb_parent_dev(const struct screen_info *si);
+
 static bool sysfb_unregister(void)
 {
 	if (IS_ERR_OR_NULL(pd))
@@ -52,6 +54,7 @@ static bool sysfb_unregister(void)
 
 /**
  * sysfb_disable() - disable the Generic System Framebuffers support
+ * @dev:	the device to check if non-NULL
  *
  * This disables the registration of system framebuffer devices that match the
  * generic drivers that make use of the system framebuffer set up by firmware.
@@ -61,17 +64,21 @@ static bool sysfb_unregister(void)
  * Context: The function can sleep. A @disable_lock mutex is acquired to serialize
  *          against sysfb_init(), that registers a system framebuffer device.
  */
-void sysfb_disable(void)
+void sysfb_disable(struct device *dev)
 {
+	struct screen_info *si = &screen_info;
+
 	mutex_lock(&disable_lock);
-	sysfb_unregister();
-	disabled = true;
+	if (!dev || dev == sysfb_parent_dev(si)) {
+		sysfb_unregister();
+		disabled = true;
+	}
 	mutex_unlock(&disable_lock);
 }
 EXPORT_SYMBOL_GPL(sysfb_disable);
 
 #if defined(CONFIG_PCI)
-static __init bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
+static bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
 {
 	/*
 	 * TODO: Try to integrate this code into the PCI subsystem
@@ -87,13 +94,13 @@ static __init bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
 	return true;
 }
 #else
-static __init bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
+static bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
 {
 	return false;
 }
 #endif
 
-static __init struct device *sysfb_parent_dev(const struct screen_info *si)
+static struct device *sysfb_parent_dev(const struct screen_info *si)
 {
 	struct pci_dev *pdev;
 
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 389d4ea6bfc1..ef622d41eb5b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -592,7 +592,7 @@ static int __init of_platform_default_populate_init(void)
 			 * This can happen for example on DT systems that do EFI
 			 * booting and may provide a GOP handle to the EFI stub.
 			 */
-			sysfb_disable();
+			sysfb_disable(NULL);
 			of_platform_device_create(node, NULL, NULL);
 			of_node_put(node);
 		}
diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 561be8feca96..2b5a1e666e9b 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -293,7 +293,7 @@ int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t si
 	 * ask for this, so let's assume that a real driver for the display
 	 * was already probed and prevent sysfb to register devices later.
 	 */
-	sysfb_disable();
+	sysfb_disable(NULL);
 
 	aperture_detach_devices(base, size);
 
@@ -346,15 +346,10 @@ EXPORT_SYMBOL(__aperture_remove_legacy_vga_devices);
  */
 int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name)
 {
-	bool primary = false;
 	resource_size_t base, size;
 	int bar, ret = 0;
 
-	if (pdev == vga_default_device())
-		primary = true;
-
-	if (primary)
-		sysfb_disable();
+	sysfb_disable(&pdev->dev);
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; ++bar) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
@@ -370,7 +365,7 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 	 * that consumes the VGA framebuffer I/O range. Remove this
 	 * device as well.
 	 */
-	if (primary)
+	if (pdev == vga_default_device())
 		ret = __aperture_remove_legacy_vga_devices(pdev);
 
 	return ret;
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index c9cb657dad08..bef5f06a91de 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -58,11 +58,11 @@ struct efifb_dmi_info {
 
 #ifdef CONFIG_SYSFB
 
-void sysfb_disable(void);
+void sysfb_disable(struct device *dev);
 
 #else /* CONFIG_SYSFB */
 
-static inline void sysfb_disable(void)
+static inline void sysfb_disable(struct device *dev)
 {
 }
 


