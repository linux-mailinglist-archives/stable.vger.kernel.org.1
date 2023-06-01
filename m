Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE3719E13
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjFAN3E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjFAN2g (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA918E49
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7581D644E5
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B66C433EF;
        Thu,  1 Jun 2023 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626095;
        bh=yoZPY05x3K3NZpsJOuwwLFvB3q17fniQU1wJlokk1KM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXYdFueXkui1VXTd+geJCZtZmQrGucYV2tjCUtnTWkE5+LTRRUg+7i96De+kPfZBk
         pNakYXj0as7L0AeM8fTPSc3P3PhLkGb2jhUQFMgmMq7WIQdsAduOYKOPxgRjxhEUOr
         u5cduBASvCdJXBlyUWCjhs51rI/m1JrTNh28f58s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 29/42] wifi: iwlwifi: mvm: fix potential memory leak
Date:   Thu,  1 Jun 2023 14:21:38 +0100
Message-Id: <20230601131940.326078748@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 457d7fb03e6c3d73fbb509bd85fc4b02d1ab405e ]

If we do get multiple notifications from firmware, then
we might have allocated 'notif', but don't free it. Fix
that by checking for duplicates before allocation.

Fixes: 4da46a06d443 ("wifi: iwlwifi: mvm: Add support for wowlan info notification")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230418122405.116758321cc4.I8bdbcbb38c89ac637eaa20dda58fa9165b25893a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 0253dedb9b71a..c876e81437fee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2714,6 +2714,13 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 	case WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION): {
 		struct iwl_wowlan_info_notif *notif;
 
+		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_INFO) {
+			/* We might get two notifications due to dual bss */
+			IWL_DEBUG_WOWLAN(mvm,
+					 "Got additional wowlan info notification\n");
+			break;
+		}
+
 		if (wowlan_info_ver < 2) {
 			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
 
@@ -2732,13 +2739,6 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 			notif = (void *)pkt->data;
 		}
 
-		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_INFO) {
-			/* We might get two notifications due to dual bss */
-			IWL_DEBUG_WOWLAN(mvm,
-					 "Got additional wowlan info notification\n");
-			break;
-		}
-
 		d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_INFO;
 		len = iwl_rx_packet_payload_len(pkt);
 		iwl_mvm_parse_wowlan_info_notif(mvm, notif, d3_data->status,
-- 
2.39.2



