Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5EF6FAE94
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjEHLqH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjEHLps (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FCA44A0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3080D636F6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F972C433EF;
        Mon,  8 May 2023 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546322;
        bh=kvbit7G32yOy//dA96Pvm6UyorxCBvmePhIJIWsisDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQCeNf5ex6Rq9qXwHb0WHXG19zcop3vWkNJLIFsqpO01VSt6OgJaMe3Xsa6iO1NGT
         kdKEIp2DH1d/0GHDCucFnCkusE7CycxxZ8e5kryflBfx3JViy80Zs/ve8kE/0noCxU
         RZ6t7HODm/gwvj+jd9YT4d6KNASHJCACGxv+5CVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 330/371] leds: tca6507: Fix error handling of using fwnode_property_read_string
Date:   Mon,  8 May 2023 11:48:51 +0200
Message-Id: <20230508094825.198035868@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: H. Nikolaus Schaller <hns@goldelico.com>

[ Upstream commit c1087c29e96a48e9080377e168d35dcb52fb068b ]

Commit 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")

changed to fwnode API but did not take into account that a missing property
"linux,default-trigger" now seems to return an error and as a side effect
sets value to -1. This seems to be different from of_get_property() which
always returned NULL in any case of error.

Neglecting this side-effect leads to

[   11.201965] Unable to handle kernel paging request at virtual address ffffffff when read

in the strcmp() of led_trigger_set_default() if there is no led-trigger
defined in the DTS.

I don't know if this was recently introduced somewhere in the fwnode lib
or if the effect was missed in initial testing. Anyways it seems to be a
bug to ignore the error return value of an optional value here in the
driver.

Fixes: 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/cbae7617db83113de726fcc423a805ebaa1bfca6.1680433978.git.hns@goldelico.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-tca6507.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 225b765830bdc..caad9d3e0eac8 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -696,8 +696,9 @@ tca6507_led_dt_init(struct device *dev)
 		if (fwnode_property_read_string(child, "label", &led.name))
 			led.name = fwnode_get_name(child);
 
-		fwnode_property_read_string(child, "linux,default-trigger",
-					    &led.default_trigger);
+		if (fwnode_property_read_string(child, "linux,default-trigger",
+						&led.default_trigger))
+			led.default_trigger = NULL;
 
 		led.flags = 0;
 		if (fwnode_property_match_string(child, "compatible",
-- 
2.39.2



