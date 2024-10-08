Return-Path: <stable+bounces-82399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42526994D61
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4075B231E3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C48E1DF247;
	Tue,  8 Oct 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tbqGv93C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7ED1DE8AA;
	Tue,  8 Oct 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392129; cv=none; b=r1wtgCfPz+PFa1saD2Qe4GuN1oph2zJ33TWbOZ6XYK4URZkr2YTlvZ/30MbAJMzOmlOJLk7V5N/ToBMvIb6vk05IcBf6zBsrW/KPC4tvo0CjrJ8BEDPXq/wM2DIMg0yvXj97qzcuBI1YUyhS1acuTLcWyRCmmyBCBrveYGWX0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392129; c=relaxed/simple;
	bh=jPxBgPAMfSbwQGxXGGGAESZnm6podJ2rZafC1ZXhTQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg+ODeC/PA/lQ+JfoIGU8Pr54hz/pjiNSbxwCBJzR3dCR6RcKbxIAo2TOooGl1AcTEjVrrmQ2FRaL4LtbgwLqWuGWjRRxsnn7ITPdyb199Zdx3DbV0UFG9tebxuAZC61nZinvQyuVzeJ2jG0JyXqqB+M9Rjw+iXFFdrd+mkGj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tbqGv93C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BDEC4CEC7;
	Tue,  8 Oct 2024 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392129;
	bh=jPxBgPAMfSbwQGxXGGGAESZnm6podJ2rZafC1ZXhTQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbqGv93C7whRFgKpeO4QEy+vKzIlvED+1nNhZj4SSCm5UZwnIK27rhW7KZ5sJbhkp
	 jUoiKnKgQ64HCnIWHw20NGDfBtFb0LrW99yL8BE4dDYxYIVW7+g85AJpRAaSPPyLrL
	 VMKGYqgWpk5HApSY1rLCbTQ7sFnTUxicmc+TBkJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kan Liang <kan.liang@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Changbin Du <changbin.du@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 325/558] perf callchain: Fix stitch LBR memory leaks
Date: Tue,  8 Oct 2024 14:05:55 +0200
Message-ID: <20241008115715.094631472@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 599c19397b17d197fc1184bbc950f163a292efc9 ]

The 'struct callchain_cursor_node' has a 'struct map_symbol' whose maps
and map members are reference counted. Ensure these values use a _get
routine to increment the reference counts and use map_symbol__exit() to
release the reference counts.

Do similar for 'struct thread's prev_lbr_cursor, but save the size of
the prev_lbr_cursor array so that it may be iterated.

Ensure that when stitch_nodes are placed on the free list the
map_symbols are exited.

Fix resolve_lbr_callchain_sample() by replacing list_replace_init() to
list_splice_init(), so the whole list is moved and nodes aren't leaked.

A reproduction of the memory leaks is possible with a leak sanitizer
build in the perf report command of:

  ```
  $ perf record -e cycles --call-graph lbr perf test -w thloop
  $ perf report --stitch-lbr
  ```

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Fixes: ff165628d72644e3 ("perf callchain: Stitch LBR call stack")
Signed-off-by: Ian Rogers <irogers@google.com>
[ Basic tests after applying the patch, repeating the example above ]
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anne Macedo <retpolanne@posteo.net>
Cc: Changbin Du <changbin.du@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240808054644.1286065-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/machine.c | 17 +++++++++++++++--
 tools/perf/util/thread.c  |  4 ++++
 tools/perf/util/thread.h  |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8477edefc2997..706be5e4a0761 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2270,8 +2270,12 @@ static void save_lbr_cursor_node(struct thread *thread,
 		cursor->curr = cursor->first;
 	else
 		cursor->curr = cursor->curr->next;
+
+	map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
 	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
 	       sizeof(struct callchain_cursor_node));
+	lbr_stitch->prev_lbr_cursor[idx].ms.maps = maps__get(cursor->curr->ms.maps);
+	lbr_stitch->prev_lbr_cursor[idx].ms.map = map__get(cursor->curr->ms.map);
 
 	lbr_stitch->prev_lbr_cursor[idx].valid = true;
 	cursor->pos++;
@@ -2482,6 +2486,9 @@ static bool has_stitched_lbr(struct thread *thread,
 		memcpy(&stitch_node->cursor, &lbr_stitch->prev_lbr_cursor[i],
 		       sizeof(struct callchain_cursor_node));
 
+		stitch_node->cursor.ms.maps = maps__get(lbr_stitch->prev_lbr_cursor[i].ms.maps);
+		stitch_node->cursor.ms.map = map__get(lbr_stitch->prev_lbr_cursor[i].ms.map);
+
 		if (callee)
 			list_add(&stitch_node->node, &lbr_stitch->lists);
 		else
@@ -2505,6 +2512,8 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 	if (!thread__lbr_stitch(thread)->prev_lbr_cursor)
 		goto free_lbr_stitch;
 
+	thread__lbr_stitch(thread)->prev_lbr_cursor_size = max_lbr + 1;
+
 	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->lists);
 	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->free_lists);
 
@@ -2560,8 +2569,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 						max_lbr, callee);
 
 		if (!stitched_lbr && !list_empty(&lbr_stitch->lists)) {
-			list_replace_init(&lbr_stitch->lists,
-					  &lbr_stitch->free_lists);
+			struct stitch_list *stitch_node;
+
+			list_for_each_entry(stitch_node, &lbr_stitch->lists, node)
+				map_symbol__exit(&stitch_node->cursor.ms);
+
+			list_splice_init(&lbr_stitch->lists, &lbr_stitch->free_lists);
 		}
 		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
 	}
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 87c59aa9fe38b..0ffdd52d86d70 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -476,6 +476,7 @@ void thread__free_stitch_list(struct thread *thread)
 		return;
 
 	list_for_each_entry_safe(pos, tmp, &lbr_stitch->lists, node) {
+		map_symbol__exit(&pos->cursor.ms);
 		list_del_init(&pos->node);
 		free(pos);
 	}
@@ -485,6 +486,9 @@ void thread__free_stitch_list(struct thread *thread)
 		free(pos);
 	}
 
+	for (unsigned int i = 0 ; i < lbr_stitch->prev_lbr_cursor_size; i++)
+		map_symbol__exit(&lbr_stitch->prev_lbr_cursor[i].ms);
+
 	zfree(&lbr_stitch->prev_lbr_cursor);
 	free(thread__lbr_stitch(thread));
 	thread__set_lbr_stitch(thread, NULL);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 8b4a3c69bad19..6cbf6eb2812e0 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -26,6 +26,7 @@ struct lbr_stitch {
 	struct list_head		free_lists;
 	struct perf_sample		prev_sample;
 	struct callchain_cursor_node	*prev_lbr_cursor;
+	unsigned int prev_lbr_cursor_size;
 };
 
 DECLARE_RC_STRUCT(thread) {
-- 
2.43.0




