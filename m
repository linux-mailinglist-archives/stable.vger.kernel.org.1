Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A979975B51E
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGTQ7r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGTQ7r (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 12:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D344186
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 09:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD27C61B75
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 16:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4849C433C8;
        Thu, 20 Jul 2023 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689872385;
        bh=qbEZGLJ5MM/FQbFeV5ldVxJKxJE6EvVxZtch0mw5oeE=;
        h=Subject:To:Cc:From:Date:From;
        b=CiC5WLWaPHZhyLO4Ncwtya8PSdQz3DJSWeQqBXft0GSa8D5tyy/iTAIYHbWn8Zp7i
         MwQM7IyOxYOVKIEWIJ6Pe9QWie59gg6+JvNRUbH77hs0cEsl/fWGk5EKp+e/z3Ot2c
         70kiDr8/ZP7vA305j2SDmQXUefmPQ5YPlzdcLVNQ=
Subject: FAILED: patch "[PATCH] video/aperture: Only remove sysfb on the default vga pci" failed to apply to 6.4-stable tree
To:     daniel.vetter@ffwll.ch, alexander.deucher@amd.com,
        aplattner@nvidia.com, daniel.vetter@intel.com, deller@gmx.de,
        javierm@redhat.com, sam@ravnborg.org, stable@vger.kernel.org,
        tzimmermann@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 20 Jul 2023 18:59:42 +0200
Message-ID: <2023072042-diffused-album-15e5@gregkh>
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 5ae3716cfdcd286268133867f67d0803847acefc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072042-diffused-album-15e5@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



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

