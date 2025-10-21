Return-Path: <stable+bounces-188808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B049BBF8A84
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 22:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F4754F6069
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF9427990A;
	Tue, 21 Oct 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4Hf6gZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988D42773F4;
	Tue, 21 Oct 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077584; cv=none; b=SyZjkQHf3NnMyg/lEbi2iERQTZe0Oa8E1t7vBUX5U9W5HGP8BVMzkfTZDeg8yHdFMAyZHVz8xfHmK7DJ+UPcIgnT6PJFoCxl6evDt46m83bMlgVV8OZ5vBHuK7+aVAinYUxK2FbKhwHOkFirb3WDdVNr6vT/z3wddNd5W6qKjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077584; c=relaxed/simple;
	bh=Cu1OH+hErbxXsoYZNyWus+jyTTIdJsFh8X3w0SXsyZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXpmrDTq91xw/B2wQdMsmbpW+8jTvWmJ/GoxfRWIpGEFvMZhR1A5NwpA0A5GOYz0D3XqFQPoInVVotM54/Mphrl4iZWa/dQRIIzJ7FlM0gGAG0cv/KYl7wYFs8shKwkeEWFqtvf1iPHOAWvbC1u1EtEqKcVVGU1IkSST6zY3MXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4Hf6gZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BD0C4CEF7;
	Tue, 21 Oct 2025 20:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761077584;
	bh=Cu1OH+hErbxXsoYZNyWus+jyTTIdJsFh8X3w0SXsyZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4Hf6gZbZ7NRZI4hRvUrBdAFpncl2z1v4CbCgYhNu6mly/U+R7pYrcnUiGV27tsIT
	 F7uR9sDNJ6Z6kK9IQLcfO8H9bFob54TWjLTOO+Mo2afTPfGaoZvk70NAyNb6+x5f+j
	 bEthmE7IirVbGa8Nx3+c9NyNFGGI3oJDGDIqKxLw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 152/159] cxl: Fix match_region_by_range() to use region_res_match_cxl_range()
Date: Tue, 21 Oct 2025 21:52:09 +0200
Message-ID: <20251021195046.830582334@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195043.182511864@linuxfoundation.org>
References: <20251021195043.182511864@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/region.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -831,7 +831,7 @@ static int match_free_decoder(struct dev
 }
 
 static bool region_res_match_cxl_range(const struct cxl_region_params *p,
-				       struct range *range)
+				       const struct range *range)
 {
 	if (!p->res)
 		return false;
@@ -3287,10 +3287,7 @@ static int match_region_by_range(struct
 	p = &cxlr->params;
 
 	guard(rwsem_read)(&cxl_rwsem.region);
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		return 1;
-
-	return 0;
+	return region_res_match_cxl_range(p, r);
 }
 
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,



