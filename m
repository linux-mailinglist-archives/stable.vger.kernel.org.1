Return-Path: <stable+bounces-95557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2557F9D9D34
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F33163FC8
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7F1DD87C;
	Tue, 26 Nov 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkI2QKmz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538F1DD525
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644839; cv=none; b=lBUscVz+sgdVEPt2gxpvZnhKBKeNxRv1dQgnPvUkykm+qNlktFNQopijYMTSXNHMggNPaS2kmEltNFr8zt+A1bWW850sBnYfBFRuUZcvbEQwkc/5ZQvDgQ1Axl4WXbfu+vUZXOD5Kjin9vmZcKfd0/9OkABz61a6WUMcVJeBLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644839; c=relaxed/simple;
	bh=iCVKrPeG/GLuuHtd+a7Jc9v7UFAhw3CbriX6ZehsFS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc2ZBhpOu5Gk8NXcjk9VPf6Gi3ZmGZQdSmI1gJy/5+3ZXSvDbbpY/J2rBcs/ANyxenPUaCvc2CgvPVk64w2RV3ksXTu1R4acz7qw2HykzWcpXF1GEBgVWZgI46SAeqKE+vT6fjo33CWScjp65hZyDp1Ya1BrvlH1YXruMSqhGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkI2QKmz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732644838; x=1764180838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iCVKrPeG/GLuuHtd+a7Jc9v7UFAhw3CbriX6ZehsFS0=;
  b=PkI2QKmzUUmsVuGHnqP056HevLaslEqDtH4SQK8kuicvt8KaGfNkOSm8
   fVGJDGW/8aHIKvreFVaGTeHWqwLrZgtqhosXT+nut/IoZmmArrSROajaA
   vNivoGVWqHaNZ7cVlm2C0AQuND6952COQSOfOpdwIKC1LQUp7Dc4nUeLq
   pPqWWDe3LdqBEW4LsVewXeSHhDfW8y4/HWXeQQRJbLnrL7amUwLF2357O
   m1CMuytxyvILxIb25rdqf6rTqU0m71Ifg4Wv1u40C4QAgJMLwJXK9kmHv
   QbDUUmLGwcaq2gpTRTCZsCewFuRLVVe1D1NBiquYj3FiwRuwWDYwLOjtF
   g==;
X-CSE-ConnectionGUID: DVfjMIX8SRiSEB+nvl1thQ==
X-CSE-MsgGUID: DF5YQp0YTomG1z/rhszLuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32197194"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32197194"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 10:13:58 -0800
X-CSE-ConnectionGUID: 5l2ag/KvQsG5JIXF9l3tJw==
X-CSE-MsgGUID: MWg4pPJIQHyTUGTyQuJCcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91642721"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.145])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 10:13:56 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/xe/migrate: use XE_BO_FLAG_PAGETABLE
Date: Tue, 26 Nov 2024 18:13:01 +0000
Message-ID: <20241126181259.159713-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126181259.159713-3-matthew.auld@intel.com>
References: <20241126181259.159713-3-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some HW we want to avoid the host caching PTEs, since access from GPU
side can be incoherent. However here the special migrate object is
mapping PTEs which are written from the host and potentially cached. Use
XE_BO_FLAG_PAGETABLE to ensure that non-cached mapping is used, on
platforms where this matters.

Fixes: 7a060d786cc1 ("drm/xe/mtl: Map PPGTT as CPU:WC")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 48e205a40fd2..1b97d90aadda 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -209,7 +209,8 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 				  num_entries * XE_PAGE_SIZE,
 				  ttm_bo_type_kernel,
 				  XE_BO_FLAG_VRAM_IF_DGFX(tile) |
-				  XE_BO_FLAG_PINNED);
+				  XE_BO_FLAG_PINNED |
+				  XE_BO_FLAG_PAGETABLE);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
-- 
2.47.0


