Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070DE775D9A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjHILjY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjHILjY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C321FDE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2950A635EC
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B36CC433C8;
        Wed,  9 Aug 2023 11:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581162;
        bh=kXsbGSWvEqNnuhopsvjTZ44HY2fx32sg+hg9qolCsDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buTurd970l3sGshM8elaGIguFqa1iTLfGSugt+a6wKu/T7JSoAGK0JBV7sZvhIZBm
         vnMJN404c7pDm5XTJTubAj4ESkbYwBGBJ8Ssnp4KTQwq7scggBMq9B5ltTaO1busg2
         N0BwxbLAWp91O86QlS7vPnCFGMnria3nIsqHKNUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilan Peer <ilan.peer@intel.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 128/201] wifi: cfg80211: Fix return value in scan logic
Date:   Wed,  9 Aug 2023 12:42:10 +0200
Message-ID: <20230809103648.017625164@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit fd7f08d92fcd7cc3eca0dd6c853f722a4c6176df ]

The reporter noticed a warning when running iwlwifi:

WARNING: CPU: 8 PID: 659 at mm/page_alloc.c:4453 __alloc_pages+0x329/0x340

As cfg80211_parse_colocated_ap() is not expected to return a negative
value return 0 and not a negative value if cfg80211_calc_short_ssid()
fails.

Fixes: c8cb5b854b40f ("nl80211/cfg80211: support 6 GHz scanning")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217675
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230723201043.3007430-1-ilan.peer@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 671c7f83d5fc3..f59691936e5b8 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -641,7 +641,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 
 	ret = cfg80211_calc_short_ssid(ies, &ssid_elem, &s_ssid_tmp);
 	if (ret)
-		return ret;
+		return 0;
 
 	/* RNR IE may contain more than one NEIGHBOR_AP_INFO */
 	while (pos + sizeof(*ap_info) <= end) {
-- 
2.40.1



