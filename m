Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D346FA694
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjEHKVy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjEHKVX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34690D85A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:20:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD28C624EF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94DCC433EF;
        Mon,  8 May 2023 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541240;
        bh=bTownw0lLmAEW9KKrhaRE6LyTWM03ryZNH3lvWjfgeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bo8XEpcIRMc8WaREGiOJEgORgrfldTRj2levlP4iAn0uU49WMsX7oKB1Lp58FpVya
         rwI/DAC6HnrfhGnmSVKVY8mxU5IREbgytpkO6uDhbf9WFKzjvWZzKAAxlpaKxoa7WA
         DOW19dzD+oxCGEVrt+g8+psChYQPjwO+m/Bv5OT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Badhri Jagan Sridharan <badhri@google.com>
Subject: [PATCH 6.2 033/663] usb: gadget: udc: core: Prevent redundant calls to pullup
Date:   Mon,  8 May 2023 11:37:39 +0200
Message-Id: <20230508094429.534513106@linuxfoundation.org>
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

From: Badhri Jagan Sridharan <badhri@google.com>

commit a3afbf5cc887fc3401f012fe629810998ed61859 upstream.

usb_gadget_connect calls gadget->ops->pullup without checking whether
gadget->connected was previously set. Make this symmetric to
usb_gadget_disconnect by returning early if gadget->connected is
already set.

Fixes: 5a1da544e572 ("usb: gadget: core: do not try to disconnect gadget if it is not connected")
Cc: stable@vger.kernel.org
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Link: https://lore.kernel.org/r/20230407030741.3163220-2-badhri@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -676,6 +676,9 @@ static int usb_gadget_connect_locked(str
 		goto out;
 	}
 
+	if (gadget->connected)
+		goto out;
+
 	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.


