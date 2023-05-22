Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8B70C6A2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjEVTU0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjEVTU0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956B93
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EFC56281C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F8DC433D2;
        Mon, 22 May 2023 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783224;
        bh=sN4OxucnleR66JiVPoR7GEFHfJLRIGgmiM5R53EPTCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yZOPFx3UYy4CIQNFpipuJNJ2Jpf8XSNzUFIGWrXyWc+9s4gRR6VyrrP74Ud3fusFV
         1Z6kZKXYylw0oHy/9ux5gH/RzbTOdeHDV/R4ied3lrmkt0EWIEn5VMukKxXY8RUu4t
         iT2BvkyoOS0Da/HcRVk98XZNCWOGodvpqduJS2ow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 152/203] wifi: iwlwifi: mvm: dont trust firmware n_channels
Date:   Mon, 22 May 2023 20:09:36 +0100
Message-Id: <20230522190359.185452890@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index da705fcaf0fcc..8a9732b5b9652 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -445,6 +445,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
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
@@ -456,6 +461,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
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



