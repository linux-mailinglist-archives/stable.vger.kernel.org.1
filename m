Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6078D7D334F
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjJWL3E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjJWL3D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:29:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A0DB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:29:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671A1C433C8;
        Mon, 23 Oct 2023 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060540;
        bh=uIqHdn/YO7H6Pk5xRc6bAissAu5KEbQSuVgLsyyJ1Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGhfleZaYyS9f4Vy40I92htDseV8jtuxfZ3yByvxSpv1rIburneMjDf3scIRRSrGh
         Om79PLw+I53BX12E14ovPjrOXFiTmK8L7IsLO6xo72Mc/M52skZMzEbiv9reP63blx
         fIQMhePWtL/GtfAIUr7y0cfYr2N/7idnsUKTkyYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 002/123] platform/x86: hp-wmi:: Mark driver struct with __refdata to prevent section mismatch warning
Date:   Mon, 23 Oct 2023 12:56:00 +0200
Message-ID: <20231023104817.798120233@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5b44abbc39ca15df80d0da4756078c98c831090f ]

As described in the added code comment, a reference to .exit.text is ok
for drivers registered via module_platform_driver_probe(). Make this
explicit to prevent a section mismatch warning:

	WARNING: modpost: drivers/platform/x86/hp/hp-wmi: section mismatch in reference: hp_wmi_driver+0x8 (section: .data) -> hp_wmi_bios_remove (section: .exit.text)

Fixes: c165b80cfecc ("hp-wmi: fix handling of platform device")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231004111624.2667753-1-u.kleine-koenig@pengutronix.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp-wmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index d3a329b201b1e..f7d714a775300 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -964,7 +964,13 @@ static const struct dev_pm_ops hp_wmi_pm_ops = {
 	.restore  = hp_wmi_resume_handler,
 };
 
-static struct platform_driver hp_wmi_driver = {
+/*
+ * hp_wmi_bios_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver hp_wmi_driver __refdata = {
 	.driver = {
 		.name = "hp-wmi",
 		.pm = &hp_wmi_pm_ops,
-- 
2.40.1



