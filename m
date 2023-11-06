Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9DD7E24D4
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjKFNZn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjKFNZm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:25:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453FBD8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:25:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D97C433CA;
        Mon,  6 Nov 2023 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277138;
        bh=BynNrtfkXlrFIQXUCDhWeTsG7/mDqUJEBJzDDIEDR9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2F7r+6OWoPMcJhy4vbRrNNSHPWTjtnlF5RsdPPznUdT79TXZi9yaR9McZJdZpFbBm
         nDB9LpbWe1SZvSCjR/ySqn/91NEq2FDfi5LOIE/MCP/5Qk27GF68STjb+kBt1T/r5Z
         ChFR/LSa7Es7aZT3hFJji7zvTGTL4UAGZui4p0nQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stable@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.15 051/128] nvmem: imx: correct nregs for i.MX6SLL
Date:   Mon,  6 Nov 2023 14:03:31 +0100
Message-ID: <20231106130311.419867456@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

commit 414a98abbefd82d591f4e2d1efd2917bcd3b6f6d upstream.

The nregs for i.MX6SLL should be 80 per fuse map, correct it.

Fixes: 6da27821a6f5 ("nvmem: imx-ocotp: add support for imx6sll")
Cc: Stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231013124904.175782-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/imx-ocotp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -485,7 +485,7 @@ static const struct ocotp_params imx6sl_
 };
 
 static const struct ocotp_params imx6sll_params = {
-	.nregs = 128,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,


