Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADCF7BDD99
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376806AbjJINLG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376841AbjJINKl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:10:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC302113
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:10:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB01C433C8;
        Mon,  9 Oct 2023 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857022;
        bh=8w/o176i7s7SQ5JcxR+9Ef4d1zPMIEfN0MUlWDDJ1yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJHTJBhFyioOkxsuq0HG1PAzSkvGJ9GAT+wxnV006mU6ZMggX20mVflgH15mepZpT
         SHHmJ9ONynBARm70RIxRN1zHN+VtJY3s6sFQCSuFYh6b+J8/1B8FxMUbmYElCShK9w
         Q+NOuKbsNr18lvSzurb5iZPWJ5oVG2LKkoP6fDZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 062/163] wifi: iwlwifi: dbg_ini: fix structure packing
Date:   Mon,  9 Oct 2023 15:00:26 +0200
Message-ID: <20231009130125.751217510@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index f5e08988dc7bf..06d6f7f664308 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -310,9 +310,9 @@ struct iwl_fw_ini_fifo_hdr {
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



