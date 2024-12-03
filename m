Return-Path: <stable+bounces-96266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F15F9E1AF2
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6C3B2A842
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7501E0E13;
	Tue,  3 Dec 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vFyJoGr5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F51E0E0C
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220754; cv=none; b=NwYvVXBizc8HBfi/5KPGT2WDa11g3fyz9+2iH8MhmoVaOq+P8hYGH+LXOzGNaiGeFBbrt/X+QUqNHv+yPt5VKxKIxX8aSLemmu8cv80ZUiyLdTwSloiIG/8Ofr6Bc2gdCUkfCZuBEW5SNU7dmxXvfwerASAJu8k6DGhBW0Hov5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220754; c=relaxed/simple;
	bh=Zw96vQu6NMfM217e/igQVzff7WLTEXmi9vUFt5O6ysE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sNSFtIBbOQqcXlVkd2qtTPsr4qpt2gfriY3dBHXV7p6EMkLEEle15QbwCoAvy1QbR467zJesCZH5MIKAWCXqX6gP9u3W+RSDb0xLz0YGKkjX5IVMkb0tnYw/XPMoKe8+B5fr5Bm+7+0czzyftNk5QOb2oANuUiDZY5NEBIWclQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vFyJoGr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE65C4CECF;
	Tue,  3 Dec 2024 10:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733220754;
	bh=Zw96vQu6NMfM217e/igQVzff7WLTEXmi9vUFt5O6ysE=;
	h=Subject:To:Cc:From:Date:From;
	b=vFyJoGr55p9pkcInndE79QrcOCAPgp+5t1PWZfrA4XICd5IGTOEYsQ0+5rTyYWetW
	 RWWhHB3Lk4M3wbTQmw90FfMMj4u61sSWmS3Z6/9qwVtZYuKGKFCmL0QeA6P5uqRe6f
	 hDLTx/dmvTgyHDj5+vokWx6UGYnsX7Y4quUmR9is=
Subject: FAILED: patch "[PATCH] soc: fsl: cpm1: qmc: Set the ret error code on" failed to apply to 6.11-stable tree
To: herve.codina@bootlin.com,christophe.leroy@csgroup.eu,dan.carpenter@linaro.org,lkp@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:12:31 +0100
Message-ID: <2024120330-purifier-maturely-c720@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x cb3daa51db819a172e9524e96e2ed96b4237e51a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120330-purifier-maturely-c720@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb3daa51db819a172e9524e96e2ed96b4237e51a Mon Sep 17 00:00:00 2001
From: Herve Codina <herve.codina@bootlin.com>
Date: Tue, 5 Nov 2024 15:56:23 +0100
Subject: [PATCH] soc: fsl: cpm1: qmc: Set the ret error code on
 platform_get_irq() failure

A kernel test robot detected a missing error code:
   qmc.c:1942 qmc_probe() warn: missing error code 'ret'

Indeed, the error returned by platform_get_irq() is checked and the
operation is aborted in case of failure but the ret error code is
not set in that case.

Set the ret error code.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411051350.KNy6ZIWA-lkp@intel.com/
Fixes: 3178d58e0b97 ("soc: fsl: cpm1: Add support for QMC")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/r/20241105145623.401528-1-herve.codina@bootlin.com
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 3dffebb48b0d..fa7dc7d4abf3 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -2005,8 +2005,10 @@ static int qmc_probe(struct platform_device *pdev)
 
 	/* Set the irq handler */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq < 0) {
+		ret = irq;
 		goto err_exit_xcc;
+	}
 	ret = devm_request_irq(qmc->dev, irq, qmc_irq_handler, 0, "qmc", qmc);
 	if (ret < 0)
 		goto err_exit_xcc;


