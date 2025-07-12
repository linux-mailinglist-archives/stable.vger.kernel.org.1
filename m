Return-Path: <stable+bounces-161729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E7DB02B2A
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 16:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557E7563C84
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0227935C;
	Sat, 12 Jul 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IbCQZGzH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5901F5823
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328851; cv=none; b=kjOyghdbUQoaZwCNiTym1y1ql1bYyYl3X+csD7g6ya+cCdSxb6FU6t/32cukCMrOZkFbyYbeeGAbfQTau02D8qE6py0f/jc45ggWHS1U2LEeWfEBK1eLxQ2FEqYtlmBZGZDLN6KQ2oqYD+e3vse3XZw+LLiaHX8WUbaxyqr7Jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328851; c=relaxed/simple;
	bh=KSZhGfbaH7VWVOSljTcjmtiMZ0uK4WFmoovkUAkosO8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rzQPu90U9Hbc6J/NAXb97rlj/MYvPV495Dmext9lSvMhHx4HWQx73x9O9r1S3FN+eoTkEHzECgiOy0lMuv2aB6ZEkP/Vlle2/Nt55AtL4asDl4veRwHJI4pXw8NVc6EMD1mX0eiYsAMwYzgts9iEk9OQR3MToioXbytfOR5sfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IbCQZGzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E10DC4CEEF;
	Sat, 12 Jul 2025 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752328850;
	bh=KSZhGfbaH7VWVOSljTcjmtiMZ0uK4WFmoovkUAkosO8=;
	h=Subject:To:Cc:From:Date:From;
	b=IbCQZGzH5pC5kBANs8pR+GDPAtLBoGb2GfOyEyUKu7UGD/LycymqlVkVyUrtmtJmG
	 WppbTgT7v7jgS7NSAaH4A0yac+l0OcRpsLtgGfjzecFroNzeiHKz/mLFy08xZHiQUQ
	 eZER9+Ffr4o9fB8c3037zCEvmopapyaO2fgN+7H4=
Subject: FAILED: patch "[PATCH] pwm: mediatek: Ensure to disable clocks in error path" failed to apply to 5.4-stable tree
To: u.kleine-koenig@baylibre.com,ukleinek@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 12 Jul 2025 16:00:36 +0200
Message-ID: <2025071236-generous-jazz-41e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 505b730ede7f5c4083ff212aa955155b5b92e574
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071236-generous-jazz-41e4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 505b730ede7f5c4083ff212aa955155b5b92e574 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Fri, 4 Jul 2025 19:27:27 +0200
Subject: [PATCH] pwm: mediatek: Ensure to disable clocks in error path
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling the clocks each error path must disable the clocks again.
One of them failed to do so. Unify the error paths to use goto to make it
harder for future changes to add a similar bug.

Fixes: 7ca59947b5fc ("pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/20250704172728.626815-2-u.kleine-koenig@baylibre.com
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 7eaab5831499..33d3554b9197 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -130,8 +130,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-	if (!clk_rate)
-		return -EINVAL;
+	if (!clk_rate) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
@@ -150,9 +152,9 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
-		pwm_mediatek_clk_disable(chip, pwm);
 		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
@@ -169,9 +171,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
+out:
 	pwm_mediatek_clk_disable(chip, pwm);
 
-	return 0;
+	return ret;
 }
 
 static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)


