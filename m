Return-Path: <stable+bounces-65062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 454ED943DFA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E79B29ED3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7023D1D1745;
	Thu,  1 Aug 2024 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7ap+HiZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF711D173D;
	Thu,  1 Aug 2024 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472220; cv=none; b=dRD34Bx35qQ3vFakBVWowu4gG8cdasssrVDlB1F7kawSSsEKSOfNR43ExuP0xbCH/Qk0LMhL+Nmiw8Qs3zMfMwBY+T90cJn1NL7HCYdFVkGzi+H456ye1yQ51UPy8DF9xJ7worD132QUG2UAbPTBVqe6TY+z4ntv0O20oRpr9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472220; c=relaxed/simple;
	bh=aQOPGRDuca0jP6BFG+wUCutmfPwa2tzy8A7TzRxZPUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjmXKS9sR3bJLRKRynET3KROZlwKilNdRVGGC9FgteoIX/1V6iSegbc0Z2/z/L2mHipz5wnLsf2kahNe56F30E+gEJhHNM/U+2mpNVWkzHZJJtVi53fOLgObDWhCCkuM03slvzF42VieV8NJzpMuaPN+AZxsbzmC9IPKBg0qrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7ap+HiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F4CC32786;
	Thu,  1 Aug 2024 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472220;
	bh=aQOPGRDuca0jP6BFG+wUCutmfPwa2tzy8A7TzRxZPUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7ap+HiZuKlSI5svQOoyzBvxheD0AzRJcFg3je9eaDLcemNkkZO1t946gjfHONOkw
	 l9hP29IbUy6sVf4Z50QWqvbZAsmOIBNvzr/hNgE6SyipBfSVW9D7UrQZam2o0MyLdl
	 7G/K/YJmYdjPn00jAc59gqCbNNfSetx/569zEHa5EkBqvx+fNVdPOSdxBKX85Jzazo
	 cxvgP4VnDQ50kHnv08Cgo1BI7YZAftOOQI2C6jbCamMlZibF5dkGwsIrBW5tUMmgR6
	 i3ZeIi9YbYjKSeWOLCmF+1s9kvD7ifVBIB95U2R2F5J+Th3TJACBJ7nzGYWhvKuT2z
	 trTZcur4UgLnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ken Sloat <ksloat@designlinxhs.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 33/61] pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM mode.
Date: Wed, 31 Jul 2024 20:25:51 -0400
Message-ID: <20240801002803.3935985-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Ken Sloat <ksloat@designlinxhs.com>

[ Upstream commit 56f45266df67aa0f5b2a6881c8c4d16dbfff6b7d ]

This timer HW supports 8, 16 and 32-bit timer widths. This
driver currently uses a u32 to store the max possible value
of the timer. However, statements perform addition of 2 in
xilinx_pwm_apply() when calculating the period_cycles and
duty_cycles values. Since priv->max is a u32, this will
result in an overflow to 1 which will not only be incorrect
but fail on range comparison. This results in making it
impossible to set the PWM in this timer mode.

There are two obvious solutions to the current problem:
1. Cast each instance where overflow occurs to u64.
2. Change priv->max from a u32 to a u64.

Solution #1 requires more code modifications, and leaves
opportunity to introduce similar overflows if other math
statements are added in the future. These may also go
undetected if running in non 32-bit timer modes.

Solution #2 is the much smaller and cleaner approach and
thus the chosen method in this patch.

This was tested on a Zynq UltraScale+ with multiple
instances of the PWM IP.

Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>
Reviewed-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/SJ0P222MB0107490C5371B848EF04351CA1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/clocksource/timer-xilinx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
index c0f56fe6d22ae..d116f18de899c 100644
--- a/include/clocksource/timer-xilinx.h
+++ b/include/clocksource/timer-xilinx.h
@@ -41,7 +41,7 @@ struct regmap;
 struct xilinx_timer_priv {
 	struct regmap *map;
 	struct clk *clk;
-	u32 max;
+	u64 max;
 };
 
 /**
-- 
2.43.0


