Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AFB7C4141
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 22:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjJJUbN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjJJUbM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 16:31:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1C8E;
        Tue, 10 Oct 2023 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696969871; x=1728505871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q0gBOkzDsq/gQYzu51R39rST/HZysRsPFQA+3BD9Ztk=;
  b=Er/HXTzCb+nemcU13NpA33/dERp29XIecWktvV3oTBbLtVawgr7CYt/X
   dfYnaf2RBmAPJkhDH1Xg2puydJLpCDz6RGVfFPDTN11s31QIibyCYHFi6
   HNEFj0GPFeJd2foezH/58qwxvxGRd5MzVLuVY5vmZRhgwmWQCZjSiK7+Y
   bDRPlYrodKoKqL+c9wKyFzPRfddG3mEoaCouz6Beo4DBc5e9b4E6AYp1w
   dF7zPQ9a1Cba3dzZKJpFFFYynf0PUSZ/pYwMeFHfn1s+qtfnmkmDKc4e4
   UlsYxo92lVTeW+/RLhw7lu1x1KLHafAGNcCDrzH6ycKWrm0+qQqtxRet8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3088339"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="3088339"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 13:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753533599"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="753533599"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 13:31:08 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        stable@vger.kernel.org, Simon Horman <horms@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net] ice: fix over-shifted variable
Date:   Tue, 10 Oct 2023 13:30:59 -0700
Message-ID: <20231010203101.406248-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Since the introduction of the ice driver the code has been
double-shifting the RSS enabling field, because the define already has
shifts in it and can't have the regular pattern of "a << shiftval &
mask" applied.

Most places in the code got it right, but one line was still wrong. Fix
this one location for easy backports to stable. An in-progress patch
fixes the defines to "standard" and will be applied as part of the
regular -next process sometime after this one.

Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: stable@vger.kernel.org
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7bf9b7069754..73bbf06a76db 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1201,8 +1201,7 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 
 	ctxt->info.q_opt_rss = ((lut_type << ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
 				ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				((hash_type << ICE_AQ_VSI_Q_OPT_RSS_HASH_S) &
-				 ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+				(hash_type & ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
 }
 
 static void
-- 
2.41.0

