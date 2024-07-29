Return-Path: <stable+bounces-62593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EFA93FC86
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35FB1F22A7B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2BC15F301;
	Mon, 29 Jul 2024 17:40:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1580633;
	Mon, 29 Jul 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274845; cv=none; b=hTUUIRpcRXBEtRKYMyxr9uDIo2h6N8pgMUkm8kFJ5EE3JP/Q/7GSp3OEO9H/jO6cJ1eh3U4tLV73yyyd4G2TiFpkzpy1qaME6Qc+56YiPt9HCaFqy9T+DHKEVMkIRAwlB476py4qlvWsLtp6QARBkqrkKeeBM3mzZgHUEoXdLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274845; c=relaxed/simple;
	bh=4esnx1FRDoMGl74KozGGPcNOXjBDx63PSVV03XzAHh8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=InoWSoBrhP0+4RRwSQK1m1LKZxcOQlCwOzP0S+ZGgmMhPFtiopkeV2ilAXW5Slw2u6+S4H/eenetwjhXZakt1sl8VoS+MqneZ+BNQopSnQaMynUCgSa4VI6fEmpYx6DnkvqzpZByv28FDMExTr9oG8+1zyNgJ6sc4l1BajhfqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 29 Jul
 2024 20:40:38 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 29 Jul
 2024 20:40:38 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Tvrtko Ursulin
	<tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
	<ville.syrjala@linux.intel.com>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()
Date: Mon, 29 Jul 2024 10:40:35 -0700
Message-ID: <20240729174035.25727-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

On the off chance that clock value ends up being too high (by means
of skl_ddi_calculate_wrpll() having benn called with big enough
value of crtc_state->port_clock * 1000), one possible consequence
may be that the result will not be able to fit into signed int.

Fix this issue by moving conversion of clock parameter from kHz to Hz
into the body of skl_ddi_calculate_wrpll(), as well as casting the
same parameter to u64 type while calculating the value for AFE clock.
This both mitigates the overflow problem and avoids possible erroneous
integer promotion mishaps.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: fe70b262e781 ("drm/i915: Move a bunch of stuff into rodata from the stack")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v2: instead of double casting of 'clock' with (u64)(u32), convert
'clock' to Hz inside skl_ddi_calculate_wrpll() and cast it only
to u64 to mitigate the issue. Per Jani's <jani.nikula@linux.intel.com>
helpful suggestion made here:
https://lore.kernel.org/all/87ed7gzhin.fsf@intel.com/
Also, change commit description accordingly.

v1: https://lore.kernel.org/all/20240724184911.12250-1-n.zhandarovich@fintech.ru/

 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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

