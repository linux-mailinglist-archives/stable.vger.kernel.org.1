Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4317551D4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGPUAi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjGPUAh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B342F1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDAC560E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCACEC433C8;
        Sun, 16 Jul 2023 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537636;
        bh=hK3PhZbMy8cFByA6JhpnJEF+lN1/DWhxonLZYMQHvqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9NYnQLz5ChjY66CDczldsaYPs5EJj2Xq2+SSP7ZJt2h0GtldFI8FL3/o/E0pxTfj
         zDxtE3d/M5EQja9c8A1d1O7YQ/M2bLccNnl+4ky5u+STCMfA62bkL6JuEe3rezgFcn
         B43TpysWgBlam84KDpbf5bXI7HTE1zg2BENXBj74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 166/800] wifi: iwlwifi: fw: print PC register value instead of address
Date:   Sun, 16 Jul 2023 21:40:19 +0200
Message-ID: <20230716194952.964928846@linuxfoundation.org>
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

[ Upstream commit 2b69d242e29b891b11f1190201f4a08abb0c8342 ]

The program counter address is read from the TLV and
PC address is printed in debug messages.
Read the value at PC address and print the value
instead of the register address.

Fixes: 5e31b3df86ec ("wifi: iwlwifi: dbg: print pc register data once fw dump occurred")
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230612184434.e5a5f18f1b2c.Ib6117a4e7f66a075913241cc81477c0059953d5d@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index f86f7b4baa181..f61f1ce7fe795 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -507,11 +507,16 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 	iwl_fwrt_dump_fseq_regs(fwrt);
 	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		pc_data = fwrt->trans->dbg.pc_data;
+
+		if (!iwl_trans_grab_nic_access(fwrt->trans))
+			return;
 		for (count = 0; count < fwrt->trans->dbg.num_pc;
 		     count++, pc_data++)
 			IWL_ERR(fwrt, "%s: 0x%x\n",
 				pc_data->pc_name,
-				pc_data->pc_address);
+				iwl_read_prph_no_grab(fwrt->trans,
+						      pc_data->pc_address));
+		iwl_trans_release_nic_access(fwrt->trans);
 	}
 
 	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-- 
2.39.2



