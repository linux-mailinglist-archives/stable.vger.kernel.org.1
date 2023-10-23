Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E01E7D30E2
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjJWLDT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjJWLDS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:03:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049CAD7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:03:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414D1C433C7;
        Mon, 23 Oct 2023 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058996;
        bh=Iqk5N73vxQacaGA4FavkPyH0dYJRHyHVd3EpvDcyFAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTnxC3LsUGti3euPwq6VXTpRxFi5EwbpkUYCwUpvSFSnJxGjWfBRJscrmbO1RgdU/
         UrmJcg/nC5nofz6ZKsiq03Z3p3ybsAQlwe6qeEKJvaJfxdBAt0PCh3d1a+bCUYDgR1
         vfOxkTY8kmwQf8KlHnucYvuwK7WKZ8WkePROrl/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.5 004/241] Bluetooth: vhci: Fix race when opening vhci device
Date:   Mon, 23 Oct 2023 12:53:10 +0200
Message-ID: <20231023104833.951080670@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>

commit 92d4abd66f7080075793970fc8f241239e58a9e7 upstream.

When the vhci device is opened in the two-step way, i.e.: open device
then write a vendor packet with requested controller type, the device
shall respond with a vendor packet which includes HCI index of created
interface.

When the virtual HCI is created, the host sends a reset request to the
controller. This request is processed by the vhci_send_frame() function.
However, this request is send by a different thread, so it might happen
that this HCI request will be received before the vendor response is
queued in the read queue. This results in the HCI vendor response and
HCI reset request inversion in the read queue which leads to improper
behavior of btvirt:

> dmesg
[1754256.640122] Bluetooth: MGMT ver 1.22
[1754263.023806] Bluetooth: MGMT ver 1.22
[1754265.043775] Bluetooth: hci1: Opcode 0x c03 failed: -110

In order to synchronize vhci two-step open/setup process with virtual
HCI initialization, this patch adds internal lock when queuing data in
the vhci_send_frame() function.

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_vhci.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -74,7 +74,10 @@ static int vhci_send_frame(struct hci_de
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+
+	mutex_lock(&data->open_mutex);
 	skb_queue_tail(&data->readq, skb);
+	mutex_unlock(&data->open_mutex);
 
 	wake_up_interruptible(&data->read_wait);
 	return 0;


