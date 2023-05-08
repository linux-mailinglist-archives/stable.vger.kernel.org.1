Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCCB6FAC31
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbjEHLVy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjEHLVv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:21:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF74B2109
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCFF262CA1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB622C433EF;
        Mon,  8 May 2023 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544905;
        bh=fquWWUTh7y+Gdg76M90XUq7d3ZEihN4eT4T7TfhaCoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZX+1qkiyU0FFwpI0K80DVgk3tVfGD9ZVNm5jtCNQuevP/wQHyCAcMUEj1BM0GKK0
         EH4Edl9xelo108SRLIV90GOrXDqvy1qxJhMLQCZFgkn0FezLiqMhYn4WE72VDLp051
         9c43hMHXIzmK45CZwym/LpfKiRF+7rXfcsZIN/Vk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 544/694] usb: gadget: tegra-xudc: Fix crash in vbus_draw
Date:   Mon,  8 May 2023 11:46:19 +0200
Message-Id: <20230508094452.137579119@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index 2b71b33725f17..5bccd64847ff7 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -2167,7 +2167,7 @@ static int tegra_xudc_gadget_vbus_draw(struct usb_gadget *gadget,
 
 	dev_dbg(xudc->dev, "%s: %u mA\n", __func__, m_a);
 
-	if (xudc->curr_usbphy->chg_type == SDP_TYPE)
+	if (xudc->curr_usbphy && xudc->curr_usbphy->chg_type == SDP_TYPE)
 		ret = usb_phy_set_power(xudc->curr_usbphy, m_a);
 
 	return ret;
-- 
2.39.2



