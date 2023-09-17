Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BEF7A39F9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbjIQT4u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbjIQT4e (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:56:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9C812F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:56:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE60C433C8;
        Sun, 17 Sep 2023 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980587;
        bh=W0oEmUM3Eg/m4RcBuAghDz29QYQX6m4FsadyLS08IaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x4Meb2mqkEeg4n+jr2m6cBkg1kG6FszHOXnbYe8MmhmlbAI8/AOxPlrQ31xTbB1o9
         XFdsHxSajD8cfzWhbHL9+uubpm8IiYOSn5Dbcu6u4Aa6VDl47XRLrzxgsUC2Cn5UnV
         BdX5ttG8yFO+W5JXeQrBS4oTR7oBZP5RGTc6cbL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 195/285] hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation
Date:   Sun, 17 Sep 2023 21:13:15 +0200
Message-ID: <20230917191058.341427456@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Marangi <ansuelsmth@gmail.com>

commit 23316be8a9d450f33a21f1efe7d89570becbec58 upstream.

Commit 5d4753f741d8 ("hwspinlock: qcom: add support for MMIO on older
SoCs") introduced and made regmap_config mandatory in the of_data struct
but didn't add the regmap_config for sfpb based devices.

SFPB based devices can both use the legacy syscon way to probe or the
new MMIO way and currently device that use the MMIO way are broken as
they lack the definition of the now required regmap_config and always
return -EINVAL (and indirectly makes fail probing everything that
depends on it, smem, nandc with smem-parser...)

Fix this by correctly adding the missing regmap_config and restore
function of hwspinlock on SFPB based devices with MMIO implementation.

Cc: stable@vger.kernel.org
Fixes: 5d4753f741d8 ("hwspinlock: qcom: add support for MMIO on older SoCs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20230716022804.21239-1-ansuelsmth@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwspinlock/qcom_hwspinlock.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -69,9 +69,18 @@ static const struct hwspinlock_ops qcom_
 	.unlock		= qcom_hwspinlock_unlock,
 };
 
+static const struct regmap_config sfpb_mutex_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= 0x100,
+	.fast_io		= true,
+};
+
 static const struct qcom_hwspinlock_of_data of_sfpb_mutex = {
 	.offset = 0x4,
 	.stride = 0x4,
+	.regmap_config = &sfpb_mutex_config,
 };
 
 static const struct regmap_config tcsr_msm8226_mutex_config = {


