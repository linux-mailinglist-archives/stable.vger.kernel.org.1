Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7447B885C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244024AbjJDSPT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244027AbjJDSPS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:15:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BB9BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:15:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47251C433C8;
        Wed,  4 Oct 2023 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443314;
        bh=95O6bv7uRaTurm19RTcilQlYsRtSa5gJcOdsA7s5es8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtHvmmywUhiGaCKZ/wbBw3kZM72HFqKyp7585zeYOszZmzSukJfoSvn1JhIJXpBBI
         UoMWKkdmxre8pJlXZg07uAjWe5otF9pflKDM8KEMgv9EygCziezoavs50CCAtn1NfH
         Api0rsnYXxkwdWJ/W7mOFxgD5WG5piBtBzkFNSE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Julien Panis <jpanis@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/259] bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()
Date:   Wed,  4 Oct 2023 19:54:45 +0200
Message-ID: <20231004175222.488859612@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index ddde1427c90c7..6ac79417b5120 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2166,8 +2166,7 @@ static int sysc_reset(struct sysc *ddata)
 	}
 
 	if (ddata->cfg.srst_udelay)
-		usleep_range(ddata->cfg.srst_udelay,
-			     ddata->cfg.srst_udelay * 2);
+		fsleep(ddata->cfg.srst_udelay);
 
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);
-- 
2.40.1



