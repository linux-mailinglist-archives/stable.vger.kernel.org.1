Return-Path: <stable+bounces-160323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB80AFA778
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 21:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8597A4960
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0E7288C12;
	Sun,  6 Jul 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp6grlXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFCD18A6AE;
	Sun,  6 Jul 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751830332; cv=none; b=QGc+cT7mByoZ7Qdc9WS88AlNJ4q+G74XiAMTx9yQrd3wWJ180G3MFBkDAyRMeT4iT5+lvaJHx1mJj2VW4+vZ+o6SyE15i6NzCzHSQbVGZA5KjDC0n8svn28NChE2MazysRlJ70NwUIl2cXq1+w+bhvfcVzm2MbqQKBoc86QPf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751830332; c=relaxed/simple;
	bh=WHVKcu3OKn9+z4TbtcrV+rsHC/Q8OOdR8csfZWK5Jhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HeQfFaLiSLZQktpfYrJTUQiOYpNbtAYnrySLGdRGYSJPORWGe2gdWGKBkwlxFQXJ/JLRRoOe2xRjUDGBPLDBSgtbjjY7S3f30i9D18I6dStLfl6BE5msb7DEXWa3Yk9MYOpWyKa5cPxl/ZM/0mSFwsvkMn/a8Lg/0y8mwYfVI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp6grlXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF99C4CEED;
	Sun,  6 Jul 2025 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751830331;
	bh=WHVKcu3OKn9+z4TbtcrV+rsHC/Q8OOdR8csfZWK5Jhw=;
	h=From:To:Cc:Subject:Date:From;
	b=Gp6grlXTBqDCt3Mj1jb8ViP8M9MdeGMP3n6tW9gklD2Q5k5STNWN/DvFraIXCGBli
	 dkl985rEOAEd8YaRSHISFkhh8ndtBsWHhMJUufR+rnD3qPcEb414PcxKjePnarWfs/
	 vUHUnNtcP/oTmvaBUzEs1RnW0wuWy263eI7FK3E5RbCy+qRRy0dBVYgel5WFxOEgzv
	 hOo0mTzquqX/IDeD6naguBzfK8fwRezJT0GcT2FWmLXLmsXqxtwwIqaaPeEOiltm3A
	 ES1stfFdYYOFtxiBkQ18KAkOqfTmsXXDc823buGRPeX36ptdZS/pjk/o3I3oJ9VA0B
	 K97ABGraJenWg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 0/6] mm/damon: fix misc bugs in DAMON modules
Date: Sun,  6 Jul 2025 12:32:01 -0700
Message-Id: <20250706193207.39810-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From manual code review, I found below bugs in DAMON modules.

DAMON sample modules crash if those are enabled at boot time, via kernel
command line.  A similar issue was found and fixed on DAMON non-sample
modules in the past, but we didn't check that for sample modules.

DAMON non-sample modules are not setting 'enabled' parameters
accordingly when real enabling is failed.  Honggyu found and fixed[1]
this type of bugs in DAMON sample modules, and my inspection was
motivated by the great work.  Kudos to Honggyu.

Finally, DAMON_RECLIAM is mistakenly losing scheme internal status due
to misuse of damon_commit_ctx().  DAMON_LRU_SORT has a similar misuse,
but fortunately it is not causing real status loss.

Fix the bugs.  Since these are similar patterns of bugs that were found
in the past, it would be better to add tests or refactor the code, in
future.

Note that the fix of the second bug for DAMON_STAT is sent
separately[2], since it is a fix for a bug in mm-unstable tree at the
moment.  Also as mentioned above, DAMON_LRU_SORT also has a misuse of
damon_commit_ctx(), but it is not causing a real issue, hence the fix is
not included in this series.  I will post it later.

[1] https://lore.kernel.org/20250702000205.1921-1-honggyu.kim@sk.com
[2] https://lore.kernel.org/20250706184750.36588-1-sj@kernel.org

SeongJae Park (6):
  samples/damon/wsse: fix boot time enable handling
  samples/damon/prcl: fix boot time enable crash
  samples/damon/mtier: support boot time enable setup
  mm/damon/reclaim: reset enabled when DAMON start failed
  mm/damon/lru_sort: reset enabled when DAMON start failed
  mm/damon/reclaim: use parameter context correctly

 mm/damon/lru_sort.c   |  5 ++++-
 mm/damon/reclaim.c    |  9 ++++++---
 samples/damon/mtier.c | 13 +++++++++++++
 samples/damon/prcl.c  | 13 +++++++++++++
 samples/damon/wsse.c  | 15 ++++++++++++++-
 5 files changed, 50 insertions(+), 5 deletions(-)


base-commit: a555ad24c884e9f4ee2f2a0184f5b7b89c8d4a6e
-- 
2.39.5

