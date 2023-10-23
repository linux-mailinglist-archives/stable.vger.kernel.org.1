Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED67D307A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjJWK7K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjJWK7J (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 06:59:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC74D6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 03:59:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FF3C433C8;
        Mon, 23 Oct 2023 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058747;
        bh=NTSPUw0AUPt/Hx7dYKjrhbI6OPNOsqljmJZJxRAzVhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMuyQYyJY0UmDhuXrIe3xi/35xq22FlH5fCpFSiEV+jm4pJRyzBYSfg0bnhiIIn54
         gfv3s5t5wttszsqKqTBjrFWduElKphBhdIaUUeBBTQki7iqRax9lpyelIVZQ+NlFIq
         +NuYTT8/cOxeMiMQhOQLBd9mww6b+hkJeew69PG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xingxing Luo <xingxing.luo@unisoc.com>
Subject: [PATCH 4.14 13/66] usb: musb: Modify the "HWVers" register address
Date:   Mon, 23 Oct 2023 12:56:03 +0200
Message-ID: <20231023104811.281977477@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xingxing Luo <xingxing.luo@unisoc.com>

commit 6658a62e1ddf726483cb2d8bf45ea3f9bd533074 upstream.

musb HWVers rgister address is not 0x69, if we operate the
wrong address 0x69, it will cause a kernel crash, because
there is no register corresponding to this address in the
additional control register of musb. In fact, HWVers has
been defined in musb_register.h, and the name is
"MUSB_HWVERS", so We need to use this macro instead of 0x69.

Fixes: c2365ce5d5a0 ("usb: musb: replace hard coded registers with defines")
Cc: stable@vger.kernel.org
Signed-off-by: Xingxing Luo <xingxing.luo@unisoc.com>
Link: https://lore.kernel.org/r/20230922075929.31074-1-xingxing.luo@unisoc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/musb/musb_debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -64,7 +64,7 @@ static const struct musb_register_map mu
 	{ "IntrUsbE",	MUSB_INTRUSBE,	8 },
 	{ "DevCtl",	MUSB_DEVCTL,	8 },
 	{ "VControl",	0x68,		32 },
-	{ "HWVers",	0x69,		16 },
+	{ "HWVers",	MUSB_HWVERS,	16 },
 	{ "LinkInfo",	MUSB_LINKINFO,	8 },
 	{ "VPLen",	MUSB_VPLEN,	8 },
 	{ "HS_EOF1",	MUSB_HS_EOF1,	8 },


