Return-Path: <stable+bounces-43357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E478BF209
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AE01F21228
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533B116D4EA;
	Tue,  7 May 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlPpkkCT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C316D4CA;
	Tue,  7 May 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123481; cv=none; b=oYGqeh1fj7XExaVnWI/s7+zRL+c4euQJTRAl4ou2At8+SoJO+RLxWnCCL2dV2Un9u4EoHQ0NKjwnAPCdMFV8E1DcnJJs/FtVrQTfLThhwewVkYeZrMu3q4qftl5x1MauByc3MbaHYU8nlG6j9PUDc5KzvGvmr3Kbpr3t7dHQvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123481; c=relaxed/simple;
	bh=Vjg4Fmi6G6fzx0gO2iQTTiPmXRNi21IOpym6rx+7TWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gI9G4mU3Ouup0eCEv4W6Q2gzwQA+H8oXdti8rtodZpMAxRoI4FqW/2fDZJI0rkjT2cPET1OlIYIPu5ptxyoGX6WKZ6Xn38fI0vNojcCSSp4UwB3Bhh1B+Cu15F9V3KKWv2eDB9uLXFtp2Lmomsyrg+xVABsXepqDdsWx+LEiASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlPpkkCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21512C3277B;
	Tue,  7 May 2024 23:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123480;
	bh=Vjg4Fmi6G6fzx0gO2iQTTiPmXRNi21IOpym6rx+7TWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlPpkkCTS9sBO5WOCizTxXbCHIuZJ5J0qZztFgz37aP73OVeCUaLKAf4TBNaBhn4H
	 E88SjCQT/jqlpf/VZ4uHJYlHLmBJQdO5+QLSFP99ovpRaOCTrLCGuR8yVMKt6oy1j+
	 3zRCVy72MN+XeEI5ZDMDuaGjJEGg+NqzGK1JgdeH8OwAISwtAXp8Q8F9Jt8y02l6gH
	 oZNcLxGjzNZCg4X6XNWLBBFyTB7N49D3hVcCLBVfT+8DHfFQiAGTUg+kjmb+kPC/jY
	 QJB/wCVAXkd6YKXLh7TdpMYQMzvUnVi2/kerLbz3pVOq0R1dSWyZcraCMzG1GKNYvb
	 iDQ8VwISngyDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 25/43] platform/x86: ISST: Add Grand Ridge to HPM CPU list
Date: Tue,  7 May 2024 19:09:46 -0400
Message-ID: <20240507231033.393285-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 515a3c3a5489a890c7c3c1df3855eb4868a27598 ]

Add Grand Ridge (ATOM_CRESTMONT) to hpm_cpu_ids, so that MSR 0x54 can be
used.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20240422212222.3881606-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 08df9494603c5..84fe2e5a06044 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -720,6 +720,7 @@ static struct miscdevice isst_if_char_driver = {
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
 	{}
 };
-- 
2.43.0


