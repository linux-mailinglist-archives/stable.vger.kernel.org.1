Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3770C800
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjEVTfJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjEVTfG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:35:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDF1AC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A166562970
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC528C433EF;
        Mon, 22 May 2023 19:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784011;
        bh=BOKvx4PfsewxTkFxmIG8Ji/pjMIi0eC/tBSnhigWNME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ji3FkhQVX7gbBKa3arl3gsB82AwvXQ5Els/Nx30p1NQTxbVBdVgDnHFIAtXwyk9x/
         j/5GgAyxs/BjU44tmrhjV4xYGk6SPeoJ3/+5XyvXn4s7GPE756PSbl6qj1r8ejysLM
         LuDy74EfvCOxOF59ntpXOKaEEA+zACASKZZtsaqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Lee <michael-cy.lee@mediatek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 207/292] wifi: mac80211: Abort running color change when stopping the AP
Date:   Mon, 22 May 2023 20:09:24 +0100
Message-Id: <20230522190411.133745818@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Lee <michael-cy.lee@mediatek.com>

[ Upstream commit a23d7f5b2fbda114de60c4b53311e052281d7533 ]

When stopping the AP, there might be a color change in progress. It
should be deactivated here, or the driver might later finalize a color
change on a stopped AP.

Fixes: 5f9404abdf2a (mac80211: add support for BSS color change)
Signed-off-by: Michael Lee <michael-cy.lee@mediatek.com>
Link: https://lore.kernel.org/r/20230504080441.22958-1-michael-cy.lee@mediatek.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e8beec0a0ae1c..06b9df2fbcd77 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1477,9 +1477,10 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		sdata_dereference(link->u.ap.unsol_bcast_probe_resp,
 				  sdata);
 
-	/* abort any running channel switch */
+	/* abort any running channel switch or color change */
 	mutex_lock(&local->mtx);
 	link_conf->csa_active = false;
+	link_conf->color_change_active = false;
 	if (link->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-- 
2.39.2



