Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37287553DC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGPUXq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjGPUXq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B5BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8EB60DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E49C433C8;
        Sun, 16 Jul 2023 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539024;
        bh=Q28LyStVbehDrWtWY3BQfU9sutZfWqRYpn2cxnh32Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lg2XSDCo0H2vLXdHbS3Lq3czBYXwEIDjJGxoOP7whu7rrAAQXmoBEWk4cY+VSLzPy
         rMl3HWtKgmgHO+/nJBAWJjXNfrA6kKyMiELK9rgmKjj5KV62PG5iG23/Txn2nXrsjS
         nTokMeknRxsA9GvKn0jg0HvS0METTpM+Olg/iqMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 6.4 630/800] nvmem: imx-ocotp: Reverse MAC addresses on all i.MX derivates
Date:   Sun, 16 Jul 2023 21:48:03 +0200
Message-ID: <20230716195003.745083865@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 8a00fc606312c68b98add8fe8e6f7a013ce29e78 ]

Not just i.MX8M, but all i.MX6/7 (and subtypes) need to reverse the
MAC address read from fuses. Exceptions are i.MX6SLL and i.MX7ULP which
do not support ethernet at all.

Fixes: d0221a780cbc ("nvmem: imx-ocotp: add support for post processing")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Richard Leitner <richard.leitner@skidata.com> # imx6q
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20230611140330.154222-3-srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/imx-ocotp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index ac0edb6398f1e..c1af271052276 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -97,7 +97,6 @@ struct ocotp_params {
 	unsigned int bank_address_words;
 	void (*set_timing)(struct ocotp_priv *priv);
 	struct ocotp_ctrl_reg ctrl;
-	bool reverse_mac_address;
 };
 
 static int imx_ocotp_wait_for_busy(struct ocotp_priv *priv, u32 flags)
@@ -545,7 +544,6 @@ static const struct ocotp_params imx8mq_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
-	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mm_params = {
@@ -553,7 +551,6 @@ static const struct ocotp_params imx8mm_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
-	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mn_params = {
@@ -561,7 +558,6 @@ static const struct ocotp_params imx8mn_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
-	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mp_params = {
@@ -569,7 +565,6 @@ static const struct ocotp_params imx8mp_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_8MP,
-	.reverse_mac_address = true,
 };
 
 static const struct of_device_id imx_ocotp_dt_ids[] = {
@@ -624,8 +619,7 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
-	if (priv->params->reverse_mac_address)
-		imx_ocotp_nvmem_config.layout = &imx_ocotp_layout;
+	imx_ocotp_nvmem_config.layout = &imx_ocotp_layout;
 
 	priv->config = &imx_ocotp_nvmem_config;
 
-- 
2.39.2



