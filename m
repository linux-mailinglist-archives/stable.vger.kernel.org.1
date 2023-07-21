Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5249375CDF3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGUQQR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjGUQPs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E253C26
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1362C61D2A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D27C433C9;
        Fri, 21 Jul 2023 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956108;
        bh=k94FU4zggxS/Icrp7ag8aFDkwB8YTvGxXKA/VDmBQqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgB+/ReZelZVbc+DvFGVXX50YzdypAGY8oNf3qk9YHZDF3yHqlahMmKZ8yqTWtSXH
         vkeLq7jir5+8flGcbiWcTzVfQ6oFazTuPgWMbuMOtCcwacIfavmPF4mfE/A0MKTs8K
         Jx0mDCy/knBaOO3XmtH42ZxZ0fk8RIQhJNM8iqYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiawen Wu <jiawenwu@trustnetic.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 103/292] net: txgbe: fix eeprom calculation error
Date:   Fri, 21 Jul 2023 18:03:32 +0200
Message-ID: <20230721160533.217431226@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiawen Wu <jiawenwu@trustnetic.com>

[ Upstream commit aa846677a9fb19a0f2c58154c140398aa92a87ba ]

For some device types like TXGBE_ID_XAUI, *checksum computed in
txgbe_calc_eeprom_checksum() is larger than TXGBE_EEPROM_SUM. Remove the
limit on the size of *checksum.

Fixes: 049fe5365324 ("net: txgbe: Add operations to interact with firmware")
Fixes: 5e2ea7801fac ("net: txgbe: Fix unsigned comparison to zero in txgbe_calc_eeprom_checksum()")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Link: https://lore.kernel.org/r/20230711063414.3311-1-jiawenwu@trustnetic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index ebc46f3be0569..fc37af2e71ffc 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -196,9 +196,6 @@ static int txgbe_calc_eeprom_checksum(struct wx *wx, u16 *checksum)
 	if (eeprom_ptrs)
 		kvfree(eeprom_ptrs);
 
-	if (*checksum > TXGBE_EEPROM_SUM)
-		return -EINVAL;
-
 	*checksum = TXGBE_EEPROM_SUM - *checksum;
 
 	return 0;
-- 
2.39.2



