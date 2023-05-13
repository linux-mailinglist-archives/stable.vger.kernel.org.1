Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE587014C9
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEMGsR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjEMGsM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C4D40D4
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEAE060F77
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8554AC4339C;
        Sat, 13 May 2023 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683960490;
        bh=BgTewbj4dgp8PyKnzlRyFP+IExRlJvCK5KgyoLbeSYg=;
        h=Subject:To:Cc:From:Date:From;
        b=L9HHntVK/p2uOfl+zNiXVM7J/gKA6xXAry0s2OrKhZPYZItzmLRodO2VGxRxKHFYO
         Wegty5AYLyjCJAP+6czViMMrXLCjjE0LiM0G0ASmegv+WXF0Hd9bE/5a3qF42jjurp
         G3GW3NZqsREbjpE2TV9eWID3krneOkyDdENsUj3E=
Subject: FAILED: patch "[PATCH] drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte" failed to apply to 5.10-stable tree
To:     jani.nikula@intel.com, ankit.k.nautiyal@intel.com,
        anusha.srivatsa@intel.com, navaremanasi@google.com,
        stable@vger.kernel.org, stanislav.lisovskiy@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:47:35 +0900
Message-ID: <2023051335-facial-slip-7c63@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 13525645e2246ebc8a21bd656248d86022a6ee8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051335-facial-slip-7c63@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

13525645e224 ("drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte usage")
1482ec00be4a ("drm: Add missing DP DSC extended capability definitions.")
34f667634a0d ("drm/dp_mst: add passthrough_aux to struct drm_dp_mst_port")
5d1b8b4a14f7 ("drm/display: Split DisplayPort header into core and helper")
da68386d9edb ("drm: Rename dp/ to display/")
c9e9ce0b6f85 ("Merge tag 'drm-misc-next-2022-03-03' of git://anongit.freedesktop.org/drm/drm-misc into drm-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 13525645e2246ebc8a21bd656248d86022a6ee8f Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Thu, 6 Apr 2023 16:46:14 +0300
Subject: [PATCH] drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte
 usage

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

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 632376c291db..4545ed610958 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -286,7 +286,6 @@
 
 #define DP_DSC_MAX_BITS_PER_PIXEL_HI        0x068   /* eDP 1.4 */
 # define DP_DSC_MAX_BITS_PER_PIXEL_HI_MASK  (0x3 << 0)
-# define DP_DSC_MAX_BITS_PER_PIXEL_HI_SHIFT 8
 # define DP_DSC_MAX_BPP_DELTA_VERSION_MASK  0x06
 # define DP_DSC_MAX_BPP_DELTA_AVAILABILITY  0x08
 
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index ab55453f2d2c..ade9df59e156 100644
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

