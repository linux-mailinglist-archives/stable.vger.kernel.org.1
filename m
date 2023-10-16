Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C969F7CA1FC
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjJPIoH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJPIoH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:44:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02EE6
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:44:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152A5C433C7;
        Mon, 16 Oct 2023 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445845;
        bh=hZc5gpezbAS2Wx/f7X5WmeAVAcKxQHuO5lV13KBkziM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESN27QpFeG2AC5FbnnF7OFCNWS1Fw19dayxrKLh1TSFj7DJjuT0U3wYBZw+RI+T/s
         uALcv+U/aVQk8h9q+FXz9jsfXDPmHzGPi5PniUpQJWFtatmoQPLX+FdefCqXc8KiFn
         zSJdv/udaE7QJmsRLHVSVL7WUrfnI9M/fsUive4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 006/102] RDMA/cxgb4: Check skb value for failure to allocate
Date:   Mon, 16 Oct 2023 10:40:05 +0200
Message-ID: <20231016083953.859748934@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Chernyshev <artem.chernyshev@red-soft.ru>

[ Upstream commit 8fb8a82086f5bda6893ea6557c5a458e4549c6d7 ]

get_skb() can fail to allocate skb, so check it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5be78ee924ae ("RDMA/cxgb4: Fix LE hash collision bug for active open connection")
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Link: https://lore.kernel.org/r/20230905124048.284165-1-artem.chernyshev@red-soft.ru
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/cxgb4/cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index a3e4913904b75..f159cbb6bb3ea 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1965,6 +1965,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
 	int win;
 
 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
 	req = __skb_put_zero(skb, sizeof(*req));
 	req->op_compl = htonl(WR_OP_V(FW_OFLD_CONNECTION_WR));
 	req->len16_pkd = htonl(FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*req), 16)));
-- 
2.40.1



