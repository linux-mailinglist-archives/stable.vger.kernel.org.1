Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46787713D63
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjE1TYw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjE1TYv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:24:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483A0A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D20E961BDF
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02D6C433D2;
        Sun, 28 May 2023 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301889;
        bh=ClCP30ritdjQUfuEBKlxvYgyYcUAhs0rUdyEIW3NyMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQl7NHMKQGx4W53xWjSbB4YgKFkBXJyQ8qk4rhOrZ6Xe+nGvQRv0HHNyCziYQYbbK
         HjR3QN8fqYF2+W0nsKXNiwypKDkEhRLKd4oRiLfL1r2fNyua9Ho9Gp2iiQ7sX0bSbU
         0iPlvK6TrabtKWPhQ0ROm9AsDAaiCKZelwQ9JQBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 077/161] wifi: iwlwifi: mvm: dont trust firmware n_channels
Date:   Sun, 28 May 2023 20:10:01 +0100
Message-Id: <20230528190839.595788427@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 682b6dc29d98e857e6ca4bbc077c7dc2899b7473 ]

If the firmware sends us a corrupted MCC response with
n_channels much larger than the command response can be,
we might copy far too much (uninitialized) memory and
even crash if the n_channels is large enough to make it
run out of the one page allocated for the FW response.

Fix that by checking the lengths. Doing a < comparison
would be sufficient, but the firmware should be doing
it correctly, so check more strictly.

Fixes: dcaf9f5ecb6f ("iwlwifi: mvm: add MCC update FW API")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230514120631.d7b233139eb4.I51fd319df8e9d41881fc8450e83d78049518a79a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index f49887379c43f..f485c0dd75d60 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -508,6 +508,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		struct iwl_mcc_update_resp *mcc_resp = (void *)pkt->data;
 
 		n_channels =  __le32_to_cpu(mcc_resp->n_channels);
+		if (iwl_rx_packet_payload_len(pkt) !=
+		    struct_size(mcc_resp, channels, n_channels)) {
+			resp_cp = ERR_PTR(-EINVAL);
+			goto exit;
+		}
 		resp_len = sizeof(struct iwl_mcc_update_resp) +
 			   n_channels * sizeof(__le32);
 		resp_cp = kmemdup(mcc_resp, resp_len, GFP_KERNEL);
@@ -519,6 +524,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		struct iwl_mcc_update_resp_v3 *mcc_resp_v3 = (void *)pkt->data;
 
 		n_channels =  __le32_to_cpu(mcc_resp_v3->n_channels);
+		if (iwl_rx_packet_payload_len(pkt) !=
+		    struct_size(mcc_resp_v3, channels, n_channels)) {
+			resp_cp = ERR_PTR(-EINVAL);
+			goto exit;
+		}
 		resp_len = sizeof(struct iwl_mcc_update_resp) +
 			   n_channels * sizeof(__le32);
 		resp_cp = kzalloc(resp_len, GFP_KERNEL);
-- 
2.39.2



