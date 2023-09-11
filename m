Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039C879B7AC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbjIKV7a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbjIKOjG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:39:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D09F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:39:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF66C433C8;
        Mon, 11 Sep 2023 14:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443141;
        bh=n/8Sdnp2p4NYvbs0yq3HWyDQT8uKvBe+yFVhII68qJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrb/uYbIrsEFEjCDYM6Rm7HQ6w3YgE0FFFG8ShyhybhBh+OcjPDn6Tjz/ru2PNIm4
         i2OwMo4uGlrWuWWkUTuabs4kGGhn4FwQv1Um9DIZKZtM3VKyhILWSjG4xnSioK8b+o
         uj6C1KlgrdoIdMFYAL0QSLfxe+b6P2iJeiN6NHgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 245/737] Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()
Date:   Mon, 11 Sep 2023 15:41:44 +0200
Message-ID: <20230911134657.447288167@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 2a05334d7f91ff189692089c05fc48cc1d8204de ]

It is not allowed to call kfree_skb() from hardware interrupt
context or with hardware interrupts being disabled.
So replace kfree_skb() with dev_kfree_skb_irq() under
spin_lock_irqsave(). Compile tested only.

Fixes: baac6276c0a9 ("Bluetooth: btusb: handle mSBC audio over USB Endpoints")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 025e803ba55c2..5559d6d8ae8b2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2077,7 +2077,7 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
 		 * alternate setting.
 		 */
 		spin_lock_irqsave(&data->rxlock, flags);
-		kfree_skb(data->sco_skb);
+		dev_kfree_skb_irq(data->sco_skb);
 		data->sco_skb = NULL;
 		spin_unlock_irqrestore(&data->rxlock, flags);
 
-- 
2.40.1



