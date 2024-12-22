Return-Path: <stable+bounces-105565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B809FA8A2
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 00:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0925618866D5
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 23:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D7199921;
	Sun, 22 Dec 2024 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt08AH6I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98C198A0E;
	Sun, 22 Dec 2024 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734909147; cv=none; b=jglHqV6CjbgcrK4PpyIhFCSf1+Uw2063OBqODVbbZ0fsi02S/1fftCeHoEFwaXtHlXd2/orZQAR7uTCkl+Wiaf4CWmEzsElj2A9BWlnRDhF8pU+YhJeXpbN7xJYUziRs+pgV/qbwyMO7uRwcnJIbcZM+4GAEkEroqXSwGfiNn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734909147; c=relaxed/simple;
	bh=VnA1Kpl6cnNCncV299IxvKMXy0LENGhUCK7E8iW560U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m48MI0vxcOB03i8t7iufdBs2NLlHaTycRxrF3Xf5zIzhr2v1VSh7R8nZV9Orumh7Ga5Mx9LLThFvSAIR85DDUH8crYVEtQMtbMJ63qb6cjnayqdaYoHzqWafq8tBYEcSW1iGLpN2H+gMwmDC6IsFtGHf3EfykVgXUY/ISfiyPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jt08AH6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD54AC4CEDE;
	Sun, 22 Dec 2024 23:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734909147;
	bh=VnA1Kpl6cnNCncV299IxvKMXy0LENGhUCK7E8iW560U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jt08AH6I6TbqJCHXd/acPRzbZyWx52z2MmhPoaQ2cyp9RK1qweXBp0RrtA4MOMIBf
	 07kwOrXbJ9793M3E5h78GCOPP0O+dDF4m3oX0+rmbRpoRZv6PblExjqSOxhtjkhEtG
	 HtPhow9N6iHFBadT8FT42tARcpFEL+zyCJtQi/6RslUp2TDnTx/c7N+LSbxrnYeiKw
	 HqMtwjSUIY7TCZmIDYPGiDDaniR5sBgT3AyBNUkrh4m25SObQZEFuJngEE/DN3eyXy
	 eROFrH+b04IqphTPehy3CDM3Pj7l8t6LQLvPHFQ11Gnv9BkZ2xIUh2Gqv/l75QtwCO
	 +R4AOfkouo0CA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/core: fix ignored quota goals and filters of newly committed schemes
Date: Sun, 22 Dec 2024 15:12:22 -0800
Message-Id: <20241222231222.85060-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222231222.85060-1-sj@kernel.org>
References: <20241222231222.85060-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_schemes() ignores quota goals and filters of the newly
committed schemes.  This makes users confused about the behaviors.
Correctly handle those inputs.

Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")
Cc: <stable@vger.kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 931e8e4b1333..5192ee29f6cf 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -868,6 +868,11 @@ static int damon_commit_schemes(struct damon_ctx *dst, struct damon_ctx *src)
 				NUMA_NO_NODE);
 		if (!new_scheme)
 			return -ENOMEM;
+		err = damos_commit(new_scheme, src_scheme);
+		if (err) {
+			damon_destroy_scheme(new_scheme);
+			return err;
+		}
 		damon_add_scheme(dst, new_scheme);
 	}
 	return 0;
-- 
2.39.5


