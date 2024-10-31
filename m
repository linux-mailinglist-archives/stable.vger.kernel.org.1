Return-Path: <stable+bounces-89443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559929B82AE
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 19:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190CF2834D1
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221F1CB304;
	Thu, 31 Oct 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0P16FYT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD911C9ED2;
	Thu, 31 Oct 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730399883; cv=none; b=NH2ftcEXbuhvDsz+5UZIiIcpmep7qQNX5OHETctpm0i+R0InpoKVlIqONsDQlW+d8gN60Drge/B5OYSCi53oJDcxy5OPNtMl4FI8k2eetGUkqooSKrUQiq0xQOukNq1iJOn2yBo9k5tuq+P1sMqAXtJrouLYMHtjB79KO8tGOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730399883; c=relaxed/simple;
	bh=L0OOFAcas3acRh+BRifsG3N6Sbsa4Qrr4fl+oy8M5uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiE+DMCkSNpZfD6WnAr2l0+E3GmgpT5aKxE9XlroBbT/d/U/TZOoAZ1FN40Konplg1zf270TSFrLmRyj+h9JtBnX4Ee2Ew1eWAjenAEzQ97/HDMmWmhBF3uaUYdQpEVEcCUwh7p2F3nT5PgseD5IL7sCHj/XeK/8m7uGaYwNS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0P16FYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F704C4CED1;
	Thu, 31 Oct 2024 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730399883;
	bh=L0OOFAcas3acRh+BRifsG3N6Sbsa4Qrr4fl+oy8M5uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0P16FYTS9DnqQ14GhTEt6IbNDNM+8nRMCJYKMr4VnOSTv+27cQyXSIbjCefOL9KZ
	 mDyvoyTBeBxmslifg0hATNkapdR1tV6Z+zWEvC75ed4xObZEwlahgRv4dadBxmuclo
	 z1oj7KAkBMuqJplhnZ9rvzT22HwZyV9LxGiF4nUT6DGZwq8qNQYjXVLj9HNH7u76iL
	 92Go4qFwtmoG9dJV02X4z8D6l0lMzPzjO5C8ptBvgUK0t60WBe85iP3UPEBImoHUuX
	 PNwI1+0H2G3T6weBaN3q4A+1Ue7MsGmNTLSm5tKvoPkEDOV2nJFchrQkWsb5J3Ry17
	 +BLbh7BR8+bCA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/core: handle zero schemes apply interval
Date: Thu, 31 Oct 2024 11:37:57 -0700
Message-Id: <20241031183757.49610-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031183757.49610-1-sj@kernel.org>
References: <20241031183757.49610-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's logics to determine if this is the time to apply damos schemes
assumes next_apply_sis is always set larger than current
passed_sample_intervals.  And therefore assume continuously incrementing
passed_sample_intervals will make it reaches to the next_apply_sis in
future.  The logic hence does apply the scheme and update next_apply_sis
only if passed_sample_intervals is same to next_apply_sis.

If Schemes apply interval is set as zero, however, next_apply_sis is set
same to current passed_sample_intervals, respectively.  And
passed_sample_intervals is incremented before doing the next_apply_sis
check.  Hence, next_apply_sis becomes larger than next_apply_sis, and
the logic says it is not the time to apply schemes and update
next_apply_sis.  In other words, DAMON stops applying schemes until
passed_sample_intervals overflows.

Based on the documents and the common sense, a reasonable behavior for
such inputs would be applying the schemes for every sampling interval.
Handle the case by removing the assumption.

Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 931526fb2d2e..511c3f61ab44 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1412,7 +1412,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
 
-		if (c->passed_sample_intervals != s->next_apply_sis)
+		if (c->passed_sample_intervals < s->next_apply_sis)
 			continue;
 
 		if (!s->wmarks.activated)
@@ -1636,7 +1636,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	bool has_schemes_to_apply = false;
 
 	damon_for_each_scheme(s, c) {
-		if (c->passed_sample_intervals != s->next_apply_sis)
+		if (c->passed_sample_intervals < s->next_apply_sis)
 			continue;
 
 		if (!s->wmarks.activated)
@@ -1656,9 +1656,9 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 
 	damon_for_each_scheme(s, c) {
-		if (c->passed_sample_intervals != s->next_apply_sis)
+		if (c->passed_sample_intervals < s->next_apply_sis)
 			continue;
-		s->next_apply_sis +=
+		s->next_apply_sis = c->passed_sample_intervals +
 			(s->apply_interval_us ? s->apply_interval_us :
 			 c->attrs.aggr_interval) / sample_interval;
 	}
-- 
2.39.5


