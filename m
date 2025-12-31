Return-Path: <stable+bounces-204365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2CCEC292
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61516300289F
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAB3243376;
	Wed, 31 Dec 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHJ59ISl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692101A9F91
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767194714; cv=none; b=pi1ZzfgRIufNipgk9uCCsGizB03iK6onPyee6IumWX5/KgtlpHpyGW1VODEoVd98oTf6w8AjMC4sbT+Lw2QL1jXNxthM60JmceSVQh1IWj5LFInF98I05y2x5SPx/sdQEKzpdjbedP1xHTaXnjOmWjBNNVu+8kPn5IwXZZXVnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767194714; c=relaxed/simple;
	bh=e0hT1T4DaNFIUiTvE2kDyFinpHIEFluv2E3t9HfGXXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loJ7LMJTsCmcweOzaT68WcyKkLMgLLPpr24+TJsGhKfHYTDizWnpRZt84gOM13XJvU5QU/5qytrur5nIaZUOoLrQtQ61r7gnqphiPbthOMUoys89BKcd/sEp6r/Pba+IwwiD4u6+e97j1smjAX1UOv8mwkYK+D7y8j+GSyxvjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHJ59ISl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6990EC113D0;
	Wed, 31 Dec 2025 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767194713;
	bh=e0hT1T4DaNFIUiTvE2kDyFinpHIEFluv2E3t9HfGXXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHJ59ISlgCSibazIo/g60A6D3UullczQ4joIH3VLlb8kVQ5rftcLObx/dVQnnCD5L
	 PN8dv8xNlzUFYDrL+wV2k3sMg4fM6HNskMcbVq5PXS5EntusUpV/cQ+1cUFC6GyR3T
	 NrSUjLiS6/Zj0UYyUoP+nRlZLCm2JzF8owaX2GUU6ioI5ZU4nu2Xd9LqETsOAnozFb
	 guCTroxRU/WGT17tRgHfz83Qp/ryZYlqYvq7JK04512RF1OoHIl+8QPCRFYP8NhoTl
	 pE2C6oZQiNF1xqbpUDCCibkmQoRhOQZpwKRhNsx3kkbSLh1m8fHfEIzTDlhX2cR3Gv
	 /U60M510tOSmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Rogers <linux@joshua.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] svcrdma: bound check rq_pages index in inline path
Date: Wed, 31 Dec 2025 10:25:11 -0500
Message-ID: <20251231152511.3166711-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122943-program-skipper-de04@gregkh>
References: <2025122943-program-skipper-de04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Rogers <linux@joshua.hu>

[ Upstream commit d1bea0ce35b6095544ee82bb54156fc62c067e58 ]

svc_rdma_copy_inline_range indexed rqstp->rq_pages[rc_curpage] without
verifying rc_curpage stays within the allocated page array. Add guards
before the first use and after advancing to a new page.

Fixes: d7cc73972661 ("svcrdma: support multiple Read chunks per RPC")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ replaced rqstp->rq_maxpages with ARRAY_SIZE(rqstp->rq_pages) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 40797114d50a..6bc8adedf02d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -841,6 +841,9 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
 
+		if (head->rc_curpage >= ARRAY_SIZE(rqstp->rq_pages))
+			return -EINVAL;
+
 		page_len = min_t(unsigned int, remaining,
 				 PAGE_SIZE - head->rc_pageoff);
 
-- 
2.51.0


