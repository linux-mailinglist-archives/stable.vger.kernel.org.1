Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABECC7ED6A1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbjKOWCg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343757AbjKOWCf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:02:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AD91A1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:02:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71096C433C8;
        Wed, 15 Nov 2023 22:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085752;
        bh=oUp/a7YNF1fHOwUe5QrKRflGixHytHYKCbWJg/LL4M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPVp9WLt39PcJyvtfmUagoJpbFCGe++O81DtFTeZZMw5YerJ8BrByG2JQN7tHZ08a
         bzAKdlEfxhgOdka8lA7t62kH4cIYbxkvB9kqTUngFc4oi9bjBJ+IzhefNk9ClKW9DW
         EGyL8sviIngUHPNP/2dOujIUpyMbgm5xNrZyVFrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Staikov <andrii.staikov@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Simon Horman <horms@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 003/119] i40e: fix potential memory leaks in i40e_remove()
Date:   Wed, 15 Nov 2023 16:59:53 -0500
Message-ID: <20231115220132.717074709@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Staikov <andrii.staikov@intel.com>

[ Upstream commit 5ca636d927a106780451d957734f02589b972e2b ]

Instead of freeing memory of a single VSI, make sure
the memory for all VSIs is cleared before releasing VSIs.
Add releasing of their resources in a loop with the iteration
number equal to the number of allocated VSIs.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 351d4c53297f5..3ccc248b1a8a7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15553,11 +15553,15 @@ static void i40e_remove(struct pci_dev *pdev)
 			i40e_switch_branch_release(pf->veb[i]);
 	}
 
-	/* Now we can shutdown the PF's VSI, just before we kill
+	/* Now we can shutdown the PF's VSIs, just before we kill
 	 * adminq and hmc.
 	 */
-	if (pf->vsi[pf->lan_vsi])
-		i40e_vsi_release(pf->vsi[pf->lan_vsi]);
+	for (i = pf->num_alloc_vsi; i--;)
+		if (pf->vsi[i]) {
+			i40e_vsi_close(pf->vsi[i]);
+			i40e_vsi_release(pf->vsi[i]);
+			pf->vsi[i] = NULL;
+		}
 
 	i40e_cloud_filter_exit(pf);
 
-- 
2.42.0



