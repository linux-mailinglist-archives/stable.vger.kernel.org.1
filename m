Return-Path: <stable+bounces-106698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45499A00AD7
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C6E3A171C
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8B81386C9;
	Fri,  3 Jan 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mD/mQcL2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937D10F4
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915773; cv=none; b=KLXvcB8j45hjA3PF1YsnWF+kvK2UadFkWHyXcYTazp0O0s1frW7/lzfnNzJRzwSq9H4ICkBnBBaOVm4O03BwBISwwYJn/0+19cUlKE/VhjvKQsYL+aPGXgj3f+XsAat1ZGsKEsj0vbocORCZ5M2VyOQq73Le8uY68Sad041lOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915773; c=relaxed/simple;
	bh=Q5Zz/PIu7Meo0ky9sidkEXdlprcRi3tqNwwptc84pkk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bAH7Iesl+fvA4UD+08olvqY1r7Vq5NQ1SdsNqIskXpjLoizQwrluBqo71sKNVbgWC9lYPfL0LEFZ/QDH/QDneg3hbkB0PU0xOy2cJeHMgC8Lvf7mtnzzLi89Z+C7a7wOpytTEd9BDM/vhNnoLTi5K0w6XNdnV+1Yhq5Ym5KIxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mD/mQcL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5160FC4CECE;
	Fri,  3 Jan 2025 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735915772;
	bh=Q5Zz/PIu7Meo0ky9sidkEXdlprcRi3tqNwwptc84pkk=;
	h=Subject:To:Cc:From:Date:From;
	b=mD/mQcL2XN0V/BaYkYxHF3WX0fE+lK7/hnhI18MWwrHJZViTb7y4ABEud4hPzzq1L
	 5/DPsgWeniIyY9aoX8c6iCr8AvEssRt30tvPpi9PmjT6D0wdMEybF5lNFZGKloY8wi
	 Dl4FITnGOl5ekeUeKx5dRHBz4vHr7BYArqn8QIvo=
Subject: FAILED: patch "[PATCH] pmdomain: imx: gpcv2: fix an OF node reference leak in" failed to apply to 6.1-stable tree
To: joe@pf.is.s.u-tokyo.ac.jp,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Jan 2025 15:49:21 +0100
Message-ID: <2025010321-pampers-glazing-2689@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 469c0682e03d67d8dc970ecaa70c2d753057c7c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010321-pampers-glazing-2689@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 469c0682e03d67d8dc970ecaa70c2d753057c7c0 Mon Sep 17 00:00:00 2001
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Date: Sun, 15 Dec 2024 12:01:59 +0900
Subject: [PATCH] pmdomain: imx: gpcv2: fix an OF node reference leak in
 imx_gpcv2_probe()

imx_gpcv2_probe() leaks an OF node reference obtained by
of_get_child_by_name(). Fix it by declaring the device node with the
__free(device_node) cleanup construct.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: stable@vger.kernel.org
Message-ID: <20241215030159.1526624-1-joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index e67ecf99ef84..9bdb80fd7210 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1458,12 +1458,12 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		.max_register   = SZ_4K,
 	};
 	struct device *dev = &pdev->dev;
-	struct device_node *pgc_np;
+	struct device_node *pgc_np __free(device_node) =
+		of_get_child_by_name(dev->of_node, "pgc");
 	struct regmap *regmap;
 	void __iomem *base;
 	int ret;
 
-	pgc_np = of_get_child_by_name(dev->of_node, "pgc");
 	if (!pgc_np) {
 		dev_err(dev, "No power domains specified in DT\n");
 		return -EINVAL;


