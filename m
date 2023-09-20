Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4FD7A7DB1
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjITML0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbjITMLY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:11:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE89E8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:11:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7079C433C8;
        Wed, 20 Sep 2023 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211877;
        bh=LZ68nspDg8/RX24lTVKu++3GCRDlRNH1BNl28aSYM+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPEgumMgUKQMK+2kUrt9BA4eBOo9Hptbk890QHXHlhKE0gML+7NL6mTXiTjhORL58
         Vqb4LuAIEuMOMYKM+XDgzWc5XD3awiUYmdwv2NfVw8MWaN9ewFnzwFi7EIAute6hI9
         j6aQ2uACpS8VjwDtnSYQqMf0dXs9gCO59mtIgshA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/273] net: arcnet: Do not call kfree_skb() under local_irq_disable()
Date:   Wed, 20 Sep 2023 13:28:29 +0200
Message-ID: <20230920112848.596584269@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 786c96e92fb9e854cb8b0cb7399bb2fb28e15c4b ]

It is not allowed to call kfree_skb() from hardware interrupt
context or with hardware interrupts being disabled.
So replace kfree_skb() with dev_kfree_skb_irq() under
local_irq_disable(). Compile tested only.

Fixes: 05fcd31cc472 ("arcnet: add err_skb package for package status feedback")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/arcnet/arcnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 553776cc1d29d..2b112d3d85409 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -434,7 +434,7 @@ static void arcnet_reply_tasklet(unsigned long data)
 
 	ret = sock_queue_err_skb(sk, ackskb);
 	if (ret)
-		kfree_skb(ackskb);
+		dev_kfree_skb_irq(ackskb);
 
 	local_irq_enable();
 };
-- 
2.40.1



