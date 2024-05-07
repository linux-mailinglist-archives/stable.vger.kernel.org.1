Return-Path: <stable+bounces-43250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3530C8BF093
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAD61F2106B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA5134CF7;
	Tue,  7 May 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvp+Va4p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A42134723;
	Tue,  7 May 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122807; cv=none; b=D8qA3a5s7ihD+U9YOjorHHRk02s1Yf8SFAPGFymc3CvAvIwhl4YNd5gMeOkVMOrA6rOtS7XhEuhJ8zDqD+mp4NFjGCKqFzvdafLI7yoRaq4onrYhKXXQT/D0r6Zcl70gj+QDp0OUaz9srNPPY1oCWGht71Rm9XeAXNkqlr52bAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122807; c=relaxed/simple;
	bh=VGWXzDeBgl9unlqoh4SkGaKtK+l20m4UyrZeEUk0POc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/sWckMT1lSVXRM8fm/KCsWdkkQ9ZQtLcSJqCxj1EgNdS7bnypDQOswEwkxRJd11e38fL412RTaWxf6gxuY4MdKxRtH7/0ZFXRKkgcHCrWz+dVVcVyE/2NjE7PJ08hrbbJw7G8yGatf/TMwtPsosvbiMLVJnniaEm31TjDANWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvp+Va4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50A4C2BBFC;
	Tue,  7 May 2024 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122807;
	bh=VGWXzDeBgl9unlqoh4SkGaKtK+l20m4UyrZeEUk0POc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvp+Va4pho+KxKSDQAH5ZzQ1+BCbV3uPVQedhIdVSM2282L/T23vxASuQJjk38Kow
	 fzpYnYRiVwSpmZUc6T8XU2Diit/Fa1jIdHtUHSIBd6FHBRKVbISw74ce25PmJ4swVW
	 uSssP1Yv6WW3LSUJ+GZeapEBOOuLz1ulIStEMOh/tLRbCbn+NcgqG2RPrjxZLoS9a6
	 MjN3GznhWr375xap6GDtGeUw+fx51ktwt64ypTujBoCIiY2xe54gCPA8f3pEdK/eVv
	 DcCe+KDo9B5lr0meXHhJXgA1ifn+GqX/UvhYWP1UYtkUEXOjvSrVPtRb5I4Bsne1mf
	 XvmsLzFnuWp2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	chenhuacai@kernel.org,
	linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 16/19] LoongArch: Lately init pmu after smp is online
Date: Tue,  7 May 2024 18:58:38 -0400
Message-ID: <20240507225910.390914-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Bibo Mao <maobibo@loongson.cn>

[ Upstream commit f3334ebb8a2a1841c2824594dd992e66de19deb2 ]

There is an smp function call named reset_counters() to init PMU
registers of every CPU in PMU initialization state. It requires that all
CPUs are online. However there is an early_initcall() wrapper for the
PMU init funciton init_hw_perf_events(), so that pmu init funciton is
called in do_pre_smp_initcalls() which before function smp_init().
Function reset_counters() cannot work on other CPUs since they haven't
boot up still.

Here replace the wrapper early_initcall() with pure_initcall(), so that
the PMU init function is called after every cpu is online.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 0491bf453cd49..cac7cba81b65f 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -884,4 +884,4 @@ static int __init init_hw_perf_events(void)
 
 	return 0;
 }
-early_initcall(init_hw_perf_events);
+pure_initcall(init_hw_perf_events);
-- 
2.43.0


