Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137927553B0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjGPUVw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGPUVv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:21:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599390
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3394B60DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47774C433C7;
        Sun, 16 Jul 2023 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538909;
        bh=rdJAI9EbsBAXhn0C9LVplba24PBsH/+/m+vs0Edv/XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lo8ZFME0PAHEdvHnnKyyv8ZQCZqvRICh+7DGhgpNTIlpKMBp0fBbpJg9GUsHUN2Sf
         NRZxSP6MnGH3ET1CAr94XszGRj0bi2h/MHWmrArT1DCjqdlt1du1SSZ/t27Q9ZeFOV
         GokVebus7TjhWS72bYpu2Vt4c0m4rLY/I7Lhe8KY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrew Halaney <ahalaney@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 619/800] usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
Date:   Sun, 16 Jul 2023 21:47:52 +0200
Message-ID: <20230716195003.491788482@linuxfoundation.org>
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
index 9c01e963ae467..72c22851d7eef 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -865,9 +865,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
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



