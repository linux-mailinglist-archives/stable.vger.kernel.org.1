Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5782E6FA8E1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjEHKqH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjEHKpj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156A82A9F4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9053B62886
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68369C433EF;
        Mon,  8 May 2023 10:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542706;
        bh=SRRVU7pNpi8dfrzAzAUHUGIFDuGGW7paUqDYtN6Yv7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZ3U256YxxTGrX9Yex7dqA/D+f1MESGPtNpC1PCuqdCXlnU9sGciwaUUDsHcRWXO4
         ViJMZzuL7I1PJqJaErcBbBHASEHP2Rls6lqtRmxvAjLmub1tkKk5drtvvwsZSQImcu
         slfngR5p8onME+8eL9dSiGR71foIxo6Dt8lB+jzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 490/663] usb: gadget: tegra-xudc: Fix crash in vbus_draw
Date:   Mon,  8 May 2023 11:45:16 +0200
Message-Id: <20230508094444.314048116@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit 5629d31955297ca47b9283c64fff70f2f34aa528 ]

Commit ac82b56bda5f ("usb: gadget: tegra-xudc: Add vbus_draw support")
populated the vbus_draw callback for the Tegra XUDC driver. The function
tegra_xudc_gadget_vbus_draw(), that was added by this commit, assumes
that the pointer 'curr_usbphy' has been initialised, which is not always
the case because this is only initialised when the USB role is updated.
Fix this crash, by checking that the 'curr_usbphy' is valid before
dereferencing.

Fixes: ac82b56bda5f ("usb: gadget: tegra-xudc: Add vbus_draw support")
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20230405181854.42355-1-jonathanh@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 76919d7570d23..3c7ffb35c35cd 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -2160,7 +2160,7 @@ static int tegra_xudc_gadget_vbus_draw(struct usb_gadget *gadget,
 
 	dev_dbg(xudc->dev, "%s: %u mA\n", __func__, m_a);
 
-	if (xudc->curr_usbphy->chg_type == SDP_TYPE)
+	if (xudc->curr_usbphy && xudc->curr_usbphy->chg_type == SDP_TYPE)
 		ret = usb_phy_set_power(xudc->curr_usbphy, m_a);
 
 	return ret;
-- 
2.39.2



