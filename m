Return-Path: <stable+bounces-185743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A44BDC270
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 04:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C0E1922907
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 02:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1869530BF76;
	Wed, 15 Oct 2025 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZXxvPehk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2762F1FC8;
	Wed, 15 Oct 2025 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760495409; cv=none; b=LRXKTM8vSw7Y4xlC9kbRPDH2uj03zf6rvudAs60WKU/Ek/MUfbu35Arc9WAU7CsgEPb14O0agDyCVzlK8tEoYGwcXWK3M0e2HaLyShhYavL3A/Eiy5XFkpOrZHyum+CuTpWLWGeVdaajw/NbrM16/AAbrNtjZXZ+jcJ+xW35glw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760495409; c=relaxed/simple;
	bh=zJf2ff8Mc+KUCj6v/4V2e8gqyAI09SbyDK80lPTQ0mQ=;
	h=Date:To:From:Subject:Message-Id; b=k9DDoPBFaf0DImSI/TeZ+/5/REXwvl8Fy65Nz7EINsDd5hZ+bgdCskoFEQKm+5R/bkUWCZ7e6YTtYwj1Nh3BYEmS/E9jSMqDgAP/9cHYfFzfy2opU28jf3UNq7b8WINU+2Mo7NuIY9XPxvIoogyfPLutquDBqRMrbWh9r9/GwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZXxvPehk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353A1C4CEE7;
	Wed, 15 Oct 2025 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760495409;
	bh=zJf2ff8Mc+KUCj6v/4V2e8gqyAI09SbyDK80lPTQ0mQ=;
	h=Date:To:From:Subject:From;
	b=ZXxvPehkYYizuz1EVmk3gYJit5+S9ISPfLwRzVFIJxGgjmRycPzWZt8Gfzx4/C+VI
	 p87ZoeqUSuvrguNzL9jNyFqM2+6yC4/6L1NXCd9ZsU9TmNuE2LmXtCDbpMEUyEaV/L
	 85PRuc/fCtaHPUlgcCgU3eh8nLVaO4fhN4g6vCtc=
Date: Tue, 14 Oct 2025 19:30:08 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,lienze@kylinos.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-damon-core-fix-potential-memory-leak-by-cleaning-ops_filter-in-damon_destroy_scheme.patch added to mm-hotfixes-unstable branch
Message-Id: <20251015023009.353A1C4CEE7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/damon/core: fix potential memory leak by cleaning ops_filter in damon_destroy_scheme
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-damon-core-fix-potential-memory-leak-by-cleaning-ops_filter-in-damon_destroy_scheme.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-core-fix-potential-memory-leak-by-cleaning-ops_filter-in-damon_destroy_scheme.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Enze Li <lienze@kylinos.cn>
Subject: mm/damon/core: fix potential memory leak by cleaning ops_filter in damon_destroy_scheme
Date: Tue, 14 Oct 2025 16:42:25 +0800

Currently, damon_destroy_scheme() only cleans up the filter list but
leaves ops_filter untouched, which could lead to memory leaks when a
scheme is destroyed.

This patch ensures both filter and ops_filter are properly freed in
damon_destroy_scheme(), preventing potential memory leaks.

Link: https://lkml.kernel.org/r/20251014084225.313313-1-lienze@kylinos.cn
Fixes: ab82e57981d0 ("mm/damon/core: introduce damos->ops_filters")
Signed-off-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: SeongJae Park <sj@kernel.org>
Tested-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/damon/core.c~mm-damon-core-fix-potential-memory-leak-by-cleaning-ops_filter-in-damon_destroy_scheme
+++ a/mm/damon/core.c
@@ -452,6 +452,9 @@ void damon_destroy_scheme(struct damos *
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
 
+	damos_for_each_ops_filter_safe(f, next, s)
+		damos_destroy_filter(f);
+
 	kfree(s->migrate_dests.node_id_arr);
 	kfree(s->migrate_dests.weight_arr);
 	damon_del_scheme(s);
_

Patches currently in -mm which might be from lienze@kylinos.cn are

mm-damon-core-fix-potential-memory-leak-by-cleaning-ops_filter-in-damon_destroy_scheme.patch


