Return-Path: <stable+bounces-140016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F90AAA3D2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308F64653D3
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01D427979C;
	Mon,  5 May 2025 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgWyTg0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660252F81B6;
	Mon,  5 May 2025 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483919; cv=none; b=JGkbmk6vcZnGzi+BeNUgtzVrVe+dqQGhfQpEY7soVxNxzZU9WiS/qINd/feTDJa0Gd25Sr/TqQCcD0zXORkSVl1Ez/JHl2pqkH8mDT/rNSdbHmHLhbLvmtQbAoU8p/SOsbv7QHaQWRxwY6gtXRggwjATbAQtbUjPT7g78c0Cz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483919; c=relaxed/simple;
	bh=UchgOFdXp4awED8dj0TpRoeqXqCGT/KR3+SVYUokIO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKau4OA9I6DZR7PaLULdrTUuztsyu1iVgrwD2vlyZ072vY5OhVL3tXxf3ft+RoRxS8x1gG654l8Q265BK+1DrM4QLTP/wJ5RTLJ2By3rUdJ9bmCIKbFExh4ZLmQKa1sG4ZrBpq+v2Q4/SBFYlKawPnH7y3x+CKyzuyDyI+lEGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgWyTg0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8A4C4CEE4;
	Mon,  5 May 2025 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483919;
	bh=UchgOFdXp4awED8dj0TpRoeqXqCGT/KR3+SVYUokIO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgWyTg0A/LsYK28W+zA6CMeGnolrX8yIuEUA4Ae9W1mofW91EYusA1xkXzsG36eDL
	 1vbXoIPd10qkPZDR7iqKiFaKM06qlt1XGLABUn0/betlneO3APKew3frfxpXH35IH6
	 dmYu+rrJuMPnVilxNhESahioLIkDkl4uHsPDrreDYW4lVUyqzADY+I+xsv3KKq19O2
	 50Nqge0xvaVCbUZlGS0AJeVBVahNHgBYD4atKuxN6t/027k369zhIssLrS5r9QoovM
	 IHgw3X4GxtAuAwL4IEFKxJqZMgHFo3J1+s0vM81vOUNC4I7mnk5RalbuAfuvAZELzu
	 H3aaLrDane3tA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 269/642] perf/core: Fix perf_mmap() failure path
Date: Mon,  5 May 2025 18:08:05 -0400
Message-Id: <20250505221419.2672473-269-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 66477c7230eb1f9b90deb8c0f4da2bac2053c329 ]

When f_ops->mmap() returns failure, m_ops->close() is *not* called.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135519.248358497@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index de838d3819ca7..dda1670b3539a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6834,7 +6834,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!ret)
 		ret = map_range(rb, vma);
 
-	if (event->pmu->event_mapped)
+	if (!ret && event->pmu->event_mapped)
 		event->pmu->event_mapped(event, vma->vm_mm);
 
 	return ret;
-- 
2.39.5


