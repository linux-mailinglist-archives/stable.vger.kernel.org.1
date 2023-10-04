Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA67B8A0F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbjJDSbv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbjJDSbv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:31:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877298
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:31:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD2CC433CC;
        Wed,  4 Oct 2023 18:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444306;
        bh=KuSfT05nLnC9AddAE8rrk0fr4nVkN7ZY/mF/bfa/mAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6PWbf4KIf+AopJ3YZdZnk7CCz4W8okvi6zNB2ZcZP7xaYhJgSvs54BKC/mMOiRVD
         XztMKBYYM+9DDXAbRevEDGTRhSHnfRTaLhLCf2dgRy14BungTtoQ/UAHmXaYWjaE+M
         AFtxRYwWIycTVH8/1LHqV2MlMyNnIcXoZO8hjUhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Walt Holman <waltholman09@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 203/321] Add DMI ID for MSI Bravo 15 B7ED
Date:   Wed,  4 Oct 2023 19:55:48 +0200
Message-ID: <20231004175238.646877368@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Walt Holman <waltholman09@gmail.com>

[ Upstream commit e616a916fe8431ebd5eb3cf4ac224d143c57083c ]

Signed-off-by: Walt Holman <waltholman09@gmail.com>
Link: https://lore.kernel.org/r/20230910185433.13677-1-waltholman09@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index f7ee792bd1be9..ba3094b1e90a0 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -255,6 +255,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 B7ED"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.40.1



