Return-Path: <stable+bounces-143302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEFDAB3EBA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632751892816
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2072829614C;
	Mon, 12 May 2025 17:12:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6C0295DBC;
	Mon, 12 May 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069924; cv=none; b=WifShJNSCTapiBQA6CU6fmRTxy7tVxFUTbKQ36c9ONWQAB3BjCfUVlPrAUJatGqso+ICBCCMijzeN+YcV0/RIVJF3YpysjhfbqHWLcMResrBVl3PHM3/ViR/W2rQ1eLH+eTo5/341IH0In2qZWXQTb2PnXwNoVkGn+FgirC4pSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069924; c=relaxed/simple;
	bh=YQAqmLSEfsqQI4ikGcBuyqDc3yyBkf4Jaek6Xl7YfJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=brJ8DRkTT5Lt8qgNAiW/4GgXuEKBMLrTDnGPjFtv/GHKFX4E2JcbpgVoJbZkY6QFcBOmFaEbTYoEdorTgA4+6korbmKJH2a0qmPL+KrY8dLMPjv0xJRqlFxZz4cW9QcsJLGECQwWmh3JExNXHAYq+w66rTkn8eOGdAABRLpHHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90F6D14BF;
	Mon, 12 May 2025 10:11:49 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7D993F7A6;
	Mon, 12 May 2025 10:11:59 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] perf/arm-cmn: Initialise cmn->cpu earlier
Date: Mon, 12 May 2025 18:11:54 +0100
Message-Id: <b12fccba6b5b4d2674944f59e4daad91cd63420b.1747069914.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For all the complexity of handling affinity for CPU hotplug, what we've
apparently managed to overlook is that arm_cmn_init_irqs() has in fact
always been setting the *initial* affinity of all IRQs to CPU 0, not the
CPU we subsequently choose for event scheduling. Oh dear.

Cc: stable@vger.kernel.org
Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index aa2908313558..e385f187a084 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2558,6 +2558,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 
 	cmn->dev = &pdev->dev;
 	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
+	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	platform_set_drvdata(pdev, cmn);
 
 	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
@@ -2585,7 +2586,6 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.parent = cmn->dev,
-- 
2.39.2.101.g768bb238c484.dirty


