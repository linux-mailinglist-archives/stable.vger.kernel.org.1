Return-Path: <stable+bounces-197933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62313C9827E
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA61E344899
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F47333757;
	Mon,  1 Dec 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cv6Q2GcE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432E333754
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604901; cv=none; b=TAJJrcC3rrUTxzAV5RDy8PfT526qm2OKO2K3w5XNNFQRnvigph1Fgd9pELJcM7VrUfw98VROvVoZXIRVd4qnRZIKvpJ1Wdb1RqwaUZifovxCwoPMw2G8A24vFXf41Rf/4IpLnojXrWrrbpYRZcTYcFJ+mpgK8XU+mGxx0KGtsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604901; c=relaxed/simple;
	bh=TuisSaqDJECwbGTVpyoTx8wTm5iR3s1zwdiHTsDNC2M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cUNe9z/y6y/6A2IGh9NWJaNmVSVAXAumbOmTWGV7esvH/vFDcZojbtK5RAIIZCCpnpI+PDbCo5iL6RfvKsDLefwIkNoa6yJBR47qWUnkpZg8HLogbkO0yuF2Iz5qz4xhpb0Sy/WqjbMCFGGxc3yrGTbNSfm8UyrPC4Bw7PUzQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cv6Q2GcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418EFC4CEF1;
	Mon,  1 Dec 2025 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764604900;
	bh=TuisSaqDJECwbGTVpyoTx8wTm5iR3s1zwdiHTsDNC2M=;
	h=Subject:To:Cc:From:Date:From;
	b=cv6Q2GcE8BPz2/+rkcFB8S9Ef2wnuRPjXlkQ9Ksc6WUfcbTLc4y5cb3sZQH3VXzP+
	 LV0CPPjrWawNHmnqW9g1RWPeVbK9yQUjHuDOuk5aDZShKSbAJsnowOyg4ppOfa+HfW
	 6nSW4isybMiqdW/V281wloCSN2uXO/LHw60ndaBo=
Subject: FAILED: patch "[PATCH] drm, fbcon, vga_switcheroo: Avoid race condition in fbcon" failed to apply to 5.10-stable tree
To: tzimmermann@suse.de,alexander.deucher@amd.com,javierm@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 17:01:22 +0100
Message-ID: <2025120122-frostily-extortion-c700@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x eb76d0f5553575599561010f24c277cc5b31d003
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120122-frostily-extortion-c700@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eb76d0f5553575599561010f24c277cc5b31d003 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 5 Nov 2025 17:14:49 +0100
Subject: [PATCH] drm, fbcon, vga_switcheroo: Avoid race condition in fbcon
 setup

Protect vga_switcheroo_client_fb_set() with console lock. Avoids OOB
access in fbcon_remap_all(). Without holding the console lock the call
races with switching outputs.

VGA switcheroo calls fbcon_remap_all() when switching clients. The fbcon
function uses struct fb_info.node, which is set by register_framebuffer().
As the fb-helper code currently sets up VGA switcheroo before registering
the framebuffer, the value of node is -1 and therefore not a legal value.
For example, fbcon uses the value within set_con2fb_map() [1] as an index
into an array.

Moving vga_switcheroo_client_fb_set() after register_framebuffer() can
result in VGA switching that does not switch fbcon correctly.

Therefore move vga_switcheroo_client_fb_set() under fbcon_fb_registered(),
which already holds the console lock. Fbdev calls fbcon_fb_registered()
from within register_framebuffer(). Serializes the helper with VGA
switcheroo's call to fbcon_remap_all().

Although vga_switcheroo_client_fb_set() takes an instance of struct fb_info
as parameter, it really only needs the contained fbcon state. Moving the
call to fbcon initialization is therefore cleaner than before. Only amdgpu,
i915, nouveau and radeon support vga_switcheroo. For all other drivers,
this change does nothing.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://elixir.bootlin.com/linux/v6.17/source/drivers/video/fbdev/core/fbcon.c#L2942 # [1]
Fixes: 6a9ee8af344e ("vga_switcheroo: initial implementation (v15)")
Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: <stable@vger.kernel.org> # v2.6.34+
Link: https://patch.msgid.link/20251105161549.98836-1-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 11a5b60cb9ce..0b3ee008523d 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -31,9 +31,7 @@
 
 #include <linux/console.h>
 #include <linux/export.h>
-#include <linux/pci.h>
 #include <linux/sysrq.h>
-#include <linux/vga_switcheroo.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_drv.h>
@@ -566,11 +564,6 @@ EXPORT_SYMBOL(drm_fb_helper_release_info);
  */
 void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
 {
-	struct fb_info *info = fb_helper->info;
-	struct device *dev = info->device;
-
-	if (dev_is_pci(dev))
-		vga_switcheroo_client_fb_set(to_pci_dev(dev), NULL);
 	unregister_framebuffer(fb_helper->info);
 }
 EXPORT_SYMBOL(drm_fb_helper_unregister_info);
@@ -1632,7 +1625,6 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 	struct drm_client_dev *client = &fb_helper->client;
 	struct drm_device *dev = fb_helper->dev;
 	struct drm_fb_helper_surface_size sizes;
-	struct fb_info *info;
 	int ret;
 
 	if (drm_WARN_ON(dev, !dev->driver->fbdev_probe))
@@ -1653,12 +1645,6 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 
 	strcpy(fb_helper->fb->comm, "[fbcon]");
 
-	info = fb_helper->info;
-
-	/* Set the fb info for vgaswitcheroo clients. Does nothing otherwise. */
-	if (dev_is_pci(info->device))
-		vga_switcheroo_client_fb_set(to_pci_dev(info->device), info);
-
 	return 0;
 }
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9bd3c3814b5c..e7e07eb2142e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -66,6 +66,7 @@
 #include <linux/string.h>
 #include <linux/kd.h>
 #include <linux/panic.h>
+#include <linux/pci.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
@@ -78,6 +79,7 @@
 #include <linux/interrupt.h>
 #include <linux/crc32.h> /* For counting font checksums */
 #include <linux/uaccess.h>
+#include <linux/vga_switcheroo.h>
 #include <asm/irq.h>
 
 #include "fbcon.h"
@@ -2899,6 +2901,9 @@ void fbcon_fb_unregistered(struct fb_info *info)
 
 	console_lock();
 
+	if (info->device && dev_is_pci(info->device))
+		vga_switcheroo_client_fb_set(to_pci_dev(info->device), NULL);
+
 	fbcon_registered_fb[info->node] = NULL;
 	fbcon_num_registered_fb--;
 
@@ -3032,6 +3037,10 @@ static int do_fb_registered(struct fb_info *info)
 		}
 	}
 
+	/* Set the fb info for vga_switcheroo clients. Does nothing otherwise. */
+	if (info->device && dev_is_pci(info->device))
+		vga_switcheroo_client_fb_set(to_pci_dev(info->device), info);
+
 	return ret;
 }
 


