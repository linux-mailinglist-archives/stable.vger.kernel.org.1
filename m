Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6147B73E825
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjFZSXf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjFZSXV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC103E8
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8E1860F57
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61ADC433C0;
        Mon, 26 Jun 2023 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803735;
        bh=IT2ZpffyqEISnL6NLd+96omR6hfrvOlCcRzPt2a66jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqolQh689CxwpJAL7V2vt1poKGdtBSgbTBmoYCvU8PeruRxLnIXeKXd0wfzWz+6yJ
         /F8e9TYbfKKptxMVFP7h5giHipZbIAU5AAHeslbICOiUWY5toBxCgvi5CNZQrZxNps
         DMesacsXb6iDazQCxYLD59j6ZGWx7kuDxE17s8Hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 160/199] usb: gadget: udc: fix NULL dereference in remove()
Date:   Mon, 26 Jun 2023 20:11:06 +0200
Message-ID: <20230626180812.676631403@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 016da9c65fec9f0e78c4909ed9a0f2d567af6775 ]

The "udc" pointer was never set in the probe() function so it will
lead to a NULL dereference in udc_pci_remove() when we do:

	usb_del_gadget_udc(&udc->gadget);

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/ZG+A/dNpFWAlCChk@kili
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/amd5536udc_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index c80f9bd51b750..a36913ae31f9e 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -170,6 +170,9 @@ static int udc_pci_probe(
 		retval = -ENODEV;
 		goto err_probe;
 	}
+
+	udc = dev;
+
 	return 0;
 
 err_probe:
-- 
2.39.2



