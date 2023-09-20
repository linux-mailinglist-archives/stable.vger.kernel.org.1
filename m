Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA477A7B2A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjITLtt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjITLtb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:49:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD02B4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:49:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68622C433C7;
        Wed, 20 Sep 2023 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210564;
        bh=KGzeXSHmnGgxHPYaQ19j5qWJ7/NoEd+VGPcf6q3QC4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEo3lfFy/VOmfqXsfrqHe8j2U+CnwdxHmPTiQJb97E/L/3l3XtsfQGRF60ga0qfiM
         bkucnN9mNvGRLyNeMIHivcF9a4tIKQdWBjqAnErHDJh79yrORz+0yXDedtYsYsTQGG
         MjJD9uMCHQ/W5jlQld045eor7ogLbNphEFEa7KpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xu Yang <xu.yang_2@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 123/211] usb: chipidea: add workaround for chipidea PEC bug
Date:   Wed, 20 Sep 2023 13:29:27 +0200
Message-ID: <20230920112849.609470980@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 12e6ac69cc7e7d3367599ae26a92a0f9a18bc728 ]

Some NXP processors using ChipIdea USB IP have a bug when frame babble is
detected.

Issue description:
In USB camera test, our controller is host in HS mode. In ISOC IN, when
device sends data across the micro frame, it causes the babble in host
controller. This will clear the PE bit. In spec, it also requires to set
the PEC bit and then set the PCI bit. Without the PCI interrupt, the
software does not know the PE is cleared.

This will add a flag CI_HDRC_HAS_PORTSC_PEC_MISSED to some impacted
platform datas. And the ehci host driver will assert PEC by SW when
specific conditions are satisfied.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20230809024432.535160-2-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/ci.h          | 1 +
 drivers/usb/chipidea/ci_hdrc_imx.c | 4 +++-
 drivers/usb/chipidea/core.c        | 2 ++
 drivers/usb/chipidea/host.c        | 1 +
 include/linux/usb/chipidea.h       | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index f210b7489fd5b..78cfbe621272c 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -257,6 +257,7 @@ struct ci_hdrc {
 	bool				id_event;
 	bool				b_sess_valid_event;
 	bool				imx28_write_fix;
+	bool				has_portsc_pec_bug;
 	bool				supports_runtime_pm;
 	bool				in_lpm;
 	bool				wakeup_int;
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 873539f9a2c0a..a96d8af935382 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -67,11 +67,13 @@ static const struct ci_hdrc_imx_platform_flag imx7d_usb_data = {
 
 static const struct ci_hdrc_imx_platform_flag imx7ulp_usb_data = {
 	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM |
+		CI_HDRC_HAS_PORTSC_PEC_MISSED |
 		CI_HDRC_PMQOS,
 };
 
 static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
-	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM,
+	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM |
+		CI_HDRC_HAS_PORTSC_PEC_MISSED,
 };
 
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 51994d655b821..500286a4576b5 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1045,6 +1045,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		CI_HDRC_IMX28_WRITE_FIX);
 	ci->supports_runtime_pm = !!(ci->platdata->flags &
 		CI_HDRC_SUPPORTS_RUNTIME_PM);
+	ci->has_portsc_pec_bug = !!(ci->platdata->flags &
+		CI_HDRC_HAS_PORTSC_PEC_MISSED);
 	platform_set_drvdata(pdev, ci);
 
 	ret = hw_device_init(ci, base);
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index ebe7400243b12..08af26b762a2d 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -151,6 +151,7 @@ static int host_start(struct ci_hdrc *ci)
 	ehci->has_hostpc = ci->hw_bank.lpm;
 	ehci->has_tdi_phy_lpm = ci->hw_bank.lpm;
 	ehci->imx28_write_fix = ci->imx28_write_fix;
+	ehci->has_ci_pec_bug = ci->has_portsc_pec_bug;
 
 	priv = (struct ehci_ci_priv *)ehci->priv;
 	priv->reg_vbus = NULL;
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index ee38835ed77cc..0b4f2d5faa080 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -63,6 +63,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_IMX_IS_HSIC		BIT(14)
 #define CI_HDRC_PMQOS			BIT(15)
 #define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
+#define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
-- 
2.40.1



