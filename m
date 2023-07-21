Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B71675D2BB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGUTDE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjGUTDB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D442B30D6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6846D61D85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F64C433C8;
        Fri, 21 Jul 2023 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966179;
        bh=Emp9mvaD/c7n2S01WqXCpGFOSilggKT6T+FuqgaQSIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEutzd3JcEvLwUxiU6UikFs0tk20XvD2inPXUvaNUL7VAYRdWyO9IBnmmW7I2egOf
         k8e9AAInbzbZKEsgmEpnBNPpqFUlPfsc8IN8ob4efYzddanj8RU5KNu8gyyfLymTNY
         LeMRa63S6bwcZSXBvsSa59/IOGY2yOeNIRazw2cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.15 251/532] usb: dwc3: gadget: Propagate core init errors to UDC during pullup
Date:   Fri, 21 Jul 2023 18:02:35 +0200
Message-ID: <20230721160627.972147311@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krishna Kurapati <quic_kriskura@quicinc.com>

commit c0aabed9cabe057309779a9e26fe86a113d24dad upstream.

In scenarios where pullup relies on resume (get sync) to initialize
the controller and set the run stop bit, then core_init is followed by
gadget_resume which will eventually set run stop bit.

But in cases where the core_init fails, the return value is not sent
back to udc appropriately. So according to UDC the controller has
started but in reality we never set the run stop bit.

On systems like Android, there are uevents sent to HAL depending on
whether the configfs_bind / configfs_disconnect were invoked. In the
above mentioned scnenario, if the core init fails, the run stop won't
be set and the cable plug-out won't result in generation of any
disconnect event and userspace would never get any uevent regarding
cable plug out and we never call pullup(0) again. Furthermore none of
the next Plug-In/Plug-Out's would be known to configfs.

Return back the appropriate result to UDC to let the userspace/
configfs know that the pullup failed so they can take appropriate
action.

Fixes: 77adb8bdf422 ("usb: dwc3: gadget: Allow runtime suspend if UDC unbinded")
Cc: stable <stable@kernel.org>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Message-ID: <20230618120949.14868-1-quic_kriskura@quicinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2530,7 +2530,9 @@ static int dwc3_gadget_pullup(struct usb
 	ret = pm_runtime_get_sync(dwc->dev);
 	if (!ret || ret < 0) {
 		pm_runtime_put(dwc->dev);
-		return 0;
+		if (ret < 0)
+			pm_runtime_set_suspended(dwc->dev);
+		return ret;
 	}
 
 	if (dwc->pullups_connected == is_on) {


