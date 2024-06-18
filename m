Return-Path: <stable+bounces-53645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D6A90D556
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921022864F8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E1C1514EE;
	Tue, 18 Jun 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbMtz607"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9313C83D
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720241; cv=none; b=AnnWHYt5lNu4lmcYSHSIngTgeeW0yJsS9kagMgbxCtRaw321u0v26myMvh+etE/yl5beIq+oat5mCk6W1/jmVSNlxigrjArt8guKQqnv36s4d7D54faoUaj0jGxkbmBYrFWohG5mmJvCHn05l+LeQHdUvKwpYN/wTsqAg1Cl2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720241; c=relaxed/simple;
	bh=TGnCS0Wzw0lUsZ/yxrXINgcxxPMars6JvnJ+jpAU8Uc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HkI2AKpEftIaXZ4Pif5H2hGJMDMvaLiZaYPmqW7VLgZBdCpi+LVHpC7EWPUmgD2jxsqt101sJuuJW3Ie1s4uYfJhbbkSjVVmYo7qZy+kc0VF8oGy20s64yuqdjIZGNERZkwd5qClnCzDu72gdtsw37Hd+aXANl8NfwbN+XyaTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbMtz607; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A54C3277B;
	Tue, 18 Jun 2024 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718720240;
	bh=TGnCS0Wzw0lUsZ/yxrXINgcxxPMars6JvnJ+jpAU8Uc=;
	h=Subject:To:Cc:From:Date:From;
	b=FbMtz607jSiJIHZhpLgkSwDUuZWGAVTjKUs3z3e1FtlTOAxqqxMIrBI7CCJD72RL/
	 dPxxRNmhhO/XWi0FTo2Jg7NJd7OY0+mrWbb3nxJhxS4VqbSvCjrKX6wKXuvtG1lHMJ
	 f8rGXs4biGt1H5BOXcRUnyIxfIfNHg7cWE93k9so=
Subject: FAILED: patch "[PATCH] remoteproc: k3-r5: Wait for core0 power-up before powering up" failed to apply to 5.10-stable tree
To: a-nandan@ti.com,b-padhi@ti.com,mathieu.poirier@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 16:17:17 +0200
Message-ID: <2024061816-plug-grub-253a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 61f6f68447aba08aeaa97593af3a7d85a114891f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061816-plug-grub-253a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up before powering up core1")
1168af40b1ad ("remoteproc: k3-r5: Add support for IPC-only mode for all R5Fs")
ee99ee7c929c ("remoteproc: k3-r5: Extend support to R5F clusters on AM64x SoCs")
c3c21b356505 ("remoteproc: k3-r5: Adjust TCM sizes in Split-mode on J7200 SoCs")
7508ea19b20d ("remoteproc: k3-r5: Extend support to R5F clusters on J7200 SoCs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61f6f68447aba08aeaa97593af3a7d85a114891f Mon Sep 17 00:00:00 2001
From: Apurva Nandan <a-nandan@ti.com>
Date: Tue, 30 Apr 2024 16:23:06 +0530
Subject: [PATCH] remoteproc: k3-r5: Wait for core0 power-up before powering up
 core1

PSC controller has a limitation that it can only power-up the second core
when the first core is in ON state. Power-state for core0 should be equal
to or higher than core1, else the kernel is seen hanging during rproc
loading.

Make the powering up of cores sequential, by waiting for the current core
to power-up before proceeding to the next core, with a timeout of 2sec.
Add a wait queue event in k3_r5_cluster_rproc_init call, that will wait
for the current core to be released from reset before proceeding with the
next core.

Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240430105307.1190615-2-b-padhi@ti.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index ad3415a3851b..6d6afd6beb3a 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -103,12 +103,14 @@ struct k3_r5_soc_data {
  * @dev: cached device pointer
  * @mode: Mode to configure the Cluster - Split or LockStep
  * @cores: list of R5 cores within the cluster
+ * @core_transition: wait queue to sync core state changes
  * @soc_data: SoC-specific feature data for a R5FSS
  */
 struct k3_r5_cluster {
 	struct device *dev;
 	enum cluster_mode mode;
 	struct list_head cores;
+	wait_queue_head_t core_transition;
 	const struct k3_r5_soc_data *soc_data;
 };
 
@@ -128,6 +130,7 @@ struct k3_r5_cluster {
  * @atcm_enable: flag to control ATCM enablement
  * @btcm_enable: flag to control BTCM enablement
  * @loczrama: flag to dictate which TCM is at device address 0x0
+ * @released_from_reset: flag to signal when core is out of reset
  */
 struct k3_r5_core {
 	struct list_head elem;
@@ -144,6 +147,7 @@ struct k3_r5_core {
 	u32 atcm_enable;
 	u32 btcm_enable;
 	u32 loczrama;
+	bool released_from_reset;
 };
 
 /**
@@ -460,6 +464,8 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 			ret);
 		return ret;
 	}
+	core->released_from_reset = true;
+	wake_up_interruptible(&cluster->core_transition);
 
 	/*
 	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
@@ -1140,6 +1146,12 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
 		return ret;
 	}
 
+	/*
+	 * Skip the waiting mechanism for sequential power-on of cores if the
+	 * core has already been booted by another entity.
+	 */
+	core->released_from_reset = c_state;
+
 	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
 				     &stat);
 	if (ret < 0) {
@@ -1280,6 +1292,26 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
 		    cluster->mode == CLUSTER_MODE_SINGLECORE)
 			break;
+
+		/*
+		 * R5 cores require to be powered on sequentially, core0
+		 * should be in higher power state than core1 in a cluster
+		 * So, wait for current core to power up before proceeding
+		 * to next core and put timeout of 2sec for each core.
+		 *
+		 * This waiting mechanism is necessary because
+		 * rproc_auto_boot_callback() for core1 can be called before
+		 * core0 due to thread execution order.
+		 */
+		ret = wait_event_interruptible_timeout(cluster->core_transition,
+						       core->released_from_reset,
+						       msecs_to_jiffies(2000));
+		if (ret <= 0) {
+			dev_err(dev,
+				"Timed out waiting for %s core to power up!\n",
+				rproc->name);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1709,6 +1741,7 @@ static int k3_r5_probe(struct platform_device *pdev)
 	cluster->dev = dev;
 	cluster->soc_data = data;
 	INIT_LIST_HEAD(&cluster->cores);
+	init_waitqueue_head(&cluster->core_transition);
 
 	ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
 	if (ret < 0 && ret != -EINVAL) {


