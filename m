Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4666875D2E6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGUTE6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjGUTE5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950F2D4A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96EE661D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48CDC433C7;
        Fri, 21 Jul 2023 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966296;
        bh=RIYHqq51frdQ7V9Gj+bQrpEYc3Jm2jrNixnss3KbcRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMZ5QFv/zH2OzPUSMGuuXVnZS3g+QWhwhKoU+aaDmtC2C3ieHD4F0LergiuP60VtV
         a+XP8HngJobiUhyJ4g3tLUlgo2dSGY09enf6PbKUgtfNAgXu3apVsG7zRDyjFUAneH
         ji1VkrH0j+s188ZFUH5CcurgufZ8z5ai327zJItw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrew Halaney <ahalaney@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 294/532] usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
Date:   Fri, 21 Jul 2023 18:03:18 +0200
Message-ID: <20230721160630.345270317@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 4a944da707123686d372ec01ea60056902fadf35 ]

If dwc3_qcom_create_urs_usb_platdev() fails, some resources still need to
be released, as already done in the other error handling path of the
probe.

Fixes: c25c210f590e ("usb: dwc3: qcom: add URS Host support for sdm845 ACPI boot")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Message-ID: <b69fa8dd68d816e7d24c88d3eda776ceb28c5dc5.1685890571.git.christophe.jaillet@wanadoo.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3a81b95accdf4..73c0c381e5d05 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -791,9 +791,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
 				dev_err(dev, "failed to create URS USB platdev\n");
 				if (!qcom->urs_usb)
-					return -ENODEV;
+					ret = -ENODEV;
 				else
-					return PTR_ERR(qcom->urs_usb);
+					ret = PTR_ERR(qcom->urs_usb);
+				goto clk_disable;
 			}
 		}
 	}
-- 
2.39.2



