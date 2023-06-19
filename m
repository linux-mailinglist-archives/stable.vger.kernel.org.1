Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D21735538
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFSLCp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjFSLCW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34C26A5
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF3D60B42
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A323CC433C0;
        Mon, 19 Jun 2023 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172478;
        bh=pS2N2lntY2VpsyD69X43BDpNELB8gRZ8brV56N2u4WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEyB8eo1gyRFPrq8BQ+8uNdt5I/SeHs7/1NOZ4Q/WBtdlnWY7uSntrp6AU76hcaMz
         fLOrd3up3aVkAhG0kPkGtg2YCUklPTOkT+uvxe7WZZWFgn3jM6Pnru3gx+5SeEE1fx
         kR0W4tB0OUcDITj28KO8gtn737UVxU0AB3kTCmuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.15 057/107] usb: dwc3: gadget: Reset num TRBs before giving back the request
Date:   Mon, 19 Jun 2023 12:30:41 +0200
Message-ID: <20230619102144.216875895@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
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

From: Elson Roy Serrao <quic_eserrao@quicinc.com>

commit 00f8205ffcf112dcef14f8151d78075d38d22c08 upstream.

Consider a scenario where cable disconnect happens when there is an active
usb reqest queued to the UDC. As part of the disconnect we would issue an
end transfer with no interrupt-on-completion before giving back this
request. Since we are giving back the request without skipping TRBs the
num_trbs field of dwc3_request still holds the stale value previously used.
Function drivers re-use same request for a given bind-unbind session and
hence their dwc3_request context gets preserved across cable
disconnect/connect. When such a request gets re-queued after cable connect,
we would increase the num_trbs field on top of the previous stale value
thus incorrectly representing the number of TRBs used. Fix this by
resetting num_trbs field before giving back the request.

Fixes: 09fe1f8d7e2f ("usb: dwc3: gadget: track number of TRBs per request")
Cc: stable <stable@kernel.org>
Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Message-ID: <1685654850-8468-1-git-send-email-quic_eserrao@quicinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -180,6 +180,7 @@ static void dwc3_gadget_del_and_unmap_re
 	list_del(&req->list);
 	req->remaining = 0;
 	req->needs_extra_trb = false;
+	req->num_trbs = 0;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;


