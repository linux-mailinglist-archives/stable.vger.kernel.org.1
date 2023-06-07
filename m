Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F65726F15
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjFGUzb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbjFGUzI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:55:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDDB95
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08D43647D1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C03BC433D2;
        Wed,  7 Jun 2023 20:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171306;
        bh=dUePTNR+/lmT5WMp9B07MmHSlzvUB6vleBK+OqK+mvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsXRLpUEARvaJJmohNLidnbLv023ghwVA9R5HdFfCvY7yJ6oWZRi8plY5l3MU3mEF
         CevccD4mKakac+PyuGDSlgNJZQpvzixvWPFyNddyQjLm1A3mgx8cjrDUl1XbLfaDqM
         4T6muLJZmqNbdWJrLXmAyiZnr56Xb9qK9GAVHBGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 67/99] net: usb: qmi_wwan: Set DTR quirk for BroadMobi BM818
Date:   Wed,  7 Jun 2023 22:16:59 +0200
Message-ID: <20230607200902.335839521@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

commit 36936a56e1814f6c526fe71fbf980beab4f5577a upstream.

BM818 is based on Qualcomm MDM9607 chipset.

Fixes: 9a07406b00cd ("net: usb: qmi_wwan: Add the BroadMobi BM818 card")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Acked-by: Bjørn Mork <bjorn@mork.no>
Link: https://lore.kernel.org/r/20230526-bm818-dtr-v1-1-64bbfa6ba8af@puri.sm
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1282,7 +1282,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x2001, 0x7e3d, 4)},	/* D-Link DWM-222 A2 */
 	{QMI_FIXED_INTF(0x2020, 0x2031, 4)},	/* Olicard 600 */
 	{QMI_FIXED_INTF(0x2020, 0x2033, 4)},	/* BroadMobi BM806U */
-	{QMI_FIXED_INTF(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
+	{QMI_QUIRK_SET_DTR(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
 	{QMI_FIXED_INTF(0x0f3d, 0x68a2, 8)},    /* Sierra Wireless MC7700 */
 	{QMI_FIXED_INTF(0x114f, 0x68a2, 8)},    /* Sierra Wireless MC7750 */
 	{QMI_FIXED_INTF(0x1199, 0x68a2, 8)},	/* Sierra Wireless MC7710 in QMI mode */


