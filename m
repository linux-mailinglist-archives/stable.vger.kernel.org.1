Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E336FADF9
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbjEHLkJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjEHLjh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:39:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42693F2D1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B1563448
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B5DC4339B;
        Mon,  8 May 2023 11:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545962;
        bh=KMOtky+437wF3UKERJj8E3iSJeckzTsgNhx29VbAcLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jarDVQAkWjp9wnHKo8NSnL4Kz6O0lCAd9zqKk4exnrDQ6hwrDHnSklrIZpwqolHDq
         c0E2jMFbBIitlZq2yoo3Keh5yzgq/hd8Nsz17N/3r85L62lMZwA3jFzHixzmbnCeuT
         KS0YkII3AX0f3L6tSrDl5DSYIKSCo+nhtFq871WU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 211/371] wifi: iwlwifi: yoyo: skip dump correctly on hw error
Date:   Mon,  8 May 2023 11:46:52 +0200
Message-Id: <20230508094820.435712996@linuxfoundation.org>
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

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit 11195ab0d6f3202cf7af1a4c69570f59c377d8ad ]

When NIC is in a bad state, reading data will return 28 bits as
0xa5a5a5a and the lowest 4 bits are not fixed value.

Mask these bits in a few places to skip the dump correctly.

Fixes: 89639e06d0f3 ("iwlwifi: yoyo: support for new DBGI_SRAM region")
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230413213309.df6c0663179d.I36d8487b2419c6fefa65e5514855d94327c3b1eb@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index b00cf92c8965a..69616a2868bb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1022,7 +1022,7 @@ iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 	range->range_data_size = reg->dev_addr.size;
 	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
 		prph_val = iwl_read_prph(fwrt->trans, addr + i);
-		if (prph_val == 0x5a5a5a5a)
+		if ((prph_val & ~0xf) == 0xa5a5a5a0)
 			return -EBUSY;
 		*val++ = cpu_to_le32(prph_val);
 	}
@@ -1536,7 +1536,7 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 		prph_data = iwl_read_prph(fwrt->trans, (i % 2) ?
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_LSB);
-		if (prph_data == 0x5a5a5a5a) {
+		if ((prph_data & ~0xf) == 0xa5a5a5a0) {
 			iwl_trans_release_nic_access(fwrt->trans);
 			return -EBUSY;
 		}
-- 
2.39.2



