Return-Path: <stable+bounces-119974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BADA4A0EF
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 18:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716BD1681C0
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B31BEF9D;
	Fri, 28 Feb 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9IvHPyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8331607AC;
	Fri, 28 Feb 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765222; cv=none; b=VmP8f0lHJhx0vfI2A7LDX+Oy/El/coJEjizZdPk86Oy4qZZtAcUSDd7DJRRHqXw+E8ToihUkeAB4YjKiGs288FRcz9nHiwOODlW+DKKD3zBCwgJCKpDs1m6QEJ/6IMPohwi9NeqKXEYNozYc8HxMqmZyHBhM1BxxqurSNNsuTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765222; c=relaxed/simple;
	bh=lNGI9OmFIX3ROmd0YpW0aM2qLJRXMahB6voPpXPOFSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DW+UmI4vUCIyQIgHqHTSKZk2+OfANsy7v7D3Faz/jxXBA7l23ZhrtNqmeLTLSJqj6UeRK148MGedgvdtKhElDaID3O0gHC50vWOKpvJXJh1OcBnrylBSm4LcCYkVQPZ4IwheB5f9Iuio1+ioIuZAq0FsF2fWdW98NfH8D+xa0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9IvHPyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F633C4CED6;
	Fri, 28 Feb 2025 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740765220;
	bh=lNGI9OmFIX3ROmd0YpW0aM2qLJRXMahB6voPpXPOFSE=;
	h=From:To:Cc:Subject:Date:From;
	b=q9IvHPyT1M2YCPvq1IDmlhw8ouy0R0gup7Y6Yd1WpWttU581st2d2ZscKzGNsdfAw
	 5jjcxvs8Yuru7fhgpcruJYCfNmpeMCPSiA1mFTumnobza5W4GFKdw0pZ9l5uvXz2Ng
	 j2G3uSgLYk+IuYvc51AXOvgfbZE6cV3drkyleOXp5cRLLpTPyKrWp2YCBwufjSppn5
	 m0QqX9+g9wZqwPMDDzbbslCUD8rUfQuMZ5PjpypZtppA/FZMTPBmBH1bMBJALSQNZw
	 y4z5mLYfAvvzOyV2leDHFdsMA+QoYiKJ70/8wzeMGZSTNzVtymVAOqHgsQZkEFNRtI
	 P5Vcc/rOlmgPA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon: respect core layer filters' allowance decision on ops layer
Date: Fri, 28 Feb 2025 09:53:36 -0800
Message-Id: <20250228175336.42781-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filtering decisions are made in filters evaluation order.  Once a
decision is made by a filter, filters that scheduled to be evaluated
after the decision-made filter should just respect it.  This is the
intended and documented behavior.  Since core layer-handled filters are
evaluated before operations layer-handled filters, decisions made on
core layer should respected by ops layer.

In case of reject filters, the decision is respected, since core
layer-rejected regions are not passed to ops layer.  But in case of
allow filters, ops layer filters don't know if the region has passed to
them because it was allowed by core filters or just because it didn't
match to any core layer.  The current wrong implementation assumes it
was due to not matched by any core filters.  As a reuslt, the decision
is not respected.  Pass the missing information to ops layer using a new
filed in 'struct damos', and make the ops layer filters respect it.

Fixes: 491fee286e56 ("mm/damon/core: support damos_filter->allow")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 mm/damon/core.c       | 6 +++++-
 mm/damon/paddr.c      | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 795ca09b1107..242910b190c9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -496,6 +496,11 @@ struct damos {
 	unsigned long next_apply_sis;
 	/* informs if ongoing DAMOS walk for this scheme is finished */
 	bool walk_completed;
+	/*
+	 * If the current region in the filtering stage is allowed by core
+	 * layer-handled filters.  If true, operations layer allows it, too.
+	 */
+	bool core_filters_allowed;
 /* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index cfa105ee9610..b1ce072b56f2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1433,9 +1433,13 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 {
 	struct damos_filter *filter;
 
+	s->core_filters_allowed = false;
 	damos_for_each_filter(filter, s) {
-		if (damos_filter_match(ctx, t, r, filter))
+		if (damos_filter_match(ctx, t, r, filter)) {
+			if (filter->allow)
+				s->core_filters_allowed = true;
 			return !filter->allow;
+		}
 	}
 	return false;
 }
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 25090230da17..d5db313ca717 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -253,6 +253,9 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 {
 	struct damos_filter *filter;
 
+	if (scheme->core_filters_allowed)
+		return false;
+
 	damos_for_each_filter(filter, scheme) {
 		if (damos_pa_filter_match(filter, folio))
 			return !filter->allow;

base-commit: c8f5534db6574708eee17fcd416f0a3fb3b45dbd
-- 
2.39.5

