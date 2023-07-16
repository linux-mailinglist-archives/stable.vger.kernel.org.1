Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC57551D3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGPUAg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjGPUAf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63371F1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01BE260E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA03C433C7;
        Sun, 16 Jul 2023 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537633;
        bh=J5Bzcrh6i5IMS2a+emzyTRQYnG4sHVRJCtVem2QY/34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJ5A4PBNwiB6DqOhpu8pVNXzkiWuQRp0eQ3EHK6ZAVuoQBzF41a25fTaNvvwk4SxX
         5n0erYzvWs5uo6laSWML0g0hVFIOi+KV+gp7WdlxRdlp4euyGnNKxhTn5hLQOC0KJd
         fvwv05FJixI+eu0zvLcCPlupILLjj8V74ooa6iqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 165/800] wifi: iwlwifi: mvm: Handle return value for iwl_mvm_sta_init
Date:   Sun, 16 Jul 2023 21:40:18 +0200
Message-ID: <20230716194952.941928083@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

[ Upstream commit 8d507812cb4bb3c3b05404a7dda70b32a1fc1324 ]

sta_init function can fail and if it returns an error then
driver should not send the request to fw to add a station.

Fixes: 69aef848052b ("wifi: iwlwifi: mvm: refactor iwl_mvm_add_sta(), iwl_mvm_rm_sta()")
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230612184434.1ecd293539e8.I5ec6aab387bb2fe743a7402581beaeb9c801d31f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 05a54a69c1357..b85e363544f8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1859,6 +1859,8 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 
 	ret = iwl_mvm_sta_init(mvm, vif, sta, sta_id,
 			       sta->tdls ? IWL_STA_TDLS_LINK : IWL_STA_LINK);
+	if (ret)
+		goto err;
 
 update_fw:
 	ret = iwl_mvm_sta_send_to_fw(mvm, sta, sta_update, sta_flags);
-- 
2.39.2



