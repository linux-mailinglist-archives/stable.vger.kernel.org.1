Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928587E22DC
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjKFNGQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjKFNGP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:06:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D855091
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:06:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2485EC433C8;
        Mon,  6 Nov 2023 13:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275972;
        bh=iRSgre419D5U/BaTGC8fJmZ/xNl0eCxKi+uVXpBBbZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsSus7ROsgosTHZhtszHFnMkNqSqJZnEZ/1SP48lJZmnKXpNH8VEyCzZB7rV4b8fq
         EYIk+CFB+4UuTGKOWUq83WdFA1akYfCirQjyeZPePopGyADlsgKhp+A/8onaD+cdHX
         da/m1nkY2u2jceG9vq9VD5+7+b7Gb6a0M6tz6qHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ivan Vecera <ivecera@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 4.14 09/48] i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR
Date:   Mon,  6 Nov 2023 14:03:00 +0100
Message-ID: <20231106130258.169048153@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index d79a2c8175c4c..02871e0e20249 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2401,7 +2401,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+	if (q_vector->tx.ring[0].flags & I40E_TXR_FLAGS_WB_ON_ITR)
 		q_vector->arm_wb_state = false;
 
 	/* Work is done so exit the polling mode and re-enable the interrupt */
-- 
2.42.0



