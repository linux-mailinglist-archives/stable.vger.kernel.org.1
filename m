Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602B87551FB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjGPUCZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGPUCY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:02:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9708B9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C34960EAA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2B5C433C7;
        Sun, 16 Jul 2023 20:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537742;
        bh=SjPg8PdkZRvY3H5LtwZdxgA3zmBrfsUx3KawS2NBjJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHZJxHcqh0qdEqV+vtjF9HesN+vS4dMlMh+zryQae/1sDvDZ5EMJ3ncKIxX6qoWUc
         wDfXd8H/9vUiwpCAPeheDgYgSVy5qynIwGPNxWpHVIazgAt6BgyLgjFlbPL9sN5Eno
         maXDHLvdgcAvP1WkCvR0JBT2ZQ+HQkuPHYHDj+sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Simon Horman <simon.horman@corigine.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 177/800] wifi: mac80211: Remove "Missing iftype sband data/EHT cap" spam
Date:   Sun, 16 Jul 2023 21:40:30 +0200
Message-ID: <20230716194953.216715958@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

[ Upstream commit 6e21e7b8cd897193cee3c2649640efceb3004ba5 ]

In mesh mode, ieee80211_chandef_he_6ghz_oper() is called by
mesh_matches_local() for every received mesh beacon.

On a 6 GHz mesh of a HE-only phy, this spams that the hardware does not
have EHT capabilities, even if the received mesh beacon does not have an
EHT element.

Unlike HE, not supporting EHT in the 6 GHz band is not an error so do
not print anything in this case.

Fixes: 5dca295dd767 ("mac80211: Add initial support for EHT and 320 MHz channels")

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230614132648.28995-1-nicolas.cavallari@green-communications.fr
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 74bcc9590c759..4cfd6b9b705cb 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3798,10 +3798,8 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	}
 
 	eht_cap = ieee80211_get_eht_iftype_cap(sband, iftype);
-	if (!eht_cap) {
-		sdata_info(sdata, "Missing iftype sband data/EHT cap");
+	if (!eht_cap)
 		eht_oper = NULL;
-	}
 
 	he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
 
-- 
2.39.2



