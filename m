Return-Path: <stable+bounces-43228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B18BF057
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570561F220DF
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF012C7F7;
	Tue,  7 May 2024 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUz4uGVY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D7B12C48C;
	Tue,  7 May 2024 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122707; cv=none; b=R5dMUa0/RXDAPGGUviqiqc0xqJEyR53HqIWeMlY5LaQpkXMc7LPYAd/yB/CCddyZDBuRpIpgx7eipeGPlByXtdASQGqCnsFQ+JiJocE+CdnVOHL4vQ26ASmZLq0XcowUUjJdDLnSVVprkY6zYlMoBrnUZTA9wzrrl8YZkAdAbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122707; c=relaxed/simple;
	bh=VGWXzDeBgl9unlqoh4SkGaKtK+l20m4UyrZeEUk0POc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLDkG8s43ll9hHvuvuaNKFFe1rqbyIy2G1tK7pfzS7sKG3GjE4OTtrn968B3Cw6W1cYkDbFHX2MRpkjx9Cjfk/6Ys2Pgu8VUWaU7821vfUjTE8jft9M77YMGMll+4GeVIYCsfTYLzM8mXLxd6Pemu4e6zVuA6Ddkxh9BOhn5UWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUz4uGVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92785C4DDE0;
	Tue,  7 May 2024 22:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122706;
	bh=VGWXzDeBgl9unlqoh4SkGaKtK+l20m4UyrZeEUk0POc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUz4uGVYH7x9jrUD8vsKxqh/Ib3LcVBWZYUj+GMmq/2sohfnD5C8+0KpRxvvY7DUU
	 3awzZe2WaJ58HKZhyo8yC7zSxTr72nQRR/B9PLws5SbYc1d6Bgnd5VjUvxtLLPG/uO
	 TUoz6QBp3tCuIRrGwv9jhCQbITuuyg3NjTmv66fLayAfElFqqCAYIQql5SUfMnOfoo
	 8/TMSMpKw4HSVq2YVbQhgj3ST8PirR6/g+3gAHdbTPFpOH/QU1A1zZGhto5VXxjYC2
	 geTltFRnAcPOCAietTWEgW3gojldxQ6LqbUtnLcL2cYVjlZdB/2Wy9BrAjAYujuHW+
	 2CUqH6+Nq0tvg==
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
Subject: [PATCH AUTOSEL 6.8 18/23] LoongArch: Lately init pmu after smp is online
Date: Tue,  7 May 2024 18:56:44 -0400
Message-ID: <20240507225725.390306-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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


