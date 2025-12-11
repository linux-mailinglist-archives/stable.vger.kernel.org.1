Return-Path: <stable+bounces-200760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65329CB48FE
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 03:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE741301BE9B
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 02:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3D322A813;
	Thu, 11 Dec 2025 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="deaW0JTq"
X-Original-To: stable@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F122E3F0
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765420515; cv=none; b=jrfs8hu5DMqMcjYFa+muZhRqSlrq7+v5l4fIEclMRQv92BzN1ahbSYN35gnnkPNy2ZC6PARuCtv9h9XfHfwCDXhTpCZlfZFwLCndFsXkAuDWxRM4Ieo6EA/902aQm25gRCpXhaC7FNKY+DnWi/ZczuxejaqiZJEfe1XladnJf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765420515; c=relaxed/simple;
	bh=LyCpG3hePJmnW1ayV0jI53RnNs4s8cKZMYdVeVQ6Fa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObdHApc3TsV22j5Xe+RIzC30b2l2wUlVvA9ZQhAFgqnShM2PeFslJrGJ+9d4RS0BzGMkbEfHu2MeLbALH7FOpk1UBG04Udt384aUtUP/hXbUiRXd0Un0BGrLBrw7B6OLkFbUZccyLHPkhabLy151TrmYe6OUlBB8iCEWs6N0HD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=deaW0JTq; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765420510; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=n2jJgkK2KobzA0ab3tmCBUkHTgyBbt61Pm4yK6ymxRQ=;
	b=deaW0JTqVE54YaWWSiYnvO4sZLt2OVM07xKsaojyZ53d1mRckLFTHNBa9gludRFofYEhTuZNx0UDo0xYYhnCS7OZUaeiFx5bZHN1KK9hqrTs5G+Nq4N5tK3xelxkTN15v7kjuxvJ289wo5aCVSe9VOQSQO1jmVueaiBSTwTmAEM=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WuYgR-c_1765420509 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 10:35:09 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: jefflexu@linux.alibaba.com
Subject: [PATCH 2/2] mm: fix arithmetic for max_prop_frac when setting max_ratio
Date: Thu, 11 Dec 2025 10:35:07 +0800
Message-Id: <20251211023507.82177-3-jefflexu@linux.alibaba.com>
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

commit fa151a39a6879144b587f35c0dfcc15e1be9450f upstream.

Since now bdi->max_ratio is part per million, fix the wrong arithmetic for
max_prop_frac when setting max_ratio.  Otherwise the miscalculated
max_prop_frac will affect the incrementing of writeout completion count
when max_ratio is not 100%.

Link: https://lkml.kernel.org/r/20231219142508.86265-3-jefflexu@linux.alibaba.com
Fixes: efc3e6ad53ea ("mm: split off __bdi_set_max_ratio() function")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Stefan Roesch <shr@devkernel.io>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page-writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3929bb0a7501..e7a7233f6d5d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -750,7 +750,8 @@ static int __bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ra
 		ret = -EINVAL;
 	} else {
 		bdi->max_ratio = max_ratio;
-		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
+		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) /
+						(100 * BDI_RATIO_SCALE);
 	}
 	spin_unlock_bh(&bdi_lock);
 
-- 
2.19.1.6.gb485710b


