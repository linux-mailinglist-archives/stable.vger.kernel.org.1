Return-Path: <stable+bounces-93583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F639CF3CC
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E321F23C36
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84A61D63E8;
	Fri, 15 Nov 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH8mnw6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BF14A088;
	Fri, 15 Nov 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694826; cv=none; b=DXHQnXZrPeOOcXTdUGAC0txw8gg4sZploO5BJxiykjJSHucmLG5kRzpsdEldtrmaqM0D1QXLVoGqPHnA3tQClFnswpGrqfAMGWpH/MtjpWXctf6+xmtk6AOvG1O9DHH6hlcTA3wI4A8GI61tDI2mFjK/9iauSXjN420YlIH/o7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694826; c=relaxed/simple;
	bh=QLvF9Itl9shxQblgQCJX6lFfL008SE7kFJDmbFl2xFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mYD91xgzBYR8Zc2cxEYYu/RM36Po0iAuyTUKC0Tr5LHtWQ1ehaHsSCEMXk6mbh5nwH1T24W8H4w6TXusH4rqF9jmOUyiSO2+r6O6/qdKK0YIvOf2y47zlsGTT03J/OwtEKV/2RI5u44iC7x9UtvAuYoDuJ8YWw5I1nCS0l26j78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH8mnw6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028E0C4CECF;
	Fri, 15 Nov 2024 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731694826;
	bh=QLvF9Itl9shxQblgQCJX6lFfL008SE7kFJDmbFl2xFk=;
	h=From:To:Cc:Subject:Date:From;
	b=bH8mnw6/M5E0nJjuC15yc9XPrnq8Pf61PmV7FxetOjend/gusHFq9AyU7RG/UkHy9
	 Xt3xottVcZbQaBxh8x0/WyEGhUtj7ACbbx3PlIO7Qj4p7sO7nEIQtN9AOkyzxNBGL4
	 Qmntvk0T7IPneDFdOdT1rBU4Ce8FEEquUMAFlb5ABiOG2Jm1lQteci1NB5pBsyiD5T
	 3UdvxSlzuRVaAvMeheaUJamQcjFE0N8Kze3xdXzwpk6DS4kCuiQnXqQZgYySf6sSm3
	 +TAau+4tZpY1UrfRcYCUldvj4R9CTMqV/MiGc6QYZB55ZcXXQyyXIydRlwM5b7Dr/W
	 fxbdjkeX76n3w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH RESEND] mm/damon: fix order of arguments in damos_before_apply tracepoint
Date: Fri, 15 Nov 2024 10:20:23 -0800
Message-Id: <20241115182023.43118-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akinobu Mita <akinobu.mita@gmail.com>

Since the order of the scheme_idx and target_idx arguments in TP_ARGS is
reversed, they are stored in the trace record in reverse.

Fixes: c603c630b509 ("mm/damon/core: add a tracepoint for damos apply target regions")
Cc: <stable@vger.kernel.org>
Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Link: https://patch.msgid.link/20241112154828.40307-1-akinobu.mita@gmail.com
---
 include/trace/events/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 23200aabccac..da4bd9fd1162 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -15,7 +15,7 @@ TRACE_EVENT_CONDITION(damos_before_apply,
 		unsigned int target_idx, struct damon_region *r,
 		unsigned int nr_regions, bool do_trace),
 
-	TP_ARGS(context_idx, target_idx, scheme_idx, r, nr_regions, do_trace),
+	TP_ARGS(context_idx, scheme_idx, target_idx, r, nr_regions, do_trace),
 
 	TP_CONDITION(do_trace),
 
-- 
2.39.5


