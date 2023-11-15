Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1DF7ECFE7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjKOTv1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjKOTvZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F785AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1240C433C8;
        Wed, 15 Nov 2023 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077882;
        bh=ghDXs4KtFFFlmQz2TzY7o44FBhB14Q/ubhg2xpvjPTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+JGXAint17FUULvKwxMQZr7+KcF9eGirk0GGZChTGOPEK63xIzooQ+SlPTWMPHyF
         U4h+zeGBOZkmCnNR0AKtXAOxP3RQF6r38+Cg4dhN0IWRmgPpz+SuzoVqsRvmgUERnB
         XrYAm+Cql2wOLlbmPsS0hSLuvsCjq8RuOKaSi+DU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Diogo Ivo <diogo.ivo@siemens.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 578/603] net: ti: icss-iep: fix setting counter value
Date:   Wed, 15 Nov 2023 14:18:43 -0500
Message-ID: <20231115191651.439283436@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diogo Ivo <diogo.ivo@siemens.com>

[ Upstream commit 83b9dda8afa4e968d9cce253f390b01c0612a2a5 ]

Currently icss_iep_set_counter() writes the upper 32-bits of the
counter value to both the lower and upper counter registers, so
fix this by writing the appropriate value to the lower register.

Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
Link: https://lore.kernel.org/r/20231107120037.1513546-1-diogo.ivo@siemens.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 4cf2a52e43783..3025e9c189702 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -177,7 +177,7 @@ static void icss_iep_set_counter(struct icss_iep *iep, u64 ns)
 	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
 		writel(upper_32_bits(ns), iep->base +
 		       iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG1]);
-	writel(upper_32_bits(ns), iep->base + iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
+	writel(lower_32_bits(ns), iep->base + iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
 }
 
 static void icss_iep_update_to_next_boundary(struct icss_iep *iep, u64 start_ns);
-- 
2.42.0



