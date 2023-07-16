Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0D755318
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjGPUPX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjGPUPS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360EFC0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F0060EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D786DC433C8;
        Sun, 16 Jul 2023 20:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538515;
        bh=To9bNd2JTYZ+mreilwJbdLU3Qjzpy3d9eUON6y2dxQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtB99isDV8QBzvmNlr0UkIRperE3mrUISVWfrx6hzVMJ9aFO027o2Dh3PC9yu7oOc
         EN26WrFGCJJ4R3r1Z+JMOEKI+VSswlxfIECd240RzndS7ANiby8K7j+LjDLk7bVm2j
         U+3B6NYRIOaGgkhPLJZCKZYJcKDJ3wc5Wn3+DfBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiaolei Wang <xiaolei.wang@windriver.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 478/800] pinctrl: freescale: Fix a memory out of bounds when num_configs is 1
Date:   Sun, 16 Jul 2023 21:45:31 +0200
Message-ID: <20230716195000.181227933@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit 9063777ca1e2e895c5fdd493ee0c3f18fa710ed4 ]

The config passed in by pad wakeup is 1, when num_configs is 1,
Configuration [1] should not be fetched, which will be detected
by KASAN as a memory out of bounds condition. Modify to get
configs[1] when num_configs is 2.

Fixes: f60c9eac54af ("gpio: mxc: enable pad wakeup on i.MX8x platforms")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20230504233736.3766296-1-xiaolei.wang@windriver.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/freescale/pinctrl-scu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-scu.c b/drivers/pinctrl/freescale/pinctrl-scu.c
index ea261b6e74581..3b252d684d723 100644
--- a/drivers/pinctrl/freescale/pinctrl-scu.c
+++ b/drivers/pinctrl/freescale/pinctrl-scu.c
@@ -90,7 +90,7 @@ int imx_pinconf_set_scu(struct pinctrl_dev *pctldev, unsigned pin_id,
 	struct imx_sc_msg_req_pad_set msg;
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
 	unsigned int mux = configs[0];
-	unsigned int conf = configs[1];
+	unsigned int conf;
 	unsigned int val;
 	int ret;
 
@@ -115,6 +115,7 @@ int imx_pinconf_set_scu(struct pinctrl_dev *pctldev, unsigned pin_id,
 	 * Set mux and conf together in one IPC call
 	 */
 	WARN_ON(num_configs != 2);
+	conf = configs[1];
 
 	val = conf | BM_PAD_CTL_IFMUX_ENABLE | BM_PAD_CTL_GP_ENABLE;
 	val |= mux << BP_PAD_CTL_IFMUX;
-- 
2.39.2



