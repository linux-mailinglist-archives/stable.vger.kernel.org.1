Return-Path: <stable+bounces-161730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01518B02B2B
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 16:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BB4A462AE
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7727935C;
	Sat, 12 Jul 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R9zjFYVK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36AE1F5823
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328854; cv=none; b=Y1u0SKTSjd3QtvfufuD2aUvEAelkGLQYdHyBkEupcD9uNbuTQhvoWWZy3lgc6BAG5KvWSeGVVnqbT5DQd0vRYNpWPMMWibec1hQOZcdCVdakYnFxSutOpXgkSL9WVEu0A0AOG7qJE1Hg05d/MDoxMETsHZHbrsMDp7yTZrmyS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328854; c=relaxed/simple;
	bh=6R0KOqo70rHzWjQTXyZv7eGdio2PyKXQDsqm7jjFjH8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tjWzFs5ak++RNxoXVWoux63PhvhBigwuQ8yezyBqig9YVlYLaqpeHSu70EOEE8Ic0RJwy4tCBiJUQGH/IFg1QqPxxM0kcNFDmadAaKiVhf5iXsbt0W55iWH87WlkoBalM5mtOz1aVj93LWV0URCd159aYA8sDZWX2KiX9IzeeRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R9zjFYVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33673C4CEEF;
	Sat, 12 Jul 2025 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752328853;
	bh=6R0KOqo70rHzWjQTXyZv7eGdio2PyKXQDsqm7jjFjH8=;
	h=Subject:To:Cc:From:Date:From;
	b=R9zjFYVKsYKyQohpq4hWgvHbSyCbiVYvNG1vkMnt8CYiwXg31HYYPuNB58mpMZ6v9
	 xGNJmuDPLufV4usixgwR+AEBn43AW3B1068H2apS6pW2JM5DKQg5aToQUBOxs+obRr
	 FsQTIFGzhZhD1H6GRJ+tCSZv9ArcbC3pGyCxKLgE=
Subject: FAILED: patch "[PATCH] pwm: mediatek: Ensure to disable clocks in error path" failed to apply to 5.10-stable tree
To: u.kleine-koenig@baylibre.com,ukleinek@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 12 Jul 2025 16:00:36 +0200
Message-ID: <2025071236-propeller-quality-54b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 505b730ede7f5c4083ff212aa955155b5b92e574
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071236-propeller-quality-54b9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


