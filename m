Return-Path: <stable+bounces-55076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C089154B2
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20BA286062
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500D619D8BB;
	Mon, 24 Jun 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vH9McDWU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A692F24
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247684; cv=none; b=CLo6O00mC9QeZY8Rmt9fkyn+nr4/NM4PJi5EEbxRgZuSsYafYmx+2uCzMiE8xofy4DM93gmJ/FQZWsFpsn3Z7amlOaby7+kcfDFh0cHk9Owyd8GIysVE5mSpn8w6j77etxwVMZnefXG7bG+XDiQP/XqIFToCAn8jkDrwd/ypOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247684; c=relaxed/simple;
	bh=5cqvUQhxmgBcitw0z3rMaMoHifd1KDRTDIhyGL/swv0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nCuGBXv7yl63zFBQQkBQcLmItvr0urlWUK2ABVBfoTRO+S7fATKhlNO/CTyRsdXcJaucdvkcK0fInniynox9SWDO/CBntLJIZ+BuxPTYjMSogP69g7DwHTLXGbOOvcijX5GhrqVw7SZ0bDkxGZgqO+tPRdXcWzMes5nnlUydMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vH9McDWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F245C2BBFC;
	Mon, 24 Jun 2024 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247683;
	bh=5cqvUQhxmgBcitw0z3rMaMoHifd1KDRTDIhyGL/swv0=;
	h=Subject:To:Cc:From:Date:From;
	b=vH9McDWUQnlCFvL79A4Sv+uUANTrtFAc/UE4AOT4A2lOZTKQXKt+JYEonHzKeLVmV
	 8skCuflrcQPUGwgvvqDjVvDQNGH1Jx5etfY+4CMt+U034WMv0fCL6xTQJeIy/jkPkP
	 jUZpipFRoaaXFtsL7WRY1zq14dwhaXS8r++oiGl4=
Subject: FAILED: patch "[PATCH] pwm: stm32: Refuse too small period requests" failed to apply to 6.1-stable tree
To: u.kleine-koenig@baylibre.com,tgamblin@baylibre.com,ukleinek@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:47:56 +0200
Message-ID: <2024062456-unvocal-anyone-3135@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c45fcf46ca2368dafe7e5c513a711a6f0f974308
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062456-unvocal-anyone-3135@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


