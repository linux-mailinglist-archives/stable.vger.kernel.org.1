Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAB9713F5D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjE1Toj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjE1Toi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C377B9B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FEF61F30
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754CEC433D2;
        Sun, 28 May 2023 19:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303076;
        bh=SfYwJLQS5Atb8CCp+ewm8+z+6A2CBaeyiBc9WsAITs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H84JmAZxCVFaSFu83tD1k7pahfIL6ItPLH1oxjtaUMUDkAnmk2qEOeYUyKdm8jxsz
         7BwzxMSzb1GM732NToLGfzxvUb+YEgnKEnNbPPQLDHahL+PEHzEFRKCkpU7Y7QKOOr
         ler0JM0zy42GcZURcc4vol0yVJ+7Z0jSV06C7SDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 116/211] wifi: iwlwifi: mvm: dont trust firmware n_channels
Date:   Sun, 28 May 2023 20:10:37 +0100
Message-Id: <20230528190846.445022293@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
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
index 60296a754af26..34be3f75c2e96 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -502,6 +502,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
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
@@ -513,6 +518,11 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
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



