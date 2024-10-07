Return-Path: <stable+bounces-81414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF3993439
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDB3283740
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDEC1DC1AF;
	Mon,  7 Oct 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BAo5k6J+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEB31DB352
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320235; cv=none; b=nwIDPVWOKyj8gBHS3vymKSw7nJbr1vo4QlBFGa+Zz5wDPkm4Ii3+58iB2gaEqzFgwFrzGJmejYLS0L0G7SlquYStWMrktAPaqClqrMEHCHkciWa0uWeA94UWeTNPEbpNgwOIdbDefcx+58bMrHse/U1hvgBf6r0VoejrQhqXsrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320235; c=relaxed/simple;
	bh=G6bMtaAWd1FLrXHegujQSiwhx1x8DZdsQ8Cgecc4IdA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PnJ9bI8PtR0JTPWHCBuS9/Aziz/UfwOegkhV7a3mgJIuHH9Eh33AerEy+8wo7LekCDsO/mvg7T9uNl+XltlkUaJsgUsRDHV6GmiZZN0DlbGnLMMC1AJwoJrqVi8KyUQsHLA/n1Y48NNGUDfYQX3eEm0CQP2LcP5L8Sm1NioOLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BAo5k6J+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB529C4CEC6;
	Mon,  7 Oct 2024 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320235;
	bh=G6bMtaAWd1FLrXHegujQSiwhx1x8DZdsQ8Cgecc4IdA=;
	h=Subject:To:Cc:From:Date:From;
	b=BAo5k6J+r/pBFXLPcDD426kaa8YOl6LUe6KM/SFXaBUkfhaOIeFzx81pGIX7nhZ4l
	 6DRDpAlFzlP732v83kS1dfXMfUglmlLcsv9gln+5WCoOKn4/l6C/5IbQV2tDR/ahim
	 iwHInkx8JeQp9Hd+VRpBATP1w2G6JYWz3bTBg/Kk=
Subject: FAILED: patch "[PATCH] rtc: at91sam9: fix OF node leak in probe() error path" failed to apply to 4.19-stable tree
To: krzysztof.kozlowski@linaro.org,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:57:11 +0200
Message-ID: <2024100711-womanhood-immerse-83a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 73580e2ee6adfb40276bd420da3bb1abae204e10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100711-womanhood-immerse-83a6@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

73580e2ee6ad ("rtc: at91sam9: fix OF node leak in probe() error path")
1a76a77c8800 ("rtc: at91sam9: drop platform_data support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73580e2ee6adfb40276bd420da3bb1abae204e10 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 20:31:03 +0200
Subject: [PATCH] rtc: at91sam9: fix OF node leak in probe() error path

Driver is leaking an OF node reference obtained from
of_parse_phandle_with_fixed_args().

Fixes: 43e112bb3dea ("rtc: at91sam9: make use of syscon/regmap to access GPBR registers")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240825183103.102904-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index f93bee96e362..993c0878fb66 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -368,6 +368,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 		return ret;
 
 	rtc->gpbr = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
 	rtc->gpbr_offset = args.args[0];
 	if (IS_ERR(rtc->gpbr)) {
 		dev_err(&pdev->dev, "failed to retrieve gpbr regmap, aborting.\n");


