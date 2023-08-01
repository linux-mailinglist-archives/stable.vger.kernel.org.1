Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8964276AD8E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjHAJaO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjHAJ3t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:29:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F273C13
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74901614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD07C433C8;
        Tue,  1 Aug 2023 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882118;
        bh=+cSykmEd8jLkDlWWxthMSy1Nu6DBJj/GdLkrby1HzzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9l+BqACnJ0WzIS+YEEVplZjsrrH+5WRQlSiuokhP8hE65rHW8d7NLDtinlPajQQd
         BujmG6W8WyR9u1G3O4wEN8tlWk1TRSd+R1aLG/v216UPxs5gm8meOR7wBMLQAccUaL
         92VmHzdOsS0cqQoA1vi6Nd0iRMX54Q2E6fb8G+eQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 5.15 119/155] usb: cdns3: fix incorrect calculation of ep_buf_size when more than one config
Date:   Tue,  1 Aug 2023 11:20:31 +0200
Message-ID: <20230801091914.468713046@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frank Li <Frank.Li@nxp.com>

commit 2627335a1329a0d39d8d277994678571c4f21800 upstream.

Previously, the cdns3_gadget_check_config() function in the cdns3 driver
mistakenly calculated the ep_buf_size by considering only one
configuration's endpoint information because "claimed" will be clear after
call usb_gadget_check_config().

The fix involves checking the private flags EP_CLAIMED instead of relying
on the "claimed" flag.

Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
Cc: stable <stable@kernel.org>
Reported-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Tested-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Link: https://lore.kernel.org/r/20230707230015.494999-2-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdns3-gadget.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3012,12 +3012,14 @@ static int cdns3_gadget_udc_stop(struct
 static int cdns3_gadget_check_config(struct usb_gadget *gadget)
 {
 	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct cdns3_endpoint *priv_ep;
 	struct usb_ep *ep;
 	int n_in = 0;
 	int total;
 
 	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-		if (ep->claimed && (ep->address & USB_DIR_IN))
+		priv_ep = ep_to_cdns3_ep(ep);
+		if ((priv_ep->flags & EP_CLAIMED) && (ep->address & USB_DIR_IN))
 			n_in++;
 	}
 


