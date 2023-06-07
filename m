Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D33F726FAE
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjFGVA7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjFGVAd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:00:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF9213B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4A63648E4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD08EC433D2;
        Wed,  7 Jun 2023 21:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171611;
        bh=IxY9yD28x09t6EP3qwL6MxSZUKwa8NFQn8cpurereZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQ5RDEibn+lWpQTt2P3hluAzN4Rcwkusv7wq+vgWyrSOBOiE4NOksqSc/vmKcnLoZ
         A4Q+jNGGWedFyMcMhvO6ep8lZ9ll7Pqvy5YGflU4qrs/tkKcVhq5aNg0Q5sm6PmEFn
         NCIPEl/pTKCbop1JlfkF9Fou4zdH3Sii1BgRQsRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 053/159] fbdev: stifb: Fix info entry in sti_struct on error path
Date:   Wed,  7 Jun 2023 22:15:56 +0200
Message-ID: <20230607200905.424257895@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit 0bdf1ad8d10bd4e50a8b1a2c53d15984165f7fea ]

Minor fix to reset the info field to NULL in case of error.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/stifb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index ef8a4c5fc6875..63f51783352dc 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1413,6 +1413,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	iounmap(info->screen_base);
 out_err0:
 	kfree(fb);
+	sti->info = NULL;
 	return -ENXIO;
 }
 
-- 
2.39.2



