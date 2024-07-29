Return-Path: <stable+bounces-62470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A695E93F332
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A442C1C21205
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B40144D20;
	Mon, 29 Jul 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GbwU3pEc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71217145354
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250289; cv=none; b=PPPZdD9ywAL63L3rgkj6PcrE+wZzX/jHTB7AtxV3ewVJsCGz8H9VbiTceUjGZPvXhA++2VTtmIIc3IlQWUqXe4LQ8cM9pbKXPm3pbleAe8PZ8YQhvMP3naUA4U2rCB9oh5kHn39Z8i1xeMISO5uEhBzWJzin2mvr++nzIzmJbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250289; c=relaxed/simple;
	bh=HhsUwY0lmfAvDF5gVmLlLoitJPn8A6o0VbBnsibosuY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=adc8yaSJAFjuVseFvumvgVkLD3jsnkoSOy/yij+a0ppncnKUY8J7xDE5AxKxJ83HlVW1eldgQaZmrVYRz+dQfoXe8fvnxtnElFk/I1Wg1+gLksxopEyXBBGPcv4ES3Ff9WgzuyrMsR1d3UnA6G+jCGFr534GNB9BFjDoXLn1FKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GbwU3pEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04ADC4AF0B;
	Mon, 29 Jul 2024 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250289;
	bh=HhsUwY0lmfAvDF5gVmLlLoitJPn8A6o0VbBnsibosuY=;
	h=Subject:To:Cc:From:Date:From;
	b=GbwU3pEcqtWA3KfybYluiMwhvT+bUeH7nFWH8xpWx0Eb492An4Vzhn56QcFldzJnz
	 S1aPEhKbAfiwWn0vGH2GyAFjhOEyTK+90PkukUdBsxFA1lF9b41PhfqEyc1QAPHJ0K
	 y1Ppg01RpZcJ2g2r6k7pEX+lMGTT/RygxDXspPoA=
Subject: FAILED: patch "[PATCH] cpufreq: qcom-nvmem: fix memory leaks in probe error paths" failed to apply to 5.15-stable tree
To: javier.carrasco.cruz@gmail.com,viresh.kumar@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:51:17 +0200
Message-ID: <2024072917-daily-trio-3d03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d01c84b97f19f1137211e90b0a910289a560019e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072917-daily-trio-3d03@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d01c84b97f19 ("cpufreq: qcom-nvmem: fix memory leaks in probe error paths")
2a5d46c3ad6b ("cpufreq: qcom-nvmem: Simplify driver data allocation")
402732324b17 ("cpufreq: qcom-nvmem: Convert to platform remove callback returning void")
d78be404f97f ("cpufreq: qcom-nvmem: Switch to use dev_err_probe() helper")
49cd000dc51b ("cpufreq: qcom-nvmem: Migrate to dev_pm_opp_set_config()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d01c84b97f19f1137211e90b0a910289a560019e Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 23 May 2024 23:24:59 +0200
Subject: [PATCH] cpufreq: qcom-nvmem: fix memory leaks in probe error paths

The code refactoring added new error paths between the np device node
allocation and the call to of_node_put(), which leads to memory leaks if
any of those errors occur.

Add the missing of_node_put() in the error paths that require it.

Cc: stable@vger.kernel.org
Fixes: 57f2f8b4aa0c ("cpufreq: qcom: Refactor the driver to make it easier to extend")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index ea05d9d67490..5004e1dbc752 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -480,23 +480,30 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 	drv = devm_kzalloc(&pdev->dev, struct_size(drv, cpus, num_possible_cpus()),
 		           GFP_KERNEL);
-	if (!drv)
+	if (!drv) {
+		of_node_put(np);
 		return -ENOMEM;
+	}
 
 	match = pdev->dev.platform_data;
 	drv->data = match->data;
-	if (!drv->data)
+	if (!drv->data) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	if (drv->data->get_version) {
 		speedbin_nvmem = of_nvmem_cell_get(np, NULL);
-		if (IS_ERR(speedbin_nvmem))
+		if (IS_ERR(speedbin_nvmem)) {
+			of_node_put(np);
 			return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
 					     "Could not get nvmem cell\n");
+		}
 
 		ret = drv->data->get_version(cpu_dev,
 							speedbin_nvmem, &pvs_name, drv);
 		if (ret) {
+			of_node_put(np);
 			nvmem_cell_put(speedbin_nvmem);
 			return ret;
 		}


