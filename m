Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB13F7612D1
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjGYLFp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjGYLFa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4172730EB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB05561681
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A82C433C8;
        Tue, 25 Jul 2023 11:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283005;
        bh=7Aqdfft26SAgUbG2cQaETBdwcUJXP6+QPqFdd7U2Rkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okPtYFEvPbXuYMMm8QcEE3efRX3ItxkROr1Nqkq0dbG65R6D6zAodnG9mJ9uQk0K7
         ws5zSvoxjkghw9rzDib9XrdijAnRKXVZTSRW7T1oeyJqtFAW/rj41kte9sMxbNa9Ac
         G0WfBtpq0iGPofJVRHAkqQQGsCr89tyxA9VqNdGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tanmay Patil <t-patil@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 105/183] net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()
Date:   Tue, 25 Jul 2023 12:45:33 +0200
Message-ID: <20230725104511.721694197@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tanmay Patil <t-patil@ti.com>

[ Upstream commit b685f1a58956fa36cc01123f253351b25bfacfda ]

CPSW ALE has 75 bit ALE entries which are stored within three 32 bit words.
The cpsw_ale_get_field() and cpsw_ale_set_field() functions assume that the
field will be strictly contained within one word. However, this is not
guaranteed to be the case and it is possible for ALE field entries to span
across up to two words at the most.

Fix the methods to handle getting/setting fields spanning up to two words.

Fixes: db82173f23c5 ("netdev: driver: ethernet: add cpsw address lookup engine support")
Signed-off-by: Tanmay Patil <t-patil@ti.com>
[s-vadapalli@ti.com: rephrased commit message and added Fixes tag]
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 231370e9a8017..2647c18d40d95 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -106,23 +106,37 @@ struct cpsw_ale_dev_id {
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx;
+	int idx, idx2;
+	u32 hi_val = 0;
 
 	idx    = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be fetched exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
-	return (ale_entry[idx] >> start) & BITMASK(bits);
+	return (hi_val + (ale_entry[idx] >> start)) & BITMASK(bits);
 }
 
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx;
+	int idx, idx2;
 
 	value &= BITMASK(bits);
-	idx    = start / 32;
+	idx = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be set exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+	}
 	start -= idx * 32;
-	idx    = 2 - idx; /* flip */
+	idx = 2 - idx; /* flip */
 	ale_entry[idx] &= ~(BITMASK(bits) << start);
 	ale_entry[idx] |=  (value << start);
 }
-- 
2.39.2



