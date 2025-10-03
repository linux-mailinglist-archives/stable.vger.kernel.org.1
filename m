Return-Path: <stable+bounces-183324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067ABB80E2
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 22:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134001B208A7
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 20:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B4242D83;
	Fri,  3 Oct 2025 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAiGGoC3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE623A9A8;
	Fri,  3 Oct 2025 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522512; cv=none; b=I7p4PylZHko9cPM8ZjpR/tJo7ZQM1wKfLd50d5VPFl+LhbmRx0Oxw8AbMGfwHdlIvvcOHQXyA1tvOZLMbtcpuFUY6zNlXCdloFTec11p4CAOO3BZ9WKQbU0ERdUSmYmhtA14SGeMTpFmjMn7L4AStIqFkZma3fELPEyuX7TR4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522512; c=relaxed/simple;
	bh=bjwiI9Qos1leLOU/dQfUObg++Tq8M6DnTqo6oPGEiwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mh9KZm4rwYCo3pIi/0+nMU2BX70AUCjRkMb8IfgnmVp3TFQ1FBTyyW8hBz/kj4hvqJk79aWknbyuQQCUzFerAykqeJ3x2SMASdnvkEsnYH4Y4mF4i5+NqyhCUZDqArGoMtJi2KOQP3ZGUrV/4wLj246kRU1wqvKgvvDzIIt0Adg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAiGGoC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5B9C4CEF5;
	Fri,  3 Oct 2025 20:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759522512;
	bh=bjwiI9Qos1leLOU/dQfUObg++Tq8M6DnTqo6oPGEiwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAiGGoC3YCsVr4iogOumZyxh+ejcDryCAR6xlmtdwpzmPRapmWe/8/vC6ii/Iekmn
	 qrVTrHY1nQ+tZcwdyLnWwuE1SWd46ShRfMqfE0PLmv1judTAgpdNBXm3VUYVG5ZSs+
	 7GDWZuGnwrVzsgMB0ROjGo3Q8rFf75L02xxAUxp1KZlksOF0m35m5rgP7EWrnLpkxa
	 7KXmGufNdLh+PEH84FHy/v6zeobPwA7Ohpf9gnOd7qj9PMbh9yZYAtBllDy0/fShv3
	 V/HlnTMboDq19GvntLbUNYnUh7kie3pDjZIqQR+XxPLaIV74zWx6lljpBcnnrFWB5c
	 1ogpe7EaBVj7w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/sysfs: catch commit test ctx alloc failure
Date: Fri,  3 Oct 2025 13:14:54 -0700
Message-Id: <20251003201455.41448-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251003201455.41448-1-sj@kernel.org>
References: <20251003201455.41448-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The damon_ctx for testing online DAMON parameters commit inputs is used
without its allocation failure check.  This could result in an invalid
memory access.  Fix it by directly returning an error when the
allocation failed.

Fixes: 4c9ea539ad59 ("mm/damon/sysfs: validate user inputs from damon_sysfs_commit_input()")
Cc: <stable@vger.kernel.org> # 6.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index a212877ed240..27ebfe016871 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1473,6 +1473,8 @@ static int damon_sysfs_commit_input(void *data)
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
 	test_ctx = damon_new_ctx();
+	if (!test_ctx)
+		return -ENOMEM;
 	err = damon_commit_ctx(test_ctx, param_ctx);
 	if (err) {
 		damon_destroy_ctx(test_ctx);
-- 
2.39.5

