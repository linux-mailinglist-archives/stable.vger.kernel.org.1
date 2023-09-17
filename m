Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9808A7A3B75
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjIQUSJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbjIQURh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:17:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D2F1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:17:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED22FC433C7;
        Sun, 17 Sep 2023 20:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981852;
        bh=ZpsLx2OuMhez4FiCcOHOxDFWdzfGGidvzvkpdrEizks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USwBUEl9XtM1fqNb8bDW/enSwDlXWIbUI9PpE8uctjWz/kEb7xiqf0S/dccgw8nPD
         7sOrKNE5UGvVGZy+rchXNMaL+NPOxz9DduuvT3Ct4bk5Dwxf2imHXY45R+egZWwgIp
         sCjiNM5C6jve+zJZdxa5vsZXxXkXVI+x8kB+jXZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 115/511] Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()
Date:   Sun, 17 Sep 2023 21:09:02 +0200
Message-ID: <20230917191116.653942988@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 15d253325fd8a..84a42348b3bcb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1756,7 +1756,7 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
 		 * alternate setting.
 		 */
 		spin_lock_irqsave(&data->rxlock, flags);
-		kfree_skb(data->sco_skb);
+		dev_kfree_skb_irq(data->sco_skb);
 		data->sco_skb = NULL;
 		spin_unlock_irqrestore(&data->rxlock, flags);
 
-- 
2.40.1



