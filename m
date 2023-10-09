Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4647BE07E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377338AbjJINkp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377312AbjJINkn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:40:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621749D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:40:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A3AC433C8;
        Mon,  9 Oct 2023 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858842;
        bh=BrFQmTkptpam5NSMcrzTRbYDWTo4lzjbEftnjz9HvCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+DnhvPgKKeicVSaOZfJQlfNY+gLeOR/9xR4kbkQmIjkSWZZf3V6LYewJ0vsTEbBB
         2LlMO3Lt4RZ5BfZx1uhc7Tw4Rk8tS8Pf5XAL0tCfNYBhv1URMFKTgarx6HEypogMkG
         H+cTMHCaeXMZHcNnyWsHt9eeIENR2D97MvG7xVUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Julien Panis <jpanis@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 089/226] bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()
Date:   Mon,  9 Oct 2023 15:00:50 +0200
Message-ID: <20231009130129.099607892@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julien Panis <jpanis@baylibre.com>

[ Upstream commit d929b2b7464f95ec01e47f560b1e687482ba8929 ]

The am335x-evm started producing boot errors because of subtle timing
changes:

Unhandled fault: external abort on non-linefetch (0x1008) at 0xf03c1010
...
sysc_reset from sysc_probe+0xf60/0x1514
sysc_probe from platform_probe+0x5c/0xbc
...

The fix consists in using the appropriate sleep function in sysc reset.
For flexible sleeping, fsleep is recommended. Here, sysc delay parameter
can take any value in [0 - 255] us range. As a result, fsleep() should
be used, calling udelay() for a sysc delay lower than 10 us.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Fixes: e709ed70d122 ("bus: ti-sysc: Fix missing reset delay handling")
Message-ID: <20230821-fix-ti-sysc-reset-v1-1-5a0a5d8fae55@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 5e8c078efd22a..24d589b43dfe7 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2085,8 +2085,7 @@ static int sysc_reset(struct sysc *ddata)
 	}
 
 	if (ddata->cfg.srst_udelay)
-		usleep_range(ddata->cfg.srst_udelay,
-			     ddata->cfg.srst_udelay * 2);
+		fsleep(ddata->cfg.srst_udelay);
 
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);
-- 
2.40.1



