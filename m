Return-Path: <stable+bounces-78532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4871998BF01
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3622856E8
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C051C57BC;
	Tue,  1 Oct 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BLnOqeMl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2B17FD
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791639; cv=none; b=jjg838H+ojwXEcKzh+zkoLhJq1OYFJmUmQOO0GzgnCxM2qYKEqG3cPmm4CDGo6lmUQWMGsz6QkUPFWQqPJccEUbeoGKdd7RBjxaESYPGLNwexNz6rik30sraa1u2nj/RtnsV9kn1OGFnAlBLfn/cfwRif70XDch/oZSzJhj0kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791639; c=relaxed/simple;
	bh=kzGuXPmt0ogePb5Ah+WVEHduUK4Ph1SpbZRRdSY6xKI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a+2URDrEJdU7CiKcuNrp0zhQ4PFFLlVBeK+Z1FrQlSPWSuUAxibkNll2y4zz6LyOq+SEPTT9SBFEmo9NRMdabOjbZcSU9sKRQ4DAx4ERmB8TQuwpjEZJCPNvzHSTnot1ZQonywFl81gu05qXlfJAsp/AIYPba6YDKyANr+x7c4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BLnOqeMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3ABC4CEC6;
	Tue,  1 Oct 2024 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791639;
	bh=kzGuXPmt0ogePb5Ah+WVEHduUK4Ph1SpbZRRdSY6xKI=;
	h=Subject:To:Cc:From:Date:From;
	b=BLnOqeMly4ZVgJ7DH61fU8E+4yu0qgMzfFqlgKQC94wNIqEo4IRaB0S2HrcvP4/WH
	 PbAFhICTJZiHmsphmKk99u5rb2UlRIEcJdrDlPnx415UtQkZObV14WaJs69WUhmCD6
	 6cDzMZsJKDVm+zp3S6ggye8wOxXVpy8mIXcsJVKo=
Subject: FAILED: patch "[PATCH] hwrng: mtk - Use devm_pm_runtime_enable" failed to apply to 4.19-stable tree
To: guoqing.jiang@canonical.com,herbert@gondor.apana.org.au,stable@vger.kernel.org,wenst@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 16:06:30 +0200
Message-ID: <2024100129-herring-nutcase-68d7@gregkh>
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
git cherry-pick -x 78cb66caa6ab5385ac2090f1aae5f3c19e08f522
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100129-herring-nutcase-68d7@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

78cb66caa6ab ("hwrng: mtk - Use devm_pm_runtime_enable")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78cb66caa6ab5385ac2090f1aae5f3c19e08f522 Mon Sep 17 00:00:00 2001
From: Guoqing Jiang <guoqing.jiang@canonical.com>
Date: Mon, 26 Aug 2024 15:04:15 +0800
Subject: [PATCH] hwrng: mtk - Use devm_pm_runtime_enable

Replace pm_runtime_enable with the devres-enabled version which
can trigger pm_runtime_disable.

Otherwise, the below appears during reload driver.

mtk_rng 1020f000.rng: Unbalanced pm_runtime_enable!

Fixes: 81d2b34508c6 ("hwrng: mtk - add runtime PM support")
Cc: <stable@vger.kernel.org>
Suggested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Guoqing Jiang <guoqing.jiang@canonical.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/mtk-rng.c b/drivers/char/hw_random/mtk-rng.c
index aa993753ab12..1e3048f2bb38 100644
--- a/drivers/char/hw_random/mtk-rng.c
+++ b/drivers/char/hw_random/mtk-rng.c
@@ -142,7 +142,7 @@ static int mtk_rng_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, RNG_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	devm_pm_runtime_enable(&pdev->dev);
 
 	dev_info(&pdev->dev, "registered RNG driver\n");
 


