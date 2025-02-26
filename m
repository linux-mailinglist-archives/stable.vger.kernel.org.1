Return-Path: <stable+bounces-119697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E362EA46525
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DFF17DE22
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012021D5A5;
	Wed, 26 Feb 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqTvb2Z0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CC21D5A9
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584080; cv=none; b=Vws3IT7n+QGJfG+BuPOHCpo+4l8NxtflXYUh3JaXCf3k9IquqH6OfWWXpgBGjoF4NEeFI25Nnr42FJYRTpvYiYPq6+8frUtEcskhaSGt+tlb3/7BRTll9SlHer1yLKsAoJuVFN5bumxYPlpc8rfd6C9ZtPJV/hXoWT5B4NYfEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584080; c=relaxed/simple;
	bh=GNI35ffPdLNANFCbuTvB3jq0HX/20SvIig/LQAVb0hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwV//Y7Q34sB0+Q1TB4umb4mLGUjEr+R+05WN89E6+0d5XI/l/7zwkuBSpm/O2NSd4bWLImEJLZy9GxnqnbCIBFr0H1Ba52o50B2knXpzTvGGtmU1HVhdoWqTHGuZqxfGheffwyzsLX9e0AVSlLatDrUGB0qlfsRpFN47A5kHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqTvb2Z0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740584079; x=1772120079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNI35ffPdLNANFCbuTvB3jq0HX/20SvIig/LQAVb0hM=;
  b=JqTvb2Z0O+WVRjmqdh69jv4lxVZn3hA13uNJhYapFFk04Ushwq/ZX2Ax
   RjqbBGv7A52ovx1l8gzB3gWL0PMFy3fvXqshoZ+k1UQHP71YCZyqYZYzt
   U8qvZ0SD+MapIF73SD97WRG19x+u4PCOzoAr69hxvyoHGb5GovkBK6TMx
   iSHQ1KO8x75qUkKvgApVeUsUkwvxHV08D776h9IZwsdWksf1g789Kk8tJ
   r6BB2mi6EAoVSm1pudtd23P1VDVzmuZ/4GpAv3ShxPoId5etPwZZUrE7m
   yckCFzMtYwOYHQ37cOdTPEILnBe/DCAZcVEFw8AEFa2YLO09fJVXnhrhD
   w==;
X-CSE-ConnectionGUID: Fh7aeHXnRE+hZCaUinzARw==
X-CSE-MsgGUID: BacM9zzcSB+epjBZafXKWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="44260324"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="44260324"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:34:38 -0800
X-CSE-ConnectionGUID: Bl0h1TMUQ7KkZ+ymOU+JUA==
X-CSE-MsgGUID: RNpSc36zRgWbqQwhaoR+Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116917923"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:34:36 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] drm/xe/vm: Fix a misplaced #endif
Date: Wed, 26 Feb 2025 16:33:42 +0100
Message-ID: <20250226153344.58175-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226153344.58175-1-thomas.hellstrom@linux.intel.com>
References: <20250226153344.58175-1-thomas.hellstrom@linux.intel.com>
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


