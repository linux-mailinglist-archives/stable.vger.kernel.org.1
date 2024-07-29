Return-Path: <stable+bounces-62468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8593F32F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF9B229A3
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446914372D;
	Mon, 29 Jul 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wUYAEiHP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7004140E30
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250282; cv=none; b=RVoji5hs4OswsZzTPBJaLEzgV0sQ+KuOrBDlItS9LYfjS+WL2IdSS+Cuf5QROjhOVA1r/BcJ6l6ZhQaVClD56VlkiOMlqz8elUGyxAwQD/QwkGPqyIPgwktQHGfKd/YQ5avianJCWU/gaY1QmCztBnhI7ybngeyGpJWRJP05xgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250282; c=relaxed/simple;
	bh=euzWaowhKmZ/hzQESS8/1kB341OWDLlhNPy59Ur7eAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nNk0yvFwVivO1rfu1oHD08O1jjOwz02WadLQ37JeCDdVH/fOmcnAIZbSqcqeEZy4FYTjV4uokOEqALbMBBRVieB2mVxC2phnBB6f9jQJZLD3ihzRoAEWlwNPWcwR+zE8zGfmoVanoachn1zOyKvXKp271CAefmJHI+DW2K4U+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wUYAEiHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2123C32786;
	Mon, 29 Jul 2024 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250282;
	bh=euzWaowhKmZ/hzQESS8/1kB341OWDLlhNPy59Ur7eAg=;
	h=Subject:To:Cc:From:Date:From;
	b=wUYAEiHP73Y30Is8FtZPTKJcr6KjFwsu/hF2Zcm4PFIgCo3ijpd4eW19um4MSnI0p
	 rliUVuBOcbvNolLTO6ODfDW9I3Vt9ofr/k+yYr3UvKu1AoNvovKXntQE/IxWsgWemx
	 fd1oYJZrMoS5GaCC0b3LAaThaeUyDmFUCFQ4uHfg=
Subject: FAILED: patch "[PATCH] cpufreq: qcom-nvmem: fix memory leaks in probe error paths" failed to apply to 6.1-stable tree
To: javier.carrasco.cruz@gmail.com,viresh.kumar@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:51:16 +0200
Message-ID: <2024072916-lusty-flashy-062b@gregkh>
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
git cherry-pick -x d01c84b97f19f1137211e90b0a910289a560019e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072916-lusty-flashy-062b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d01c84b97f19 ("cpufreq: qcom-nvmem: fix memory leaks in probe error paths")
2a5d46c3ad6b ("cpufreq: qcom-nvmem: Simplify driver data allocation")
402732324b17 ("cpufreq: qcom-nvmem: Convert to platform remove callback returning void")

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


