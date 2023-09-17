Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A77A37D7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbjIQTZy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbjIQTZa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F3121
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:25:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF2FC433C7;
        Sun, 17 Sep 2023 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978723;
        bh=NN4lHcxXuJ64yZnY0INnK/Y4gnVUuwxBD/Ekvvart74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhCNh8uScA0c/uiCby/qhV49fJ0aPHzCef/uXm+ZWjjSEA363m3ic+Iu+0uUhf7Ar
         0NL+xUCeU5eK658T4GVKTmz65FP6l5A2DQO9sTBmlWwzvZOVW0SY4bfP9jrXeEuYWV
         vAtsHnKT9XtViFiY/UnFmTby0QZavyDZtnrSibTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 116/406] net: arcnet: Do not call kfree_skb() under local_irq_disable()
Date:   Sun, 17 Sep 2023 21:09:30 +0200
Message-ID: <20230917191104.196044547@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index d76dd7d14299e..a7899405a51a5 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -468,7 +468,7 @@ static void arcnet_reply_tasklet(unsigned long data)
 
 	ret = sock_queue_err_skb(sk, ackskb);
 	if (ret)
-		kfree_skb(ackskb);
+		dev_kfree_skb_irq(ackskb);
 
 	local_irq_enable();
 };
-- 
2.40.1



