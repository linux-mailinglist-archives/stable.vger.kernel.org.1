Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175176FA67B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjEHKT4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjEHKTs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB3D85F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FCC6252B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0020C433D2;
        Mon,  8 May 2023 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541185;
        bh=d0X3yg7haQvgsR2Vxh0jBkmYqiZKufzWZYdFlrBGUqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hn3rIxNyrX3wFZiwkqMBV5EYPaOHE/HlTmFsipwLZwt+IpaG5omybuzfqIUBI4Uy8
         d/ubZtUanWEKO5JWDCGD5JsWk0uxr7KdIfWDdobjwRvO5zetymv5yq1AbPFLW8p0pt
         b2Y1mIloB9yvlGqnhz0coTN/ZmWeGWQfxCnc5t8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ge-org Brohammer <gbrohammer@outlook.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 005/663] ASoC: amd: yc: Add DMI entries to support Victus by HP Laptop 16-e1xxx (8A22)
Date:   Mon,  8 May 2023 11:37:11 +0200
Message-Id: <20230508094428.573446239@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Ge-org Brohammer <gbrohammer@outlook.com>

[ Upstream commit 205efd4619b860404ebb5882e5a119eb3b3b3716 ]

This model requires an additional detection quirk to
enable the internal microphone.

Tried to use git send-email this time.

Signed-off-by: Ge-org Brohammer <gbrohammer@outlook.com>
Link: https://lore.kernel.org/r/PAVP195MB2261322C220E95D7F4B2732ADABC9@PAVP195MB2261.EURP195.PROD.OUTLOOK.COM
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 4a69ce702360c..0acdf0156f075 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -269,6 +269,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A43"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
+		}
+	},
 	{}
 };
 
-- 
2.39.2



