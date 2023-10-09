Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFECA7BDF04
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376545AbjJINZc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376592AbjJINZb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:25:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3E399
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:25:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03607C433C7;
        Mon,  9 Oct 2023 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857928;
        bh=oOnyU8llnZBlNbLzHUs58/br9RMiBUM2iHBTLjbPCfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6z13L9RHtj+nj5UOYt/4xFzQijzqi5uqMOcrIXxTB851y6cS/OICSg4RLkFXEjRr
         iEKqC7vm8ZDWOx3QbaoiUsMSB3cFs+kzbDD12RdrKFLTn88rjWiMViKtfgH9UuLfFg
         SgVxjKdZ4Q07hyiuLjOK2yy695VMFbzNLB7T/LOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 30/75] wifi: iwlwifi: dbg_ini: fix structure packing
Date:   Mon,  9 Oct 2023 15:01:52 +0200
Message-ID: <20231009130112.280343170@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 424c82e8ad56756bb98b08268ffcf68d12d183eb ]

The iwl_fw_ini_error_dump_range structure has conflicting alignment
requirements for the inner union and the outer struct:

In file included from drivers/net/wireless/intel/iwlwifi/fw/dbg.c:9:
drivers/net/wireless/intel/iwlwifi/fw/error-dump.h:312:2: error: field  within 'struct iwl_fw_ini_error_dump_range' is less aligned than 'union iwl_fw_ini_error_dump_range::(anonymous at drivers/net/wireless/intel/iwlwifi/fw/error-dump.h:312:2)' and is usually due to 'struct iwl_fw_ini_error_dump_range' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
        union {

As the original intention was apparently to make the entire structure
unaligned, mark the innermost members the same way so the union
becomes packed as well.

Fixes: 973193554cae6 ("iwlwifi: dbg_ini: dump headers cleanup")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230616090343.2454061-1-arnd@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 521ca2bb0e928..2cdc3caf7740d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -277,9 +277,9 @@ struct iwl_fw_ini_fifo_hdr {
 struct iwl_fw_ini_error_dump_range {
 	__le32 range_data_size;
 	union {
-		__le32 internal_base_addr;
-		__le64 dram_base_addr;
-		__le32 page_num;
+		__le32 internal_base_addr __packed;
+		__le64 dram_base_addr __packed;
+		__le32 page_num __packed;
 		struct iwl_fw_ini_fifo_hdr fifo_hdr;
 		struct iwl_cmd_header fw_pkt_hdr;
 	};
-- 
2.40.1



