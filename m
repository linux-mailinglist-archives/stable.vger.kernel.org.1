Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73557876D6
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbjHXRUP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242907AbjHXRUE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:20:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70AE10D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 292F867552
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC5CC433C8;
        Thu, 24 Aug 2023 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897601;
        bh=f6iiAGTMuyeIFjwpL+68Y8En2Kqrkt3aGTMEThFi0FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKsLH8CMXAAAJdy5rSyu54E8KLc2wJhc2RwDuiej80L7NYIrmhHdmkyZyQgJA7RRR
         ewyaCrL+jlivQ4dm5iHNN1Nayxo/B+XlBWk0qFJJqaHbuguDZU8DXlu3o5kb6axCs4
         19owBVmHVCYi5Tnn74pCg0tjWD9WXnCf32/EjCKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Andrii Staikov <andrii.staikov@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 090/135] i40e: fix misleading debug logs
Date:   Thu, 24 Aug 2023 19:09:22 +0200
Message-ID: <20230824170621.162760426@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Staikov <andrii.staikov@intel.com>

[ Upstream commit 2f2beb8874cb0844e84ad26e990f05f4f13ff63f ]

Change "write" into the actual "read" word.
Change parameters description.

Fixes: 7073f46e443e ("i40e: Add AQ commands for NVM Update for X722")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 7164f4ad81202..6b1996451a4bd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -210,11 +210,11 @@ static i40e_status i40e_read_nvm_word_srctl(struct i40e_hw *hw, u16 offset,
  * @hw: pointer to the HW structure.
  * @module_pointer: module pointer location in words from the NVM beginning
  * @offset: offset in words from module start
- * @words: number of words to write
- * @data: buffer with words to write to the Shadow RAM
+ * @words: number of words to read
+ * @data: buffer with words to read to the Shadow RAM
  * @last_command: tells the AdminQ that this is the last command
  *
- * Writes a 16 bit words buffer to the Shadow RAM using the admin command.
+ * Reads a 16 bit words buffer to the Shadow RAM using the admin command.
  **/
 static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw,
 				    u8 module_pointer, u32 offset,
@@ -234,18 +234,18 @@ static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw,
 	 */
 	if ((offset + words) > hw->nvm.sr_size)
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: offset %d beyond Shadow RAM limit %d\n",
+			   "NVM read error: offset %d beyond Shadow RAM limit %d\n",
 			   (offset + words), hw->nvm.sr_size);
 	else if (words > I40E_SR_SECTOR_SIZE_IN_WORDS)
-		/* We can write only up to 4KB (one sector), in one AQ write */
+		/* We can read only up to 4KB (one sector), in one AQ write */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write fail error: tried to write %d words, limit is %d.\n",
+			   "NVM read fail error: tried to read %d words, limit is %d.\n",
 			   words, I40E_SR_SECTOR_SIZE_IN_WORDS);
 	else if (((offset + (words - 1)) / I40E_SR_SECTOR_SIZE_IN_WORDS)
 		 != (offset / I40E_SR_SECTOR_SIZE_IN_WORDS))
-		/* A single write cannot spread over two sectors */
+		/* A single read cannot spread over two sectors */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: cannot spread over two sectors in a single write offset=%d words=%d\n",
+			   "NVM read error: cannot spread over two sectors in a single read offset=%d words=%d\n",
 			   offset, words);
 	else
 		ret_code = i40e_aq_read_nvm(hw, module_pointer,
-- 
2.40.1



