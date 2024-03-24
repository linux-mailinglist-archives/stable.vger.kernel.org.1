Return-Path: <stable+bounces-29321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F08884B5
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 01:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ACD285485
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB551B7F67;
	Sun, 24 Mar 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOmGaB7c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E761B7F5E;
	Sun, 24 Mar 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320292; cv=none; b=YIIGkJkogEKL87DFr5TFTF7JyFXwNXCOkSG3JF0u/NlL3QmW9LL9vbuP4qe+kEcl30uwNtNw/LMjPPJZSvIIcbbLsLcXLcoPJ+iLYtMnRV6qIsnxZQaiYoeAJryl1Kw/x7LGyrYqrlPFNJfgisSe0rgWdx2rRuoGedAMjyorUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320292; c=relaxed/simple;
	bh=twi/4kBDVPstULhD0+o4PYXT4uAaHc6/fhPNElnlVdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1WxZxF00jVVo3buXPjcw4/z75vdEQDRTstSZab7wjRbia9u8qvrZZ9I5IQu2S1xg14OKgkIVUbNpsb07DDI/6jW9uXFVosa5MPMs0sbpR5OwVpemjpFiXV3km6+Tq8PFTlAjHB5k9dYKcv76pJ2+VHrkjrxGWI/DMXE2G+9r8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOmGaB7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0B5C433C7;
	Sun, 24 Mar 2024 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320292;
	bh=twi/4kBDVPstULhD0+o4PYXT4uAaHc6/fhPNElnlVdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOmGaB7cS7l/+l31KnssUrGAmYyWrOruynrC0hLAJQimU1fm9rA5OGipXa7Oy6gDW
	 ABy/adi3S3Bw9isFyA0xIsq7yhuO5qVzAyjrMMM2MQ3rl3Zo0+6bPGs4rBqRliHcoa
	 Fbt59qf+87iD9hhINJ+SLkvw4Mvlje60kscJZZSiS57xSDUBW4k8UJ2eigndE/kWgv
	 GnQpjFXm6GGk/tXH41L2QWiyXMrFQI3+4QhEZTPI+Nzjo4yNvJWde887ge0726jGix
	 O0exoiAZ/ap2+/g7c+lNCAB28TacwNGq22R49t7iEdJm/f4sReUMBF5Uqg8m+O9XVE
	 9AfT6CzB4XeGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sandipan Das <sandipan.das@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 600/715] perf/x86/amd/core: Avoid register reset when CPU is dead
Date: Sun, 24 Mar 2024 18:32:59 -0400
Message-ID: <20240324223455.1342824-601-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sandipan Das <sandipan.das@amd.com>

[ Upstream commit ad8c91282c95f801c37812d59d2d9eba6899b384 ]

When bringing a CPU online, some of the PMC and LBR related registers
are reset. The same is done when a CPU is taken offline although that
is unnecessary. This currently happens in the "cpu_dead" callback which
is also incorrect as the callback runs on a control CPU instead of the
one that is being taken offline. This also affects hibernation and
suspend to RAM on some platforms as reported in the link below.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/550a026764342cf7e5812680e3e2b91fe662b5ac.1706526029.git.sandipan.das@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 81f6d8275b6bf..1f114d4bfe303 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -604,7 +604,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
-	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
-- 
2.43.0


