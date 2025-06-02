Return-Path: <stable+bounces-148937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C2ACAD32
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197E57A273A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B402482EF;
	Mon,  2 Jun 2025 11:27:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744BA18F2FC
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748863677; cv=none; b=Y+yUQmdHlEY53Fzb9FopgCB2tHqEJ9/NqyRc0Ivd0RLSnSmdMUf4/Kj7nZ3YC6EZ2PEHgdCa8jVnafH1aYm2kfABqwBs79TT96xXjsOl/FRdKWx7g5ZXoZc0doOcsFmenn/l4TILK/hc4e0qR8Bu4Tt14i7NuNAmVkQA7yTBOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748863677; c=relaxed/simple;
	bh=BUDHAlW/HRDkviXrXJt4p3CXoQlXmR8/H9d2yi/0nRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UqpCPPXD2NTgIvArms8b2KqULKYUbi+S98b93DrFCV07ADeqt4NoF/eXEjsQtjVo65cJcgPUZNH8pllaVXnf4l37U9oUNygx9bS29YLsHpFo2qreXlR3LY8i1mcGwySLYLCP67IgAbs20W/wR9MTiF5Rs6xVix5vyPFHPnoBa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43FAF12FC;
	Mon,  2 Jun 2025 04:27:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C7753F673;
	Mon,  2 Jun 2025 04:27:54 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: stable@vger.kernel.org
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 5.10/5.15] perf/arm-cmn: Initialise cmn->cpu earlier
Date: Mon,  2 Jun 2025 12:27:45 +0100
Message-Id: <32923ed9af28f3857fd64f7cd884895e717258b0.1748861349.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 597704e201068db3d104de3c7a4d447ff8209127 upstream.

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
[ backport past NUMA changes in 5.17 ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index e2a055ba0b7a..cabeff8c944b 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1512,6 +1512,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	cmn->dev = &pdev->dev;
+	cmn->cpu = raw_smp_processor_id();
 	platform_set_drvdata(pdev, cmn);
 
 	if (has_acpi_companion(cmn->dev))
@@ -1533,7 +1534,6 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	cmn->cpu = raw_smp_processor_id();
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.attr_groups = arm_cmn_attr_groups,
-- 
2.39.2.101.g768bb238c484.dirty


