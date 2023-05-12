Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD77E7008EB
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 15:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbjELNPo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbjELNPm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 09:15:42 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437E13C30;
        Fri, 12 May 2023 06:15:01 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 61D75206F4;
        Fri, 12 May 2023 15:14:42 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v1 1/2] Revert "usb: gadget: udc: core: Prevent redundant calls to pullup"
Date:   Fri, 12 May 2023 15:14:34 +0200
Message-Id: <20230512131435.205464-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512131435.205464-1-francesco@dolcini.it>
References: <20230512131435.205464-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This reverts commit a3afbf5cc887fc3401f012fe629810998ed61859.

This depends on commit 0db213ea8eed ("usb: gadget: udc: core: Invoke
usb_gadget_connect only when started") that introduces a regression,
revert it till the issue is fixed.

Cc: stable@vger.kernel.org
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/gadget/udc/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 4641153e9706..583c339876ab 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -703,9 +703,6 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
 		goto out;
 	}
 
-	if (gadget->connected)
-		goto out;
-
 	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.
-- 
2.25.1

