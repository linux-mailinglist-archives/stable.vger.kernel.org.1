Return-Path: <stable+bounces-185730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3ABDB58E
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 22:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C9894EAF49
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F33093DF;
	Tue, 14 Oct 2025 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l20NnhA7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB50308F19;
	Tue, 14 Oct 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475591; cv=none; b=uBd4YJIKKgktyfzLGe44fxqqOgdCORB5XloC/lFMw9Ph6xodsVvXtPEyhaajH0ooxOCckTRxbdWn1mAn31fHPSM/+Mmx/oDNGN+twGviDU9MwqZb7IZoXhmUk0TgRXJEAK2KU4MxiVK9D2xqmrO/x8ghjamh9P5QcU/giCyif/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475591; c=relaxed/simple;
	bh=CwCpWIEbjznOcuvaN31S0BbRxv1BAYgTlvJi+4awgk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWS4aKUK1qlhQlQwiSgosoLnsoFegcsCjkBTOuGDdCVdhi0p3wwKqCkSVNYIqb0wwnMRoCYsZWBB+aCq7Qxb2d4utsJTATnU+/do91sKV10q1Q4guJ8u/k8aQ+u5u5R4tcw+L+VIaAjz+n5XyWBMlEkKvZSdGQw74IJy2hewYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l20NnhA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F46BC4CEE7;
	Tue, 14 Oct 2025 20:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760475590;
	bh=CwCpWIEbjznOcuvaN31S0BbRxv1BAYgTlvJi+4awgk0=;
	h=From:To:Cc:Subject:Date:From;
	b=l20NnhA76N7s1JSZeE4HhkKM+jYSydazTLNhwgoJedy5N4CCAltIeitOYzgB97nb4
	 yJSSA9ISOIGcN2F9dO+VCT1VLFrvp54XNbUrWUdkDP2FiTUs/ZDkDeRWtmzY/FhZ7+
	 Ag9wxqiH2XLDqbC9Ggh/zHwDP6RlKazJnmRgHiV2FJAyV/4/EQIRApzSRJoDFpR/D2
	 G0WEYRuObwpMkxOXM9nuIjaVqQyPF++e+Nhf/APPitSe86Ru9BXWjh/pmchadrsuWT
	 3t5rjmLa779clCBhePxGVHmeqGxEMLEm3mMkhZ7cPhhZloWcJIWfjfJzO+QjzwkjjY
	 tRLtLdypBkohw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: fix list_add_tail() call on damon_call()
Date: Tue, 14 Oct 2025 13:59:36 -0700
Message-ID: <20251014205939.1206-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each damon_ctx maintains callback requests using a linked list
(damon_ctx->call_controls).  When a new callback request is received via
damon_call(), the new request should be added to the list.  However, the
function is making a mistake at list_add_tail() invocation: putting the
new item to add and the list head to add it before, in the opposite
order.  Because of the linked list manipulation implementation, the new
request can still be reached from the context's list head.  But the list
items that were added before the new request are dropped from the list.

As a result, the callbacks are unexpectedly not invocated.  Worse yet,
if the dropped callback requests were dynamically allocated, the memory
is leaked.  Actually DAMON sysfs interface is using a dynamically
allocated repeat-mode callback request for automatic essential stats
update.  And because the online DAMON parameters commit is using
a non-repeat-mode callback request, the issue can easily be reproduced,
like below.

    # damo start --damos_action stat --refresh_stat 1s
    # damo tune --damos_action stat --refresh_stat 1s

The first command dynamically allocates the repeat-mode callback request
for automatic essential stat update.  Users can see the essential stats
are automatically updated for every second, using the sysfs interface.

The second command calls damon_commit() with a new callback request that
was made for the commit.  As a result, the previously added repeat-mode
callback request is dropped from the list.  The automatic stats refresh
stops working, and the memory for the repeat-mode callback request is
leaked.  It can be confirmed using kmemleak.

Fix the mistake on the list_add_tail() call.

Fixes: 004ded6bee11 ("mm/damon: accept parallel damon_call() requests")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 417f33a7868e..109b050c795a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1453,7 +1453,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	INIT_LIST_HEAD(&control->list);
 
 	mutex_lock(&ctx->call_controls_lock);
-	list_add_tail(&ctx->call_controls, &control->list);
+	list_add_tail(&control->list, &ctx->call_controls);
 	mutex_unlock(&ctx->call_controls_lock);
 	if (!damon_is_running(ctx))
 		return -EINVAL;

base-commit: 49926cfb24ad064c8c26f8652e8a61bbcde37701
-- 
2.47.3

