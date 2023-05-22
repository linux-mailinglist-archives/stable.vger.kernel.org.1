Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA82870C84E
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjEVThy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjEVThm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:37:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A59E7C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44257629B7
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492BFC433D2;
        Mon, 22 May 2023 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784249;
        bh=NUXAdrRRJjntRHz1LipXAnNBW5mZ5HlULv67EdzbuTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVec6wIOgn/o/QRRz5q0CaoX+KvY+4M43fsZ+OsLnidyMLxCRWyCG5+eSbjH8m+bJ
         02SAW3G4SNNR1BXB+IQklD08qjqu2LlRrXHiCn74h8GOiCe5Kh+D+vms99k6uVNi+z
         tQQ/Ca4hK9pgSsk3psv4vNJhwPN55amIu3QBYUeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pierre Asselin <pa@panix.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 002/364] firmware/sysfb: Fix VESA format selection
Date:   Mon, 22 May 2023 20:05:07 +0100
Message-Id: <20230522190412.867341075@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pierre Asselin <pa@panix.com>

[ Upstream commit 1b617bc93178912fa36f87a957c15d1f1708c299 ]

Some legacy BIOSes report no reserved bits in their 32-bit rgb mode,
breaking the calculation of bits_per_pixel in  commit f35cd3fa7729
("firmware/sysfb: Fix EFI/VESA format selection").  However they report
lfb_depth correctly for those modes.  Keep the computation but
set bits_per_pixel to lfb_depth if the latter is larger.

v2 fixes the warnings from a max3() macro with arguments of different
types;  split the bits_per_pixel assignment to avoid uglyfing the code
with too many typecasts.

v3 fixes space and formatting blips pointed out by Javier, and change
the bit_per_pixel assignment back to a single statement using two casts.

v4 go back to v2 and use max_t()

Signed-off-by: Pierre Asselin <pa@panix.com>
Fixes: f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")
Link: https://lore.kernel.org/r/4Psm6B6Lqkz1QXM@panix3.panix.com
Link: https://lore.kernel.org/r/20230412150225.3757223-1-javierm@redhat.com
Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230419044834.10816-1-pa@panix.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/sysfb_simplefb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 82c64cb9f5316..74363ed7501f6 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -51,7 +51,8 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	 *
 	 * It's not easily possible to fix this in struct screen_info,
 	 * as this could break UAPI. The best solution is to compute
-	 * bits_per_pixel here and ignore lfb_depth. In the loop below,
+	 * bits_per_pixel from the color bits, reserved bits and
+	 * reported lfb_depth, whichever is highest.  In the loop below,
 	 * ignore simplefb formats with alpha bits, as EFI and VESA
 	 * don't specify alpha channels.
 	 */
@@ -60,6 +61,7 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 					  si->green_size + si->green_pos,
 					  si->blue_size + si->blue_pos),
 				     si->rsvd_size + si->rsvd_pos);
+		bits_per_pixel = max_t(u32, bits_per_pixel, si->lfb_depth);
 	} else {
 		bits_per_pixel = si->lfb_depth;
 	}
-- 
2.39.2



