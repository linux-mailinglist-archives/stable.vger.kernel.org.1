Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA1755617
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjGPUr1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjGPUr0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD0E51
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4369D60DFD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B14C433C8;
        Sun, 16 Jul 2023 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540442;
        bh=V14iCNd3HiqaAiIk0JlBs60dP7RbH2dn+gqfahy/bt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEn3bRbpFE5an87hLPaJajVa6gbUDrTWM9oq4VAyw2L2tslpg3i++glLMIarKq0Tt
         GN/VRw4ZGOhRmMnv6j/MBBTkPLxXGxV6LMBfjBp1mWdaB8WSm54oH8L9DtD0JhzI7h
         SKILVjtBQu9GXBNkJ3VbCeOwONB22cxDfzCOqW1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.1 364/591] usb: dwc3: gadget: Propagate core init errors to UDC during pullup
Date:   Sun, 16 Jul 2023 21:48:23 +0200
Message-ID: <20230716194933.335149359@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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
@@ -2631,7 +2631,9 @@ static int dwc3_gadget_pullup(struct usb
 	ret = pm_runtime_get_sync(dwc->dev);
 	if (!ret || ret < 0) {
 		pm_runtime_put(dwc->dev);
-		return 0;
+		if (ret < 0)
+			pm_runtime_set_suspended(dwc->dev);
+		return ret;
 	}
 
 	if (dwc->pullups_connected == is_on) {


