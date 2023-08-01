Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA9276AE14
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjHAJf4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjHAJff (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27292108
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26587614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392F4C433C8;
        Tue,  1 Aug 2023 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882424;
        bh=hLv+fj9Zoh3pP38Y3doKhgAe6T71XdS1sjd4pPeNiGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4ZAZUIqx/yqvjPLiUmfRjCjyIP5oFfDTVCNXl/ftgEhJ2WrTtW3GsDPmv8TRIDgz
         4TSz3djUd7BRtW0k/woBhX5Pn2Bf71O9SlZGdD+EoLsH0jgl/cYxvsDY0B3T3UPZrs
         uIQvtzTt2wi0mMZCoIi7uk8LWnyVxo/DPRZzW0TU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suman Ghosh <sumang@marvell.com>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 100/228] octeontx2-af: Fix hash extraction enable configuration
Date:   Tue,  1 Aug 2023 11:19:18 +0200
Message-ID: <20230801091926.436390735@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Suman Ghosh <sumang@marvell.com>

[ Upstream commit 4e62c99d71e56817c934caa2a709a775c8cee078 ]

As of today, hash extraction support is enabled for all the silicons.
Because of which we are facing initialization issues when the silicon
does not support hash extraction. During creation of the hardware
parsing table for IPv6 address, we need to consider if hash extraction
is enabled then extract only 32 bit, otherwise 128 bit needs to be
extracted. This patch fixes the issue and configures the hardware parser
based on the availability of the feature.

Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230721061222.2632521-1-sumang@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 43 ++++++++++++++++++-
 .../marvell/octeontx2/af/rvu_npc_hash.h       |  8 ++--
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index efc2e64689f7d..34fa59575fa91 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -218,13 +218,54 @@ void npc_config_secret_key(struct rvu *rvu, int blkaddr)
 
 void npc_program_mkex_hash(struct rvu *rvu, int blkaddr)
 {
+	struct npc_mcam_kex_hash *mh = rvu->kpu.mkex_hash;
 	struct hw_cap *hwcap = &rvu->hw->cap;
+	u8 intf, ld, hdr_offset, byte_len;
 	struct rvu_hwinfo *hw = rvu->hw;
-	u8 intf;
+	u64 cfg;
 
+	/* Check if hardware supports hash extraction */
 	if (!hwcap->npc_hash_extract)
 		return;
 
+	/* Check if IPv6 source/destination address
+	 * should be hash enabled.
+	 * Hashing reduces 128bit SIP/DIP fields to 32bit
+	 * so that 224 bit X2 key can be used for IPv6 based filters as well,
+	 * which in turn results in more number of MCAM entries available for
+	 * use.
+	 *
+	 * Hashing of IPV6 SIP/DIP is enabled in below scenarios
+	 * 1. If the silicon variant supports hashing feature
+	 * 2. If the number of bytes of IP addr being extracted is 4 bytes ie
+	 *    32bit. The assumption here is that if user wants 8bytes of LSB of
+	 *    IP addr or full 16 bytes then his intention is not to use 32bit
+	 *    hash.
+	 */
+	for (intf = 0; intf < hw->npc_intfs; intf++) {
+		for (ld = 0; ld < NPC_MAX_LD; ld++) {
+			cfg = rvu_read64(rvu, blkaddr,
+					 NPC_AF_INTFX_LIDX_LTX_LDX_CFG(intf,
+								       NPC_LID_LC,
+								       NPC_LT_LC_IP6,
+								       ld));
+			hdr_offset = FIELD_GET(NPC_HDR_OFFSET, cfg);
+			byte_len = FIELD_GET(NPC_BYTESM, cfg);
+			/* Hashing of IPv6 source/destination address should be
+			 * enabled if,
+			 * hdr_offset == 8 (offset of source IPv6 address) or
+			 * hdr_offset == 24 (offset of destination IPv6)
+			 * address) and the number of byte to be
+			 * extracted is 4. As per hardware configuration
+			 * byte_len should be == actual byte_len - 1.
+			 * Hence byte_len is checked against 3 but nor 4.
+			 */
+			if ((hdr_offset == 8 || hdr_offset == 24) && byte_len == 3)
+				mh->lid_lt_ld_hash_en[intf][NPC_LID_LC][NPC_LT_LC_IP6][ld] = true;
+		}
+	}
+
+	/* Update hash configuration if the field is hash enabled */
 	for (intf = 0; intf < hw->npc_intfs; intf++) {
 		npc_program_mkex_hash_rx(rvu, blkaddr, intf);
 		npc_program_mkex_hash_tx(rvu, blkaddr, intf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
index a1c3d987b8044..57a09328d46b5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
@@ -70,8 +70,8 @@ static struct npc_mcam_kex_hash npc_mkex_hash_default __maybe_unused = {
 	[NIX_INTF_RX] = {
 		[NPC_LID_LC] = {
 			[NPC_LT_LC_IP6] = {
-				true,
-				true,
+				false,
+				false,
 			},
 		},
 	},
@@ -79,8 +79,8 @@ static struct npc_mcam_kex_hash npc_mkex_hash_default __maybe_unused = {
 	[NIX_INTF_TX] = {
 		[NPC_LID_LC] = {
 			[NPC_LT_LC_IP6] = {
-				true,
-				true,
+				false,
+				false,
 			},
 		},
 	},
-- 
2.39.2



