Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6EF761638
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjGYLh0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjGYLhZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5121BEE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7013B61654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C35C433C8;
        Tue, 25 Jul 2023 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285035;
        bh=mdKo+7+TTNJbKFnWI8xBRKP0JQvRtiw0qVAAmi7uQ6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMCMZ1zx6rcWQBaWcoxiZoMZziJUMShCOWNI0xQI52h2/BppsC10Vz8ZYgP96GIHe
         hPqAdk585FRZ1LqIqL+mkG5Hrls7VS1H41+7M/yzwNH6B/mFvSE/R+u/WtUQlRxVmJ
         OHW9ipudzEZ7gPpxRMiBUGR1k0S8Sn8rNkTYgABY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 032/313] wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()
Date:   Tue, 25 Jul 2023 12:43:05 +0200
Message-ID: <20230725104522.498945373@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit d9aef04fcfa81ee4fb2804a21a3712b7bbd936af ]

The type of "mwifiex_adapter->nd_info" is "struct cfg80211_wowlan_nd_info",
not "struct cfg80211_wowlan_nd_match".

Use struct_size() to ease the computation of the needed size.

The current code over-allocates some memory, so is safe.
But it wastes 32 bytes.

Fixes: 7d7f07d8c5d3 ("mwifiex: add wowlan net-detect support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/7a6074fb056d2181e058a3cc6048d8155c20aec7.1683371982.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 629af26675cf1..1ab04adc53dcd 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2202,9 +2202,9 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 
 	if (nd_config) {
 		adapter->nd_info =
-			kzalloc(sizeof(struct cfg80211_wowlan_nd_match) +
-				sizeof(struct cfg80211_wowlan_nd_match *) *
-				scan_rsp->number_of_sets, GFP_ATOMIC);
+			kzalloc(struct_size(adapter->nd_info, matches,
+					    scan_rsp->number_of_sets),
+				GFP_ATOMIC);
 
 		if (adapter->nd_info)
 			adapter->nd_info->n_matches = scan_rsp->number_of_sets;
-- 
2.39.2



