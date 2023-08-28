Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C462678AB9B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjH1Kcz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjH1Kca (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7859ACCE
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 586C163D23
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7F1C433C8;
        Mon, 28 Aug 2023 10:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218722;
        bh=scmly9Z9stiNp9iH0yZPl2cwo+rpB7BajbCRKwItGWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QruR4JSMQFoJY848bax6errVA169f/YM6CtkRN0M8xxiAFVmtlApMo1TlruLmhUuF
         mCAxWkEnTQXQDZq+F5NKltoPZi5mUNVwdT7cwNLrWygEFoLRm1U8gzxoGsbNvSuurY
         qLuj74slh02eLmZrcaj9kA5srJc/vun7r1pFW4HE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, BrenoRCBrito <brenorcbrito@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 061/122] ASoC: amd: yc: Add VivoBook Pro 15 to quirks list for acp6x
Date:   Mon, 28 Aug 2023 12:12:56 +0200
Message-ID: <20230828101158.456646231@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: BrenoRCBrito <brenorcbrito@gmail.com>

commit 3b1f08833c45d0167741e4097b0150e7cf086102 upstream.

VivoBook Pro 15 Ryzen Edition uses Ryzen 6800H processor, and adding to
 quirks list for acp6x will enable internal mic.

Signed-off-by: BrenoRCBrito <brenorcbrito@gmail.com>
Link: https://lore.kernel.org/r/20230818211417.32167-1-brenorcbrito@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/yc/acp6x-mach.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -251,6 +251,13 @@ static const struct dmi_system_id yc_acp
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "TIMI"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi Book Pro 15 2022"),
 		}


