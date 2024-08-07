Return-Path: <stable+bounces-65548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C3D94A96D
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606A91F21462
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E43A1C4;
	Wed,  7 Aug 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="skdPG4cd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3636B17
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039711; cv=none; b=H3dKvrRbH/IB8hhgSFyihK7b+ZLjltjfPp/syYU0LjhlQ1p2WC2BIiSg/efOyznPi6P+QyNGogCuKLxEa7Bbf65qTRNYMe6W1+42ZHNR/Jz3crSmTCFIMAspua2uD75kWeelw1MWUPKZ8x5oekJ0Q7Vk+9He+oMEPJGJ4l7Fjvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039711; c=relaxed/simple;
	bh=JXVhOtRQKgS0ZJQO0hAcDk2AvgnaaBgo+4HDFB9UGI4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N7Gpore50QTCNPJjecVyWJ9kKOPnTyGxOYNWyvc8GbZ4qdyaQjZVZnlVQEbdu7dVirAAdRq9159RRArFAq/IOtdDLwawO/ErEnH4Ry5UJhYLveF/7U7kWtGWwHZgThyfQzbqZa0idkfAbVYIxgUYJfjR7Bpecm8tiuq2ptV8pqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=skdPG4cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADACC32782;
	Wed,  7 Aug 2024 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039711;
	bh=JXVhOtRQKgS0ZJQO0hAcDk2AvgnaaBgo+4HDFB9UGI4=;
	h=Subject:To:Cc:From:Date:From;
	b=skdPG4cdS0L3alAcwAEUb5/KJ+UrXSTCuzbKRwj2TqVvh2ijihs4jk9siW+w0vvfi
	 3V2ACne0X/Q5PFVbHxVtejbwPnfQKqfUJCpb/vapNhhZkpCBYpE13THAmsXqXRmZ3I
	 zEdKcZmOymQ8ZhXuKjPAMysrqI8tf/IoQKK84GRo=
Subject: FAILED: patch "[PATCH] drm/i915: Fix possible int overflow in" failed to apply to 5.10-stable tree
To: n.zhandarovich@fintech.ru,jani.nikula@intel.com,joonas.lahtinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:08:25 +0200
Message-ID: <2024080725-lemon-stopped-a201@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5b511572660190db1dc8ba412efd0be0d3781ab6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080725-lemon-stopped-a201@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

5b5115726601 ("drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()")
4d6e86fbecbb ("drm/i915: Introduce some local PLL state variables")
25591b66d0a4 ("drm/i915: s/dev_priv/i915/ in the shared_dpll code")
51d3e6292719 ("drm/i915: Introduce for_each_shared_dpll()")
99e5a010e815 ("drm/i915: Decouple I915_NUM_PLLS from PLL IDs")
027c57017795 ("drm/i915: Stop requiring PLL index == PLL ID")
461f35f01446 ("Merge tag 'drm-next-2023-08-30' of git://anongit.freedesktop.org/drm/drm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b511572660190db1dc8ba412efd0be0d3781ab6 Mon Sep 17 00:00:00 2001
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Date: Mon, 29 Jul 2024 10:40:35 -0700
Subject: [PATCH] drm/i915: Fix possible int overflow in
 skl_ddi_calculate_wrpll()

On the off chance that clock value ends up being too high (by means
of skl_ddi_calculate_wrpll() having been called with big enough
value of crtc_state->port_clock * 1000), one possible consequence
may be that the result will not be able to fit into signed int.

Fix this issue by moving conversion of clock parameter from kHz to Hz
into the body of skl_ddi_calculate_wrpll(), as well as casting the
same parameter to u64 type while calculating the value for AFE clock.
This both mitigates the overflow problem and avoids possible erroneous
integer promotion mishaps.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 82d354370189 ("drm/i915/skl: Implementation of SKL DPLL programming")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240729174035.25727-1-n.zhandarovich@fintech.ru
(cherry picked from commit 833cf12846aa19adf9b76bc79c40747726f3c0c1)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index 90998b037349..292d163036b1 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -1658,7 +1658,7 @@ static void skl_wrpll_params_populate(struct skl_wrpll_params *params,
 }
 
 static int
-skl_ddi_calculate_wrpll(int clock /* in Hz */,
+skl_ddi_calculate_wrpll(int clock,
 			int ref_clock,
 			struct skl_wrpll_params *wrpll_params)
 {
@@ -1683,7 +1683,7 @@ skl_ddi_calculate_wrpll(int clock /* in Hz */,
 	};
 	unsigned int dco, d, i;
 	unsigned int p0, p1, p2;
-	u64 afe_clock = clock * 5; /* AFE Clock is 5x Pixel clock */
+	u64 afe_clock = (u64)clock * 1000 * 5; /* AFE Clock is 5x Pixel clock, in Hz */
 
 	for (d = 0; d < ARRAY_SIZE(dividers); d++) {
 		for (dco = 0; dco < ARRAY_SIZE(dco_central_freq); dco++) {
@@ -1808,7 +1808,7 @@ static int skl_ddi_hdmi_pll_dividers(struct intel_crtc_state *crtc_state)
 	struct skl_wrpll_params wrpll_params = {};
 	int ret;
 
-	ret = skl_ddi_calculate_wrpll(crtc_state->port_clock * 1000,
+	ret = skl_ddi_calculate_wrpll(crtc_state->port_clock,
 				      i915->display.dpll.ref_clks.nssc, &wrpll_params);
 	if (ret)
 		return ret;


