Return-Path: <stable+bounces-147383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93992AC576C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528763B6F33
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B0427F728;
	Tue, 27 May 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="utvKxBrQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AE2110E;
	Tue, 27 May 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367172; cv=none; b=AVq6hgF+GTTKECyGABwS6gE/Zo2PlPaZNXRTW6XDah2hlI2IViiil/X/Ia2WkoxusV3RZpHPE4pDcsXNdidEP6lnEYlTrQ6/PXBP0KOOKpQoSSis3OPP/X6JfoapJ7ZIL61f+39FKGSRIXEYnZ2JxZB5LDK2HLwKOoQZlKeG72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367172; c=relaxed/simple;
	bh=94uZIlDEIn0s+G/xPYS1V61n3O/gkex0PryZWRQL2ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfdzfNbn3lXw4+pD7ygFwyrvWUPVhDoiXiAnRrK19PrjHomvwl/rsuWRhiF/0PIajHvx+pZnYYmgSv+dFmxt9SsmEFwCqUZ8TIROiZjvpVZGghKodg1CCSKm404s+YJs0xPMZcJfEd480u0mPOXcB0K5sixIhRXbhvus+CUdei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=utvKxBrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6438CC4CEE9;
	Tue, 27 May 2025 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367172;
	bh=94uZIlDEIn0s+G/xPYS1V61n3O/gkex0PryZWRQL2ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utvKxBrQjIYxsGuzaRVox65BGuZ3JANSKdccKEWmM7k00XZ+D99VMLAwEVi/UZftv
	 fkR3jVOKgxAtp1c3l/Mghv88TmzIEPYnk62yeLGKRjWPjuhqqMDV1PwgQEdOdoRvz9
	 j0pWYn23iGlTHLhm7j4OgdNz3CmzrmybAdU06Tpw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 301/783] perf/core: Fix perf_mmap() failure path
Date: Tue, 27 May 2025 18:21:38 +0200
Message-ID: <20250527162525.329395125@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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




