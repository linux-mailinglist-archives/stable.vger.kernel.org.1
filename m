Return-Path: <stable+bounces-200705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D8BCB2C7C
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E500E30FF006
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEAF30DEA3;
	Wed, 10 Dec 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4mnLRPg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F11314D1B
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364902; cv=none; b=j3+yYs/uYLBQi6Roajz+/FMIi229TU+bTdGZvHpcvZEXzO3PPbBvSznaTh7we0WLCEC6kl7uNVyqJH801qpqGcULAh/hIgZYLnE5MmmSQ98e21e0n8mpv+kj9UxfQGTM/oATGbaOlLafnOyFVuNVSgle/GsxRvVOoQMz5ICGz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364902; c=relaxed/simple;
	bh=QXDhClxx77FjRlfoI7lh96LeNFyEQPM7TrkQFQa4Q8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aw7Iiuo+22/sScsfsUFvxVXMA1gMre53xKSI4TOJRr2Y5G9lQn04Sckf04hI/wV5nGxqqtTJnFjc998y7Rzj8kuiNBIlmzkj22joufJhl/Kxz1qabDEiIYvLon17nQkEYjjmLloJ19Jl9aFa7+J+euTvPcymsF6R/Ess7ZStX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4mnLRPg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765364900; x=1796900900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXDhClxx77FjRlfoI7lh96LeNFyEQPM7TrkQFQa4Q8I=;
  b=j4mnLRPgO+nT6Hpi/5lL2b9tTDWv4BcHM3jZksIbfhx+5mch51VV1cQS
   wY9HSuskoZSC1KKRc94rLMjrNaMib4cWz0z4qCA+oSsuQgEX94dFljlmp
   r6cUbwuxS8SDRuFCuW/oVqnbC44fOc+HbbVrs+U3uWbn6FAIMRxay2nFd
   TVfRUcWzXAHXgg8Ez2xKZ0VtBnzOGiKBa+jgFUo3BJUu+4AZ74+uPYCH8
   W9e8KXK4IxDAudeKI8QRFQuXc+mKojQyTE3zRi/nD/IQptsjYRvoTvVY5
   OSNHU95wXaksUFbRwpaf7MKEWVe8V5YDx5YyhQ3JAKY6Ut6JaNxiMbSsN
   A==;
X-CSE-ConnectionGUID: LZPWWfmqSkarT1QXfIA0pg==
X-CSE-MsgGUID: tydfsaF3Sva7dwnKlfpBPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67221734"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="67221734"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 03:08:20 -0800
X-CSE-ConnectionGUID: hwCss/ZpTAKlF8QhrjNsxg==
X-CSE-MsgGUID: wkqX9HWURV+qXb1FUS9vxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="196486915"
Received: from rvuia-mobl.ger.corp.intel.com (HELO fedora) ([10.245.244.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 03:08:17 -0800
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
Subject: [PATCH v3 01/22] drm/xe/svm: Fix a debug printout
Date: Wed, 10 Dec 2025 12:07:21 +0100
Message-ID: <20251210110742.107575-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251210110742.107575-1-thomas.hellstrom@linux.intel.com>
References: <20251210110742.107575-1-thomas.hellstrom@linux.intel.com>
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
index 46977ec1e0de..36634c84d148 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -948,7 +948,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
 	xe_assert(vm->xe, IS_DGFX(vm->xe));
 
 	if (xe_svm_range_in_vram(range)) {
-		drm_info(&vm->xe->drm, "Range is already in VRAM\n");
+		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");
 		return false;
 	}
 
-- 
2.51.1


