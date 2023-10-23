Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276EF7D34CF
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjJWLnC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjJWLmx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:42:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC911702
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:42:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC4BC433C9;
        Mon, 23 Oct 2023 11:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061361;
        bh=F23UavbwxMim2U7IVQIJybjBToWWsQVSDPW8wToOEvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aa2H8eM6C4UWkcFLYQlrfpz939SQbto9lijGALUVS1LVb8so2MJqxt1nPrJ5Ot/oh
         GRLqtRyE+81s7xmwIr7DhsTdfsBLcJ6wn4uj60nP4E87oFQxKdNPjvpBM9G/UhgVwT
         mmcbR8UsLnBy+8Yr77SrUKJwubvxHChFHWqLeuvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <horms@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 022/202] ixgbe: fix crash with empty VF macvlan list
Date:   Mon, 23 Oct 2023 12:55:29 +0200
Message-ID: <20231023104827.255786216@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 7b5add9af567c44e12196107f0fe106e194034fd ]

The adapter->vf_mvs.l list needs to be initialized even if the list is
empty.  Otherwise it will lead to crashes.

Fixes: a1cbb15c1397 ("ixgbe: Add macvlan support for VF")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Link: https://lore.kernel.org/r/ZSADNdIw8zFx1xw2@kadam
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 0078ae5926164..5eba086690efa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -28,6 +28,9 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	struct vf_macvlans *mv_list;
 	int num_vf_macvlans, i;
 
+	/* Initialize list of VF macvlans */
+	INIT_LIST_HEAD(&adapter->vf_mvs.l);
+
 	num_vf_macvlans = hw->mac.num_rar_entries -
 			  (IXGBE_MAX_PF_MACVLANS + 1 + num_vfs);
 	if (!num_vf_macvlans)
@@ -36,8 +39,6 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
 			  GFP_KERNEL);
 	if (mv_list) {
-		/* Initialize list of VF macvlans */
-		INIT_LIST_HEAD(&adapter->vf_mvs.l);
 		for (i = 0; i < num_vf_macvlans; i++) {
 			mv_list[i].vf = -1;
 			mv_list[i].free = true;
-- 
2.40.1



