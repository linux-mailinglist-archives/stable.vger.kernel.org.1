Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911E67E2358
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjKFNLS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjKFNLO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:11:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE65112;
        Mon,  6 Nov 2023 05:11:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB238C433C7;
        Mon,  6 Nov 2023 13:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276270;
        bh=leY8eLaFM/5INJzbeFxEGUT4tiMRF+8GfXU/heY0qng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kr3CFCiSVk9PNyAVpwXexQEw5PQthUjSVGCsE92QpNnfzT9E/aOZGU/0lmxHr/rV7
         zfZhX16pwZ2M2q8+xuDCWsa1gLdCuXEiO3AGUbWuOQUoqd1AW5wTG2HrLpq9+m6vSP
         fs9u5jyrP18Lodrdtj/b8NB8ix+nRChIcLrq7xlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Baoquan He <bhe@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 47/61] fbdev: atyfb: only use ioremap_uc() on i386 and ia64
Date:   Mon,  6 Nov 2023 14:03:43 +0100
Message-ID: <20231106130301.221719418@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit c1a8d1d0edb71dec15c9649cb56866c71c1ecd9e ]

ioremap_uc() is only meaningful on old x86-32 systems with the PAT
extension, and on ia64 with its slightly unconventional ioremap()
behavior, everywhere else this is the same as ioremap() anyway.

Change the only driver that still references ioremap_uc() to only do so
on x86-32/ia64 in order to allow removing that interface at some
point in the future for the other architectures.

On some architectures, ioremap_uc() just returns NULL, changing
the driver to call ioremap() means that they now have a chance
of working correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 05111e90f1681..5ef008e9c61c3 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3435,11 +3435,15 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	}
 
 	info->fix.mmio_start = raddr;
+#if defined(__i386__) || defined(__ia64__)
 	/*
 	 * By using strong UC we force the MTRR to never have an
 	 * effect on the MMIO region on both non-PAT and PAT systems.
 	 */
 	par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
+#else
+	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+#endif
 	if (par->ati_regbase == NULL)
 		return -ENOMEM;
 
-- 
2.42.0



