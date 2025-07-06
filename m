Return-Path: <stable+bounces-160322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F3AFA777
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A85177A47CA
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD9288537;
	Sun,  6 Jul 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNms0LMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF74186A;
	Sun,  6 Jul 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751830332; cv=none; b=rlGI4CHABZlSGVJfkdwT2mmbsTHvm+eSeIOA/6LYY9Ag4PjU9VVvQ9vCWMI6Gxl39q1T4E9O74y5blMWyV9UkKvTq2QZ06MVLoQdvGn9jKDInxK6wTmrBpfSYVadi+MR4LKLRuJ/wJohBuMin0GJ16Muz0VhQJuqvB0aso/FnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751830332; c=relaxed/simple;
	bh=sJNUfzwZJvQuoC1F66bEVuJ3ctg7lAi4+PjtYCktIEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oOLFMY6xeaDtzJL79NBw8CMyArsZY03mcYtwvhSwLg4CUr1jteOTU4ggHqElv61kM8SsMm58J3+v8wyQXjsHHxsQ0QFh1AW3Ns41wuieJ+UvS/md3XSRc1d3LgZfoiYZHtWrYL8sY6aWbeVdGvvaj+VrmgsHrQNYSQ8Fe7QWYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNms0LMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEF0C4CEEE;
	Sun,  6 Jul 2025 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751830332;
	bh=sJNUfzwZJvQuoC1F66bEVuJ3ctg7lAi4+PjtYCktIEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNms0LMnuLq5XZ6TxvfkzWtuOenMfZRROw0kJ5+cQl9xWB24W3LzEwyWWmlGR9HtY
	 AMbsxj2gYKPhGgIRcd8xoe+yu8OPTCVxt9YrgG7jeTdJFJtnT9LfxlNRC7ZFzFeYIy
	 WABZK2AKedpb1JSrnCYxEroLPUUf7i2QNUqs/+qpYZOOKlnYZDWmuvyNp9sw7A9reF
	 31E7p9yReXo4OpbxkMIneMiAvdB25ljXfRRLQN4O/hDtKxk6y95A6PCOCvLXhO+5hh
	 EaIomREwbJifZTOkCbNYZAqMRJGBRCwfXysRHcRs63XNU02Jc9YeQsaw2P/laz4E/v
	 pM1zJ7JBVa+Xg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 1/6] samples/damon/wsse: fix boot time enable handling
Date: Sun,  6 Jul 2025 12:32:02 -0700
Message-Id: <20250706193207.39810-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706193207.39810-1-sj@kernel.org>
References: <20250706193207.39810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'enable' parameter of the 'wsse' DAMON sample module is set at boot
time via the kernel command line, memory allocation is tried before the
slab is initialized.  As a result kernel NULL pointer dereference BUG
can happen.  Fix it by checking the initialization status.

Fixes: b757c6cfc696 ("samples/damon/wsse: start and stop DAMON as the user requests")
Cc: stable@vger.kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index e20238a249e7..15e2683fe5f3 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -89,6 +89,8 @@ static void damon_sample_wsse_stop(void)
 		put_pid(target_pidp);
 }
 
+static bool init_called;
+
 static int damon_sample_wsse_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -103,6 +105,9 @@ static int damon_sample_wsse_enable_store(
 		return 0;
 
 	if (enable) {
+		if (!init_called)
+			return 0;
+
 		err = damon_sample_wsse_start();
 		if (err)
 			enable = false;
@@ -114,7 +119,15 @@ static int damon_sample_wsse_enable_store(
 
 static int __init damon_sample_wsse_init(void)
 {
-	return 0;
+	int err = 0;
+
+	init_called = true;
+	if (enable) {
+		err = damon_sample_wsse_start();
+		if (err)
+			enable = false;
+	}
+	return err;
 }
 
 module_init(damon_sample_wsse_init);
-- 
2.39.5

