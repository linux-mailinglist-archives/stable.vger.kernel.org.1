Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E8A73533B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjFSKnI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjFSKmn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:42:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB92E7F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99FCE60B7F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC0CC433C0;
        Mon, 19 Jun 2023 10:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171356;
        bh=GmpFHOh7eUvRjM15pWxFpYiHWim5Aj1goONNBTECNWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrDT7FXzt7ipmgtIIq6NiPv3qN9Y0eSrvKXiNp3mwD+FWHSs0xGQ//M5HWU1Kcd4F
         VnOvozS0Vcb7qy0FuOlqlHm+b6JGS6nmt9ixyJrW2uLoSoHNNuTHgP3SueUa5prU2J
         cQ0STlrnuiRx6DxYe1wDEfTrsDnY7G/jng+htYFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Romain Izard <romain.izard.pro@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH 4.19 26/49] usb: gadget: f_ncm: Fix NTP-32 support
Date:   Mon, 19 Jun 2023 12:30:04 +0200
Message-ID: <20230619102131.238435174@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
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

From: Romain Izard <romain.izard.pro@gmail.com>

commit 550eef0c353030ac4223b9c9479bdf77a05445d6 upstream.

When connecting a CDC-NCM gadget to an host that uses the NTP-32 mode,
or that relies on the default CRC setting, the current implementation gets
confused, and does not expect the correct signature for its packets.

Fix this, by ensuring that the ndp_sign member in the f_ncm structure
always contain a valid value.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_ncm.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -36,9 +36,7 @@
 
 /* to trigger crc/non-crc ndp signature */
 
-#define NCM_NDP_HDR_CRC_MASK	0x01000000
 #define NCM_NDP_HDR_CRC		0x01000000
-#define NCM_NDP_HDR_NOCRC	0x00000000
 
 enum ncm_notify_state {
 	NCM_NOTIFY_NONE,		/* don't notify */
@@ -532,6 +530,7 @@ static inline void ncm_reset_values(stru
 {
 	ncm->parser_opts = &ndp16_opts;
 	ncm->is_crc = false;
+	ncm->ndp_sign = ncm->parser_opts->ndp_sign;
 	ncm->port.cdc_filter = DEFAULT_FILTER;
 
 	/* doesn't make sense for ncm, fixed size used */
@@ -814,25 +813,20 @@ static int ncm_setup(struct usb_function
 	case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8)
 		| USB_CDC_SET_CRC_MODE:
 	{
-		int ndp_hdr_crc = 0;
-
 		if (w_length != 0 || w_index != ncm->ctrl_id)
 			goto invalid;
 		switch (w_value) {
 		case 0x0000:
 			ncm->is_crc = false;
-			ndp_hdr_crc = NCM_NDP_HDR_NOCRC;
 			DBG(cdev, "non-CRC mode selected\n");
 			break;
 		case 0x0001:
 			ncm->is_crc = true;
-			ndp_hdr_crc = NCM_NDP_HDR_CRC;
 			DBG(cdev, "CRC mode selected\n");
 			break;
 		default:
 			goto invalid;
 		}
-		ncm->ndp_sign = ncm->parser_opts->ndp_sign | ndp_hdr_crc;
 		value = 0;
 		break;
 	}
@@ -849,6 +843,8 @@ invalid:
 			ctrl->bRequestType, ctrl->bRequest,
 			w_value, w_index, w_length);
 	}
+	ncm->ndp_sign = ncm->parser_opts->ndp_sign |
+		(ncm->is_crc ? NCM_NDP_HDR_CRC : 0);
 
 	/* respond with data transfer or status phase? */
 	if (value >= 0) {


