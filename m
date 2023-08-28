Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FFF78AB6F
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjH1Kau (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjH1KaU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE8712D;
        Mon, 28 Aug 2023 03:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 151CF63C8C;
        Mon, 28 Aug 2023 10:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24314C433C9;
        Mon, 28 Aug 2023 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218615;
        bh=QwrTinuWMkHvk0BeVjkbEPWY58zxuudSWheXc5Gxx54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbVddH7K+4WZ81sFd857GB2IokLLJVuzmSlkX1RHNOiNQcKnFy6yYR96hQI2hlN9o
         Tqi1eG9n7fepHGwyZMDd+GVAPvRKG2mVQTNWCfXoy+RPDHbmeISZJ8pfQi6YFB/ZA3
         1oIdt95jWyTYoruuDQsM1YGAZyM7XX73BQTd8HgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/122] video/aperture: Only kick vgacon when the pdev is decoding vga
Date:   Mon, 28 Aug 2023 12:12:03 +0200
Message-ID: <20230828101156.751919923@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vetter <daniel.vetter@ffwll.ch>

[ Upstream commit 7450cd235b45d43ee6f3c235f89e92623458175d ]

Otherwise it's a bit silly, and we might throw out the driver for the
screen the user is actually looking at. I haven't found a bug report
for this case yet, but we did get bug reports for the analog case
where we're throwing out the efifb driver.

v2: Flip the check around to make it clear it's a special case for
kicking out the vgacon driver only (Thomas)

v4:
- fixes to commit message
- fix Daniel's S-o-b address

v5:
- add back an S-o-b tag with Daniel's Intel address

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216303
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230406132109.32050-5-tzimmermann@suse.de
Stable-dep-of: 5ae3716cfdcd ("video/aperture: Only remove sysfb on the default vga pci device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/aperture.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 5c94abdb1ad6d..7ea18086e6599 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -344,13 +344,15 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 		aperture_detach_devices(base, size);
 	}
 
-	/*
-	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
-	 * otherwise the vga fbdev driver falls over.
-	 */
-	ret = vga_remove_vgacon(pdev);
-	if (ret)
-		return ret;
+	if (primary) {
+		/*
+		 * WARNING: Apparently we must kick fbdev drivers before vgacon,
+		 * otherwise the vga fbdev driver falls over.
+		 */
+		ret = vga_remove_vgacon(pdev);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 
-- 
2.40.1



