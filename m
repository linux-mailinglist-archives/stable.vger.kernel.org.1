Return-Path: <stable+bounces-61320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DEA93B6FF
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 20:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB48B236C7
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A637015F3E2;
	Wed, 24 Jul 2024 18:49:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36E22089;
	Wed, 24 Jul 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846967; cv=none; b=Pm/ATBtTOkBulsGjp1hpo7/77MbS0rVE9nlhFyryEu5vej60fnBNzNdmpiBqDQwIjzN/xFYuHINFEjR/XNC7Wn/vjuFqhISD3KqSGntdGeWXhhHNqXXUkKp7E6649OkvNkN4+KPjCx6ayPja07N7rfasOTt2hhagxxG0JVNXIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846967; c=relaxed/simple;
	bh=GHqDnOOaXb1hN1zGoqyJvvqNbxshNBgSd6R+hDYVavM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yarp62yaW1NJp+0GruokQGvt9CcmH6F7xIKo4tTSVT5nmwVJkSzBB5xS/vuLpeSL6D2CmSLb+mCUsGlV5i8X3MROuNTvshO8iwOW03mpbXU1zQqrv0zsCHxKTynhWFpsMjen8F8X5i2eL1vc7igvt0YzVBAhKAn1PnEe8Wl4+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 24 Jul
 2024 21:49:20 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 24 Jul
 2024 21:49:20 +0300
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
Subject: [PATCH] drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()
Date: Wed, 24 Jul 2024 11:49:11 -0700
Message-ID: <20240724184911.12250-1-n.zhandarovich@fintech.ru>
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

Fix this, albeit unlikely, issue by first casting one of the operands
to u32, then to u64, and thus avoid causing an integer overflow.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: fe70b262e781 ("drm/i915: Move a bunch of stuff into rodata from the stack")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
Fixes: tag is not entirely correct, as I can't properly identify the
origin with all the code movement. I opted out for using the most
recent topical commit instead.

 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index 90998b037349..46d4dac6c491 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -1683,7 +1683,7 @@ skl_ddi_calculate_wrpll(int clock /* in Hz */,
 	};
 	unsigned int dco, d, i;
 	unsigned int p0, p1, p2;
-	u64 afe_clock = clock * 5; /* AFE Clock is 5x Pixel clock */
+	u64 afe_clock = (u64)(u32)clock * 5; /* AFE Clock is 5x Pixel clock */
 
 	for (d = 0; d < ARRAY_SIZE(dividers); d++) {
 		for (dco = 0; dco < ARRAY_SIZE(dco_central_freq); dco++) {

