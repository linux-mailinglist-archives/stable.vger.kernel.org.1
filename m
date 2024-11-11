Return-Path: <stable+bounces-92168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17A9C47E8
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 22:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640A81F21A2C
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 21:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC411A76C7;
	Mon, 11 Nov 2024 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/GJQKE3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AE1EB36
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359982; cv=none; b=Nz4fc3g/sKR+Q3a8dbERE27gXBRDd9M2Vo6MMXO4DoPmP/qN20f/mO6ZJ3XjlVzcB0iZ6lYUluC4dioBFLZqLGC5sWU13tPDHjac6vhlNOx81E3Bd17Rt9/dNLzEgHZTr9c7WXXW8cU3GE8HSpOBXAmUpejjImo1dRmtO8P/43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359982; c=relaxed/simple;
	bh=giSWVpBEmguoJxo2aiQ9E42mznDsKXSnmtDmDlBjPbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKqP6Sijq8B7J9CA5CCs/1UUxKlrtnqPVxvUOrwU4GWjGeuj4qwCFvzmcGtiBZE/UFBV7EGqFO2ZqGdZY4wAJn3TWmE6xzVe4LfaspFSqyte69a7+iL7sofZV1RAslW9cSO7Xfi2uC/AZMxhjRR0qJafoqyb41g/NiIy3O9+rpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/GJQKE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8F2C4CECF;
	Mon, 11 Nov 2024 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731359981;
	bh=giSWVpBEmguoJxo2aiQ9E42mznDsKXSnmtDmDlBjPbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/GJQKE3bAw2YYTppfgKo392aLmmI4IMebXXhwpmEgzUzjvwqdIJ+p++hL46903ae
	 7fNzRCA2SyAAM9PjQpf89JfpF0xHnpGdGSk8vztzixYtO5y1qNhYkyTx0U66HdN+C8
	 7iYYmrQJqQSOzmjSl7uJB3sX4cc8lEdhaYDyUEVRTyLRuqrX/l9jX557a+r3SXVvJG
	 5Mo9G5tSYNugrOaAeRQVvHChaWqceYDaa6pYXfK6zr4YalVP2D7siw9IZ6fpLuf7oS
	 pghjfxdSvNOfklNlW3Tkk6Ky4pznXL5Cqd3rlDOt34r85uxaMGbSETnuNORyo54u7S
	 o/z4Yj51sixZA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/core: handle zero {aggregation,ops_update} intervals
Date: Mon, 11 Nov 2024 13:19:34 -0800
Message-Id: <20241111211934.75731-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2024111132-portal-crowbar-256b@gregkh>
References: <2024111132-portal-crowbar-256b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch series "mm/damon/core: fix handling of zero non-sampling intervals".

DAMON's internal intervals accounting logic is not correctly handling
non-sampling intervals of zero values for a wrong assumption.  This could
cause unexpected monitoring behavior, and even result in infinite hang of
DAMON sysfs interface user threads in case of zero aggregation interval.
Fix those by updating the intervals accounting logic.  For details of the
root case and solutions, please refer to commit messages of fixes.

This patch (of 2):

DAMON's logics to determine if this is the time to do aggregation and ops
update assumes next_{aggregation,ops_update}_sis are always set larger
than current passed_sample_intervals.  And therefore it further assumes
continuously incrementing passed_sample_intervals every sampling interval
will make it reaches to the next_{aggregation,ops_update}_sis in future.
The logic therefore make the action and update
next_{aggregation,ops_updaste}_sis only if passed_sample_intervals is same
to the counts, respectively.

If Aggregation interval or Ops update interval are zero, however,
next_aggregation_sis or next_ops_update_sis are set same to current
passed_sample_intervals, respectively.  And passed_sample_intervals is
incremented before doing the next_{aggregation,ops_update}_sis check.
Hence, passed_sample_intervals becomes larger than
next_{aggregation,ops_update}_sis, and the logic says it is not the time
to do the action and update next_{aggregation,ops_update}_sis forever,
until an overflow happens.  In other words, DAMON stops doing aggregations
or ops updates effectively forever, and users cannot get monitoring
results.

Based on the documents and the common sense, a reasonable behavior for
such inputs is doing an aggregation and an ops update for every sampling
interval.  Handle the case by removing the assumption.

Note that this could incur particular real issue for DAMON sysfs interface
users, in case of zero Aggregation interval.  When user starts DAMON with
zero Aggregation interval and asks online DAMON parameter tuning via DAMON
sysfs interface, the request is handled by the aggregation callback.
Until the callback finishes the work, the user who requested the online
tuning just waits.  Hence, the user will be stuck until the
passed_sample_intervals overflows.

Link: https://lkml.kernel.org/r/20241031183757.49610-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20241031183757.49610-2-sj@kernel.org
Fixes: 4472edf63d66 ("mm/damon/core: use number of passed access sampling as a timer")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.7.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ae55f20835b0..dc8bda943673 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1407,7 +1407,7 @@ static int kdamond_fn(void *data)
 
 		sample_interval = ctx->attrs.sample_interval ?
 			ctx->attrs.sample_interval : 1;
-		if (ctx->passed_sample_intervals == next_aggregation_sis) {
+		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
 			ctx->next_aggregation_sis = next_aggregation_sis +
 				ctx->attrs.aggr_interval / sample_interval;
 			kdamond_merge_regions(ctx,
@@ -1424,7 +1424,7 @@ static int kdamond_fn(void *data)
 				ctx->ops.reset_aggregated(ctx);
 		}
 
-		if (ctx->passed_sample_intervals == next_ops_update_sis) {
+		if (ctx->passed_sample_intervals >= next_ops_update_sis) {
 			ctx->next_ops_update_sis = next_ops_update_sis +
 				ctx->attrs.ops_update_interval /
 				sample_interval;
-- 
2.39.5


