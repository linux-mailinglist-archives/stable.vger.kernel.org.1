Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255E17ED412
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjKOU4k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjKOU4i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F26BCE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:56:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC150C4E778;
        Wed, 15 Nov 2023 20:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081795;
        bh=aqMR1SYtHF5nwjqyalx1u6sRMYEF/n1VmFSYUtOyqOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DysvB4S1XdE7J/x+tmx8ZE/GqfO9MU9ujl6c55FjAbVrDrqgLHN+3azXBxr2Lg1wx
         oTy7fIczcxuOmLzwY0aaO8GRObt/RCoHJGQ9t0KCkZTaOAxU64fNBryMn2vBYpyhNp
         XrFmsplB6m+s8C+hF7VPmMLtq9yrilPAHwuBUXlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 129/191] misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()
Date:   Wed, 15 Nov 2023 15:46:44 -0500
Message-ID: <20231115204652.270333796@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 4d08c3d12b61022501989f9f071514d2d6f77c47 ]

It is not allowed to call kfree_skb() from hardware interrupt
context or with hardware interrupts being disabled.
So replace kfree_skb() with dev_kfree_skb_irq() under
spin_lock_irqsave(). Compile tested only.

Fixes: 53618cc1e51e ("Staging: sources for ST core")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/20230823035020.1281892-1-ruanjinjie@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/ti-st/st_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index f4ddd1e670151..ca115f344fa29 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -15,6 +15,7 @@
 #include <linux/skbuff.h>
 
 #include <linux/ti_wilink_st.h>
+#include <linux/netdevice.h>
 
 extern void st_kim_recv(void *, const unsigned char *, long);
 void st_int_recv(void *, const unsigned char *, long);
@@ -436,7 +437,7 @@ static void st_int_enqueue(struct st_data_s *st_gdata, struct sk_buff *skb)
 	case ST_LL_AWAKE_TO_ASLEEP:
 		pr_err("ST LL is illegal state(%ld),"
 			   "purging received skb.", st_ll_getstate(st_gdata));
-		kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		break;
 	case ST_LL_ASLEEP:
 		skb_queue_tail(&st_gdata->tx_waitq, skb);
@@ -445,7 +446,7 @@ static void st_int_enqueue(struct st_data_s *st_gdata, struct sk_buff *skb)
 	default:
 		pr_err("ST LL is illegal state(%ld),"
 			   "purging received skb.", st_ll_getstate(st_gdata));
-		kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		break;
 	}
 
@@ -499,7 +500,7 @@ void st_tx_wakeup(struct st_data_s *st_data)
 				spin_unlock_irqrestore(&st_data->lock, flags);
 				break;
 			}
-			kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			spin_unlock_irqrestore(&st_data->lock, flags);
 		}
 		/* if wake-up is set in another context- restart sending */
-- 
2.42.0



