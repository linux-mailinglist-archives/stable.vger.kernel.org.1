Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E76E77ABC1
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjHMVZ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjHMVZ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B710EA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAAD262909
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EE8C433C8;
        Sun, 13 Aug 2023 21:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961924;
        bh=usbrCYWnWrqnXz4FIP2bhefwrQV3tv8ofGDbSdIEa8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuPxDtIRT3TFyTjvHWr5V1K7MvEp80IG0MK/YAU00jKBEQIsn1zndKK+j/i2heEo+
         ulNNIbyXCLRQVtRv5YlzvmjmE5biStMMaAS85p5uMq3JdrtVaNU/Q0OQcRtGvHO919
         yncIxXh5DfGxk+xxKOlnVsybpGWJ1XpChRK6Oa2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.4 047/206] tpm: tpm_tis: Fix UPX-i11 DMI_MATCH condition
Date:   Sun, 13 Aug 2023 23:16:57 +0200
Message-ID: <20230813211726.347546120@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit 51e5e551af53259e0274b0cd4ff83d8351fb8c40 upstream.

The patch which made it to the kernel somehow changed the
match condition from
DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
to
DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL")

Revert back to the correct match condition to disable the
interrupt mode on the board.

Cc: stable@vger.kernel.org # v6.4+
Fixes: edb13d7bb034 ("tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11")
Link: https://lore.kernel.org/lkml/20230524085844.11580-1-peter.ujfalusi@linux.intel.com/
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index ac4daaf294a3..3c0f68b9e44f 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -183,7 +183,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 		.ident = "UPX-TGL",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
 		},
 	},
 	{}
-- 
2.41.0



