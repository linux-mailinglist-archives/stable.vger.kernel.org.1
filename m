Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DE87551D0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGPUAa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjGPUA3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A3F1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CB6460E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5732EC433C9;
        Sun, 16 Jul 2023 20:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537627;
        bh=RxvKdJKL3vwD090Wb0vuanC4jKGji81AFXD8hyhfBWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECY4fYgWGNFPZ/k2XwGOht9ttDQ0YyKD9ppJ3o/U8I0K1MV7H8SHBn6+40qfKTZoy
         q3A8eLgHLGaNNVf5einOm7zWcw+ijbl/AyJ/3PpQoJEisnhqjTglRTdvdOSV1XXdUy
         4eJHEnsCQ/PQyfWrHJBPu3N2wHs0G6Ne3DalkA2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 146/800] wifi: iwlwifi: mvm: send time sync only if needed
Date:   Sun, 16 Jul 2023 21:39:59 +0200
Message-ID: <20230716194952.485800088@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit ead65aa2d5155728baec90f6404cd02618ef29d0 ]

If there's no peer configured then there's no point in sending
the command down to the firmware with an invalid peer address.

Fixes: cf85123a210f ("wifi: iwlwifi: mvm: support enabling and disabling HW timestamping")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230531194630.0fb9f81f1852.Idcc41b67d1fbb421e5ed9bac2177b948b7b4d1c9@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 205c09bc98634..a6367909d7fe4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1699,9 +1699,11 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		iwl_mvm_send_recovery_cmd(mvm, ERROR_RECOVERY_UPDATE_DB);
-		iwl_mvm_time_sync_config(mvm, mvm->time_sync.peer_addr,
-					 IWL_TIME_SYNC_PROTOCOL_TM |
-					 IWL_TIME_SYNC_PROTOCOL_FTM);
+
+		if (mvm->time_sync.active)
+			iwl_mvm_time_sync_config(mvm, mvm->time_sync.peer_addr,
+						 IWL_TIME_SYNC_PROTOCOL_TM |
+						 IWL_TIME_SYNC_PROTOCOL_FTM);
 	}
 
 	if (!mvm->ptp_data.ptp_clock)
-- 
2.39.2



