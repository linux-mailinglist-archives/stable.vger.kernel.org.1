Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A216FA824
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjEHKhv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjEHKhn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:37:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537DD28930
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEECA627EE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5403C433D2;
        Mon,  8 May 2023 10:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542261;
        bh=POKbqvt9fvc6l7RP4ZCjGBg8ML0uBWcn0rP1sofmOEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfFMcaTEw5/pcRvhh+aDfneV6eynI2r+3FBZ0XM6ywFaoXBqYNQ4pntOuyXXQnkRS
         AnvpFz7y8r2cS1Tg8DOGUjmL7xNl1JqMs+y1ZpQOA2r732qalDDRl6mAjGTClKJ69+
         GLpY7dzPNjJveJD9BtJgIMTNhbrxoK4uMs/0MiQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 377/663] wifi: iwlwifi: mvm: dont drop unencrypted MCAST frames
Date:   Mon,  8 May 2023 11:43:23 +0200
Message-Id: <20230508094440.348337887@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Ayala Beker <ayala.beker@intel.com>

[ Upstream commit 8e5a26360cbe29b896b6758518280d41c3704d43 ]

MCAST frames are filtered out by the driver if we are not
authorized yet.
Fix it to filter out only protected frames.

Fixes: 147eb05f24e6 ("iwlwifi: mvm: always tell the firmware to accept MCAST frames in BSS")
Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230413213309.9cedcc27db60.I8fb7057981392660da482dd215e85c15946d3f4b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 49ca1e168fc5b..eee98cebbb46a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -384,9 +384,10 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		 * Don't even try to decrypt a MCAST frame that was received
 		 * before the managed vif is authorized, we'd fail anyway.
 		 */
-		if (vif->type == NL80211_IFTYPE_STATION &&
+		if (is_multicast_ether_addr(hdr->addr1) &&
+		    vif->type == NL80211_IFTYPE_STATION &&
 		    !mvmvif->authorized &&
-		    is_multicast_ether_addr(hdr->addr1)) {
+		    ieee80211_has_protected(hdr->frame_control)) {
 			IWL_DEBUG_DROP(mvm, "MCAST before the vif is authorized\n");
 			kfree_skb(skb);
 			rcu_read_unlock();
-- 
2.39.2



