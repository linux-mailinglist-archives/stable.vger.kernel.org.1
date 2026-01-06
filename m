Return-Path: <stable+bounces-204995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12ECF6576
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB11D301B4A1
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470532939B;
	Tue,  6 Jan 2026 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUopMDzp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C97A329389;
	Tue,  6 Jan 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663920; cv=none; b=Pjw+DtAIoo0R3qvRWBoW6VcsSYF2BhZK17ynh4erPSjTSfPUdF8/2gTstetTGJCIUanpjfdPddRmBftyjJPOqHHX5j3MxUqP2+l7umQ/OhRVTvUv/VyqtwA6DofCL/+h2aja+ZKg7eyuXt4+BwLPrW7Bno5FD8rhpc/4n1xR5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663920; c=relaxed/simple;
	bh=IbMNEw9lBhcSH8cRNEs0s/qONMcvyGFnAD7Wq4vbsjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eumy/mMJHN+em3vPBYwCmSkuj5Jkofv4JxyYAxbo1qJgCMuycdsdshHvgT+dqznG0E1+OLvTRxkwSV1faBhbOY4BwqKJHwSY0BnTVAvF9OpJLM7lYn8B+n4FqVKj8qbWFZxMkaj0utx/OAtP4f7USdCsvl08MPZdc5iY2yWsLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUopMDzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D1DC116D0;
	Tue,  6 Jan 2026 01:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663919;
	bh=IbMNEw9lBhcSH8cRNEs0s/qONMcvyGFnAD7Wq4vbsjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUopMDzpH4fMyFRIa0oD3AjHJwyb6fonv467tV9Ykadlzg6tw3rWbKxqoF9St6mfx
	 OgVCg10Oyy8rJ3XY++Lavl11M1rolW6Pj/lCR+fFbVg3Q+1G8qTwfJHD7fIyPWFkiJ
	 BdYSLFtYzi/2fq64vPNsqPihCWAbC/LclO+zZyQ3DjJU/GfJ6NcWKsa6jZgk30L27B
	 ft4XvmCT46ANAbHx/XXPIgcpQ/ucBJADFVAhoVkzlRDOIRFG8G1niziZ+5qRVB6CFi
	 RtgP+f1869vG2Y+PlWtySGnPTClzMtzjoctnQ1MePCGgL3es4PZXkmi4lmexNX/l16
	 xz8bFyzAteL6g==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()
Date: Mon,  5 Jan 2026 17:45:10 -0800
Message-ID: <20260106014510.377757-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010550-tank-repugnant-eee6@gregkh>
References: <2026010550-tank-repugnant-eee6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_new_filter() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-14-sj@kernel.org
Fixes: 2a158e956b98 ("mm/damon/core-test: add a test for damos_new_filter()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 28ab2265e9422ccd81e4beafc0ace90f78de04c4)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index cf22e09a3507..28f88cc27517 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -412,6 +412,8 @@ static void damos_test_new_filter(struct kunit *test)
 	struct damos_filter *filter;
 
 	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
+	if (!filter)
+		kunit_skip(test, "filter alloc fail");
 	KUNIT_EXPECT_EQ(test, filter->type, DAMOS_FILTER_TYPE_ANON);
 	KUNIT_EXPECT_EQ(test, filter->matching, true);
 	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);
-- 
2.47.3


