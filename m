Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400A5742C72
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjF2StG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjF2Sst (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA06D3588
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98502615C8
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCF4C433C0;
        Thu, 29 Jun 2023 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064507;
        bh=jGuwhosPqR+8otm7NNUjp6JfVxgUTuY+fcRDuzgsDJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=daSOAZKWGbgEk0VuYiGEdutqkV5HoEdClnJZH8js6Bt3AS+gFOLrXnxq8o3z69fB4
         g3YHr5AZT+dRPxf+zmpLZCmX6TYXgYzOvCwYwcQQ+BMmWG52DTNj2LIFWt7Oxi6ND+
         Lxn5hpwDMCLwC67S8MyKjPbWW6LNC/mVu5IEagZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.4 25/28] fbdev: fix potential OOB read in fast_imageblit()
Date:   Thu, 29 Jun 2023 20:44:13 +0200
Message-ID: <20230629184152.872120836@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
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

From: Zhang Shurong <zhang_shurong@foxmail.com>

commit c2d22806aecb24e2de55c30a06e5d6eb297d161d upstream.

There is a potential OOB read at fast_imageblit, for
"colortab[(*src >> 4)]" can become a negative value due to
"const char *s = image->data, *src".
This change makes sure the index for colortab always positive
or zero.

Similar commit:
https://patchwork.kernel.org/patch/11746067

Potential bug report:
https://groups.google.com/g/syzkaller-bugs/c/9ubBXKeKXf4/m/k-QXy4UgAAAJ

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/sysimgblt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -189,7 +189,7 @@ static void fast_imageblit(const struct
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
 	u32 bit_mask, eorx, shift;
-	const char *s = image->data, *src;
+	const u8 *s = image->data, *src;
 	u32 *dst;
 	const u32 *tab;
 	size_t tablen;


