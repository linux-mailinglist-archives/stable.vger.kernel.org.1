Return-Path: <stable+bounces-180807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC1AB8DC5C
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F4B189E62D
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29C253B4C;
	Sun, 21 Sep 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGMJnkQu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06A4A1A
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461861; cv=none; b=Tyw9u5bvnhjh7eEHd4z7/MzBAFXXCPAbQxIogAqaW5CL06lm1kN1VenvPHjYBX7VjNkTbtPp4Ud20pPZMaddhRUSyqaMBQXh8tDZFaSSmFSkL0PzW+Bz0mlWkBDiVH0MAnijfbety6RI3xNadCHx8Fuj9fGYuZ3J6UDPcZQ7U4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461861; c=relaxed/simple;
	bh=yAl+XhKpdpCfRhFGn7e0pqOSueRe1jLhBJr7y40IaZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0oJ6OzDOTvjitzYuwPFxAHanGXW+TNWJNhp7jcSa7gmopI0CB24EmX8VXJQDVxMkNBj4biMHQV79UJnOpdHfgJbIpJMJ9/XN1GBS/ib7iyrvlWQ0SFUtm/G/PDiW2Mip8Gb/SDy6nbh6Q3v1PV+5PKf2pkEO7iT9kbC2j+Qk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGMJnkQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796FFC4CEE7;
	Sun, 21 Sep 2025 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461860;
	bh=yAl+XhKpdpCfRhFGn7e0pqOSueRe1jLhBJr7y40IaZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGMJnkQub82vT1oF1vyQGlHWsfzxv7GMIE8AwsDFa+fuyBjfdp9FPgikCZNaoIqto
	 pUOvlRbuf7gMnCxfzwSAnyUEtnTPv/BTqAtMVohldUlyHGATAK40fHObjvNClkddOS
	 5cnB6OQbHuFPAs1JiTcusx9gXoDuPMvmhQppGeuZblLwi6JDH5vb1hbJ62Mesi1Bvv
	 Nk3xdkKFNn4oq2hVyEf10hxxGzxEed8nHrC1CzQd+EzzktAWcawqzOlZ5tuskhwRuF
	 5WVB75Rt9kvpLHJ75TSsDak3gF2RpQFq8pvx2SAsSJjDrKi9l0xGmoEvXEJBlPHbQk
	 ahKEZ3QVUlSug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/3] samples/damon/prcl: fix boot time enable crash
Date: Sun, 21 Sep 2025 09:37:36 -0400
Message-ID: <20250921133738.2911582-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092111-specked-enviably-906d@gregkh>
References: <2025092111-specked-enviably-906d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 2780505ec2b42c07853b34640bc63279ac2bb53b ]

If 'enable' parameter of the 'prcl' DAMON sample module is set at boot
time via the kernel command line, memory allocation is tried before the
slab is initialized.  As a result kernel NULL pointer dereference BUG can
happen.  Fix it by checking the initialization status.

Link: https://lkml.kernel.org/r/20250706193207.39810-3-sj@kernel.org
Fixes: 2aca254620a8 ("samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation")
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f826edeb888c ("samples/damon/wsse: avoid starting DAMON before initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/damon/prcl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 5597e6a08ab22..a9d7629d70f0a 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -109,6 +109,8 @@ static void damon_sample_prcl_stop(void)
 		put_pid(target_pidp);
 }
 
+static bool init_called;
+
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -134,6 +136,14 @@ static int damon_sample_prcl_enable_store(
 
 static int __init damon_sample_prcl_init(void)
 {
+	int err = 0;
+
+	init_called = true;
+	if (enable) {
+		err = damon_sample_prcl_start();
+		if (err)
+			enable = false;
+	}
 	return 0;
 }
 
-- 
2.51.0


