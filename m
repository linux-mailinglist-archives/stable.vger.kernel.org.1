Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C969370C98F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjEVTt1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjEVTt0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56209C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22D0A62AD5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4093FC433D2;
        Mon, 22 May 2023 19:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784964;
        bh=XXdsZRFyar6cNNo3P1OICuol1fOEypnLFD59uzXdXQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYcbYMsAN1hTvRI6Q0ebtpn+UvUjnEUoMaCbd8/KZkKq/mxqHWTw8NZFUsYGN5W1S
         Dd4yx5u8ihDBwjeUZ45zy7HrX0guVW8MhfswPArhjSC2miI9gr4uu5P4tryzooqfh7
         tUrNiQNWGExihwQB5SIuPKQTx5+NehNctiAt5/zk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ahmed Zaki <ahmed.zaki@intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 263/364] ice: Fix stats after PF reset
Date:   Mon, 22 May 2023 20:09:28 +0100
Message-Id: <20230522190419.286200871@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ahmed Zaki <ahmed.zaki@intel.com>

[ Upstream commit ab7470bc6d8fb5f3004ccc8e4dfd49aab0f27561 ]

After a core PF reset, the VFs were showing wrong Rx/Tx stats. This is a
regression in commit 6624e780a577 ("ice: split ice_vsi_setup into smaller
functions") caused by missing to set "stat_offsets_loaded = false" in the
ice_vsi_rebuild() path.

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 450317dfcca73..11ae0e41f518a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2745,6 +2745,8 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 			goto unroll_vector_base;
 
 		ice_vsi_map_rings_to_vectors(vsi);
+		vsi->stat_offsets_loaded = false;
+
 		if (ice_is_xdp_ena_vsi(vsi)) {
 			ret = ice_vsi_determine_xdp_res(vsi);
 			if (ret)
@@ -2793,6 +2795,9 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 		ret = ice_vsi_alloc_ring_stats(vsi);
 		if (ret)
 			goto unroll_vector_base;
+
+		vsi->stat_offsets_loaded = false;
+
 		/* Do not exit if configuring RSS had an issue, at least
 		 * receive traffic on first queue. Hence no need to capture
 		 * return value
-- 
2.39.2



