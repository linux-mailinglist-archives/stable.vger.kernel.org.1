Return-Path: <stable+bounces-160324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C9AFA77C
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 21:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C431189A3B0
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB402BD598;
	Sun,  6 Jul 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMJRlayK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE72BD03D;
	Sun,  6 Jul 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751830334; cv=none; b=ALEw+xErHnFTwy3WPmo8PRkGcBDzvK6FTd9o57+MmfdFtiFU1EMznVsy7I7+xJnc2SoT7BZj6o4iLgklH+sMy8pJDM4KwgzNWNwdXU7MTluQwFKre504sgaqL3/nMrAyks56nalzqchF8u3aoT9O7PqGnWpH7uPSPTjOX4qLJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751830334; c=relaxed/simple;
	bh=6YD9fy08Fo/Z6UH4MbMMm+CPYSdgQozsFgabwgS4zT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+QkU1OPBzEc/AL2slHfQ6xVc25O1Qet0sIF1170r2aL1af/kq86xFyi3iXIQyCEO0GNF8KXYBca2oPRvFWMGJIhm7LzTtGUgwXrXm62DLMSSGp4qZ/WRfPNNVlOmyffxClJquFLKnDydjYlRgNFizxHF0NA8MiqtdJANjSLj80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMJRlayK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C56AC4CEED;
	Sun,  6 Jul 2025 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751830334;
	bh=6YD9fy08Fo/Z6UH4MbMMm+CPYSdgQozsFgabwgS4zT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMJRlayKVif4YbZF9qfw9t+/LZpmyuFR/neasYaN30x+/Uro4/h7gm0L4P9lyLCHp
	 qqxu1PF7g1OZphsraYVBTe2h2BzlfGS9roOjjp0CGJVAz9gaxzXFBSvrI1g6PGu/TA
	 AG53phwplyMHUlFnqmZOzK7SV3q3xudIwDMzm1RJ050OONWzteQf4LsAlt+9Z19pkl
	 KB5knvrBsMnWnHJS7SGYgES1uUDKo/3KrfPU3XKcmPtXVRijp7rwxeJum//6Ef3Mpp
	 xxglyjXdpy51HeLQXm2x28Tt9kDyP5N1YGVcdz03k9pwJEJHXShIqN4J7la3dSu0Jk
	 4NDIVjwrZmpEA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 3/6] samples/damon/mtier: support boot time enable setup
Date: Sun,  6 Jul 2025 12:32:04 -0700
Message-Id: <20250706193207.39810-4-sj@kernel.org>
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

If 'enable' parameter of the 'mtier' DAMON sample module is set at boot
time via the kernel command line, memory allocation is tried before the
slab is initialized.  As a result kernel NULL pointer dereference BUG
can happen.  Fix it by checking the initialization status.

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Cc: stable@vger.kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 97892ade7f31..20c3102242ec 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -157,6 +157,8 @@ static void damon_sample_mtier_stop(void)
 	damon_destroy_ctx(ctxs[1]);
 }
 
+static bool init_called;
+
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -170,6 +172,9 @@ static int damon_sample_mtier_enable_store(
 	if (enable == enabled)
 		return 0;
 
+	if (!init_called)
+		return 0;
+
 	if (enable) {
 		err = damon_sample_mtier_start();
 		if (err)
@@ -182,6 +187,14 @@ static int damon_sample_mtier_enable_store(
 
 static int __init damon_sample_mtier_init(void)
 {
+	int err = 0;
+
+	init_called = true;
+	if (enable) {
+		err = damon_sample_mtier_start();
+		if (err)
+			enable = false;
+	}
 	return 0;
 }
 
-- 
2.39.5

