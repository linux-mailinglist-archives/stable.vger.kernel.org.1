Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90496FAB95
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjEHLPE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjEHLPD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2673236571
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CECE62BD4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDB3C4339B;
        Mon,  8 May 2023 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544501;
        bh=Vz6FXD+nTESi9ykuQCZ8RPeDHcdB9OmyxMqaP7lU10I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y87cCIXmwoG39Vvp37JX+8LBTZxk+ZDQnRyKLjV5WBH/PWGka3ALzLSZOFePkN8AU
         8PQMjidXODK4hETLzaScTgUFWJNCEK7473TZRX1urNSOsnhinrIgr+4bbqgE9+epaV
         7KsgnCJRYr63pWCtJE2lBGuWLuC7EpXO1H+m61Zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 413/694] wifi: iwlwifi: trans: dont trigger d3 interrupt twice
Date:   Mon,  8 May 2023 11:44:08 +0200
Message-Id: <20230508094446.669006422@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit 277f56a141fc54ef7f9e09dba65fb2e12021411d ]

When the IPC registers are used for sleep control, setting
the IPC sleep bit already triggers an interrupt to the fw, so
there is no need to also set the doorbell. Setting also the
doorbell triggers the sleep interrupt twice which lead to
an assert.

Fixes: af08571d3925 ("iwlwifi: pcie: support Bz suspend/resume trigger")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230413102635.b5f2f6e44d38.I4cb5b6ad4914db47a714e731c4c8b4db679cabce@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 0a9af1ad1f206..40283fe622daa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1522,19 +1522,16 @@ static int iwl_pcie_d3_handshake(struct iwl_trans *trans, bool suspend)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
 				    suspend ? UREG_DOORBELL_TO_ISR6_SUSPEND :
 					      UREG_DOORBELL_TO_ISR6_RESUME);
-	} else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+	else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		iwl_write32(trans, CSR_IPC_SLEEP_CONTROL,
 			    suspend ? CSR_IPC_SLEEP_CONTROL_SUSPEND :
 				      CSR_IPC_SLEEP_CONTROL_RESUME);
-		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
-				    UREG_DOORBELL_TO_ISR6_SLEEP_CTRL);
-	} else {
+	else
 		return 0;
-	}
 
 	ret = wait_event_timeout(trans_pcie->sx_waitq,
 				 trans_pcie->sx_complete, 2 * HZ);
-- 
2.39.2



