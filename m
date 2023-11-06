Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA97E25BA
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjKFNec (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjKFNeb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:34:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B15F1
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:34:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CBDC433CB;
        Mon,  6 Nov 2023 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277668;
        bh=enOi76hTuc0oCjrwy/pPCYa8AB2oONFh04VxAtQYMuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVDpfquNDM/qRDNxFrz6ZGKiza+Noe3UGb/JTUxUpHyQfZ8z9G9dc3r0NveSO3fgE
         60/PJHgG8m5Y+ZYt0EZywuByZiiZKCee1ViuZFepkdXwCW1VkSv42P+iX0TewLv6Be
         TMLGR732YfW3/MZ8lY+tQVUMbg22SzbWiXzG7acg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liha Sikanen <lihasika@gmail.com>
Subject: [PATCH 5.10 89/95] usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility
Date:   Mon,  6 Nov 2023 14:04:57 +0100
Message-ID: <20231106130307.948105612@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: LihaSika <lihasika@gmail.com>

commit 0e3139e6543b241b3e65956a55c712333bef48ac upstream.

Change lower bcdDevice value for "Super Top USB 2.0  SATA BRIDGE" to match
1.50. I have such an older device with bcdDevice=1.50 and it will not work
otherwise.

Cc: stable@vger.kernel.org
Signed-off-by: Liha Sikanen <lihasika@gmail.com>
Link: https://lore.kernel.org/r/ccf7d12a-8362-4916-b3e0-f4150f54affd@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/unusual_cypress.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/storage/unusual_cypress.h
+++ b/drivers/usb/storage/unusual_cypress.h
@@ -19,7 +19,7 @@ UNUSUAL_DEV(  0x04b4, 0x6831, 0x0000, 0x
 		"Cypress ISD-300LP",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
 
-UNUSUAL_DEV( 0x14cd, 0x6116, 0x0160, 0x0160,
+UNUSUAL_DEV( 0x14cd, 0x6116, 0x0150, 0x0160,
 		"Super Top",
 		"USB 2.0  SATA BRIDGE",
 		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),


