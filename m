Return-Path: <stable+bounces-62467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F4B93F32D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8EC1C219AA
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171A14532C;
	Mon, 29 Jul 2024 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8n4eZXR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A031144D34
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250279; cv=none; b=oXIGvjbyETzWNAADaJClt+QrWyYoXk3vkXrfot+AYxqJL6a9Ed9KQR5cXKC+9r5feA0k5L7c2c1G1pXvsv1//6Jg7X3BSOoydQetDjM0NGsJQiO6+u15C+Voiz93s5u0B7EnTMdyFzvnvafwYmfuYwpTY3GQ24gzaBMhDtiRivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250279; c=relaxed/simple;
	bh=qDQN9BtCdzhb1+O5nDruEGYrtzvmB2mRS+1WJlHsBo8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=egSRlHArcThxfwULKz8aus4ydfy8sA/JhrpkFimwVNOpMfYh2F0kkKurLF1TCtd1os7zruyZWyDpeFXQEHD1kAd2zdhOECavKCEdkWsQG1fK0A7ejtxb2vpIT/ZCs4z0UBZEj7Rm4aPX+WqtwkZN+iQtZOq10igxGfkzBnh8cgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8n4eZXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC48C32786;
	Mon, 29 Jul 2024 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250278;
	bh=qDQN9BtCdzhb1+O5nDruEGYrtzvmB2mRS+1WJlHsBo8=;
	h=Subject:To:Cc:From:Date:From;
	b=e8n4eZXRUFYIwFLDeZCjjpJCCrndDkZMg0eH9sX/lfx9QztllmauYviZEqGPCfET/
	 K4jSFu5j3+CUzBn8SNNK159sPS9rU2gX2+l2wVeoxQSJ9rcFoImyR1lInUZH+9abUJ
	 5vsR9mv7XpHdd9ER+xPmEj2onZmnA1hZ11CRqmc0=
Subject: FAILED: patch "[PATCH] cpufreq: qcom-nvmem: fix memory leaks in probe error paths" failed to apply to 6.6-stable tree
To: javier.carrasco.cruz@gmail.com,viresh.kumar@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:51:15 +0200
Message-ID: <2024072915-unweave-tiling-74ec@gregkh>
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
git cherry-pick -x d01c84b97f19f1137211e90b0a910289a560019e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072915-unweave-tiling-74ec@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d01c84b97f19 ("cpufreq: qcom-nvmem: fix memory leaks in probe error paths")
2a5d46c3ad6b ("cpufreq: qcom-nvmem: Simplify driver data allocation")

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


