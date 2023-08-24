Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D17876AE
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbjHXRSc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbjHXRSQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:18:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D11F19B5
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 125A867464
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26102C433C9;
        Thu, 24 Aug 2023 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897493;
        bh=0Ch+78c/JG3mjvOjG1C0QDYz3v4rZh2uYJk/sNFGlRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZPSpPJvxqpDrGhB6F/93ZouGO9N3To87YpPTwu7WmkVXVo45PE1hL3p4tRMolWQH
         0+n3e46jwp+aMu49qk1pcVWQN+oCM8QToRceXGomPME7V2k2Wvx2Dm+N5cKC+AUmtl
         2i1LaetZW7Z3kfon8CxmAQEKXE6uolneqW9IdQpo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xu Yang <xu.yang_2@nxp.com>,
        Li Jun <jun.li@nxp.com>, Peter Chen <peter.chen@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/135] usb: chipidea: imx: dont request QoS for imx8ulp
Date:   Thu, 24 Aug 2023 19:08:22 +0200
Message-ID: <20230824170618.455867256@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 9a070e8e208995a9d638b538ed7abf28bd6ea6f0 ]

Use dedicated imx8ulp usb compatible to remove QoS request
since imx8ulp has no such limitation of imx7ulp: DMA will
not work if system enters idle.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Message-ID: <20230530104007.1294702-2-xu.yang_2@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index f798455942844..4d47fe89864d9 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -70,6 +70,10 @@ static const struct ci_hdrc_imx_platform_flag imx7ulp_usb_data = {
 		CI_HDRC_PMQOS,
 };
 
+static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
+	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM,
+};
+
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx23-usb", .data = &imx23_usb_data},
 	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
@@ -80,6 +84,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx6ul-usb", .data = &imx6ul_usb_data},
 	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
 	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
+	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ci_hdrc_imx_dt_ids);
-- 
2.40.1



