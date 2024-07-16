Return-Path: <stable+bounces-60304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A07933023
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE78282CBD
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903E1A2FC2;
	Tue, 16 Jul 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba5Tj+mx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9A1A01D8;
	Tue, 16 Jul 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154819; cv=none; b=lwMzVPn5AGX/32S2QFZyKqtCY2NlnvaXJ2ZCF8OvfOUNi9pnoAphKyDpnXlUPPHVMGlaqxcCEGz2XamAh6G3Tj1l0oGRhC1CzzfZ8AxxRBXqZSgNgqkaYFO5Aiyup+0TyFR6uXGligIVaqno0coVRlpvEtjS+hEvnPkEJH60goY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154819; c=relaxed/simple;
	bh=RoTz8SCDctxTyPa/A3kJf11i3VVBdS3TP8fU1fccXPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u8wrDG8LpUSlugxJQOOA5RVJmEqhqLZw/VwLZ3f4QSOOTUV9gvv+tXiCjpIHfVinlncyr2UI30Nj2xbETJA7zQk65C5ucUjLJNM1tePGQGLjzDUy0kOWEFdqdvhE5B/nF26cVgmWVAfiAJmcjenta0FvMbVQXVrWxXw7mCnvbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba5Tj+mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0D9C4AF0E;
	Tue, 16 Jul 2024 18:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154819;
	bh=RoTz8SCDctxTyPa/A3kJf11i3VVBdS3TP8fU1fccXPk=;
	h=From:To:Cc:Subject:Date:From;
	b=ba5Tj+mxToRnRvQFkDDUXX1LI3YQCVsfunTbHPZdgbMp3Fosf9I/uRFn+aTUNw3gr
	 ncHffD5kX8NBDV4VHTTxnO1UadEYU4YWVoPz83NyFHLD2zOTiBpR9fEUduZVV+TeWg
	 kvxFWaH+jsBng/DIHdwBWjcEpbo3XgJsgg8gmhPL7SXCPbveCDZropmyKJPvtQwRD5
	 iIdQizTJevrzaYVjcoZJP9kM1hSbsU4IvY+sahjlblKkBK0EaTQoFhpMc3tsQt7TG0
	 octmW0uD0GEEgMFNOTUxN+VisZb7SA2AKtadC4g4CMNKP8kdDwpYcDLEJCCm+kSYtd
	 sZqZ3Wk0fjKQQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y 0/8] Backport patches for DAMON merge regions fix
Date: Tue, 16 Jul 2024 11:33:25 -0700
Message-Id: <20240716183333.138498-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
max_nr_regions") causes a build warning and a build failure [1] on
5.15.y.  Those are due to
1) unnecessarily strict type check from max(), and
2) use of not-yet-introduced damon_ctx->attrs field, respectively.

Fix the warning by backporting a minmax.h upstream commit that made the
type check less strict for unnecessary case, and upstream commits that
it depends on.

Note that all patches except the fourth one ("minmax: fix header
inclusions") are clean cherry-picks of upstream commit.  For the fourth
one, minor conflict resolving was needed.

Also, the last patch, which is the backport of the DAMON fix, was
cleanly cherry-picked, but added manual fix for the build failure.

[1] https://lore.kernel.org/2024071532-pebble-jailhouse-48b2@gregkh

Andy Shevchenko (1):
  minmax: fix header inclusions

Bart Van Assche (1):
  tracing: Define the is_signed_type() macro once

David Laight (3):
  minmax: allow min()/max()/clamp() if the arguments have the same
    signedness.
  minmax: allow comparisons of 'int' against 'unsigned char/short'
  minmax: relax check to allow comparison between unsigned arguments and
    signed constants

Jason A. Donenfeld (2):
  minmax: sanity check constant bounds when clamping
  minmax: clamp more efficiently by avoiding extra comparison

SeongJae Park (1):
  mm/damon/core: merge regions aggressively when max_nr_regions is unmet

 include/linux/compiler.h     |  6 +++
 include/linux/minmax.h       | 89 ++++++++++++++++++++++++++----------
 include/linux/overflow.h     |  1 -
 include/linux/trace_events.h |  2 -
 mm/damon/core.c              | 23 ++++++++--
 5 files changed, 90 insertions(+), 31 deletions(-)


base-commit: 4d1b7f1bf3858ed48a98c004bda5fdff2cdf13c8
-- 
2.39.2


