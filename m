Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035AD73536A
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjFSKpd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjFSKo6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B72E65
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E735760B85
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E7C433C0;
        Mon, 19 Jun 2023 10:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171467;
        bh=UL1wfdsUQBKlzGq2PJgrxBOWBUnxUBn/pysu3p7J4s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+vrSFyufCF1DXAWbVPUNAMJJXE52jCgCGWK+RuQkeuDf0i5ZUcat8EzKe/mfxFZi
         2eIR05GVY+Vb3g1BsqAIPHSwlskIdxXh3vyp9cCBz1cVjpfPlFvq4nbfTCbe13aiIb
         o4jlYk9OVRx5+2dTB9NAfi866xfAwczjHhrso7GM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maya Matuszczyk <maccraft123mc@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 024/166] drm: panel-orientation-quirks: Change Airs quirk to support Air Plus
Date:   Mon, 19 Jun 2023 12:28:21 +0200
Message-ID: <20230619102155.923808105@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Maya Matuszczyk <maccraft123mc@gmail.com>

[ Upstream commit 1aa7f416175619e0286fddc5fc44e968b06bf2aa ]

It turned out that Aya Neo Air Plus had a different board name than
expected.
This patch changes Aya Neo Air's quirk to account for that, as both
devices share "Air" in DMI product name.

Tested on Air claiming to be an Air Pro, and on Air Plus.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230515184843.1552612-1-maccraft123mc@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index b1a38e6ce2f8f..0cb646cb04ee1 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -179,7 +179,7 @@ static const struct dmi_system_id orientation_data[] = {
 	}, {	/* AYA NEO AIR */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-		  DMI_MATCH(DMI_BOARD_NAME, "AIR"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYA NEO NEXT */
-- 
2.39.2



