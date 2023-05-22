Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB23B70C905
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjEVToR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjEVToP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:44:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB9BB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 508B0629A9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B644C433D2;
        Mon, 22 May 2023 19:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784653;
        bh=ZEidmOY0OPv8NxLA1XAIN+hIxvWIKWhk7/byheG/Gn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=maeXh73FP2TBvcC0huS/vFNKlsOmpyMW2NCsGbxzkly2xAroAMYxHIhgw2h1zMkv7
         8LqKKFa//Rd0ShnCH3pEDbWd8+39Ae/CA42W+aE/SlofxvBWcsQ4BysXH3iWRkoPV6
         lBjb4o5i9zWDaLi8NnOW9X+pD3FvvRvkVGrh6YdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Prajna Sariputra <putr4.s@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 152/364] ASoC: amd: yc: Add DMI entries to support HP OMEN 16-n0xxx (8A42)
Date:   Mon, 22 May 2023 20:07:37 +0100
Message-Id: <20230522190416.553580555@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Prajna Sariputra <putr4.s@gmail.com>

[ Upstream commit ee4281de4d60288b9c802bb0906061ec355ecef2 ]

This model requires an additional detection quirk to enable the internal microphone.

Signed-off-by: Prajna Sariputra <putr4.s@gmail.com>
Link: https://lore.kernel.org/r/2283110.ElGaqSPkdT@n0067ax-linux62
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0acdf0156f075..a428e17f03259 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -262,6 +262,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16z-n000"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A42"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2



