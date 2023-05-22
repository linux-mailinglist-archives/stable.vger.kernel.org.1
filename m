Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158C770C748
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjEVT1u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjEVT1q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F93F103
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C84628C8
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A3AC433D2;
        Mon, 22 May 2023 19:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783664;
        bh=IehnyUpib8Q5XWZlAiw93YmFAasfVCSZCdIm39tlKfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMOQRzx2hz3CqV9bp19hmy20EeI+RUQ9UihYlEPjayhSz23eYDvJEdv6thzBL2aKB
         3qvXAmNemvZpIHRrXuklGv7ylVo47ILIlj0HWIKOx2/rSve6yJw1QmMTEZdE8e5N6s
         A4i4xe+re2LFd3mXerx6hZvnS5wRmwk6BwSgeDSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Raul Cheleguini <rcheleguini@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 113/292] Bluetooth: Improve support for Actions Semi ATS2851 based devices
Date:   Mon, 22 May 2023 20:07:50 +0100
Message-Id: <20230522190408.791358873@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Raul Cheleguini <rcheleguini@google.com>

[ Upstream commit 7c2b2d2d0cb658aa543e11e90ae95621d3cb5fe6 ]

Add two more quirks to resume the device initialization and basic
operation as the device seems not to support "Read Transmit Power"
and "Set Extended Scan Parameters".

< HCI Command: LE Read Transmit Power (0x08|0x004b) plen 0
> HCI Event: Command Status (0x0f) plen 4
      LE Read Transmit Power (0x08|0x004b) ncmd 1
        Status: Unknown HCI Command (0x01)

< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Status (0x0f) plen 4
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Unknown HCI Command (0x01)

Signed-off-by: Raul Cheleguini <rcheleguini@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8ee147ad76b79..3991dcd2ebf79 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4019,6 +4019,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_ACTIONS_SEMI) {
 		/* Support is advertised, but not implemented */
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 	}
 
 	if (!reset)
-- 
2.39.2



