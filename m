Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0826FA64A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjEHKSH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjEHKR6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:17:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286C0D2FA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00A16624A0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE5C433D2;
        Mon,  8 May 2023 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541074;
        bh=V3le+qVrWxpVBhfvah3fhqSvZ1G7EY9kYVojJjE3teE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTmF4WpaRBsfKNph55XbX/6MYu8qUDrZRJhoJx2PuyHtIFgMb/ABKYp3s7w9wsUeF
         dGTcqDBEfDumAMd7p1dN6LF9KqA1SxvmDYYlQMmdV6NIZkz7KvFvxKRjwzdgxdOZia
         2Prkxfh06g43AFQ8F5Ein6xzg/ifmzzYMbJ9Bp8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Sokolowski <jan.sokolowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Gurucharan G <gurucharanx.g@intel.com>
Subject: [PATCH 6.1 606/611] i40e: Remove unused i40e status codes
Date:   Mon,  8 May 2023 11:47:28 +0200
Message-Id: <20230508094441.601920865@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jan Sokolowski <jan.sokolowski@intel.com>

commit 9d135352bb5d885a7b21417103423301a40c1b8b upstream.

In an effort to remove i40e status codes and replace them
with standard kernel errornums, unused values of i40e_status_code
were removed.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c |   70 --------------------------
 drivers/net/ethernet/intel/i40e/i40e_status.h |   35 -------------
 2 files changed, 105 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -138,106 +138,40 @@ const char *i40e_stat_str(struct i40e_hw
 		return "I40E_ERR_NVM";
 	case I40E_ERR_NVM_CHECKSUM:
 		return "I40E_ERR_NVM_CHECKSUM";
-	case I40E_ERR_PHY:
-		return "I40E_ERR_PHY";
 	case I40E_ERR_CONFIG:
 		return "I40E_ERR_CONFIG";
 	case I40E_ERR_PARAM:
 		return "I40E_ERR_PARAM";
-	case I40E_ERR_MAC_TYPE:
-		return "I40E_ERR_MAC_TYPE";
 	case I40E_ERR_UNKNOWN_PHY:
 		return "I40E_ERR_UNKNOWN_PHY";
-	case I40E_ERR_LINK_SETUP:
-		return "I40E_ERR_LINK_SETUP";
-	case I40E_ERR_ADAPTER_STOPPED:
-		return "I40E_ERR_ADAPTER_STOPPED";
 	case I40E_ERR_INVALID_MAC_ADDR:
 		return "I40E_ERR_INVALID_MAC_ADDR";
 	case I40E_ERR_DEVICE_NOT_SUPPORTED:
 		return "I40E_ERR_DEVICE_NOT_SUPPORTED";
-	case I40E_ERR_PRIMARY_REQUESTS_PENDING:
-		return "I40E_ERR_PRIMARY_REQUESTS_PENDING";
-	case I40E_ERR_INVALID_LINK_SETTINGS:
-		return "I40E_ERR_INVALID_LINK_SETTINGS";
-	case I40E_ERR_AUTONEG_NOT_COMPLETE:
-		return "I40E_ERR_AUTONEG_NOT_COMPLETE";
 	case I40E_ERR_RESET_FAILED:
 		return "I40E_ERR_RESET_FAILED";
-	case I40E_ERR_SWFW_SYNC:
-		return "I40E_ERR_SWFW_SYNC";
 	case I40E_ERR_NO_AVAILABLE_VSI:
 		return "I40E_ERR_NO_AVAILABLE_VSI";
 	case I40E_ERR_NO_MEMORY:
 		return "I40E_ERR_NO_MEMORY";
 	case I40E_ERR_BAD_PTR:
 		return "I40E_ERR_BAD_PTR";
-	case I40E_ERR_RING_FULL:
-		return "I40E_ERR_RING_FULL";
-	case I40E_ERR_INVALID_PD_ID:
-		return "I40E_ERR_INVALID_PD_ID";
-	case I40E_ERR_INVALID_QP_ID:
-		return "I40E_ERR_INVALID_QP_ID";
-	case I40E_ERR_INVALID_CQ_ID:
-		return "I40E_ERR_INVALID_CQ_ID";
-	case I40E_ERR_INVALID_CEQ_ID:
-		return "I40E_ERR_INVALID_CEQ_ID";
-	case I40E_ERR_INVALID_AEQ_ID:
-		return "I40E_ERR_INVALID_AEQ_ID";
 	case I40E_ERR_INVALID_SIZE:
 		return "I40E_ERR_INVALID_SIZE";
-	case I40E_ERR_INVALID_ARP_INDEX:
-		return "I40E_ERR_INVALID_ARP_INDEX";
-	case I40E_ERR_INVALID_FPM_FUNC_ID:
-		return "I40E_ERR_INVALID_FPM_FUNC_ID";
-	case I40E_ERR_QP_INVALID_MSG_SIZE:
-		return "I40E_ERR_QP_INVALID_MSG_SIZE";
-	case I40E_ERR_QP_TOOMANY_WRS_POSTED:
-		return "I40E_ERR_QP_TOOMANY_WRS_POSTED";
-	case I40E_ERR_INVALID_FRAG_COUNT:
-		return "I40E_ERR_INVALID_FRAG_COUNT";
 	case I40E_ERR_QUEUE_EMPTY:
 		return "I40E_ERR_QUEUE_EMPTY";
-	case I40E_ERR_INVALID_ALIGNMENT:
-		return "I40E_ERR_INVALID_ALIGNMENT";
-	case I40E_ERR_FLUSHED_QUEUE:
-		return "I40E_ERR_FLUSHED_QUEUE";
-	case I40E_ERR_INVALID_PUSH_PAGE_INDEX:
-		return "I40E_ERR_INVALID_PUSH_PAGE_INDEX";
-	case I40E_ERR_INVALID_IMM_DATA_SIZE:
-		return "I40E_ERR_INVALID_IMM_DATA_SIZE";
 	case I40E_ERR_TIMEOUT:
 		return "I40E_ERR_TIMEOUT";
-	case I40E_ERR_OPCODE_MISMATCH:
-		return "I40E_ERR_OPCODE_MISMATCH";
-	case I40E_ERR_CQP_COMPL_ERROR:
-		return "I40E_ERR_CQP_COMPL_ERROR";
-	case I40E_ERR_INVALID_VF_ID:
-		return "I40E_ERR_INVALID_VF_ID";
-	case I40E_ERR_INVALID_HMCFN_ID:
-		return "I40E_ERR_INVALID_HMCFN_ID";
-	case I40E_ERR_BACKING_PAGE_ERROR:
-		return "I40E_ERR_BACKING_PAGE_ERROR";
-	case I40E_ERR_NO_PBLCHUNKS_AVAILABLE:
-		return "I40E_ERR_NO_PBLCHUNKS_AVAILABLE";
-	case I40E_ERR_INVALID_PBLE_INDEX:
-		return "I40E_ERR_INVALID_PBLE_INDEX";
 	case I40E_ERR_INVALID_SD_INDEX:
 		return "I40E_ERR_INVALID_SD_INDEX";
 	case I40E_ERR_INVALID_PAGE_DESC_INDEX:
 		return "I40E_ERR_INVALID_PAGE_DESC_INDEX";
 	case I40E_ERR_INVALID_SD_TYPE:
 		return "I40E_ERR_INVALID_SD_TYPE";
-	case I40E_ERR_MEMCPY_FAILED:
-		return "I40E_ERR_MEMCPY_FAILED";
 	case I40E_ERR_INVALID_HMC_OBJ_INDEX:
 		return "I40E_ERR_INVALID_HMC_OBJ_INDEX";
 	case I40E_ERR_INVALID_HMC_OBJ_COUNT:
 		return "I40E_ERR_INVALID_HMC_OBJ_COUNT";
-	case I40E_ERR_INVALID_SRQ_ARM_LIMIT:
-		return "I40E_ERR_INVALID_SRQ_ARM_LIMIT";
-	case I40E_ERR_SRQ_ENABLED:
-		return "I40E_ERR_SRQ_ENABLED";
 	case I40E_ERR_ADMIN_QUEUE_ERROR:
 		return "I40E_ERR_ADMIN_QUEUE_ERROR";
 	case I40E_ERR_ADMIN_QUEUE_TIMEOUT:
@@ -248,14 +182,10 @@ const char *i40e_stat_str(struct i40e_hw
 		return "I40E_ERR_ADMIN_QUEUE_FULL";
 	case I40E_ERR_ADMIN_QUEUE_NO_WORK:
 		return "I40E_ERR_ADMIN_QUEUE_NO_WORK";
-	case I40E_ERR_BAD_IWARP_CQE:
-		return "I40E_ERR_BAD_IWARP_CQE";
 	case I40E_ERR_NVM_BLANK_MODE:
 		return "I40E_ERR_NVM_BLANK_MODE";
 	case I40E_ERR_NOT_IMPLEMENTED:
 		return "I40E_ERR_NOT_IMPLEMENTED";
-	case I40E_ERR_PE_DOORBELL_NOT_ENABLED:
-		return "I40E_ERR_PE_DOORBELL_NOT_ENABLED";
 	case I40E_ERR_DIAG_TEST_FAILED:
 		return "I40E_ERR_DIAG_TEST_FAILED";
 	case I40E_ERR_NOT_READY:
--- a/drivers/net/ethernet/intel/i40e/i40e_status.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_status.h
@@ -9,65 +9,30 @@ enum i40e_status_code {
 	I40E_SUCCESS				= 0,
 	I40E_ERR_NVM				= -1,
 	I40E_ERR_NVM_CHECKSUM			= -2,
-	I40E_ERR_PHY				= -3,
 	I40E_ERR_CONFIG				= -4,
 	I40E_ERR_PARAM				= -5,
-	I40E_ERR_MAC_TYPE			= -6,
 	I40E_ERR_UNKNOWN_PHY			= -7,
-	I40E_ERR_LINK_SETUP			= -8,
-	I40E_ERR_ADAPTER_STOPPED		= -9,
 	I40E_ERR_INVALID_MAC_ADDR		= -10,
 	I40E_ERR_DEVICE_NOT_SUPPORTED		= -11,
-	I40E_ERR_PRIMARY_REQUESTS_PENDING	= -12,
-	I40E_ERR_INVALID_LINK_SETTINGS		= -13,
-	I40E_ERR_AUTONEG_NOT_COMPLETE		= -14,
 	I40E_ERR_RESET_FAILED			= -15,
-	I40E_ERR_SWFW_SYNC			= -16,
 	I40E_ERR_NO_AVAILABLE_VSI		= -17,
 	I40E_ERR_NO_MEMORY			= -18,
 	I40E_ERR_BAD_PTR			= -19,
-	I40E_ERR_RING_FULL			= -20,
-	I40E_ERR_INVALID_PD_ID			= -21,
-	I40E_ERR_INVALID_QP_ID			= -22,
-	I40E_ERR_INVALID_CQ_ID			= -23,
-	I40E_ERR_INVALID_CEQ_ID			= -24,
-	I40E_ERR_INVALID_AEQ_ID			= -25,
 	I40E_ERR_INVALID_SIZE			= -26,
-	I40E_ERR_INVALID_ARP_INDEX		= -27,
-	I40E_ERR_INVALID_FPM_FUNC_ID		= -28,
-	I40E_ERR_QP_INVALID_MSG_SIZE		= -29,
-	I40E_ERR_QP_TOOMANY_WRS_POSTED		= -30,
-	I40E_ERR_INVALID_FRAG_COUNT		= -31,
 	I40E_ERR_QUEUE_EMPTY			= -32,
-	I40E_ERR_INVALID_ALIGNMENT		= -33,
-	I40E_ERR_FLUSHED_QUEUE			= -34,
-	I40E_ERR_INVALID_PUSH_PAGE_INDEX	= -35,
-	I40E_ERR_INVALID_IMM_DATA_SIZE		= -36,
 	I40E_ERR_TIMEOUT			= -37,
-	I40E_ERR_OPCODE_MISMATCH		= -38,
-	I40E_ERR_CQP_COMPL_ERROR		= -39,
-	I40E_ERR_INVALID_VF_ID			= -40,
-	I40E_ERR_INVALID_HMCFN_ID		= -41,
-	I40E_ERR_BACKING_PAGE_ERROR		= -42,
-	I40E_ERR_NO_PBLCHUNKS_AVAILABLE		= -43,
-	I40E_ERR_INVALID_PBLE_INDEX		= -44,
 	I40E_ERR_INVALID_SD_INDEX		= -45,
 	I40E_ERR_INVALID_PAGE_DESC_INDEX	= -46,
 	I40E_ERR_INVALID_SD_TYPE		= -47,
-	I40E_ERR_MEMCPY_FAILED			= -48,
 	I40E_ERR_INVALID_HMC_OBJ_INDEX		= -49,
 	I40E_ERR_INVALID_HMC_OBJ_COUNT		= -50,
-	I40E_ERR_INVALID_SRQ_ARM_LIMIT		= -51,
-	I40E_ERR_SRQ_ENABLED			= -52,
 	I40E_ERR_ADMIN_QUEUE_ERROR		= -53,
 	I40E_ERR_ADMIN_QUEUE_TIMEOUT		= -54,
 	I40E_ERR_BUF_TOO_SHORT			= -55,
 	I40E_ERR_ADMIN_QUEUE_FULL		= -56,
 	I40E_ERR_ADMIN_QUEUE_NO_WORK		= -57,
-	I40E_ERR_BAD_IWARP_CQE			= -58,
 	I40E_ERR_NVM_BLANK_MODE			= -59,
 	I40E_ERR_NOT_IMPLEMENTED		= -60,
-	I40E_ERR_PE_DOORBELL_NOT_ENABLED	= -61,
 	I40E_ERR_DIAG_TEST_FAILED		= -62,
 	I40E_ERR_NOT_READY			= -63,
 	I40E_NOT_SUPPORTED			= -64,


