Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BBB787294
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbjHXOzM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241931AbjHXOy4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4BB19AA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9732E66F49
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB54C433C8;
        Thu, 24 Aug 2023 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888893;
        bh=mTUlYX2wAkRwH34/FkRmDDQQDCiiiadEKkuc+9xvzOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxbejFpUL545OxqAvYEbF/2WaWJYMAhyjwOEeHEXzwu8LrhxaDldVOdsR4Wmh3091
         hLD9je13j7eANoOJ+0sF/DAKCHKpo5prsS4lA8IJ1uxGcTc6bvKSHjjZ4gsn9soBVD
         apxlv65ZBTXLw14gsMe7syO2iumhusGG/fAsdI58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 051/139] usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect
Date:   Thu, 24 Aug 2023 16:49:34 +0200
Message-ID: <20230824145025.831537554@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wesley Cheng <quic_wcheng@quicinc.com>

[ Upstream commit 9711c67de7482c81e1daca3548fbc5c9603600e3 ]

Ensure that there are no pending events being handled in between soft
connect/disconnect transitions.  As we are keeping interrupts enabled,
and EP0 events are still being serviced, this avoids any stale events from
being serviced.

Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20220817182359.13550-4-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d76a4837615d9..b2ffc98c9e747 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2540,6 +2540,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
+	synchronize_irq(dwc->irq_gadget);
+
 	if (!is_on) {
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
-- 
2.40.1



