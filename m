Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48173E93C
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjFZSdx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjFZSdw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F8DC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D28AC60F4B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBF1C433C8;
        Mon, 26 Jun 2023 18:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804430;
        bh=8YCPQa2X4QTcHRnnV0hdZsWBdlZBqIomQ70I0X5aPZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBFoGZB/W1srIsLaPIBuBBHDoQyCqyJ/d4w3pMJlVpw9HwK1k15JuSq4C/FO0oDIG
         NgDTEZO8xh1zZduPG+glHjF5WBUnRWJEmuYRP8OVM+aINeqZX/ZzwaReZr3Sw5Of7E
         OUUxRJfeSfXcuFOpXlEsdtSqh87Su8Ixt5hbULng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sicong Jiang <kevin.jiangsc@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 154/170] ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for acp6x
Date:   Mon, 26 Jun 2023 20:12:03 +0200
Message-ID: <20230626180807.389445025@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Sicong Jiang <kevin.jiangsc@gmail.com>

[ Upstream commit 57d1e8900495cf1751cec74db16fe1a0fe47efbb ]

Thinkpad Neo14 Ryzen Edition uses Ryzen 6800H processor, and adding to
quirks list for acp6x will enable internal mic.

Signed-off-by: Sicong Jiang <kevin.jiangsc@gmail.com>
Link: https://lore.kernel.org/r/20230531090635.89565-1-kevin.jiangsc@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 84b401b685f7f..c1ca3ceac5f2f 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -171,6 +171,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CL"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21EF"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2



