Return-Path: <stable+bounces-186078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356BCBE3812
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DBB584A94
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6923314CD;
	Thu, 16 Oct 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ONLlEWoo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE83314D0
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619141; cv=none; b=el66EzTSMlhjE9A1EbljmEKaZ3YQuei2WJ4ei+TvLbIYrKdQlqpzV8hcyKklDlNK1HrdOs+u/dwQ0ktITG0GVnFzDdmlk6VvoO279CmTVok693LSeRLuk0/0hnEMlKG+EKUiemnscqPzLqjvy7xLCBNc1/cB5jQ4YYDHDtn0KUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619141; c=relaxed/simple;
	bh=ho/fHbrtEOR4uoob6PYDHBYyFmT/fILqs9IbPhrFbUs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cjYK6HjWsxpqb5h4JP7k2ld6lUdEaacwzv+bHqLD4+RIT+5X3q/loLVD0ra16Ie1cK4XsgtT/xr84HDI7kThsqH7kNyDSnzpiCfMDmKYUAKm1DyeZqlR8BNWq30ZESY/LSbutgbmX2TDg2gVjtQiPVxIwYCywbEh0+hWhZ1JgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ONLlEWoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD0CC4CEF1;
	Thu, 16 Oct 2025 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619140;
	bh=ho/fHbrtEOR4uoob6PYDHBYyFmT/fILqs9IbPhrFbUs=;
	h=Subject:To:Cc:From:Date:From;
	b=ONLlEWoo/v4eHxcCOVM5Yyj32TMH+N4mbU//ri0HEWsF/DEFjWKN7M7YnjesD2Gy8
	 V/+wOB9wH/lLkH0GTzACcHK/K4vhRs+1C+3S3Z+/J4NIIxgy+MVRseW8qlFuA45bz4
	 bl+f0WMBKGf5NgDDrifOsKsioKu4cY2CMrkaQ/F0=
Subject: FAILED: patch "[PATCH] pwm: berlin: Fix wrong register in suspend/resume" failed to apply to 5.4-stable tree
To: jszhang@kernel.org,ukleinek@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:52:14 +0200
Message-ID: <2025101613-candle-babble-137f@gregkh>
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
git cherry-pick -x 3a4b9d027e4061766f618292df91760ea64a1fcc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101613-candle-babble-137f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a4b9d027e4061766f618292df91760ea64a1fcc Mon Sep 17 00:00:00 2001
From: Jisheng Zhang <jszhang@kernel.org>
Date: Tue, 19 Aug 2025 19:42:24 +0800
Subject: [PATCH] pwm: berlin: Fix wrong register in suspend/resume
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'enable' register should be BERLIN_PWM_EN rather than
BERLIN_PWM_ENABLE, otherwise, the driver accesses wrong address, there
will be cpu exception then kernel panic during suspend/resume.

Fixes: bbf0722c1c66 ("pwm: berlin: Add suspend/resume support")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Link: https://lore.kernel.org/r/20250819114224.31825-1-jszhang@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 831aed228caf..858d36991374 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -234,7 +234,7 @@ static int berlin_pwm_suspend(struct device *dev)
 	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
-		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
+		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_EN);
 		channel->ctrl = berlin_pwm_readl(bpc, i, BERLIN_PWM_CONTROL);
 		channel->duty = berlin_pwm_readl(bpc, i, BERLIN_PWM_DUTY);
 		channel->tcnt = berlin_pwm_readl(bpc, i, BERLIN_PWM_TCNT);
@@ -262,7 +262,7 @@ static int berlin_pwm_resume(struct device *dev)
 		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
 		berlin_pwm_writel(bpc, i, channel->duty, BERLIN_PWM_DUTY);
 		berlin_pwm_writel(bpc, i, channel->tcnt, BERLIN_PWM_TCNT);
-		berlin_pwm_writel(bpc, i, channel->enable, BERLIN_PWM_ENABLE);
+		berlin_pwm_writel(bpc, i, channel->enable, BERLIN_PWM_EN);
 	}
 
 	return 0;


