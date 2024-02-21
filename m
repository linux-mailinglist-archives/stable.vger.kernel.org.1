Return-Path: <stable+bounces-21783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118485D177
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 08:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07E328AC81
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795BA3A8E9;
	Wed, 21 Feb 2024 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCK2Hgl8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD863AC12
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500830; cv=none; b=RyQ2mP9OV/pJD1KkyT+o5gvMQP+IDrk/W1+fncvXvIfY2RMUwQ8qSbCX3RglB47j1evOMe3Z5L8VLaOPxFhv/TKkbshyClHfGxJZ4Y49RLxx1PgaiogTApAudDJ7lhBSM66yvuW0OVnuUInx9dkRz258QvWfyK/WIyiVHNgGeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500830; c=relaxed/simple;
	bh=WtzN/zuuF5Giq3H1uYH21SKzPx18aViDs45cU0spU+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oLH+MuMweTTW0vDKhVSlLXnUItf27+C/oOB+y04n9U5+TiUbWe4WUhJQm5tWPbIkfKyk9BI7ZtUHIdL47SnqGW/KyLYggvpzxnUQtFXRo6Co6MDQ9arRj06C6aPhIVSIkFFwuPOMg6XIwIOMMCwtz9DhrcILyJGJFwLahxAEyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCK2Hgl8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708500828; x=1740036828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WtzN/zuuF5Giq3H1uYH21SKzPx18aViDs45cU0spU+I=;
  b=GCK2Hgl8C5kEswBM44U7UDUP0KCKIIxu7xcNi+RuEvaRoAmhHWSRTaaz
   eRxyXvqEInK4RE9Canak/pXp3xb2fISPji6Afli09vfAhH+WKly1mFAFU
   xNq1/NeW6buDzMM+jlOYc67n6Pe4tQ/9K8dSpdwzfx/Tp2AWZ5eCIMuco
   maFJIzk1YLI99vWj6BCdk+gsLlFnSdPa70lVJR7uq69Y0/tMC0V5s7s6T
   nsUUyorUsjYz/H3EhfpUnKtJO9XFFu++JqT1+JsudEf5f/ClWXdZfKN+I
   m4BcRSh5Fsr4Mi8SwDLMddx7NAEvGELGWicyJOCyloYYps26H9cIYTvc6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13266414"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="13266414"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:33:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5273376"
Received: from ahashmi-mobl.ger.corp.intel.com (HELO fedora..) ([10.249.254.166])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:33:45 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Dave Airlie <airlied@redhat.com>,
	Huang Rui <ray.huang@amd.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Fix an invalid freeing on already freed page in error path
Date: Wed, 21 Feb 2024 08:33:24 +0100
Message-ID: <20240221073324.3303-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If caching mode change fails due to, for example, OOM we
free the allocated pages in a two-step process. First the pages
for which the caching change has already succeeded. Secondly
the pages for which a caching change did not succeed.

However the second step was incorrectly freeing the pages already
freed in the first step.

Fix.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: 379989e7cbdc ("drm/ttm/pool: Fix ttm_pool_alloc error path")
Cc: Christian König <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.4+
---
 drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index b62f420a9f96..112438d965ff 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -387,7 +387,7 @@ static void ttm_pool_free_range(struct ttm_pool *pool, struct ttm_tt *tt,
 				enum ttm_caching caching,
 				pgoff_t start_page, pgoff_t end_page)
 {
-	struct page **pages = tt->pages;
+	struct page **pages = &tt->pages[start_page];
 	unsigned int order;
 	pgoff_t i, nr;
 
-- 
2.43.0


