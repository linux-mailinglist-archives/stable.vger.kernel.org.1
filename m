Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859B9775B12
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjHILOF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjHILOF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5CC10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0C5C6315C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DDCC433C8;
        Wed,  9 Aug 2023 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579644;
        bh=0jxhWEqIiCqPUSCdLH52jxN4vQhyWe3Heaj+vOP/Nm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beAspAa559UlEcVU6OenjtW2YxSk5EBJulG0Jnrd8n55N6xJLRy+o3+kENLVR/NwU
         hO5DIo/VDeXhI1vFb0CUyvJ3e1SJl9Mt1a50rrzoNtH19rikS6f5H8gYZGPoB5SuVl
         7KhtkjLRjwqTdk5QHCgtPdIpy3mR3br1LjlmQWxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 064/323] fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()
Date:   Wed,  9 Aug 2023 12:38:22 +0200
Message-ID: <20230809103701.085812367@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 79a3908d1ea6c35157a6d907b1a9d8ec06015e7a ]

If 'mipid_detect()' fails, we must free 'md' to avoid a memory leak.

Fixes: 66d2f99d0bb5 ("omapfb: add support for MIPI-DCS compatible LCDs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/omap/lcd_mipid.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index e3a85432f9266..5730355ee5986 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -576,11 +576,15 @@ static int mipid_spi_probe(struct spi_device *spi)
 
 	r = mipid_detect(md);
 	if (r < 0)
-		return r;
+		goto free_md;
 
 	omapfb_register_panel(&md->panel);
 
 	return 0;
+
+free_md:
+	kfree(md);
+	return r;
 }
 
 static int mipid_spi_remove(struct spi_device *spi)
-- 
2.39.2



