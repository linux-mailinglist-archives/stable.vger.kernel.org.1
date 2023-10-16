Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370577CAC49
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjJPOwk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJPOwj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:52:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E777B9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:52:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F94C433C8;
        Mon, 16 Oct 2023 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467957;
        bh=9DVsvyLP9wi7nhAzFg6lg11E2jbhETUGY9q87/GU6m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcUL1Hdyk1HDzvaYRP9m2+YmYoRdQzzZ4yAUN8xcDU3a5YhTgAvVA/VHUeoXfKnzS
         Y3KBmGWxRwdKIeLFAnqtPkiX8j4lOhvIpuwqkaJnPSrsjMHHgF4SQR9vr56DndIkrX
         vXJA/rWhxAWrMHvTRVUegDs6Lheno5ui6TW080os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joey Gouly <joey.gouly@arm.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 6.5 123/191] drm/tiny: correctly print `struct resource *` on error
Date:   Mon, 16 Oct 2023 10:41:48 +0200
Message-ID: <20231016084018.250316756@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joey Gouly <joey.gouly@arm.com>

commit c1165df2be2fffe3adeeaa68f4ee4325108c5e4e upstream.

The `res` variable is already a `struct resource *`, don't take the address of it.

Fixes incorrect output:

	simple-framebuffer 9e20dc000.framebuffer: [drm] *ERROR* could not acquire memory range [??? 0xffff4be88a387d00-0xfffffefffde0a240 flags 0x0]: -16

To be correct:

	simple-framebuffer 9e20dc000.framebuffer: [drm] *ERROR* could not acquire memory range [mem 0x9e20dc000-0x9e307bfff flags 0x200]: -16

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Fixes: 9a10c7e6519b ("drm/simpledrm: Add support for system memory framebuffers")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.3+
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20231010174652.2439513-1-joey.gouly@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index ff86ba1ae1b8..8ea120eb8674 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -745,7 +745,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 
 		ret = devm_aperture_acquire_from_firmware(dev, res->start, resource_size(res));
 		if (ret) {
-			drm_err(dev, "could not acquire memory range %pr: %d\n", &res, ret);
+			drm_err(dev, "could not acquire memory range %pr: %d\n", res, ret);
 			return ERR_PTR(ret);
 		}
 
-- 
2.42.0



