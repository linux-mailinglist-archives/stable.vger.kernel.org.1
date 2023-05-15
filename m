Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5F67037FB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbjEOR0T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbjEORZy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0FB10A2B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9904562CA9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908F3C433EF;
        Mon, 15 May 2023 17:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171480;
        bh=ivP3k2WFf+n9kzd7MuXC+9aumpovZM0r0BZvFDK/bM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XF05FMsGoDMJZSF13ffIQ011wRyLHsfl6rkgQBZSj0zN+C4/wh41Oc9Fx+kyXi9Nv
         CdWgtfspRR4sbVhc6fAjRK/BUmywRELVGCZh/GLpyHN0KmjPcrZs63HUQEGrTuwzPy
         2CBbfneD+yldL/g7i8CUkpXqHngmaRDa528rjkCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Manasi Navare <navaremanasi@google.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 222/242] drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte usage
Date:   Mon, 15 May 2023 18:29:08 +0200
Message-Id: <20230515161728.582511184@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

[ Upstream commit 13525645e2246ebc8a21bd656248d86022a6ee8f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/display/drm_dp.h        | 1 -
 include/drm/display/drm_dp_helper.h | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 9bc22a02874d9..50428ba92ce8b 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -286,7 +286,6 @@
 
 #define DP_DSC_MAX_BITS_PER_PIXEL_HI        0x068   /* eDP 1.4 */
 # define DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK  (0x3 << 0)
-# define DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT 8
 # define DP_DSC_MAX_BPP_DELTA_VERSION_MASK  0x06
 # define DP_DSC_MAX_BPP_DELTA_AVAILABILITY  0x08
 
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index ab55453f2d2cd..ade9df59e156a 100644
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
-- 
2.39.2



