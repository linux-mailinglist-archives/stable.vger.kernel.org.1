Return-Path: <stable+bounces-100424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C1F9EB1A7
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF116681A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22741A76AC;
	Tue, 10 Dec 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNxEx2gX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E3278F44
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733836186; cv=none; b=JqZo+5suMd4z03p9Lz9Ce2+y7CU1LfEj4M59VcHC23cwGYnANwLIb3uL0qoISDi3bx2hMq83gZHO4+UIef7OdJGqEl7T5sL9kg2uN3S6CQXhgZDHbcEplI+3+pq9BG5LZ5BunyOEme0uxCcNJoqL74m8v4O4gno084yUzOpEhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733836186; c=relaxed/simple;
	bh=Kins5pRBzjG2BfRs5W6rRnhUS4kpsEx0TMCHyLNnups=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4bSJibsfA1fZixBlKj031b56/yEbKS4A706mZHpqaXYxGDPyC2nnvXRNBAy8uSUUxBb2RuVGyuakmkyx70ddSm8zl1qw4fDmXyGmsMjRc8bYqQbr+SCihFc59ULTUrVQ5QHv81ivzzWgCFWzK254i3RwT/J0muglJhWVsicXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNxEx2gX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733836185; x=1765372185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kins5pRBzjG2BfRs5W6rRnhUS4kpsEx0TMCHyLNnups=;
  b=DNxEx2gXp65zW6JFyxgKq0QFVwmf7b6zPMF6ZS8Yu2yJ+k8Bq0m5zK98
   p+UuePJ8M4orGTn4Z+8mGItYaHS2JKmdl33tKIyYHRsx5A6zXQYAQC1y0
   iLo3mrOsQv8w0fpn0FD1frTm1cyiKb+koxCBc3ssT/npGBN2pUvDoP/z9
   PSkxQyw3FR4DLjUl8boEg/idL8QHRtMgBXavJbgMt5UKhFwteCkyEfACO
   spB4R0MCgCApCaNTGEVwWQDA3h3Z3wRgarNRdoYlq1qvf0Blo6qwFO8UE
   YBqsyDXe8IdeTKmn3nqPYiLJiJoB3BWj7uycV2B0/byzDOjgl/zGRq9p6
   A==;
X-CSE-ConnectionGUID: y7sCbqz0RziQnJNUpnkYRQ==
X-CSE-MsgGUID: mqszDzW+Sfiig9fhdaBLjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34080113"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="34080113"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 05:09:44 -0800
X-CSE-ConnectionGUID: NAGnexRgSbeHscYKd9XPmQ==
X-CSE-MsgGUID: eRmEsOjIQmeP0iafsVh8Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95242036"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 05:09:42 -0800
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org,
	Karol Wachowski <karol.wachowski@intel.com>
Subject: [PATCH 1/3] accel/ivpu: Fix general protection fault in ivpu_bo_list()
Date: Tue, 10 Dec 2024 14:09:37 +0100
Message-ID: <20241210130939.1575610-2-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241210130939.1575610-1-jacek.lawrynowicz@linux.intel.com>
References: <20241210130939.1575610-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if ctx is not NULL before accessing its fields.

Fixes: 37dee2a2f433 ("accel/ivpu: Improve buffer object debug logs")
Cc: <stable@vger.kernel.org> # v6.8
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Karol Wachowski <karol.wachowski@intel.com>
---
 drivers/accel/ivpu/ivpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index d8e97a760fbc0..16178054e6296 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -409,7 +409,7 @@ static void ivpu_bo_print_info(struct ivpu_bo *bo, struct drm_printer *p)
 	mutex_lock(&bo->lock);
 
 	drm_printf(p, "%-9p %-3u 0x%-12llx %-10lu 0x%-8x %-4u",
-		   bo, bo->ctx->id, bo->vpu_addr, bo->base.base.size,
+		   bo, bo->ctx ? bo->ctx->id : 0, bo->vpu_addr, bo->base.base.size,
 		   bo->flags, kref_read(&bo->base.base.refcount));
 
 	if (bo->base.pages)
-- 
2.45.1


