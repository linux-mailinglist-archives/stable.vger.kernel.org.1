Return-Path: <stable+bounces-188359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A75BF72CF
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729B7188F68C
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A97D2E6CAB;
	Tue, 21 Oct 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwbokiII"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B835502F
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058335; cv=none; b=fi0GO/U4Gyj8DxjCrwD7UAakIxcqs5Lp8XoXs7Mr8HAVCDODP3XVbUoUTitj5XQqRGNWzduGLt/ADQAAzGoZbDfN3NjWVwVeEWVeZ43xUNsDUMxiUJcNzU83yIYN9G6kjU2kGfyZdpOoooM2RNwqbSvs8kf5EFAz3bRMp7szhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058335; c=relaxed/simple;
	bh=JpUhJi44J2rdDTq97ismCRSDHiI4bjnIvZiFyi/zRLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi6HVT3xWpmNUnVlQgchT3bIuYUKpt5hjJxg6KCqEt6QrESx+hq58CoF3kAlgk0VMI/IETvsK6AcwR6P7mt/MypL6zvL3i0LOvkRBxb5QARK2dQbV2UoP/huXql2WovmQV9mntEjNwmjOh/P27EPFN0F7Wegb7bTzx/D0uk69W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwbokiII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6968C4CEF1;
	Tue, 21 Oct 2025 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761058333;
	bh=JpUhJi44J2rdDTq97ismCRSDHiI4bjnIvZiFyi/zRLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwbokiIIgYTSh3wj3YYoWQyjK5qxpQgh3frWKnSsGT5Fle6s7Pbnw9f7LWATbrwLV
	 stYlkrkCnPnMe7LO1S7nZ4GXr44D+oV/nKB9kZ2VWCHzt+L5QqRYWaVMSeKyDYCP7n
	 7fQPHWVndk3qAC1EsNOl/A0wC2RNJuRS39zj4zAVjQuClTwwfRrnVDkeYm7DHxK9wA
	 gCvF8Jt93CXH/bhyFgGKjDa1acZmuVMu3vMVJ3vZWRI2lwFdQ0EVIfSf7jAWIhkxeM
	 RGV07jWikUVX5hsSvjQhyxJIN7QTvqUx0wcI+QgpnNduP6GRRYCVXatjHtrQHezRdK
	 un7pVGYOOOAFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y] cxl: Fix match_region_by_range() to use region_res_match_cxl_range()
Date: Tue, 21 Oct 2025 10:52:11 -0400
Message-ID: <20251021145211.2230999-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102001-outsmart-slackness-607a@gregkh>
References: <2025102001-outsmart-slackness-607a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit f4d027921c811ff7fc16e4d03c6bbbf4347cf37a ]

match_region_by_range() is not using the helper function that also takes
extended linear cache size into account when comparing regions. This
causes a x2 region to show up as 2 partial incomplete regions rather
than a single CXL region with extended linear cache support. Replace
the open coded compare logic with the proper helper function for
comparison. User visible impact is that when 'cxl list' is issued,
no activa CXL region(s) are shown. There may be multiple idle regions
present. No actual active CXL region is present in the kernel.

[dj: Fix stable address]

Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
Cc: stable@vger.kernel.org
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[ constify struct range ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d052481..be45211843282 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -831,7 +831,7 @@ static int match_free_decoder(struct device *dev, const void *data)
 }
 
 static bool region_res_match_cxl_range(const struct cxl_region_params *p,
-				       struct range *range)
+				       const struct range *range)
 {
 	if (!p->res)
 		return false;
@@ -3287,10 +3287,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 	p = &cxlr->params;
 
 	guard(rwsem_read)(&cxl_rwsem.region);
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		return 1;
-
-	return 0;
+	return region_res_match_cxl_range(p, r);
 }
 
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
-- 
2.51.0


