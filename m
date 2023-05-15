Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4138870353B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbjEOQ5G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbjEOQ5F (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:57:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E5D7689
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B98AA62A11
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB26C4339B;
        Mon, 15 May 2023 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169813;
        bh=nHZnYamtmPV/3wUMops14Xghzl7WBlHWOCulpsPYuEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iU+CXn/3kKEAjthEq2IjhwZRNgxl3/a/RhpHNV67K2HtdtWrSpG4UOsqJX0yO5BsS
         rw5khyrVaQNIkqycBnD3argMyZJtsVeuGTriWV08x7VtiDnPwO3Szh8F/WixEoyFfd
         jcXu2ARDAHfRJrkb0V0e+K43s/OBNWq0a09N4bz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Manasi Navare <navaremanasi@google.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 6.3 178/246] drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte usage
Date:   Mon, 15 May 2023 18:26:30 +0200
Message-Id: <20230515161727.969386828@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jani Nikula <jani.nikula@intel.com>

commit 13525645e2246ebc8a21bd656248d86022a6ee8f upstream.

The operator precedence between << and & is wrong, leading to the high
byte being completely ignored. For example, with the 6.4 format, 32
becomes 0 and 24 becomes 8. Fix it, and remove the slightly confusing
and unnecessary DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT macro while at it.

Fixes: 0575650077ea ("drm/dp: DRM DP helper/macros to get DP sink DSC parameters")
Cc: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Cc: Manasi Navare <navaremanasi@google.com>
Cc: Anusha Srivatsa <anusha.srivatsa@intel.com>
Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230406134615.1422509-1-jani.nikula@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/drm/display/drm_dp.h        |    1 -
 include/drm/display/drm_dp_helper.h |    5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -286,7 +286,6 @@
 
 #define DP_DSC_MAX_BITS_PER_PIXEL_HI        0x068   /* eDP 1.4 */
 # define DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK  (0x3 << 0)
-# define DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT 8
 # define DP_DSC_MAX_BPP_DELTA_VERSION_MASK  0x06
 # define DP_DSC_MAX_BPP_DELTA_AVAILABILITY  0x08
 
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -181,9 +181,8 @@ static inline u16
 drm_edp_dsc_sink_output_bpp(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE])
 {
 	return dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_LOW - DP_DSC_SUPPORT] |
-		(dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_HI - DP_DSC_SUPPORT] &
-		 DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK <<
-		 DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT);
+		((dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_HI - DP_DSC_SUPPORT] &
+		  DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK) << 8);
 }
 
 static inline u32


