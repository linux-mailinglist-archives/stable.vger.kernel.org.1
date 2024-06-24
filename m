Return-Path: <stable+bounces-55079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E399154B5
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575EB1C2134C
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180EA19B5A5;
	Mon, 24 Jun 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CxMHsZrp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6F2F24
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247694; cv=none; b=XyiC8BQVktVwk7H4BOSIRoRxMPyJJUWMqa35VWlmrZntwLFZmcXz32HHcX70cd5fyq9UkQCFs1rKb5CyZyqRsRKJpEndnmmhd5Yfh4MGw8Qapsf50CWo9c1e3D0NARRo84llOokDXw3Q4nmcuBb8xf2DqC65amzf/5qvn9EJFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247694; c=relaxed/simple;
	bh=To3zCBHaC180yvyMkkT5tFwG+UJB5SkWSKmsGliIUqQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N6m7hyIr+Z+VMflQOoOcaJN99Q6axQcsuZfdO4PcHRRa0o2Y0CisN4DPG7oyWKYsPpnhIGiUjfi5aRayYVOm4k2xy0lR6sEUW8oDEFecJq+Qnvw6cDJFqbgEqCIvciPhIIUKkqYKDWt9KO+m/+NZzGymjiGw8oQAcRnvIFkYBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CxMHsZrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540A1C2BBFC;
	Mon, 24 Jun 2024 16:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247694;
	bh=To3zCBHaC180yvyMkkT5tFwG+UJB5SkWSKmsGliIUqQ=;
	h=Subject:To:Cc:From:Date:From;
	b=CxMHsZrpyYrwLVj/X/DspDwVE+N8iC9EKcmuAj9zft1gDqTfUKWtsBUTCbF3EvAPg
	 y4rjsC2BROL5gp4b1HP+pEUyhVAnxvCwlngz8Yz5UhU+oTVnOb0GcAjCKbxW63tPyk
	 g2mWk6eGnWGtSVgw3lSyk2bBmErkQG/fC5/yipC4=
Subject: FAILED: patch "[PATCH] pwm: stm32: Refuse too small period requests" failed to apply to 5.4-stable tree
To: u.kleine-koenig@baylibre.com,tgamblin@baylibre.com,ukleinek@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:47:58 +0200
Message-ID: <2024062458-try-bouncing-bb82@gregkh>
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
git cherry-pick -x c45fcf46ca2368dafe7e5c513a711a6f0f974308
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062458-try-bouncing-bb82@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


