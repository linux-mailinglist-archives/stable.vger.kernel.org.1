Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288D79AD6A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242216AbjIKU5p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbjIKOiB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:38:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8AF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:37:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5D3C433C7;
        Mon, 11 Sep 2023 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443077;
        bh=BTi/iqeSX0gYQabtMy5EyjRsxohbZKsQYKMViLeIkxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzq64POC9ZImQGZN84d24kvakYi5B9a6DH8yu6u53ctqJqWab11317VMkiblrF++c
         jrLDbQCh4b9fpUd+q4vqy8oEfw3ZsW7BIa8QQ44rpgPTYIj5RZornXxJaz0rifwPLe
         1pDxtLNQxpv20/LiOA0A/AFwpcMuHcqf/BHBVEtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 250/737] net: arcnet: Do not call kfree_skb() under local_irq_disable()
Date:   Mon, 11 Sep 2023 15:41:49 +0200
Message-ID: <20230911134657.580860184@linuxfoundation.org>
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
index 1bad1866ae462..a48220f91a2df 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -468,7 +468,7 @@ static void arcnet_reply_tasklet(struct tasklet_struct *t)
 
 	ret = sock_queue_err_skb(sk, ackskb);
 	if (ret)
-		kfree_skb(ackskb);
+		dev_kfree_skb_irq(ackskb);
 
 	local_irq_enable();
 };
-- 
2.40.1



