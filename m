Return-Path: <stable+bounces-64888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BE0943BA9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31818284CD8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638F18E03B;
	Thu,  1 Aug 2024 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyA/zzYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22699148311;
	Thu,  1 Aug 2024 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471301; cv=none; b=uWsROTBGrIjxfNkvdMuIYOrwmXCYCMsgZOJhitDhF3nvMJpgX+hIBpA8D53vzTvW0QPoCljDdyrAFmmmmO6vCx0lqnOcHcgz80LmEBQ2dxe7fb7RcSSPDwnrpiAyNHjYrxqbuWkGQ+VseTuxUFGbmVQ4XZkEO0QlpznUNUJnl+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471301; c=relaxed/simple;
	bh=aQOPGRDuca0jP6BFG+wUCutmfPwa2tzy8A7TzRxZPUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4uWF6Sg5VieF5kCVjK3e+1D3Ns3kYgEjPYvpgTcsTRam2MJI1WmZAzaOSIYAWQml2oV1nergtsTNIMArrXHBa8wuQP9RMtP5a4xkqA6TUifFO1GzrjNCDhpYiGb6Y0sIBau3rYekjwtgcDLk0gSFjdXlQCKucv57P3N2LUBxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyA/zzYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA99EC32786;
	Thu,  1 Aug 2024 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471300;
	bh=aQOPGRDuca0jP6BFG+wUCutmfPwa2tzy8A7TzRxZPUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyA/zzYMsv6mvxdQtZrv77/ojZEoQ5drCWRqiXa93JSUlsaG7FmqFyH7zdjb1fUBJ
	 2IIKNIHFbB3MqPjcKCRdNsMH/uaTpz9S9TphMdRZXHLTt9WWzcCDW139PxVqciaq4a
	 GD5xX1ah8Yu5pISbeK55lx4zo6mhj4Q0QZX5t9wcy4TAqbZaAMkOMZQk5Sd3DhrFXT
	 a+djssUEJguY8UkKLBzSuAd6ddXlX7+ybuAyp+rSlS8mF67OZZI261ueIiAMXrhcvF
	 zb1iTLGHuSLWIIJIlPHRVCK+Jncsqg6Z2dI0xFVsID6IrLne2kWxWjG+9KrHBW9FTp
	 mCiWCIwSZ1mzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ken Sloat <ksloat@designlinxhs.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 063/121] pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM mode.
Date: Wed, 31 Jul 2024 20:00:01 -0400
Message-ID: <20240801000834.3930818-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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


