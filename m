Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB3E775A8D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjHILJb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjHILJb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E132ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02EDA6314B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B28FC433C8;
        Wed,  9 Aug 2023 11:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579369;
        bh=BrVKPDOtDd7ao1urvGV/fU0cRvUaqDpCMbtBCabua+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StLLmANGJvabl6QWWknzOPTJcYn7vYhO9puvfl7soCbUVcjB+ejZZzs6czI3fYu9G
         T6laGLxmB+wZNbN9tI7zRbIlhJEAOY2S9OjDwk9C520eJ/ywXtUCArmtyNrvV5AdcO
         0L7v5bf+Tz+X3v64skpALl+ti/ffSs/HCCdPl8Gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tanmay Patil <t-patil@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 140/204] net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()
Date:   Wed,  9 Aug 2023 12:41:18 +0200
Message-ID: <20230809103647.274645366@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index ddd43e09111e2..d9db5c23a9639 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -67,23 +67,37 @@
 
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



