Return-Path: <stable+bounces-137150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C05AA11EC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EE74A55C0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A724A06A;
	Tue, 29 Apr 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k41rzmgu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B46126C17;
	Tue, 29 Apr 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945211; cv=none; b=eREIikuhLmyB7RIKsSXZUtIlb8tpCz1ejDsqVsDqnCRRFk2OEAL9omtJirsAIya8k4awMG1yy0KBTsX9eTMFQKerzGr6yss0thB8ZyTSuCDkAqHzI8ycPNzcYUHG4Zm9Dg+eqCcWU40F+gkhThss2shHmCEmN2t40iVQTpyBh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945211; c=relaxed/simple;
	bh=9qDXfpdnl4y6iqaqBzgwRpEbwMoLEYA0ikcQAQ0/Fgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QP+k+L0iYQZ7OpnpykxL9aVjas579uIG/FSOKVK27um89FqLT6dQRDlLQBRbGuxmy65+1gKbTBuhAhGfe2RJm7ukKuxrslG7k15Q8cnc7HCFN52K9+f4Ex1Mcjb5Ii2NFMibFu4p2WeYFWmHFuekghxR4BXZzJWJerJkUYVGNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k41rzmgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6595DC4CEE9;
	Tue, 29 Apr 2025 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945210;
	bh=9qDXfpdnl4y6iqaqBzgwRpEbwMoLEYA0ikcQAQ0/Fgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k41rzmguxE0f3Fc/mCgid11pfjKEN4c44RsrtHbdwgQpXAoVmvNs6I8lOYu1qSgH4
	 E8WsVtfguGsh5upvE3F5H/S4bHJAJbxfGo5KgSpqu741tBPDuanpbm0gG0oif4rdDO
	 W0jct7wY1n51a9YMw5sQpFBsPw5aZ0MMz1yfAj6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 038/179] pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()
Date: Tue, 29 Apr 2025 18:39:39 +0200
Message-ID: <20250429161050.955763819@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 7ca59947b5fcf94e7ea4029d1bd0f7c41500a161 ]

With CONFIG_COMPILE_TEST && !CONFIG_HAVE_CLK, pwm_mediatek_config() has a
divide-by-zero in the following line:

	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));

due to the fact that the !CONFIG_HAVE_CLK version of clk_get_rate()
returns zero.

This is presumably just a theoretical problem: COMPILE_TEST overrides
the dependency on RALINK which would select COMMON_CLK.  Regardless it's
a good idea to check for the error explicitly to avoid divide-by-zero.

Fixes the following warning:

  drivers/pwm/pwm-mediatek.o: warning: objtool: .text: unexpected end of section

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org
[ukleinek: s/CONFIG_CLK/CONFIG_HAVE_CLK/]
Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/9e78a0796acba3435553ed7db1c7965dcffa6215.1743501688.git.u.kleine-koenig@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-mediatek.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 2bece32e62dad..b2a2e1f501682 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -125,21 +125,25 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
+	unsigned long clk_rate;
 	u64 resolution;
 	int ret;
 
 	ret = pwm_mediatek_clk_enable(chip, pwm);
-
 	if (ret < 0)
 		return ret;
 
+	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
+	if (!clk_rate)
+		return -EINVAL;
+
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
 		writel(0, pc->regs + PWM_CK_26M_SEL);
 
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
+	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {
-- 
2.39.5




