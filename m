Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5D73E7CF
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjFZSTO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjFZSTJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0735610CB
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9961F60F39
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A802FC433C0;
        Mon, 26 Jun 2023 18:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803548;
        bh=L+4/jXpgVXLoejmE/s8K69GuiFib2xP2AzggdEype/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5NMVBbE7mUPjOI05jIjurh74AfACTVDn/voBnIovcVMJegI7j9bKt55nt5zodfKH
         5ccSK880MlbyQ0/KBjidEsQNsr+WV2lKk+QjfOGu0eYfc5NtHh+xQ1d5OFQsxrw72m
         +sKOzgcPGoekcTOKLGCh01P4Ik6FfsAZK9hzlAVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Aring <aahringo@redhat.com>,
        Chen Aotian <chenaotian2@163.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 099/199] ieee802154: hwsim: Fix possible memory leaks
Date:   Mon, 26 Jun 2023 20:10:05 +0200
Message-ID: <20230626180809.971050089@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Chen Aotian <chenaotian2@163.com>

[ Upstream commit a61675294735570daca3779bd1dbb3715f7232bd ]

After replacing e->info, it is necessary to free the old einfo.

Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Chen Aotian <chenaotian2@163.com>
Link: https://lore.kernel.org/r/20230409022048.61223-1-chenaotian2@163.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 8445c2189d116..31cba9aa76366 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -685,7 +685,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, struct genl_info *info)
 static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 {
 	struct nlattr *edge_attrs[MAC802154_HWSIM_EDGE_ATTR_MAX + 1];
-	struct hwsim_edge_info *einfo;
+	struct hwsim_edge_info *einfo, *einfo_old;
 	struct hwsim_phy *phy_v0;
 	struct hwsim_edge *e;
 	u32 v0, v1;
@@ -723,8 +723,10 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	list_for_each_entry_rcu(e, &phy_v0->edges, list) {
 		if (e->endpoint->idx == v1) {
 			einfo->lqi = lqi;
-			rcu_assign_pointer(e->info, einfo);
+			einfo_old = rcu_replace_pointer(e->info, einfo,
+							lockdep_is_held(&hwsim_phys_lock));
 			rcu_read_unlock();
+			kfree_rcu(einfo_old, rcu);
 			mutex_unlock(&hwsim_phys_lock);
 			return 0;
 		}
-- 
2.39.2



