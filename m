Return-Path: <stable+bounces-132558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BE9A88352
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F39188AE9D
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429FC2C1791;
	Mon, 14 Apr 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH+Olzhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9C2C1785;
	Mon, 14 Apr 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637412; cv=none; b=RjyWwoUGjQPy71Rov+S4n8FyHnedUyoHtdkvMxxaz+oeD5btoe8ihhf7JVIs6BAmhKIL8OcWCzpEYdfMoV9obqPcZ4abJ+fE01Ws6hlM+vrYaHJh0VrYTkY7kuh2C/hF85IbaFigGC6MSpzmue5+GQ8FKZ7ZjlJ/alwpVtRLMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637412; c=relaxed/simple;
	bh=a0+9yJIvSTNLHuO38zoPIViqn64L4q0uCxCfk53OQyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYKYws/Lkb3UgV0IBhyRg/rBDhVbNBZtfD8LE4StIx8ZAVhWq8q/NJ5xrSiho0zNUXn4wZ21jj9iy9qXHRKO3IS/NXSDnR9ZzN8itwucKLfCaSjl1kREvy6U+tO6NiDRLKClzR38DrRvkE80YdJUYqGEitAWbIeqBjGUTstbG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH+Olzhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7707AC4CEEB;
	Mon, 14 Apr 2025 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637410;
	bh=a0+9yJIvSTNLHuO38zoPIViqn64L4q0uCxCfk53OQyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NH+Olzhnp7Xrcmaj13iZPZCpR6j3CTfwDuxsIOPS+VUFnw0OI4taQG9x3X+cJsUDS
	 I3rnVAPOJ/07ZCY8rpNceb7DpqfQ9nUu9V3EDkJmtmVqnjbQbV6YjZYRml7vuZGSFd
	 Neh6N3phLh5GksRAS39deAFijL3+DEmZLHvGwrXNqgY8+oBgoRcC0mkuUd3CJZDg69
	 cW/BtSaKOFruSLCRs81GQpdm1wceubU3E4kMsOxFbJwJwPL89NMQldZLyn3unQrTga
	 9q+PBikMJ8+aSSMOf/NX7o5UccZ/9exhhsghyVDtHs2A1Ln3MzqAhfQfeF+ygiuNOU
	 5D8Jqjgdew+Xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriel Shahrouzi <gshahrouzi@gmail.com>,
	syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/24] perf/core: Fix WARN_ON(!ctx) in __free_event() for partial init
Date: Mon, 14 Apr 2025 09:29:38 -0400
Message-Id: <20250414132957.680250-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit

From: Gabriel Shahrouzi <gshahrouzi@gmail.com>

[ Upstream commit 0ba3a4ab76fd3367b9cb680cad70182c896c795c ]

Move the get_ctx(child_ctx) call and the child_event->ctx assignment to
occur immediately after the child event is allocated. Ensure that
child_event->ctx is non-NULL before any subsequent error path within
inherit_event calls free_event(), satisfying the assumptions of the
cleanup code.

Details:

There's no clear Fixes tag, because this bug is a side-effect of
multiple interacting commits over time (up to 15 years old), not
a single regression.

The code initially incremented refcount then assigned context
immediately after the child_event was created. Later, an early
validity check for child_event was added before the
refcount/assignment. Even later, a WARN_ON_ONCE() cleanup check was
added, assuming event->ctx is valid if the pmu_ctx is valid.
The problem is that the WARN_ON_ONCE() could trigger after the initial
check passed but before child_event->ctx was assigned, violating its
precondition. The solution is to assign child_event->ctx right after
its initial validation. This ensures the context exists for any
subsequent checks or cleanup routines, resolving the WARN_ON_ONCE().

To resolve it, defer the refcount update and child_event->ctx assignment
directly after child_event->pmu_ctx is set but before checking if the
parent event is orphaned. The cleanup routine depends on
event->pmu_ctx being non-NULL before it verifies event->ctx is
non-NULL. This also maintains the author's original intent of passing
in child_ctx to find_get_pmu_context before its refcount/assignment.

[ mingo: Expanded the changelog from another email by Gabriel Shahrouzi. ]

Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lore.kernel.org/r/20250405203036.582721-1-gshahrouzi@gmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff3aa851d46ab82953a3
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b710976fb01b1..987807b1040ae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13419,6 +13419,9 @@ inherit_event(struct perf_event *parent_event,
 	if (IS_ERR(child_event))
 		return child_event;
 
+	get_ctx(child_ctx);
+	child_event->ctx = child_ctx;
+
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
@@ -13441,8 +13444,6 @@ inherit_event(struct perf_event *parent_event,
 		return NULL;
 	}
 
-	get_ctx(child_ctx);
-
 	/*
 	 * Make the child state follow the state of the parent event,
 	 * not its attr.disabled bit.  We hold the parent's mutex,
@@ -13463,7 +13464,6 @@ inherit_event(struct perf_event *parent_event,
 		local64_set(&hwc->period_left, sample_period);
 	}
 
-	child_event->ctx = child_ctx;
 	child_event->overflow_handler = parent_event->overflow_handler;
 	child_event->overflow_handler_context
 		= parent_event->overflow_handler_context;
-- 
2.39.5


