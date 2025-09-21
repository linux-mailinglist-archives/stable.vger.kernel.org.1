Return-Path: <stable+bounces-180811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8853FB8DCCD
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BE718992D8
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18679257829;
	Sun, 21 Sep 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2TJv0k0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFE1A8F68
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758463882; cv=none; b=nRTulGrBaVmaYaEfRsec5RFsZN4t2Vub1LMNQap1ioADd/HW94eCC0LnZ1v7LJ3sFi0a9JsOFylW0nnFvs31Po1u16MXdau82EbW5B0lXMmeSpmaDmhyEc0t5wfIO/HT6wB8Y9okK6mMakbxbfli7MHh6XET8ujvgicq7Si8yFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758463882; c=relaxed/simple;
	bh=V60jLBc+Y/LFOi4T6MB4QM8h3O6IWvng7Iu3jgs27Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIfu5+7jSbeKxY5IYqtbiMJ03lMtZWGkJx6rieg2ymHG/VfAcigevyh2KK6TyXwlpuaaEjMjoaN9qG/uhVx+GR2AEoI7I2eCJKrhpzgZinBiLANrJk45oJ63HvPZdrSJ47pWjX1cwf4uAdeFAFkAOxo2x9XnghXNCQ9M593C76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2TJv0k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AADC4CEE7;
	Sun, 21 Sep 2025 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758463881;
	bh=V60jLBc+Y/LFOi4T6MB4QM8h3O6IWvng7Iu3jgs27Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2TJv0k0LghPsohbsmqUbQ/UgT5R49oGUKsI2QEvT+l8BJG3n5o1l4xU0XTe2ht3Y
	 Mxu9aiTrzJFF6c21vXl1rSYOq1lAwzdp2ZFrXLBjL4jZf44BaE9yx8T1EO0kzVL7ub
	 6cXu7cBXfupcQK8vo2EealTmxFTD1nNWhfh/UHAaYP2i2cW44mHk1AcdsQ96eTBnDw
	 dPnuMzFMogyTiicRMC/TXvHefar6LwIobf1k/wErwQXTbExYdy8UcQaKcy0ripcT8N
	 s8kScvJNFajtY74F0yu0P1zwPc9UlCpkWib6hMdAbj4ByKiNRWoxeziXV72iD78MZq
	 uzzYEZQnpFGYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/3] samples/damon/prcl: fix boot time enable crash
Date: Sun, 21 Sep 2025 10:11:17 -0400
Message-ID: <20250921141119.2917725-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092116-ceramics-stratus-5d18@gregkh>
References: <2025092116-ceramics-stratus-5d18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 2780505ec2b42c07853b34640bc63279ac2bb53b ]

If 'enable' parameter of the 'prcl' DAMON sample module is set at boot
time via the kernel command line, memory allocation is tried before the
slab is initialized.  As a result kernel NULL pointer dereference BUG can
happen.  Fix it by checking the initialization status.

Link: https://lkml.kernel.org/r/20250706193207.39810-3-sj@kernel.org
Fixes: 2aca254620a8 ("samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation")
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: c62cff40481c ("samples/damon/mtier: avoid starting DAMON before initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/damon/prcl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 5597e6a08ab22..a9d7629d70f0a 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -109,6 +109,8 @@ static void damon_sample_prcl_stop(void)
 		put_pid(target_pidp);
 }
 
+static bool init_called;
+
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -134,6 +136,14 @@ static int damon_sample_prcl_enable_store(
 
 static int __init damon_sample_prcl_init(void)
 {
+	int err = 0;
+
+	init_called = true;
+	if (enable) {
+		err = damon_sample_prcl_start();
+		if (err)
+			enable = false;
+	}
 	return 0;
 }
 
-- 
2.51.0


