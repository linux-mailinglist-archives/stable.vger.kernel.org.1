Return-Path: <stable+bounces-94965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDD39D7195
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AA92878FA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105A1E1C32;
	Sun, 24 Nov 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYfPJbhy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08C1E1C24;
	Sun, 24 Nov 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455436; cv=none; b=OvieCUPdR6E8IDhdA4uen2KjzzRYwrSamnsM6p8/G9TB8VikSuORQq0rFVoztNedVkCfqgvxhuhNZn3fb+Nic/3bPybu5DI77zuFXpet69sJVRfROzeXn/VbpGIo9FTckNRp6KhNYPac2jJR00E+W0zhQHVQDHTS9KoK34UATxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455436; c=relaxed/simple;
	bh=K+dy7J2P2DkGP/rIUHYAhXsBZisveBBB0abmNJ+0Erw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JG9ePNbkzd1pkhU+rJCyewZvk3nU8hAKX/ElgthI+omcKJovYjbeNZIPj8w4tSwg1Uo/yDRUKnwiN0CT3Fdet+OjFDNPMoQ3OPgDDgvXjAMR0QAh+JaHcQ0gSqjh/GgieXTfl4OBbOi01hGbBIS697hUyk04z5ltpRII60SzZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYfPJbhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E060AC4CED7;
	Sun, 24 Nov 2024 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455435;
	bh=K+dy7J2P2DkGP/rIUHYAhXsBZisveBBB0abmNJ+0Erw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AYfPJbhyAq0MncAEsL3onspjS5dpd6PszonRWUJxtPSjo7MnlXdzQoAJzR0yUWf7d
	 JN13cuODAwqGeNeTM4O9wFNKEw4SEjkQKlJuEU5z9crmPlJC2nkC3PqBSbm4o4QWjX
	 3hm/xPLMvcaOU7Nd/9E7q8J12WusGhWLKwMjqDTzk1qJkLCnxHoKxySh9392qHHJCL
	 1AAFpWe6HSg8ufQWHZUYzFybLQnH6tJPMviXGUXzgC9Xn/wWNJErNZHn4jk4J4624G
	 Vg1kiPP5EOvrpJ7zWyK7P18nag6dIFVq9amJvY64op20IzaGjBFFfRECyX4nn5JPTa
	 /XSBvi0WDn73g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Levi Yun <yeoreum.yun@arm.com>,
	Denis Nikitin <denik@chromium.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 069/107] dma-debug: fix a possible deadlock on radix_lock
Date: Sun, 24 Nov 2024 08:29:29 -0500
Message-ID: <20241124133301.3341829-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Levi Yun <yeoreum.yun@arm.com>

[ Upstream commit 7543c3e3b9b88212fcd0aaf5cab5588797bdc7de ]

radix_lock() shouldn't be held while holding dma_hash_entry[idx].lock
otherwise, there's a possible deadlock scenario when
dma debug API is called holding rq_lock():

CPU0                   CPU1                       CPU2
dma_free_attrs()
check_unmap()          add_dma_entry()            __schedule() //out
                                                  (A) rq_lock()
get_hash_bucket()
(A) dma_entry_hash
                                                  check_sync()
                       (A) radix_lock()           (W) dma_entry_hash
dma_entry_free()
(W) radix_lock()
                       // CPU2's one
                       (W) rq_lock()

CPU1 situation can happen when it extending radix tree and
it tries to wake up kswapd via wake_all_kswapd().

CPU2 situation can happen while perf_event_task_sched_out()
(i.e. dma sync operation is called while deleting perf_event using
 etm and etr tmc which are Arm Coresight hwtracing driver backends).

To remove this possible situation, call dma_entry_free() after
put_hash_bucket() in check_unmap().

Reported-by: Denis Nikitin <denik@chromium.org>
Closes: https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/2WMS7BBSF5OZYB63VT44U5YWLFP5HL6U/#RWM6MLQX5ANBTEQ2PRM7OXCBGCE6NPWU
Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index d570535342cb7..f6f0387761d05 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1052,9 +1052,13 @@ static void check_unmap(struct dma_debug_entry *ref)
 	}
 
 	hash_bucket_del(entry);
-	dma_entry_free(entry);
-
 	put_hash_bucket(bucket, flags);
+
+	/*
+	 * Free the entry outside of bucket_lock to avoid ABBA deadlocks
+	 * between that and radix_lock.
+	 */
+	dma_entry_free(entry);
 }
 
 static void check_for_stack(struct device *dev,
-- 
2.43.0


