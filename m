Return-Path: <stable+bounces-98709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7627B9E4C5E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 03:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3626F283142
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 02:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D617C7B1;
	Thu,  5 Dec 2024 02:41:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D145BE49;
	Thu,  5 Dec 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366471; cv=none; b=ebpUjTkeUsmXyuzJmqtqN427lzEtedpKXlcFwVLTMu00CBHWHE30YKridc2E1ZSQKf4Tb9ClKa3VYtUGOms1D5DtED7tcm7m2olNJevNtvv5jQB5UvzNgqJ4yvpYtg4OB7Wu09YUGN/QDIqq2YSWFvVt4kbG7lm67XLf3gvvdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366471; c=relaxed/simple;
	bh=q0yv3RMHE7v9mV9K/pUaQrLNjAvfc2BMhOSEGrvlUXE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Gr5nd1cKfjVgkIYCtu3ARnei/vDNbhlifonMO9zQ8DN+zn2hlPagjcjapXKCDFI9/tmezAHdk+GQ+GQlPc2c5od3DI+7lXIELG5IHRQmFEWRncWGb0bC7vLtw59TGDCt75JdAI4f2OYf6jmY13lv66ig06cNOX6z4Nyu2kj2ue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D21C4CED6;
	Thu,  5 Dec 2024 02:41:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tJ1nn-000000022en-2Nt1;
	Wed, 04 Dec 2024 21:41:15 -0500
Message-ID: <20241205024115.419087387@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Dec 2024 21:35:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [for-linus][PATCH 1/2] tracing: Fix cmp_entries_dup() to respect sort() comparison rules
References: <20241205023552.609451828@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Kuan-Wei Chiu <visitorckw@gmail.com>

The cmp_entries_dup() function used as the comparator for sort()
violated the symmetry and transitivity properties required by the
sorting algorithm. Specifically, it returned 1 whenever memcmp() was
non-zero, which broke the following expectations:

* Symmetry: If x < y, then y > x.
* Transitivity: If x < y and y < z, then x < z.

These violations could lead to incorrect sorting and failure to
correctly identify duplicate elements.

Fix the issue by directly returning the result of memcmp(), which
adheres to the required comparison properties.

Cc: stable@vger.kernel.org
Fixes: 08d43a5fa063 ("tracing: Add lock-free tracing_map")
Link: https://lore.kernel.org/20241203202228.1274403-1-visitorckw@gmail.com
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/tracing_map.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 3a56e7c8aa4f..1921ade45be3 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -845,15 +845,11 @@ int tracing_map_init(struct tracing_map *map)
 static int cmp_entries_dup(const void *A, const void *B)
 {
 	const struct tracing_map_sort_entry *a, *b;
-	int ret = 0;
 
 	a = *(const struct tracing_map_sort_entry **)A;
 	b = *(const struct tracing_map_sort_entry **)B;
 
-	if (memcmp(a->key, b->key, a->elt->map->key_size))
-		ret = 1;
-
-	return ret;
+	return memcmp(a->key, b->key, a->elt->map->key_size);
 }
 
 static int cmp_entries_sum(const void *A, const void *B)
-- 
2.45.2



