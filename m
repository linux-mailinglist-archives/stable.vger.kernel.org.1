Return-Path: <stable+bounces-154821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC935AE0D08
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 20:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668761C22B45
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0332928B4EC;
	Thu, 19 Jun 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQwpdIDK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15E2673A9;
	Thu, 19 Jun 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750358173; cv=none; b=Tu7Z4/z5KaVgTxS5rvAa23P0i/wcBXeRMKaLgIrUBZAsbKUzAzO32A56mvaqx3vHiVwFr3zEXAskpCU2SJaFB8+r/OQMj8H3Hvh9ukUEXVNfXiYOjr3KqfM7x8221QvSpWauhD+/LdNXXKHVzSHT3Mb/mvZDT/shhnH2kttDB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750358173; c=relaxed/simple;
	bh=840kYlQBtIBzTuRYCK9lIr3LHivR6lw5teUqKnxye1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9Iupt0oSk1oaqafrOUhkYDavgPh7g7Q+KdpZF3JmGgHPxD4gVDo9myEBdwHiEgTXRb+pZjoa7ZJw5mQ0sArm43BPmZ6YBBIrH1IDbIJMAFYLyIRE/NSOjPsR+K48XBVG76eKjltoQUjmb6DTeDf3eTzCN8ss2QNENFbIN4yILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQwpdIDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FA8C4CEF0;
	Thu, 19 Jun 2025 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750358173;
	bh=840kYlQBtIBzTuRYCK9lIr3LHivR6lw5teUqKnxye1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQwpdIDKorXZCCEmcC9gDf34jdNZfCzbWg3Sa2AD2DnScGZOuQTikh0cNLCrKiO69
	 Zg1YBPEW5repRKJBEH5seo7ppGRb2OMIYAw2m0u7sJfpiDaDsqU+YHRvwD5Nmw1F1F
	 1CNZNdLS9AF7pl8nChA6rR/MEDJC3CHHeLu91Ajo+spw0rZJlC1hSN183gDuV5wkwi
	 O1/eiorO0eL1WNxQdAaJJjsZZ8cCnw4flmMwpYGvXP5tL7/fyqEkjlICmlv3+QlioJ
	 MyVdRAOz7w1wIDp44/johcURMVlHyruhHApN3gI4TxTHMxCgDQFIfHdxC9G2y9x651
	 bwm09RvzfyjEg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org, #@web.codeaurora.org,
	6.3.x@web.codeaurora.org
Subject: [PATCH 1/2] mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path on write
Date: Thu, 19 Jun 2025 11:36:07 -0700
Message-Id: <20250619183608.6647-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619183608.6647-1-sj@kernel.org>
References: <20250619183608.6647-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memcg_path_store() assigns a newly allocated memory buffer to
filter->memcg_path, without deallocating the previously allocated and
assigned memory buffer.  As a result, users can leak kernel memory by
continuously writing a data to memcg_path DAMOS sysfs file.  Fix the
leak by deallocating the previously set memory buffer.

Fixes: 7ee161f18b5d ("mm/damon/sysfs-schemes: implement filter directory")
Cc: stable@vger.kernel.org	# 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0f6c9e1fec0b..30ae7518ffbf 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -472,6 +472,7 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
+	kfree(filter->memcg_path);
 	filter->memcg_path = path;
 	return count;
 }
-- 
2.39.5

