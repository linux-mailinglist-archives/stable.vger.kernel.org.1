Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0C375B520
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 19:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjGTRAA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGTQ75 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 12:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D9A2733
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 09:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06F8E61B9D
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 16:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BA0C433C7;
        Thu, 20 Jul 2023 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689872392;
        bh=nffV/93Rp/8nNOs7I2+b7A1yBIQLJMkgU19X/SytZGM=;
        h=Subject:To:Cc:From:Date:From;
        b=j2oGG0K+WbtJDIHx2++amoNgYo7pZjjiyAVL55SwA6xDeLbjuQhgIcn4mbNmzSR1o
         OB0SQ7tJ+CbYLN55jARTd1TVOKeb2SVFGlV2TMfGTMSNS7FInXMYKsjlhvZ++3BIrR
         VgpaHeivlbz37AXd1IN99xf9K8i8Tf/ngWBYFR1w=
Subject: FAILED: patch "[PATCH] video/aperture: Only remove sysfb on the default vga pci" failed to apply to 5.15-stable tree
To:     daniel.vetter@ffwll.ch, alexander.deucher@amd.com,
        aplattner@nvidia.com, daniel.vetter@intel.com, deller@gmx.de,
        javierm@redhat.com, sam@ravnborg.org, stable@vger.kernel.org,
        tzimmermann@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 20 Jul 2023 18:59:46 +0200
Message-ID: <2023072046-tree-headphone-31c5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5ae3716cfdcd286268133867f67d0803847acefc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072046-tree-headphone-31c5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

5ae3716cfdcd ("video/aperture: Only remove sysfb on the default vga pci device")
5fbcc6708fe3 ("video/aperture: Drop primary argument")
62aeaeaa1b26 ("drm/aperture: Remove primary argument")
80e993988b97 ("drm/gma500: Use drm_aperture_remove_conflicting_pci_framebuffers")
81d2393485f0 ("fbdev/hyperv-fb: Do not set struct fb_info.apertures")
e0ba1a39b8df ("fbdev/core: Avoid uninitialized read in aperture_remove_conflicting_pci_device()")
4b760f76dd6f ("drm/arm/hdlcd: Take over EFI framebuffer properly")
ca5f13a21404 ("fbdev: Fix order of arguments to aperture_remove_conflicting_devices()")
8d69d008f44c ("fbdev: Convert drivers to aperture helpers")
9d69ef183815 ("fbdev/core: Remove remove_conflicting_pci_framebuffers()")
e23a5e14aa27 ("Backmerge tag 'v5.19-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into drm-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ae3716cfdcd286268133867f67d0803847acefc Mon Sep 17 00:00:00 2001
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 6 Apr 2023 15:21:07 +0200
Subject: [PATCH] video/aperture: Only remove sysfb on the default vga pci
 device

Instead of calling aperture_remove_conflicting_devices() to remove the
conflicting devices, just call to aperture_detach_devices() to detach
the device that matches the same PCI BAR / aperture range. Since the
former is just a wrapper of the latter plus a sysfb_disable() call,
and now that's done in this function but only for the primary devices.

This fixes a regression introduced by commit ee7a69aa38d8 ("fbdev:
Disable sysfb device registration when removing conflicting FBs"),
where we remove the sysfb when loading a driver for an unrelated pci
device, resulting in the user losing their efifb console or similar.

Note that in practice this only is a problem with the nvidia blob,
because that's the only gpu driver people might install which does not
come with an fbdev driver of it's own. For everyone else the real gpu
driver will restore a working console.

Also note that in the referenced bug there's confusion that this same
bug also happens on amdgpu. But that was just another amdgpu specific
regression, which just happened to happen at roughly the same time and
with the same user-observable symptoms. That bug is fixed now, see
https://bugzilla.kernel.org/show_bug.cgi?id=216331#c15

Note that we should not have any such issues on non-pci multi-gpu
issues, because I could only find two such cases:
- SoC with some external panel over spi or similar. These panel
  drivers do not use drm_aperture_remove_conflicting_framebuffers(),
  so no problem.
- vga+mga, which is a direct console driver and entirely bypasses all
  this.

For the above reasons the cc: stable is just notionally, this patch
will need a backport and that's up to nvidia if they care enough.

v2:
- Explain a bit better why other multi-gpu that aren't pci shouldn't
  have any issues with making all this fully pci specific.

v3
- polish commit message (Javier)

v4:
- Fix commit message style (i.e., commit 1234 ("..."))
- fix Daniel's S-o-b address

v5:
- add back an S-o-b tag with Daniel's Intel address

Fixes: ee7a69aa38d8 ("fbdev: Disable sysfb device registration when removing conflicting FBs")
Tested-by: Aaron Plattner <aplattner@nvidia.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216303#c28
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Aaron Plattner <aplattner@nvidia.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: <stable@vger.kernel.org> # v5.19+ (if someone else does the backport)
Link: https://patchwork.freedesktop.org/patch/msgid/20230406132109.32050-8-tzimmermann@suse.de

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index a0945027e0df..fa71f8257eed 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -322,15 +322,16 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 	if (pdev == vga_default_device())
 		primary = true;
 
+	if (primary)
+		sysfb_disable();
+
 	for (bar = 0; bar < PCI_STD_NUM_BARS; ++bar) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
 			continue;
 
 		base = pci_resource_start(pdev, bar);
 		size = pci_resource_len(pdev, bar);
-		ret = aperture_remove_conflicting_devices(base, size, name);
-		if (ret)
-			return ret;
+		aperture_detach_devices(base, size);
 	}
 
 	if (primary) {

