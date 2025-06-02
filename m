Return-Path: <stable+bounces-148934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC1ACABFE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A75189C73E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD31A285;
	Mon,  2 Jun 2025 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W9CwpL2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998898BE5
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857899; cv=none; b=CsbEPou+nZxqkSR3LM9nyAj16tVCHOzMAWDqHy/zegTmb3zopMt4K2gIOGhXzgIGGInfcozS6xBRWme/w94xP5DwVo5BySXeZ+PV0nAS7P9dJX/qQel8yYrxe/McJw60VL3LmLG2AjraWkz2WyGBeR5zUwQgdxYnY2Cv8d3C7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857899; c=relaxed/simple;
	bh=raEJrH4G/Fkzawno873eiigg15SxuGCFNHtJ5sY/YN8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XE7R3TUNG6o6NUrEKNp+GaxcD2QEofsIR8E3g95GvoXLSNuoV6qoJqOesMVX65PaA5n9/QtM8GRriB2pK1p/ahXSFlYGikrPDupqj5uEk/78b2/+Dgl4BiCURUN95LQqLGzAUfqdSzEfEG4Z5tOg2j4Pgn+INHDpXZ6Ehxz2ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W9CwpL2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA54C4CEEB;
	Mon,  2 Jun 2025 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857899;
	bh=raEJrH4G/Fkzawno873eiigg15SxuGCFNHtJ5sY/YN8=;
	h=Subject:To:Cc:From:Date:From;
	b=W9CwpL2ovJNUzu8puwVi+GqKcTMDg/BvCFMU3Xza6lbZS9xv/jDDdnjzYUT+8lHcD
	 w/BUSaQnZYp2DkFvPM9P7jNlmCwhLL9i8RonNEP/pFTBM6vUCrv9MWhCdr9PRyMPw0
	 w4fah66SPWaNGRVzXRMn9eCVN27oymZsIp7EAWtc=
Subject: FAILED: patch "[PATCH] perf/arm-cmn: Initialise cmn->cpu earlier" failed to apply to 5.10-stable tree
To: robin.murphy@arm.com,ilkka@os.amperecomputing.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:51:28 +0200
Message-ID: <2025060228-pureness-wildcat-f43e@gregkh>
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
git cherry-pick -x 597704e201068db3d104de3c7a4d447ff8209127
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060228-pureness-wildcat-f43e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 597704e201068db3d104de3c7a4d447ff8209127 Mon Sep 17 00:00:00 2001
From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 12 May 2025 18:11:54 +0100
Subject: [PATCH] perf/arm-cmn: Initialise cmn->cpu earlier

For all the complexity of handling affinity for CPU hotplug, what we've
apparently managed to overlook is that arm_cmn_init_irqs() has in fact
always been setting the *initial* affinity of all IRQs to CPU 0, not the
CPU we subsequently choose for event scheduling. Oh dear.

Cc: stable@vger.kernel.org
Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Link: https://lore.kernel.org/r/b12fccba6b5b4d2674944f59e4daad91cd63420b.1747069914.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 83f4ef985255..668c581e932a 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2551,6 +2551,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 
 	cmn->dev = &pdev->dev;
 	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
+	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	platform_set_drvdata(pdev, cmn);
 
 	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
@@ -2578,7 +2579,6 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.parent = cmn->dev,


