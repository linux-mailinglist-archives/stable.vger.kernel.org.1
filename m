Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40907E248D
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjKFNXC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjKFNXB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:23:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A011136
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:22:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C05C433CA;
        Mon,  6 Nov 2023 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276978;
        bh=ZVa+VsEVOycUtZBeVR5gBI0bCm6CEnFLx5HjiFat2as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IuwUH45q3a9JQhcZZpI8Ssze/p7aM2sxOHIFyiqxcr15SqZcvUENUyJo99ujGRUCW
         w3NFSMRqQJQMsciylvIDvTTR55iO87InSIh17IGC1p0kj4ksKLByB35RlLt58pPQ0g
         GegSpLqB4435wFkl9tlWnwV+tE5HuQ/vNy3bf6NU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cameron Williams <cang1@live.co.uk>
Subject: [PATCH 5.4 71/74] tty: 8250: Remove UC-257 and UC-431
Date:   Mon,  6 Nov 2023 14:04:31 +0100
Message-ID: <20231106130304.130206820@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cameron Williams <cang1@live.co.uk>

commit 33092fb3af51deb80849e90a17bada44bbcde6b3 upstream.

The UC-257 is a serial + LPT card, so remove it from this driver.
A patch has been submitted to add it to parport_serial instead.

Additionaly, the UC-431 does not use this card ID, only the UC-420
does. The 431 is a 3-port card and there is no generic 3-port configuration
available, so remove reference to it from this driver.

Fixes: 152d1afa834c ("tty: Add support for Brainboxes UC cards.")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Link: https://lore.kernel.org/r/DU0PR02MB78995ADF7394C74AD4CF3357C4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5132,13 +5132,6 @@ static const struct pci_device_id serial
 		0, 0,
 		pbn_b2_1_115200 },
 	/*
-	 * Brainboxes UC-257
-	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
-	/*
 	 * Brainboxes UC-260/271/701/756
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0D21,
@@ -5217,7 +5210,7 @@ static const struct pci_device_id serial
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
-	 * Brainboxes UC-420/431
+	 * Brainboxes UC-420
 	 */
 	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
 		PCI_ANY_ID, PCI_ANY_ID,


