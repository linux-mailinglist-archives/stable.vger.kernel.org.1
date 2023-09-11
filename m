Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC779B3B9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358006AbjIKWHR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbjIKNzn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:55:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E31FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:55:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E72C433C8;
        Mon, 11 Sep 2023 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440537;
        bh=EtCQ270Lx5fX9Ipapv/hb5GV7tKpAX8wtyiye1V0xsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmGfu4vkrCVDjbYy5l4fnw8ttuhBbf+hnj5NFU6YiJ/EKaVqNzXcvun8hsIbxQr6r
         wGFHi0qH238HjP+LEh9q+i3npik2zla3cgKXngxE+P7s/b8Fy3mdJo8HBiZMl81ceQ
         lUlqjGT1ervRuI+uKFuY9apXv51vmc1MbLHulDcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 096/739] wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH
Date:   Mon, 11 Sep 2023 15:38:15 +0200
Message-ID: <20230911134653.784519155@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 74f12d511625e603fac8c0c2b6872e687e56dd61 ]

It seems that the nla_policy in mt76_tm_policy is missed for attribute
MT76_TM_ATTR_TX_LENGTH. This patch adds the correct description to make
sure the

  u32 val = nla_get_u32(tb[MT76_TM_ATTR_TX_LENGTH]);

in function mt76_testmode_cmd() is safe and will not result in
out-of-attribute read.

Fixes: f0efa8621550 ("mt76: add API for testmode support")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/testmode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 0accc71a91c9a..4644dace9bb34 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -8,6 +8,7 @@ const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
 	[MT76_TM_ATTR_RESET] = { .type = NLA_FLAG },
 	[MT76_TM_ATTR_STATE] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_COUNT] = { .type = NLA_U32 },
+	[MT76_TM_ATTR_TX_LENGTH] = { .type = NLA_U32 },
 	[MT76_TM_ATTR_TX_RATE_MODE] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_RATE_NSS] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_RATE_IDX] = { .type = NLA_U8 },
-- 
2.40.1



