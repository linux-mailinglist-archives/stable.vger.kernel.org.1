Return-Path: <stable+bounces-96267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950579E18F1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7B128102F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677CC1E0E12;
	Tue,  3 Dec 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LyixLqxn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFE1E0DE9
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220763; cv=none; b=ZVHa+bG3EV6eb8WBLGkHONV/ClVCu/sDUZacVq7hS+/6WBCEHGXFLmfIxm0YPRAdIDMTbWyUE0HFUcmB//lNJr7F1gu0uBVvNcEnTisuPsd2K05L40DnR8ysrwq4vcINouw2Rr+AAIKz6bchHrX2jO0UqmEVT3+P61qRr5gVuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220763; c=relaxed/simple;
	bh=PMh41EgOTONmZ1NnjXQYLIiSNCKo0d8ndLBTJBVu/nM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CO0u8zNLmc456AJefXzStvXxL5k1rTGps5gyrHWt0GXuseYNKKVCCDGZaNL/NPE70xgLUFSK7oQpiqL3KJZO2gQyw0K7mMZGU4nM/NRmtTbiPmazW3GZSlqe4nAytdzlUmZ73xojPJlHQ3kWOif2cgbokNYnxlGiSlbbjsa4JOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LyixLqxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0FAC4CECF;
	Tue,  3 Dec 2024 10:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733220763;
	bh=PMh41EgOTONmZ1NnjXQYLIiSNCKo0d8ndLBTJBVu/nM=;
	h=Subject:To:Cc:From:Date:From;
	b=LyixLqxnm1hQ2rEY2dGrEklSRlx0yLefDNp9yoTl7g9AmRL4ikIomK1PNjoJYtQoK
	 7IApm0x8+WNMLe9gOxunMTzHXjXAbGuK9t7qFGg3EWvWfS6NFJbgZqS1Kn3EQST5Zk
	 Bvlw5AI3wIv3sW5oWKBVVgVBaFbmsY+5iTSi2RCY=
Subject: FAILED: patch "[PATCH] soc: fsl: cpm1: qmc: Set the ret error code on" failed to apply to 6.6-stable tree
To: herve.codina@bootlin.com,christophe.leroy@csgroup.eu,dan.carpenter@linaro.org,lkp@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:12:31 +0100
Message-ID: <2024120331-disarm-unfixed-bbec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cb3daa51db819a172e9524e96e2ed96b4237e51a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120331-disarm-unfixed-bbec@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


