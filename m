Return-Path: <stable+bounces-194510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6909FC4F1AF
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49A63BB661
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37C936CE01;
	Tue, 11 Nov 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHefme+q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99727603F
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879478; cv=none; b=BJYL6CPFAGTXLOa1TO3NkFbLQedXgFkMe9oBMW4SeIzBMdfJe/2ezlobgA70OoLjnNsnovN5koZ5dX8H1AuBnbWtRl/aPoGVKdfMqmhsKvtr0db76BNyrHkjahF68iAlzc2jXKn6g61Xp3XWD1jHLOmIMTdTMVw0SNBUd2KtNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879478; c=relaxed/simple;
	bh=knPKDrMjXe5mlH+urOE16uEbmKHp060xbgSjEhJfc34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8OjqfFhtzy+ZQooItrGUGHEzbF7ec6HLFLMtirQFiTnqGxhPa+FeQ4yXAzOy8fm1n19QNguG198bZaS4gYr+wqb/5hSGExlZ2EhEylaGcxpZPFodmRktWRw1OfdDYBIB9iB1NnMoHdxanVaCx41lfJH2CbMMDSgRVDFzhP3s08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHefme+q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762879477; x=1794415477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=knPKDrMjXe5mlH+urOE16uEbmKHp060xbgSjEhJfc34=;
  b=GHefme+qaGAr+DCmLIAEOHBoew6hbPEvJhEcjsEN1Y4wVCc28fGJir43
   +ximZMW5edqTOVW1H8HS5Ve3ohwAK9jkpRxdzLNcy8f80DXrdhMThshwz
   5wjRBmp0mcAXtp+Wlhycxq8yiojg+kVaPcN/pctS1a+UNSo8SeFFz38CF
   VcxAggw5DnfPveWpKggQwWxVf/4c6DCUeiSvV2mcatNAXj7h4dmkzoY8L
   bTl3n0q8CL6W/RhsDEbI4tuE9wx/u/1mnHOqtzQbtSpKwP1NpE/qE4MIw
   W9LWPaP1aAMN+WZ/WZ2tzMe8eZQ6YslZopCsinwTvQ1U8mbbDEVANV6fv
   Q==;
X-CSE-ConnectionGUID: 0CpA8tRrREqaLNrKF6SwXw==
X-CSE-MsgGUID: mfxDK3WcR9G4No7OfNijJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="75244615"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="75244615"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:44:36 -0800
X-CSE-ConnectionGUID: cCqBs69wRreTNP9l5lZT8Q==
X-CSE-MsgGUID: mJfXMg7EQL6N4dTq2pPY0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="188646750"
Received: from rvuia-mobl.ger.corp.intel.com (HELO fedora) ([10.245.244.91])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:44:32 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	apopple@nvidia.com,
	airlied@gmail.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	felix.kuehling@amd.com,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dakr@kernel.org,
	"Mrozek, Michal" <michal.mrozek@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v2 01/17] drm/xe/svm: Fix a debug printout
Date: Tue, 11 Nov 2025 17:43:51 +0100
Message-ID: <20251111164408.113070-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111164408.113070-1-thomas.hellstrom@linux.intel.com>
References: <20251111164408.113070-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid spamming the log with drm_info(). Use drm_dbg() instead.

Fixes: cc795e041034 ("drm/xe/svm: Make xe_svm_range_needs_migrate_to_vram() public")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: <stable@vger.kernel.org> # v6.17+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 55c5a0eb82e1..894e8f092e3f 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -941,7 +941,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
 	xe_assert(vm->xe, IS_DGFX(vm->xe));
 
 	if (xe_svm_range_in_vram(range)) {
-		drm_info(&vm->xe->drm, "Range is already in VRAM\n");
+		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");
 		return false;
 	}
 
-- 
2.51.1


