Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F101B7039DC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbjEORq2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244394AbjEORqI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3292F15512
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB57D62E96
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44E2C433EF;
        Mon, 15 May 2023 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172651;
        bh=hH5T1ub22tcYWEOE/xLrBp2p5XHg9Qb7WQTBBpzBXvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gIUEu6RpYu8CRqLi04xWl/eA02AoKP3MemRLsOIT35NGi6v7Wvd9KDXzjdTaRcpxY
         c2S3qy5dD2BrxyD+wle2C5XqwjSpyszb1d43/CfiuFYSXolWqL2ymZxArON1RqbSDU
         0gBR5ZzAx0kCLJS53DFVPb70ZahqmIynuVnivXu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Prashanth K <quic_prashk@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 195/381] usb: dwc3: gadget: Change condition for processing suspend event
Date:   Mon, 15 May 2023 18:27:26 +0200
Message-Id: <20230515161745.633297750@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Prashanth K <quic_prashk@quicinc.com>

[ Upstream commit 4decf4060ecfee1f7a710999fcd421645ac0c419 ]

Currently we process the suspend interrupt event only if the
device is in configured state. Consider a case where device
is not configured and got suspend interrupt, in that case our
gadget will still use 100mA as composite_suspend didn't happen.
But battery charging specification (BC1.2) expects a downstream
device to draw less than 2.5mA when unconnected OR suspended.

Fix this by removing the condition for processing suspend event,
and thus composite_resume would set vbus draw to 2.

Fixes: 72704f876f50 ("dwc3: gadget: Implement the suspend entry event handler")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/1677217619-10261-2-git-send-email-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 01cecde76140b..4e3b451ed749e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3726,15 +3726,8 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		break;
 	case DWC3_DEVICE_EVENT_EOPF:
 		/* It changed to be suspend event for version 2.30a and above */
-		if (!DWC3_VER_IS_PRIOR(DWC3, 230A)) {
-			/*
-			 * Ignore suspend event until the gadget enters into
-			 * USB_STATE_CONFIGURED state.
-			 */
-			if (dwc->gadget->state >= USB_STATE_CONFIGURED)
-				dwc3_gadget_suspend_interrupt(dwc,
-						event->event_info);
-		}
+		if (!DWC3_VER_IS_PRIOR(DWC3, 230A))
+			dwc3_gadget_suspend_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
-- 
2.39.2



