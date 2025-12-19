Return-Path: <stable+bounces-203077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 523D9CCF96B
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C083930181D3
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4746B2BDC03;
	Fri, 19 Dec 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvjOWicc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB43191AF
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144050; cv=none; b=ttPvc+9O3/O8S8Fk/TnYXkgYYeGuhMoRHECkzPgkCLLiimt+ODibTlldXZ5uNQJ6xmPwvydKBVd9HNzOa2qrqmrREOraUvy/reCt+qZVgw6asklNHENply09WDbW7bQh+nd5GkaOGb/H7qzoFw1LvOKCUWbeZVhLYEgGg4CzWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144050; c=relaxed/simple;
	bh=4bv3Gk1Rp61YDnZYdNpxoF/HsUv0eSFoQ9vGbwmYIKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2oaEENwN5ZlXoP1GsyeMizm9wznN25abxa2tkCNhikO0+qaBHZ6cYnnFKuom9nimni3yMLDMbgpPmiLgqYBa6o6NXqzXHmtujAwNFWM41mRS3rZmxL5VZTkN6ho4LUtPGdKAD4M8o3Eka98UNUo0bbToGF7n2ZsBuxIZV4YqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvjOWicc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766144048; x=1797680048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4bv3Gk1Rp61YDnZYdNpxoF/HsUv0eSFoQ9vGbwmYIKg=;
  b=jvjOWiccvrn0lh+1uyMRuGWGFOq9R0kxoCjCiRHmwCn5NjLfcV2mHfFV
   KrEYlsQfqfPPoTmI8NP2BGwXc8daDdh6tVedHevydw1ilQcl8/8q2O5gT
   JKuuCkDSrBR52tZj+n+NOaobhA96KEgCjTHRZvLYzqLdM0rXP1UBcGp/k
   nqdjLd9MxGoA6rIZ+TLF4N32cdQw8tGC0soDB0CFVTskBSFCw+noIVP55
   IbwCOo1mBA9m9idKJ5FhQAL3ykgFRsnmFsEWzHbv7NAukV987MARiIBUC
   TgzFdVmNHf7LlOfuSyNPZbnnhkKFx5nEGBNI1vDC7OM8aSUX/sU7HniX/
   w==;
X-CSE-ConnectionGUID: J7UeYumnRlSz2LoWfS9PyA==
X-CSE-MsgGUID: PKZn9USfTtK6K1iMWa40jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="79224464"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="79224464"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 03:34:04 -0800
X-CSE-ConnectionGUID: rZ0vhxzAR3SXyyqV3KRJrw==
X-CSE-MsgGUID: I3dRx54VSmqFJNSDJ+7U7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="203005574"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora) ([10.245.244.251])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 03:34:00 -0800
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
Subject: [PATCH v6 01/24] drm/xe/svm: Fix a debug printout
Date: Fri, 19 Dec 2025 12:32:57 +0100
Message-ID: <20251219113320.183860-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251219113320.183860-1-thomas.hellstrom@linux.intel.com>
References: <20251219113320.183860-1-thomas.hellstrom@linux.intel.com>
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
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 93550c7c84ac..bab8e6cbe53d 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -937,7 +937,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
 	xe_assert(vm->xe, IS_DGFX(vm->xe));
 
 	if (xe_svm_range_in_vram(range)) {
-		drm_info(&vm->xe->drm, "Range is already in VRAM\n");
+		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");
 		return false;
 	}
 
-- 
2.51.1


