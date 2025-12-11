Return-Path: <stable+bounces-200762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF52CB492C
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 03:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A812301B4B0
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466D20C48A;
	Thu, 11 Dec 2025 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qE3oV74Y"
X-Original-To: stable@vger.kernel.org
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6F211A09
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765420835; cv=none; b=szNDVVo8Yt0jT6WZzfLSrwYh2bDZXypUexV+ePyQLH/2XRrXay9mahSw4q2wIEXPmO+zwfcK9MBtUKyf7nwJ6nJhRH9prq69mNKjkQhHklKoyZcTwjej+g93OXV96tuYDngwIKiKsyF6gfPIsTVqRBhd6XBQvdDGeKoqZz0PtDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765420835; c=relaxed/simple;
	bh=cirWTS0LYIYbrnVJLOiUqh0OW2IWTcDe6RNYZmDYLfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEFnVLWn+jOeigUnlW7OSdk+unA+3YPkZ77jokBnLdzlbCKTWgJNiJ9dCGF00syy17sRcOQJ/O+6h9fFkyvxMripHg/7qT24kiDR3w8teJUPW65BCm+wo+aTBQeZ6zxHnH1hYkvNhQxNuDku556jMrQUUPq6rFAoa/N/DYeLIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qE3oV74Y; arc=none smtp.client-ip=47.90.199.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765420820; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hGDsDf2H5VoE3e18JTiN8pilBy3Efg/v3wbdFTaEC3w=;
	b=qE3oV74YY2vX2ir9MI4qTq48A+NPSO3eQVjI14uif5/p/JqmTl+lTtVtUWPpbM7Rz61SIsAgj8mksLfIhgbpKS1TiLvnm2S5slP57dbcLswKLMVhT6hdkJjbcwH4vNCa4ztDf7gyS0YFaP6MrMIp7F1dHdhNOMCrlQ7hQ1wubhg=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WuYZjJE_1765420508 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 10:35:09 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: jefflexu@linux.alibaba.com
Subject: [PATCH 1/2] mm: fix arithmetic for bdi min_ratio
Date: Thu, 11 Dec 2025 10:35:06 +0800
Message-Id: <20251211023507.82177-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20251211023507.82177-1-jefflexu@linux.alibaba.com>
References: <20251211023507.82177-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e0646b7590084a5bf3b056d3ad871d9379d2c25a upstream.

Since now bdi->min_ratio is part per million, fix the wrong arithmetic.
Otherwise it will fail with -EINVAL when setting a reasonable min_ratio,
as it tries to set min_ratio to (min_ratio * BDI_RATIO_SCALE) in
percentage unit, which exceeds 100% anyway.

    # cat /sys/class/bdi/253\:0/min_ratio
    0
    # cat /sys/class/bdi/253\:0/max_ratio
    100
    # echo 1 > /sys/class/bdi/253\:0/min_ratio
    -bash: echo: write error: Invalid argument

Link: https://lkml.kernel.org/r/20231219142508.86265-2-jefflexu@linux.alibaba.com
Fixes: 8021fb3232f2 ("mm: split off __bdi_set_min_ratio() function")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Stefan Roesch <shr@devkernel.io>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page-writeback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9ceb841af819..3929bb0a7501 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -714,7 +714,6 @@ static int __bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ra
 
 	if (min_ratio > 100 * BDI_RATIO_SCALE)
 		return -EINVAL;
-	min_ratio *= BDI_RATIO_SCALE;
 
 	spin_lock_bh(&bdi_lock);
 	if (min_ratio > bdi->max_ratio) {
-- 
2.19.1.6.gb485710b


