Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB17034B2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbjEOQvm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243129AbjEOQvP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3835B91
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A6362984
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66483C433EF;
        Mon, 15 May 2023 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169463;
        bh=pT+aH9WvcAJbgoqzADH5KCtQV4XQFy2qkP6YOaLD26g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyrkLbJMxUAt7vq/ulSwqV76bZsftSDKQd5gx2v2NsGMqn0exMKYmgoPRkUsbyj+g
         cR0SSxemCSBvAsu7mUZ1sICV3THqIbUjmmTTyieeS+TVCPK5XWEjCHw8J/jOYpU4/k
         6o4mTO5ax5979JO6mXAzkAA1btIqRg+bDfVin1Yw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ratheesh Kannoth <rkannoth@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Sai Krishna <saikrishnag@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 066/246] octeontx2-af: Fix start and end bit for scan config
Date:   Mon, 15 May 2023 18:24:38 +0200
Message-Id: <20230515161724.557375798@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ratheesh Kannoth <rkannoth@marvell.com>

[ Upstream commit c60a6b90e7890453f09e0d2163d6acadabe3415b ]

In the current driver, NPC exact match feature was not getting
enabled as configured bit was not read properly.
for_each_set_bit_from() need end bit as one bit post
position in the bit map to read NPC exact nibble enable
bits properly. This patch fixes the same.

Fixes: b747923afff8 ("octeontx2-af: Exact match support")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 006beb5cf98dd..f15efd41972ee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -594,8 +594,7 @@ static int npc_scan_kex(struct rvu *rvu, int blkaddr, u8 intf)
 	 */
 	masked_cfg = cfg & NPC_EXACT_NIBBLE;
 	bitnr = NPC_EXACT_NIBBLE_START;
-	for_each_set_bit_from(bitnr, (unsigned long *)&masked_cfg,
-			      NPC_EXACT_NIBBLE_START) {
+	for_each_set_bit_from(bitnr, (unsigned long *)&masked_cfg, NPC_EXACT_NIBBLE_END + 1) {
 		npc_scan_exact_result(mcam, bitnr, key_nibble, intf);
 		key_nibble++;
 	}
-- 
2.39.2



