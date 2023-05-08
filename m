Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE2C6FADFE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbjEHLkM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbjEHLjo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C45E2647F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F2563491
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8772CC433EF;
        Mon,  8 May 2023 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545978;
        bh=gG53gcjqCb0Wu6bCUVvRaqzn65iMcc4gF07snRt/dKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rg0dPMC7QxT/CGfzKB7rWVF1AdtQletNUgUyB39hAjSSZMr+t1zlbBkzoDSxHKee6
         rvaXIsMu3ibUinEr0mfxsHDBVnI9HE/5/i/ckhpjV6hm63Mb2FtANsO/i/Qb4O6w7q
         Tnw6+aCmDgg7df/84ZG7wmA0BsoaGcLIuPT8o7uI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Zolfanelli <lorenzo@zolfa.nl>
Subject: [PATCH 5.15 216/371] wifi: iwlwifi: make the loop for card preparation effective
Date:   Mon,  8 May 2023 11:46:57 +0200
Message-Id: <20230508094820.636663419@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 28965ec0b5d9112585f725660e2ff13218505ace ]

Since we didn't reset t to 0, only the first iteration of the loop
did checked the ready bit several times.
>From the second iteration and on, we just tested the bit once and
continued to the next iteration.

Reported-and-tested-by: Lorenzo Zolfanelli <lorenzo@zolfa.nl>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216452
Fixes: 289e5501c314 ("iwlwifi: fix the preparation of the card")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230416154301.615b683ab9c8.Ic52c3229d3345b0064fa34263293db095d88daf8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 02da9cc8646cf..ee325950de9d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -581,7 +581,6 @@ static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 {
 	int ret;
-	int t = 0;
 	int iter;
 
 	IWL_DEBUG_INFO(trans, "iwl_trans_prepare_card_hw enter\n");
@@ -596,6 +595,8 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 	usleep_range(1000, 2000);
 
 	for (iter = 0; iter < 10; iter++) {
+		int t = 0;
+
 		/* If HW is not ready, prepare the conditions to check again */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_PREPARE);
-- 
2.39.2



