Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5E7ECB3A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjKOTVM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjKOTUx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:20:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0ED52
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:20:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D99C433CA;
        Wed, 15 Nov 2023 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076048;
        bh=D8ICyYnpwm7lKf831BIlJQ83cPW/ABzpe5kaPbqqbQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDqjzkZNWXuTfaAPTkUedCIpZGfOTeNRaUmTAw4Mc5fuJndh0QXi496JeUKyQ/81O
         rqWnxaRBjGu+XsGYqyXNGhYp3MkjIEvOuriEeT14uIuws1xtJqjZYRi29e6CXtTVr1
         l6W9rvJjSXxZqzvo+eGHO+z9YMfsJOBgeajUlePM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 043/550] wifi: mac80211: fix RCU usage warning in mesh fast-xmit
Date:   Wed, 15 Nov 2023 14:10:27 -0500
Message-ID: <20231115191603.697804202@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 5ea82df1f50e42416d0a8a7c42d37cc1df1545fe ]

In mesh_fast_tx_flush_addr() we already hold the lock, so
don't need additional hashtable RCU protection. Use the
rhashtable_lookup_fast() variant to avoid RCU protection
warnings.

Fixes: d5edb9ae8d56 ("wifi: mac80211: mesh fast xmit support")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh_pathtbl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index d32e304eeb4ba..3e52aaa57b1fc 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -648,7 +648,7 @@ void mesh_fast_tx_flush_addr(struct ieee80211_sub_if_data *sdata,
 
 	cache = &sdata->u.mesh.tx_cache;
 	spin_lock_bh(&cache->walk_lock);
-	entry = rhashtable_lookup(&cache->rht, addr, fast_tx_rht_params);
+	entry = rhashtable_lookup_fast(&cache->rht, addr, fast_tx_rht_params);
 	if (entry)
 		mesh_fast_tx_entry_free(cache, entry);
 	spin_unlock_bh(&cache->walk_lock);
-- 
2.42.0



