Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7428B72C0F2
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbjFLKza (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjFLKzM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391A11DB3
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14290615D9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25090C4339B;
        Mon, 12 Jun 2023 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566527;
        bh=xYrM4k9eoB/5zJdDGE4BW4bvp64RREfjbXVQjbm7NVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTQtUCIgbkt8MjTmCjlUsakrGxCx8k8fzNJdBoPyJN9+iTgtNqErGhodcBbXkfgy4
         uCIbkMJyy+kdUDzNUpFKvq9qncGqoBzMuU+4FXIxfJCFRyF/nRu03nXp8XSR81VORr
         O1Lz1f4FDsmsDpG+JUe9esbFiR4dsnj0/pGJIBOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/132] wifi: mac80211: use correct iftype HE cap
Date:   Mon, 12 Jun 2023 12:26:00 +0200
Message-ID: <20230612101711.419212931@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit c37ab22bb1a43cdca8bf69cc0a22f1ccfc449e68 ]

We already check that the right iftype capa exists,
but then don't use it. Assign it to a variable so we
can actually use it, and then do that.

Fixes: bac2fd3d7534 ("mac80211: remove use of ieee80211_get_he_sta_cap()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230604120651.0e908e5c5fdd.Iac142549a6144ac949ebd116b921a59ae5282735@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/he.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 729f261520c77..0322abae08250 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,7 +3,7 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 - 2022 Intel Corporation
+ * Copyright(c) 2019 - 2023 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -114,6 +114,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct link_sta_info *link_sta)
 {
 	struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
+	const struct ieee80211_sta_he_cap *own_he_cap_ptr;
 	struct ieee80211_sta_he_cap own_he_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 he_ppe_size;
@@ -123,12 +124,16 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	memset(he_cap, 0, sizeof(*he_cap));
 
-	if (!he_cap_ie ||
-	    !ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif)))
+	if (!he_cap_ie)
 		return;
 
-	own_he_cap = sband->iftype_data->he_cap;
+	own_he_cap_ptr =
+		ieee80211_get_he_iftype_cap(sband,
+					    ieee80211_vif_type_p2p(&sdata->vif));
+	if (!own_he_cap_ptr)
+		return;
+
+	own_he_cap = *own_he_cap_ptr;
 
 	/* Make sure size is OK */
 	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap_ie_elem);
-- 
2.39.2



