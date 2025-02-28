Return-Path: <stable+bounces-119896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1093AA49230
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1876916C65B
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64291A315E;
	Fri, 28 Feb 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsHJlILL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738B1AC42B
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727877; cv=none; b=lta45oqhXHGgyN2kMv2NrnSYOT5vFmezpkFPxxMz1dQzZ/A4VXmF03ktsfWUOIsEtWoSTFsTu1FFgRPrPwBoFw3WhFFJSkr7RKsreNCjipCOStneuLa3+1Q2s54zFvzs0mcbh6k9rq/xKE8PtffTJrnpd0U5PdPAyvWBZdsF5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727877; c=relaxed/simple;
	bh=GNI35ffPdLNANFCbuTvB3jq0HX/20SvIig/LQAVb0hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stesTicofLuwcJwwqSqV98+1bEmBTJ+HM4cpIP71Ww8V9374SvXrSMK7Iw5H0xo/mwq+iz3eY6Dx83Yv0ItmJbKRk4yx1lEcMiNMFevqTy02+ss4M8L82/C7idrqWGh6yEn4Q2+bP3LrE1hpT9k7xxe9gg4FeHMqgPhdyPIKcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsHJlILL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740727876; x=1772263876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNI35ffPdLNANFCbuTvB3jq0HX/20SvIig/LQAVb0hM=;
  b=GsHJlILLjB+8cFJ1mXRIErasXjt7yFpwFOQHI1sMRvZcJe0AfrjCGWmB
   AdA6cCUSgkdu/LdNbksji3Q4gQgUeDCSkwpoF2fptyzpecToU3QRuW+go
   hoy9DejpPe1OtXo4u7ICuGYMBDg+iWRHsd+3IDMfIjGTNnD2NoKRtUkr7
   j99ZjmK6QaCIpLcv8kDlm7i9Qpe8485Y1sJRYufZumnHrfX0WRT+PrUZf
   HlsErm21bPdL7qWz+sPhcTCHtoCaktGd3VD09WbxEH9x6RqMhH3jy6yVb
   anKq0HcbMuJg+D7LcLoxa5Al9rrIa5PNouGOOgtyU8YgZDZuR11JHd+r4
   Q==;
X-CSE-ConnectionGUID: 359wnZnWRjCMSfUxuItXLg==
X-CSE-MsgGUID: KU3bE6qyRPq8U0BK6I20Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45297765"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45297765"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:31:16 -0800
X-CSE-ConnectionGUID: M0VY/HUuT6+HCU7tFplwKQ==
X-CSE-MsgGUID: EAk35QkaS76zeme5cBW2Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121386232"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.232])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:31:14 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] drm/xe/vm: Fix a misplaced #endif
Date: Fri, 28 Feb 2025 08:30:56 +0100
Message-ID: <20250228073058.59510-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228073058.59510-1-thomas.hellstrom@linux.intel.com>
References: <20250228073058.59510-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a (harmless) misplaced #endif leading to declarations
appearing multiple times.

Fixes: 0eb2a18a8fad ("drm/xe: Implement VM snapshot support for BO's and userptr")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_vm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index f66075f8a6fe..7c8e39049223 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -282,9 +282,9 @@ static inline void vm_dbg(const struct drm_device *dev,
 			  const char *format, ...)
 { /* noop */ }
 #endif
-#endif
 
 struct xe_vm_snapshot *xe_vm_snapshot_capture(struct xe_vm *vm);
 void xe_vm_snapshot_capture_delayed(struct xe_vm_snapshot *snap);
 void xe_vm_snapshot_print(struct xe_vm_snapshot *snap, struct drm_printer *p);
 void xe_vm_snapshot_free(struct xe_vm_snapshot *snap);
+#endif
-- 
2.48.1


