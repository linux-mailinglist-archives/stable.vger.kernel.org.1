Return-Path: <stable+bounces-188140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED4BF223B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19284275D7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184826A0C7;
	Mon, 20 Oct 2025 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB1F13MU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDB26B942
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974627; cv=none; b=cyw/THg0uKYbKTSqjsnE/h7w12n20Pc5XZYIudd176Q9JgaLqxkd6lyuEklPpqbPiVHK5FLgIqHh7mmvz2sfpNqAUP563T7x55GmU0sg7Gef5vErbjHKqpKx+mLWACeSvDxQ6H2+uIpdKKIMQGq/L9DpKMxN27MDwrWHI/Ttnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974627; c=relaxed/simple;
	bh=WRIoYWnrI3ksQRrwE0fbaPIniiZCAjSCVqFuxUI4o/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmpDd6EGIizTTPQKHYqBPPnjTGWm6F69jcy585hV704ociLth050FJtc4hi94hNJU2FjKANFrFtFiwPuddYjqfkZ2vG7HICSbI5P1HZEUUA+r29F4jKztoEV+hX7+zgsM8LXQt5zf1qSqzwBMVWTR8UAXjOsi/DxTxe3RCs7PqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB1F13MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75D8C4CEF9;
	Mon, 20 Oct 2025 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760974625;
	bh=WRIoYWnrI3ksQRrwE0fbaPIniiZCAjSCVqFuxUI4o/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DB1F13MUcODtmYbtENOJSW3wyEIdzO5mIP24W0mU87778FrxkA41ZcrZ8uzcYzuXr
	 k6dWbTGts4gzRJIoWYY80aTLVeaMexE2dIH+fJFuqda1/2qUpIwSi/PqBcYel7HV4L
	 Mg8t9t7VGbCAoXiZxfFrioloytRqg7yrGTTGqK/c5aJsolyG9r9f/nZcAqU1GTGr5K
	 tmiph/fIJI0vwCM+lq+2J7bCckn6RPjY1KbA4sCPFQVOg9Ol7mO4+jPb4LPz4oILHU
	 fSKDIcwtn+w9uUIedv4NUiyTuuKXuXkWy1RBIu/9y0F2/7kC+sM0XyLvj28toRXiMm
	 K9Tsf6Ocz07yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] padata: Reset next CPU when reorder sequence wraps around
Date: Mon, 20 Oct 2025 11:37:02 -0400
Message-ID: <20251020153702.1820394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101649-sector-ruined-1f7a@gregkh>
References: <2025101649-sector-ruined-1f7a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiao Liang <shaw.leon@gmail.com>

[ Upstream commit 501302d5cee0d8e8ec2c4a5919c37e0df9abc99b ]

When seq_nr wraps around, the next reorder job with seq 0 is hashed to
the first CPU in padata_do_serial(). Correspondingly, need reset pd->cpu
to the first one when pd->processed wraps around. Otherwise, if the
number of used CPUs is not a power of 2, padata_find_next() will be
checking a wrong list, hence deadlock.

Fixes: 6fc4dbcf0276 ("padata: Replace delayed timer with immediate workqueue in padata_reorder")
Cc: <stable@vger.kernel.org>
Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ relocated fix to padata_find_next() using pd->processed and pd->cpu structure fields ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 3e0ef0753e73e..c3810f5bd7156 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -290,7 +290,11 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 	if (remove_object) {
 		list_del_init(&padata->list);
 		++pd->processed;
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
+		/* When sequence wraps around, reset to the first CPU. */
+		if (unlikely(pd->processed == 0))
+			pd->cpu = cpumask_first(pd->cpumask.pcpu);
+		else
+			pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
 	}
 
 	spin_unlock(&reorder->lock);
-- 
2.51.0


