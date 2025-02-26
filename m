Return-Path: <stable+bounces-119726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB6EA467DE
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B501884A72
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC885224B16;
	Wed, 26 Feb 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOdeF5Jn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771E21E096
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590246; cv=none; b=MOEzFzGUNj8YNCpymw+HaQrm/OhGIH2kpiynw+Z69zOiOcMzqIBaGW3g4mNUoZu3ud/bLocwBKqJ1sfHkLVXKZIXxEQRNEnhhrJnwlHgEwOgAYpEzcitwlDoD6l3cf5B75xO854/7YiYWuyYkDx9bw50PPY8I+6lhFAfZxQTgUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590246; c=relaxed/simple;
	bh=ghtfsUmgifxQ8m71CTrjwcVWprHHS96QIEw3ZqwPMz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qXboQTRbebWe3XhfmweL52qPEAQqwYNsb/VsdH6rVWVhIDedchLKC2xm5jy5TQbRH+0S+fNqU5K6AiM8VdeIujVA+tvoCH69yT6ShehMnDalwMV02Nqv+U5lZmohv/B4GxqSNM/WM0gJT3KYZoqk/C/vVDzMd0O+PLA19RFVnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOdeF5Jn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740590245; x=1772126245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ghtfsUmgifxQ8m71CTrjwcVWprHHS96QIEw3ZqwPMz8=;
  b=KOdeF5JnGB6H+6aZtrByz114Yi8nMQn0fvrUNpWeBuqfbb0Vey8LFxUn
   DwnvZ+sRW5WDWzKupB4qN76po/oBkAPbEDXDhr9WzXlctytdL00S/CPM2
   4v0fX4TDNj7LsFKLXmjNAKhEdvqPvJz/4O4zZ8IQGFMyTHna/BbTu7e/u
   Bb4LuG8lV9DumFMYuj/yb4eby6kfaovjze6CKzaLoxMLDXFWT4pCfki+/
   SPy18C7E2HhlalUl1/EOpc7T8ns6vNrqvxTVZNce5SmRq7qWqMUgZXOPw
   wizBudIfFJHbxxZ4N5Bc03iHd7RdgnAB4pLrszDLMZAmoi2ltv6UQtT4I
   g==;
X-CSE-ConnectionGUID: ZJAdjVgSR4GDQn1C6dTFKQ==
X-CSE-MsgGUID: J6Yu7Sg7TxqsxRgRDSBvow==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41702837"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41702837"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:17:24 -0800
X-CSE-ConnectionGUID: g6m5eA7zTmui+E9CdaxWbg==
X-CSE-MsgGUID: XEmHGmxIQLiPQ5abkp+8Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121872009"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.27])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:17:23 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/userptr: properly setup pfn_flags_mask
Date: Wed, 26 Feb 2025 17:17:08 +0000
Message-ID: <20250226171707.280978-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently we just leave it uninitialised, which at first looks harmless,
however we also don't zero out the pfn array, and with pfn_flags_mask
the idea is to be able set individual flags for a given range of pfn or
completely ignore them, outside of default_flags. So here we end up with
pfn[i] & pfn_flags_mask, and if both are uninitialised we might get back
an unexpected flags value, like asking for read only with default_flags,
but getting back write on top, leading to potentially bogus behaviour.

To fix this ensure we zero the pfn_flags_mask, such that hmm only
considers the default_flags and not also the initial pfn[i] value.

Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/xe/xe_hmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index 089834467880..8c3cd65fa4b3 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -206,6 +206,7 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 		goto free_pfns;
 	}
 
+	hmm_range.pfn_flags_mask = 0;
 	hmm_range.default_flags = flags;
 	hmm_range.hmm_pfns = pfns;
 	hmm_range.notifier = &userptr->notifier;
-- 
2.48.1


