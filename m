Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D189E7D356A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjJWLsE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjJWLsD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:48:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A68AF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:48:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D0CC433C7;
        Mon, 23 Oct 2023 11:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061681;
        bh=ibbv6hnBcuWKKT3RcVIeR2B8z8am5WNgWsO2Lq/ajLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09xESkFwf0xsGsKud9mqgvJVG6G+7hTjh7lNS1+sCI0eEOoZL3cnNP4L2753RhLfJ
         cufWIREARUguNm3RpB8xeScFULSqyotUBHjDKU/9xucRzNdkhoo4iCsfYEmQ06q2LB
         6p9r0bfbgzZsw6QHUpjRIHxD8VwGXGZlzswUNf1o=
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
Subject: [PATCH 5.10 092/202] ice: fix over-shifted variable
Date:   Mon, 23 Oct 2023 12:56:39 +0200
Message-ID: <20231023104829.216753425@linuxfoundation.org>
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
@@ -931,8 +931,7 @@ static void ice_set_rss_vsi_ctx(struct i
 
 	ctxt->info.q_opt_rss = ((lut_type << ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
 				ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				((hash_type << ICE_AQ_VSI_Q_OPT_RSS_HASH_S) &
-				 ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+				(hash_type & ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
 }
 
 /**


