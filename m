Return-Path: <stable+bounces-43263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE2A8BF0FF
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8931C219C8
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3B713AA4D;
	Tue,  7 May 2024 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjQtPh/w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9413AA3C;
	Tue,  7 May 2024 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122865; cv=none; b=l/Hvjd6fqSb1qX/InDUYsEphvkxOW45Gses05T3RaXdYI2pNBJHSAbuULoW6NWjiFNyQXWOpPY7y4tSfCgxvv1DcWi2NYsU54D5E3AGPYBaIh6Kzlzu9FLY10qkiPl4UJcCL4puL9DnvQHWGnc1mZIPqXKaeh9Wj7EPs94QQndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122865; c=relaxed/simple;
	bh=HfHC/IKjd29RyVoUIyYS/IWsYCa94QbsfVMu+nM6rjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sguLiqkOlKaH5VDfBxGeOFJKUzT+phdA3PUJ7r2/EDD18l874esYtxIRLHC4RPxYwY6ulj9uZVTcipDU1Dr3NPRMqcVCLiohkIzl5AfQ3jNMNaGsCIASeafBd04Juqb703FvthwGcsGCjzuM+yGnqpo2UhVQwGbs1l6bgxt23L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjQtPh/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C3FC4AF17;
	Tue,  7 May 2024 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122865;
	bh=HfHC/IKjd29RyVoUIyYS/IWsYCa94QbsfVMu+nM6rjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjQtPh/wc73G9sIeF8iIwUWpChX14DizXYzxXkjx9qxQCCjFe+WiP/kQrfQZ/IsL1
	 eh3fiXdmDZrUnu2OXNgtJe/dC4Y1GxbZvQqU+SMlKBScXef/KsVM4kok4Ug/aKW5RP
	 WASWHgVYA3wnv0/AxPNbkM118Pp6EX2gOzLDhEUxAFi+Fk7QGSRAGaIcHHvK3MbvRF
	 iD5pS3msY1DMcoIpOM10NxRbj8BrGkV8DfEybCNptzYIJ2t916KT/P+PQWEgujzG9O
	 IiGYxVgQK6k2TljA3BMoLSn9ypiDo/kilRdcJJuXztpcHCbXLgWLKY//msoe/+1C+d
	 75/SSiCpiJ8xQ==
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
Subject: [PATCH AUTOSEL 6.1 10/12] LoongArch: Lately init pmu after smp is online
Date: Tue,  7 May 2024 19:00:12 -0400
Message-ID: <20240507230031.391436-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230031.391436-1-sashal@kernel.org>
References: <20240507230031.391436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
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
index 3a2edb157b65a..1563bf47f3e2c 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -884,4 +884,4 @@ static int __init init_hw_perf_events(void)
 
 	return 0;
 }
-early_initcall(init_hw_perf_events);
+pure_initcall(init_hw_perf_events);
-- 
2.43.0


