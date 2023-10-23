Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619307D3382
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjJWLbK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjJWLbH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:31:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A603A92
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:31:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA722C433C7;
        Mon, 23 Oct 2023 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060665;
        bh=FdyVyhTizuOCPZ0Mcaija7HaxN96VpcWdf6eZqCDCkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2H72+zCwNEml0IVZY9+2Kf88iztugzh5UT047WsmKcYqyN00nK1/GZWfZ9AAzZrw0
         w9BnArDQCSaxdRmKEphCrZzdLhPam87Ga15pKpfrU0opR6epPiR/0mhcXXKlRZkpGr
         ZLX6NYrXw+TwQi6ORr3HvgvfJPBq8BdlsMQZvAuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Simon Horman <horms@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 5.4 052/123] ice: fix over-shifted variable
Date:   Mon, 23 Oct 2023 12:56:50 +0200
Message-ID: <20231023104819.446949242@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

commit 242e34500a32631f85c2b4eb6cb42a368a39e54f upstream.

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
Link: https://lore.kernel.org/r/20231010203101.406248-1-jacob.e.keller@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_lib.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1015,8 +1015,7 @@ static void ice_set_rss_vsi_ctx(struct i
 
 	ctxt->info.q_opt_rss = ((lut_type << ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
 				ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				((hash_type << ICE_AQ_VSI_Q_OPT_RSS_HASH_S) &
-				 ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+				(hash_type & ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
 }
 
 /**


