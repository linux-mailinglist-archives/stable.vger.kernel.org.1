Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29577E2560
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjKFNbV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjKFNbU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:31:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375E7123
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:31:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D63C433CC;
        Mon,  6 Nov 2023 13:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277471;
        bh=OKhodJnziSpfNwZr6QdUId+SmA83WO0emHtAEGaEVG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhcYOkZlGDUdQsxlhDsbKISwpTz6U/mRVZkdf6XDdqik+BULBF8wkJwZvZZtcP6Bj
         9htqtEqMnbfjsEj1rV4+XJJAkXkLb5iZqCh8F41mE+3/85F+7G2SpZS7xXc/B796Qy
         63hxCcIc0exqv1HumnE2n2chw0Os8YzealpWY71I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stable@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.10 34/95] nvmem: imx: correct nregs for i.MX6ULL
Date:   Mon,  6 Nov 2023 14:04:02 +0100
Message-ID: <20231106130305.971423299@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

commit 2382c1b044231fd49eaf9aa82bc7113fc55487b8 upstream.

The nregs for i.MX6ULL should be 80 per fuse map, correct it.

Fixes: ffbc34bf0e9c ("nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support")
Cc: Stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231013124904.175782-4-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/imx-ocotp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -488,7 +488,7 @@ static const struct ocotp_params imx6ul_
 };
 
 static const struct ocotp_params imx6ull_params = {
-	.nregs = 64,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,


