Return-Path: <stable+bounces-188144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BBABF22A9
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFE954F80E6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288626E71C;
	Mon, 20 Oct 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml3ipnNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BD26E6F9
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974853; cv=none; b=lgG0DeBREBSGCvOSfm0+mKi8GE9ZR3mDyOIC6QjO32g+rpYipbFTFxPSq5NDfCCfqiK13H1Y10NLtRYfqtKZpGvcvP0jNgRSwGHSLpM9hdOGGroUCt0t0BKWNG21VCEzx0UMAhTNt3TZJXlulkevYb9mhI3ryVbq3phznGAFxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974853; c=relaxed/simple;
	bh=5UH8O1zKExuiXYO+DlKN9FVNlITqkAP61WxqgOWya8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ooo/sHylHBkMWUL0cgnVdrTRLstBLGwFrHDqQsNWaXSzTBbwQaz0bY9s/b4Gsyj6+2VV39NyINzLXaZ2yHpccbQmQcot/5KPDWf+2EQ09Lt8CBEhoqIcJH6MYsD4BFNVEs4WYANqHNpfKzIIQFob3yNnO8lHUkXndXft5N/e4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml3ipnNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB45FC4CEFE;
	Mon, 20 Oct 2025 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760974853;
	bh=5UH8O1zKExuiXYO+DlKN9FVNlITqkAP61WxqgOWya8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ml3ipnNv3sJISFm8TfqSJfj8OAZ4sghmxkuD4Xn3+py1Ibj+4BqDricMYK3XMouyI
	 1N3cYZS06kpaqSkw6LvjOFRfZ0WJj3wb1MWX2jEzDZffYxEs7fSPGdyNesU3Uzd/fk
	 VptQrhMfiC1ixegulVUkb/J89j8vg+/YxxIRlbHXM0khAnyUKx8mG1oJFliq65CeHY
	 i6RvqzReRt93T6tdVr9obiDatmZ34TeH5SDGJCG/YnMpw12VPkes7LB/mbg6u9GJPC
	 i7Bh5tIyfb8+wv2UvfA90U8wKqXfpzVcTV6dWKajFSPKXS0p4jqf6Y+yKH7Zss5y01
	 rdiBbf0YkEyIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] padata: Reset next CPU when reorder sequence wraps around
Date: Mon, 20 Oct 2025 11:40:50 -0400
Message-ID: <20251020154050.1821767-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101651-sizing-subfloor-8c1d@gregkh>
References: <2025101651-sizing-subfloor-8c1d@gregkh>
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
[ moved from padata_reorder() local variables to padata_find_next() using pd->processed and pd->cpu struct members ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 1bd61add09158..6c8a141b5c4b2 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -295,7 +295,11 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
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


