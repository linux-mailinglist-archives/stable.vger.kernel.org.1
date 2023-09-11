Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1979BC1A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378806AbjIKWha (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbjIKO36 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:29:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8571BF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:29:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C644C433C7;
        Mon, 11 Sep 2023 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442594;
        bh=iybcmXumYn8jC5NqrMTTUK+tY5tn7BlvP+gTJjDSsJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMyP4qWwTxS7Ae1Zw0iaNgkVWRByz3A+C1bCUmULbL2X61/xOPllTR0y2RS2/L03h
         28y6arzHwK8zUBctakXev+fASGmDSPJarJBcpZhXZFeD9wpLvNoI7EVJMCJddpqQaW
         MGbVzLrptOM/5iE7JjNkD1ZcVION8fz+25NouQ0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 079/737] broadcom: b44: Use b44_writephy() return value
Date:   Mon, 11 Sep 2023 15:38:58 +0200
Message-ID: <20230911134652.718190122@linuxfoundation.org>
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

From: Artem Chernyshev <artem.chernyshev@red-soft.ru>

[ Upstream commit 9944d203fa63721b87eee84a89f7275dc3d25c05 ]

Return result of b44_writephy() instead of zero to
deal with possible error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/b44.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 392ec09a1d8a6..3e4fb3c3e8342 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1793,11 +1793,9 @@ static int b44_nway_reset(struct net_device *dev)
 	b44_readphy(bp, MII_BMCR, &bmcr);
 	b44_readphy(bp, MII_BMCR, &bmcr);
 	r = -EINVAL;
-	if (bmcr & BMCR_ANENABLE) {
-		b44_writephy(bp, MII_BMCR,
-			     bmcr | BMCR_ANRESTART);
-		r = 0;
-	}
+	if (bmcr & BMCR_ANENABLE)
+		r = b44_writephy(bp, MII_BMCR,
+				 bmcr | BMCR_ANRESTART);
 	spin_unlock_irq(&bp->lock);
 
 	return r;
-- 
2.40.1



