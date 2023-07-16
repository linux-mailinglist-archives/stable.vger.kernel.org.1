Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C61755201
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGPUCm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjGPUCl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAFFFD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:02:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA4A760EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D85C433C8;
        Sun, 16 Jul 2023 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537759;
        bh=M7ASOLJ764P1fQuqBmKF2Bcs/nYFjGOOVTvH1vW/aBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2kxpdWhu0I4XrA5XdSo/Ak/G1vpAwbv4Ur07tfZiLcfnrcYcEFmSAZwhHlycb5yOB
         8/czs2e0Oghf5q/L8ZhlzDjbzOk49PUtjDfDdDcczcdBvQCBcFW4UA12tH4BzkJwA5
         iW50TjBbhYPsAYAyeuiStIN/BZESB3yVmpj9yof8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 181/800] wifi: ieee80211: Fix the common size calculation for reconfiguration ML
Date:   Sun, 16 Jul 2023 21:40:34 +0200
Message-ID: <20230716194953.308093723@linuxfoundation.org>
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

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit ce6e1f600b0cfc563a7d607de702262a58cd835d ]

The common information length is found in the first octet of the common
information.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230618214435.3c7ed4817338.I42ef706cb827b4dade6e4ffbb6e7f341eaccd398@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ieee80211.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 141c0cf65f2d9..4cda32ac3116a 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4612,15 +4612,12 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 	case IEEE80211_ML_CONTROL_TYPE_BASIC:
 	case IEEE80211_ML_CONTROL_TYPE_PREQ:
 	case IEEE80211_ML_CONTROL_TYPE_TDLS:
+	case IEEE80211_ML_CONTROL_TYPE_RECONF:
 		/*
 		 * The length is the first octet pointed by mle->variable so no
 		 * need to add anything
 		 */
 		break;
-	case IEEE80211_ML_CONTROL_TYPE_RECONF:
-		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
-			common += ETH_ALEN;
-		return common;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		if (control & IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR)
 			common += ETH_ALEN;
-- 
2.39.2



