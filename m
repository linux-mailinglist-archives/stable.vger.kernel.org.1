Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3123570C99D
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjEVTu1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjEVTtt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB2195
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3183A62AE2
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A9FC433D2;
        Mon, 22 May 2023 19:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784987;
        bh=xm6ICD0FF6NHE4iEPhjR4F+YtxIMnf0M8iF1ugMqSuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=diW1ROTLsCk5t66+yn04Kc2rA8lMIt2CIBMFTCF3jc3CBcgEKWGXIk2EpSR2lX2QX
         EX49+2eNw7kdj8z4EyJ4Wch/yQVIYIRvvgUwYCzb3Rqm/zaGGXNa2DAzyfcgPS6SIT
         vIc70bMzJY+XizmaA3RwsQYw28rAJVgySF2hVvKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Lee <michael-cy.lee@mediatek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 270/364] wifi: mac80211: Abort running color change when stopping the AP
Date:   Mon, 22 May 2023 20:09:35 +0100
Message-Id: <20230522190419.465249745@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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
index fb8d80ebe8bbb..5ddbe0c8cfaa1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1512,9 +1512,10 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
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



