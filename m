Return-Path: <stable+bounces-162615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E6B05E32
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C157B6559
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5918E2E88AE;
	Tue, 15 Jul 2025 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZvS7byVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7E2E6D32;
	Tue, 15 Jul 2025 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587021; cv=none; b=RN+7g/EQfh7AJBh3svLp/iKjTtBcAC6hHOqcV2/U49yl/qzs1Vq4BU/bQ7XLMGL2OsR3n2SpTRURHgn2VxHJsQmIUBgc+nOTXl0HK8LrN7N/nyahYytfE3YWsbOevg8NljgZ2UqkPx4+72QEJbXFFQccdnsCaUZrNNB1o9qSfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587021; c=relaxed/simple;
	bh=97qbLqzqhjhyYTk+wf89Or/ngAj9w7sD5K3rNBQj6Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbAozhFzrkLq5Ruv8h6dYYfLINVEnShi/PhYXp3M85HViMECUvV714fqcAQWWfmIP4bC+Cjkhhv20EM7GGupKcBimH4nbIhF8raBq+FA5GDHqNV3a7Cd64PsPQl1Pt+uFA12c5qZQ+UTTlbM6vv0ngVj2+NKkn2szTG8QridXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZvS7byVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB9C4CEE3;
	Tue, 15 Jul 2025 13:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587021;
	bh=97qbLqzqhjhyYTk+wf89Or/ngAj9w7sD5K3rNBQj6Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvS7byVMggC1aOnRbW5lD/ELjU/iGlBIhi2F/CzglGakVvoM4kGO6NSXxMQ4I8UkU
	 0+N3fcEOxn7H2yn78vOmy9/G1sWy6Wkcsw+Kc69DCiH2G+NFrT/bvxItEg1IOg4/Ml
	 tayXFLWwVUFiL9sPNG4Rg4Abe1jWmHol5P2yViZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 137/192] io_uring/zcrx: fix pp destruction warnings
Date: Tue, 15 Jul 2025 15:13:52 +0200
Message-ID: <20250715130820.401373572@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 203817de269539c062724d97dfa5af3cdf77a3ec ]

With multiple page pools and in some other cases we can have allocated
niovs on page pool destruction. Remove a misplaced warning checking that
all niovs are returned to zcrx on io_pp_zc_destroy(). It was reported
before but apparently got lost.

Reported-by: Pedro Tammela <pctammela@mojatatu.com>
Fixes: 34a3e60821ab9 ("io_uring/zcrx: implement zerocopy receive pp memory provider")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/b9e6d919d2964bc48ddbf8eb52fc9f5d118e9bc1.1751878185.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/zcrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a53058dd6b7a1..adb1e426987ed 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -676,10 +676,7 @@ static int io_pp_zc_init(struct page_pool *pp)
 static void io_pp_zc_destroy(struct page_pool *pp)
 {
 	struct io_zcrx_ifq *ifq = io_pp_to_ifq(pp);
-	struct io_zcrx_area *area = ifq->area;
 
-	if (WARN_ON_ONCE(area->free_count != area->nia.num_niovs))
-		return;
 	percpu_ref_put(&ifq->ctx->refs);
 }
 
-- 
2.39.5




