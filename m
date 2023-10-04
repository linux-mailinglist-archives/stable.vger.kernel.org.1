Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD677B88BE
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjJDSTC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjJDSTB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:19:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205D9E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:18:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA82DC433C7;
        Wed,  4 Oct 2023 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443537;
        bh=oiWy5al20uEiW+wuMmBIpu0AAdh7fv05abRYUF1V0Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhJPyrRp6QaNpFoFsdGEBLi/48+050+XainIF+DRtG0D36hUkPD7lm7Tk8VZGY3B1
         3RM5l6VwOB1LPRjzhwxa93yibDS5tEtgHqZ3PfTR0/hC2SBo3WRlhS0aIHeFAxywLg
         I9ZVQtZBxy6GSwNYsu72/EzUU4wJynDaeBX0GpS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Luke D. Jones" <luke@ljones.dev>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 163/259] platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode
Date:   Wed,  4 Oct 2023 19:55:36 +0200
Message-ID: <20231004175224.776077727@linuxfoundation.org>
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

From: Luke D. Jones <luke@ljones.dev>

[ Upstream commit 4106a70ddad57ee6d8f98b81d6f036740c72762b ]

Add quirk for ASUS ROG X16 (GV601V, 2023 versions) Flow 2-in-1
to enable tablet mode with lid flip (all screen rotations).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/20230905082813.13470-1-luke@ljones.dev
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index fdf7da06af306..d85d895fee894 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -478,6 +478,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_tablet_mode,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG FLOW X16",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV601V"),
+		},
+		.driver_data = &quirk_asus_tablet_mode,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "ASUS VivoBook E410MA",
-- 
2.40.1



