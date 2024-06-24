Return-Path: <stable+bounces-55075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B359154B1
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731601C2138A
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65D419D06B;
	Mon, 24 Jun 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K7+wCSRd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA82F24
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247681; cv=none; b=W5b3E4wWPqPL7sllSc1c8W2D87Sdj/HmzqAocmkBycBTH2ktxUQfGvr/AIvaK8EXxPqcZuvGAnxHr6/TqE+yAFF9MW+m2BL/VN2f7ZdSN3LnJ/f2DeI6dIfxVVFSDy7z3+r3dg0FTarrvoQItFa0X9iOe/NAhdm0wEHneJKvrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247681; c=relaxed/simple;
	bh=lrSr/FoLLjBHS5B7RqkIxoBe4c4JgsEYYfB12iv0GbU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z2004NW+4OeFgnFDq0ziAROqgOyQa6E2juAANomAeDCQzw2WzssxMLrTrrFMB4rqTiE/+NNLaWnex0rmIm6uWI/gmyfQqFUAW3XYz183wL5poPbmDThabsPLEM2zNgneidMtHbdhJh/NnVqSZS3ImD+fxA/dHamxJhs4pj4XeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K7+wCSRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E87C2BBFC;
	Mon, 24 Jun 2024 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247681;
	bh=lrSr/FoLLjBHS5B7RqkIxoBe4c4JgsEYYfB12iv0GbU=;
	h=Subject:To:Cc:From:Date:From;
	b=K7+wCSRdDyVEa7kRrxP0diHgyXbdjPzrORa0leQ9JAapmIl11dllT2NOE+lnOgUau
	 yb9FT/G0+Y4zC102LW9739JAvY+oe+8UxRXa+thviAy1cEL/vezFr6LVdoiQUTzm+w
	 O9daQU08xdM306UemzpcF9cFRtWncnUPhgR6JWFg=
Subject: FAILED: patch "[PATCH] pwm: stm32: Refuse too small period requests" failed to apply to 6.6-stable tree
To: u.kleine-koenig@baylibre.com,tgamblin@baylibre.com,ukleinek@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:47:55 +0200
Message-ID: <2024062455-magnetism-backing-fbef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c45fcf46ca2368dafe7e5c513a711a6f0f974308
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062455-magnetism-backing-fbef@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c45fcf46ca2368dafe7e5c513a711a6f0f974308 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Fri, 21 Jun 2024 16:37:12 +0200
Subject: [PATCH] pwm: stm32: Refuse too small period requests
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If period_ns is small, prd might well become 0. Catch that case because
otherwise with

	regmap_write(priv->regmap, TIM_ARR, prd - 1);

a few lines down quite a big period is configured.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
Cc: stable@vger.kernel.org
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/b86f62f099983646f97eeb6bfc0117bb2d0c340d.1718979150.git.u.kleine-koenig@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a2f231d13a9f..3e7b2a8e34e7 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -337,6 +337,8 @@ static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 
 	prd = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
 				  (u64)NSEC_PER_SEC * (prescaler + 1));
+	if (!prd)
+		return -EINVAL;
 
 	/*
 	 * All channels share the same prescaler and counter so when two


