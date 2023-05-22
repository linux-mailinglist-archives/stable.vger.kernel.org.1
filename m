Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD170C6FC
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjEVTYj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjEVTYi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41EC9C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 721036287A
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1E5C433EF;
        Mon, 22 May 2023 19:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783476;
        bh=t6mk1jcVqQzyyu1w/ihKCeyHnIlEPXKnlFPFJdu51Bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfQfNX9hj75ffQlTMGG7AlKIaBWnn5X9KYRRDuVYUVBez1ACc9YypzfhuCER4GHVd
         bT24yaJVRdy8T3h/ZXu3wZXVEhY9PnQrcpLoiWiAuFynvzNrNTqqw5wWrzhMWOhPkR
         c6sVzEgQt/B/JPsaSzPt9/iJthnm6lFaNofX/ifE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/292] drm/i915/dp: prevent potential div-by-zero
Date:   Mon, 22 May 2023 20:06:25 +0100
Message-Id: <20230522190406.597607320@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 0ff80028e2702c7c3d78b69705dc47c1ccba8c39 ]

drm_dp_dsc_sink_max_slice_count() may return 0 if something goes
wrong on the part of the DSC sink and its DPCD register. This null
value may be later used as a divisor in intel_dsc_compute_params(),
which will lead to an error.
In the unlikely event that this issue occurs, fix it by testing the
return value of drm_dp_dsc_sink_max_slice_count() against zero.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: a4a157777c80 ("drm/i915/dp: Compute DSC pipe config in atomic check")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230418140430.69902-1-n.zhandarovich@fintech.ru
(cherry picked from commit 51f7008239de011370c5067bbba07f0207f06b72)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 2e09899f2f927..b1653308f1450 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1512,6 +1512,11 @@ static int intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
 		pipe_config->dsc.slice_count =
 			drm_dp_dsc_sink_max_slice_count(intel_dp->dsc_dpcd,
 							true);
+		if (!pipe_config->dsc.slice_count) {
+			drm_dbg_kms(&dev_priv->drm, "Unsupported Slice Count %d\n",
+				    pipe_config->dsc.slice_count);
+			return -EINVAL;
+		}
 	} else {
 		u16 dsc_max_output_bpp;
 		u8 dsc_dp_slice_count;
-- 
2.39.2



