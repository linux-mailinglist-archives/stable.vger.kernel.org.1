Return-Path: <stable+bounces-144848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E5ABBEE9
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F4B17F9C5
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A214B1E5D;
	Mon, 19 May 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kz/wc+Pe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923C1E2834
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660610; cv=none; b=HgPCCEJjBZdnTJ5TvE9ddr3EvaGKlU4iqRLsquxgaz5vJJdPGRvn9ZBWqn4meSAJXRAq6JOwFzW6gAadjgcO91dmkpJcZCkcDxxzEkYaxbJSEmvbg39qknuoT5okXkPq03rAaGdEGcg2rPvb4rHfnCcmLDb39bCf9FozeRa+CBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660610; c=relaxed/simple;
	bh=SJth/9G6pMaG9zlWdE1GvEV87nY08e3D59rHkpNZ40o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GOznloCUt+WzOzYOXjz5przKlRiKwRo0zZpKrbfxRFzqyF0nkw7/va/z69V+NOwNTJyKhPGLFBllCZEXGLKEH++YZPAwkXZdf20pIyx4BsP3EkH0nvrmv34NzbJs2Y8oH72blbi/iTvv5tmsIcIfXkIXV7HIOzjPU3/4VIeAIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kz/wc+Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3476DC4CEE4;
	Mon, 19 May 2025 13:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660609;
	bh=SJth/9G6pMaG9zlWdE1GvEV87nY08e3D59rHkpNZ40o=;
	h=Subject:To:Cc:From:Date:From;
	b=Kz/wc+Pe9PEQ+eLOLsfrB4OLEFYqi9vL3W+3euPcKkMJpkEf958EVwx5cxIco/4Ag
	 KmAiUEbg5IXzR0VsQn1OjCFVWKLPLwIMSJi/yHLAJGJb6zvX5htPamPuejuvP5mUtL
	 U3s2GOtH/AOsEi0G5LJMcW1Tf9hm8/efk3LlqiLU=
Subject: FAILED: patch "[PATCH] dmaengine: idxd: Refactor remove call with idxd_cleanup()" failed to apply to 5.15-stable tree
To: xueshuai@linux.alibaba.com,dave.jiang@intel.com,fenghuay@nvidia.com,vinicius.gomes@intel.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:16:38 +0200
Message-ID: <2025051938-garden-pungent-45cd@gregkh>
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
git cherry-pick -x a409e919ca321cc0e28f8abf96fde299f0072a81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051938-garden-pungent-45cd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a409e919ca321cc0e28f8abf96fde299f0072a81 Mon Sep 17 00:00:00 2001
From: Shuai Xue <xueshuai@linux.alibaba.com>
Date: Fri, 4 Apr 2025 20:02:17 +0800
Subject: [PATCH] dmaengine: idxd: Refactor remove call with idxd_cleanup()
 helper

The idxd_cleanup() helper cleans up perfmon, interrupts, internals and
so on. Refactor remove call with the idxd_cleanup() helper to avoid code
duplication. Note, this also fixes the missing put_device() for idxd
groups, enginces and wqs.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Cc: stable@vger.kernel.org
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20250404120217.48772-10-xueshuai@linux.alibaba.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 974b926bd930..760b7d81fcd8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1308,7 +1308,6 @@ static void idxd_shutdown(struct pci_dev *pdev)
 static void idxd_remove(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
-	struct idxd_irq_entry *irq_entry;
 
 	idxd_unregister_devices(idxd);
 	/*
@@ -1321,21 +1320,12 @@ static void idxd_remove(struct pci_dev *pdev)
 	get_device(idxd_confdev(idxd));
 	device_unregister(idxd_confdev(idxd));
 	idxd_shutdown(pdev);
-	if (device_pasid_enabled(idxd))
-		idxd_disable_system_pasid(idxd);
 	idxd_device_remove_debugfs(idxd);
-
-	irq_entry = idxd_get_ie(idxd, 0);
-	free_irq(irq_entry->vector, irq_entry);
-	pci_free_irq_vectors(pdev);
+	idxd_cleanup(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
-	if (device_user_pasid_enabled(idxd))
-		idxd_disable_sva(pdev);
-	pci_disable_device(pdev);
-	destroy_workqueue(idxd->wq);
-	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
 	idxd_free(idxd);
+	pci_disable_device(pdev);
 }
 
 static struct pci_driver idxd_pci_driver = {


