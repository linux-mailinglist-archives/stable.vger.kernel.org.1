Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734907ECE00
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjKOTjp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjKOTjn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4B1B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992EDC433C8;
        Wed, 15 Nov 2023 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077179;
        bh=LcDfVqeTe9z95DyCRCbKypCoBOdVm8nr5chABh8mjP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uy8FHxFYFlxQl4TquTIpr30vzKNomWMAVHWedeF6yb+I2Khba7lvAM9Y0hWkCfuKi
         w8/5L6dA673C8fc7VnJnkFLz/1mSRLN6kzcpmL+yBQrhVc8G2a6V0Y9fpIt9078lFM
         nxYbaihz7KnaK1PBZ5ml94903+V8x5yMvlMRLvEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 150/603] Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err
Date:   Wed, 15 Nov 2023 14:11:35 -0500
Message-ID: <20231115191623.568348044@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

[ Upstream commit 530886897c789cf77c9a0d4a7cc5549f0768b5f8 ]

Printed Opcodes may be missing leading zeros:

	Bluetooth: hci0: Opcode 0x c03 failed: -110

Fix this by always printing leading zeros:

	Bluetooth: hci0: Opcode 0x0c03 failed: -110

Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Fixes: 6a98e3836fa2 ("Bluetooth: Add helper for serialized HCI command execution")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a15ab0b874a9d..9e71362c04b48 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -152,7 +152,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	struct sk_buff *skb;
 	int err = 0;
 
-	bt_dev_dbg(hdev, "Opcode 0x%4x", opcode);
+	bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
 
 	hci_req_init(&req, hdev);
 
@@ -248,7 +248,7 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
 	if (IS_ERR(skb)) {
 		if (!event)
-			bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
+			bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
 				   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
-- 
2.42.0



