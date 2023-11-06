Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF937E2491
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjKFNXL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjKFNXK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:23:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F0F1
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:23:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCDAC433C9;
        Mon,  6 Nov 2023 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276987;
        bh=1vJBYTZPHsyyma7OZaXf0mEeq8dtqYDjjF+LrTLP9rU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxtAVqaA8Y4NlENiqnX3+B0se9rP6g11zo9SpYpwHZhzwisnH6YeRqxJpKfKKoty/
         2/ORTYVqCJbSlrNviRdXlib8k0pG7UFzYSs9aeCpY4N6Lu78rcMJcer5TWKDrj3AjP
         Juol6Z9rm/5aBPoKp1FwGK66zxkGapU9404jbbNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cameron Williams <cang1@live.co.uk>
Subject: [PATCH 5.4 74/74] tty: 8250: Add support for Intashield IS-100
Date:   Mon,  6 Nov 2023 14:04:34 +0100
Message-ID: <20231106130304.228159040@linuxfoundation.org>
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

commit 4d994e3cf1b541ff32dfb03fbbc60eea68f9645b upstream.

Add support for the Intashield IS-100 1 port serial card.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Link: https://lore.kernel.org/r/DU0PR02MB7899A0E0CDAA505AF5A874CDC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5105,6 +5105,12 @@ static const struct pci_device_id serial
 		pbn_b1_bt_1_115200 },
 
 	/*
+	 * IntaShield IS-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D60,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
+	/*
 	 * IntaShield IS-200
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS200,


