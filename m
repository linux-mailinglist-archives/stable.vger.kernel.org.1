Return-Path: <stable+bounces-180496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31641B83C1E
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 11:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE65188954B
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4702FCC1A;
	Thu, 18 Sep 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRdfQw3i"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549D2C0263
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187352; cv=none; b=fWm+oyLd8RKZe3ZvhYvHDOqkc5QdmYdS+92cpZYh3bmmGOkYZijknITy0oWGeAfu65DYkI73rkVOKScu/nW3JFekzKDms7QVWvQHlE1r6FpuK21GWTWmEGKDr+WCu9bIUmYjh/zoQT3GIBmUx46CvcenSC61BIltO+cB2zNR0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187352; c=relaxed/simple;
	bh=o62IgxppByvf1UamDAzQ6GW1JgxOKWtl1wFnIbCsGIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBldvE+vYRiBUtE/OU/iyVEssW2Y7A8J+8QaTSV5v56dlN4EKTGx9nDjYtG5CkuREhQ6xrKwcEXPTKCYcMlE2mSSJ7eFZvKBIYc2qQad3XT11fv11sXFjdxXP0hc3DgJLFE/YLbvblOBddzguCSU9ByScAANuTsnPvHm7ydyLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRdfQw3i; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758187351; x=1789723351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o62IgxppByvf1UamDAzQ6GW1JgxOKWtl1wFnIbCsGIw=;
  b=YRdfQw3iuzAoZnV6Nll1lpwciISM81loR0NEQ9HLBlFvs04ldD3rZuT5
   /qMHWK5mU7koW4TpZHt6EVOXGFN/8nP1hbseiXXmvgyLLhGdlnZK+jFjR
   f+FeD3xZ2ptVovypY7EnWq5Zvz3hZI2tG7JzgGH1P2xPReCCoWcesemHw
   zjDFAUAe1bPYgSBOaq8Bj5zHpBKeUStuWcT3M+D60D+YbgqOX9PVgflm5
   02uVkoTuFCLXYop5Ik8V66FRQaz1DeHDvDTwi7VIl4a2vcKWIVRoFlLSC
   II4mUH1hBEYLu/dZ+M9A8sypRoiSZh4WwGjg9pp9p2ZNAH7/c47/Mb8EM
   g==;
X-CSE-ConnectionGUID: 3JunqeCETtaMjWVEIgs8tg==
X-CSE-MsgGUID: VnhMQBLfSa2YzTRp1wnRLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="48081689"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="48081689"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:22:30 -0700
X-CSE-ConnectionGUID: DBfBCONhQk2GmHHDmiaWHA==
X-CSE-MsgGUID: 6krv/U/2Seq9qWLDRMvQRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="206284854"
Received: from abityuts-desk.ger.corp.intel.com (HELO fedora) ([10.245.244.175])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:22:29 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] drm/xe: Don't copy pinned kernel bos twice on suspend
Date: Thu, 18 Sep 2025 11:22:05 +0200
Message-ID: <20250918092207.54472-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918092207.54472-1-thomas.hellstrom@linux.intel.com>
References: <20250918092207.54472-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We were copying the bo content the bos on the list
"xe->pinned.late.kernel_bo_present" twice on suspend.

Presumingly the intent is to copy the pinned external bos on
the first pass.

This is harmless since we (currently) should have no pinned
external bos needing copy since
a) exernal system bos don't have compressed content,
b) We do not (yet) allow pinning of VRAM bos.

Still, fix this up so that we copy pinned external bos on
the first pass. We're about to allow bos pinned in VRAM.

Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_bo_evict.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
index 7484ce55a303..d5dbc51e8612 100644
--- a/drivers/gpu/drm/xe/xe_bo_evict.c
+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
@@ -158,8 +158,8 @@ int xe_bo_evict_all(struct xe_device *xe)
 	if (ret)
 		return ret;
 
-	ret = xe_bo_apply_to_pinned(xe, &xe->pinned.late.kernel_bo_present,
-				    &xe->pinned.late.evicted, xe_bo_evict_pinned);
+	ret = xe_bo_apply_to_pinned(xe, &xe->pinned.late.external,
+				    &xe->pinned.late.external, xe_bo_evict_pinned);
 
 	if (!ret)
 		ret = xe_bo_apply_to_pinned(xe, &xe->pinned.late.kernel_bo_present,
-- 
2.51.0


