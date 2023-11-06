Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1627E245C
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjKFNVE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjKFNVB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:21:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247A191
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:20:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8B0C433C8;
        Mon,  6 Nov 2023 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276856;
        bh=fzowBInAC3GCXaR9RmzOJbJ90xWDlN96rQnBrZ5QTRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhQrDghUdhvj6AdHefrQsQ1TeMVsXNc3ibrmNj84mGxy3g/hy4D/xxoInTW38BwaA
         Y54G+G3DQ2a1wdVjiSJqhxGQyyZ3rBDJnhC286sNqv1LdH/P681ltooEuij6WHsdd0
         +Uzfi8lWCHphcVfV0GLZ+Hy25Sv12KOrs9brABB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ivan Vecera <ivecera@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 5.4 31/74] i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR
Date:   Mon,  6 Nov 2023 14:03:51 +0100
Message-ID: <20231106130302.810316556@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 77a8c982ff0d4c3a14022c6fe9e3dbfb327552ec ]

The I40E_TXR_FLAGS_WB_ON_ITR is i40e_ring flag and not i40e_pf one.

Fixes: 8e0764b4d6be42 ("i40e/i40evf: Add support for writeback on ITR feature for X722")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/r/20231023212714.178032-1-jacob.e.keller@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 06987913837aa..6067c88668341 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2669,7 +2669,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+	if (q_vector->tx.ring[0].flags & I40E_TXR_FLAGS_WB_ON_ITR)
 		q_vector->arm_wb_state = false;
 
 	/* Exit the polling mode, but don't re-enable interrupts if stack might
-- 
2.42.0



