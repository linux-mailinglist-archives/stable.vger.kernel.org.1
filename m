Return-Path: <stable+bounces-71938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516DC967873
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856E7B22339
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AE183CBD;
	Sun,  1 Sep 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQC3gYbL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930A5381A;
	Sun,  1 Sep 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208311; cv=none; b=tSkxiRM91TfuJWbppWTYgqJr/JuG609mykNZ3snYg54cKs//8VN8672R+vd2h9aFqV4e4FwR29y5rLoaVLKt+mJoSbsJxI/ZNEv5hhJPTgRE+0AXULA8zLklkeUBnkVhA1otuyF5bgtD+pUf4OJr2J6KP75IkbIYTghpcpqrSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208311; c=relaxed/simple;
	bh=N9jhI61vmvVcfGOfiUss9kahFjfZBn2BPi7wSnfUV50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlZMP6cDljZQiT/NxKia0AxB5Z0BwsLpIRhtwVJ9vCibe2AIvq9lIjK/iKCF/B12jpK4hCIT5/lSdfsxXmB624hlr0iUoNtX/bPhRSOl2fxSU2fOPqHGfiPrWjjK3krQ93c3lLehqaIQvIMFtSMNvvg/6nBWXyf6YYltupancHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQC3gYbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38591C4CEC3;
	Sun,  1 Sep 2024 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208311;
	bh=N9jhI61vmvVcfGOfiUss9kahFjfZBn2BPi7wSnfUV50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQC3gYbL70sJPEKZXvtDgsn4doQoLx8jlij9tcUvYVBAjkKcALo8rlI8yW3HU+Lld
	 I1+8FKHA3/gnchzlekGQ1wb/u7afz6Y84huSOUVuaHidZImC+KKrvPPb/t+EPM9I71
	 /ZVZDAoFC0K+dUuoOydl7NR+39e3MVnID5rxvjq4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.10 043/149] video/aperture: optionally match the device in sysfb_disable()
Date: Sun,  1 Sep 2024 18:15:54 +0200
Message-ID: <20240901160819.085485817@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit b49420d6a1aeb399e5b107fc6eb8584d0860fbd7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/sysfb.c |   19 +++++++++++++------
 drivers/of/platform.c    |    2 +-
 drivers/video/aperture.c |   11 +++--------
 include/linux/sysfb.h    |    4 ++--
 4 files changed, 19 insertions(+), 17 deletions(-)

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
@@ -87,13 +94,13 @@ static __init bool sysfb_pci_dev_is_enab
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
 
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -592,7 +592,7 @@ static int __init of_platform_default_po
 			 * This can happen for example on DT systems that do EFI
 			 * booting and may provide a GOP handle to the EFI stub.
 			 */
-			sysfb_disable();
+			sysfb_disable(NULL);
 			of_platform_device_create(node, NULL, NULL);
 			of_node_put(node);
 		}
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -293,7 +293,7 @@ int aperture_remove_conflicting_devices(
 	 * ask for this, so let's assume that a real driver for the display
 	 * was already probed and prevent sysfb to register devices later.
 	 */
-	sysfb_disable();
+	sysfb_disable(NULL);
 
 	aperture_detach_devices(base, size);
 
@@ -346,15 +346,10 @@ EXPORT_SYMBOL(__aperture_remove_legacy_v
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
@@ -370,7 +365,7 @@ int aperture_remove_conflicting_pci_devi
 	 * that consumes the VGA framebuffer I/O range. Remove this
 	 * device as well.
 	 */
-	if (primary)
+	if (pdev == vga_default_device())
 		ret = __aperture_remove_legacy_vga_devices(pdev);
 
 	return ret;
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
 



