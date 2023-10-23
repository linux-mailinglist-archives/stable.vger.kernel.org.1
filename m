Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B20D7D33E3
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjJWLfA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjJWLfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:35:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DBEFD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:34:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038C1C433C7;
        Mon, 23 Oct 2023 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060898;
        bh=FefQmusnEmSxDfKGmrX5dCmEyp/MRaDy14VS3tqq9TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ys7iZ8lkYIqeyCRmOW6zZg9epWJHLbfnK6cgr0tivlx1mx8ZeZz9qCAZXXBjHKCs7
         yVEE1p7Xp+kztuFc87Av9PKWp/Hsiw1vz2UcpY7/LZHcIBOfHpsQFjpz1d5/vi2wAj
         eot7tP2QbouBtqH3AwBxIo+vcwmrCuZmeOU+JHHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 105/123] mmc: core: sdio: hold retuning if sdio in 1-bit mode
Date:   Mon, 23 Oct 2023 12:57:43 +0200
Message-ID: <20231023104821.237840606@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haibo Chen <haibo.chen@nxp.com>

commit 32a9cdb8869dc111a0c96cf8e1762be9684af15b upstream.

tuning only support in 4-bit mode or 8 bit mode, so in 1-bit mode,
need to hold retuning.

Find this issue when use manual tuning method on imx93. When system
resume back, SDIO WIFI try to switch back to 4 bit mode, first will
trigger retuning, and all tuning command failed.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230830093922.3095850-1-haibo.chen@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/sdio.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1014,8 +1014,14 @@ static int mmc_sdio_resume(struct mmc_ho
 		}
 		err = mmc_sdio_reinit_card(host);
 	} else if (mmc_card_wake_sdio_irq(host)) {
-		/* We may have switched to 1-bit mode during suspend */
+		/*
+		 * We may have switched to 1-bit mode during suspend,
+		 * need to hold retuning, because tuning only supprt
+		 * 4-bit mode or 8 bit mode.
+		 */
+		mmc_retune_hold_now(host);
 		err = sdio_enable_4bit_bus(host->card);
+		mmc_retune_release(host);
 	}
 
 	if (err)


