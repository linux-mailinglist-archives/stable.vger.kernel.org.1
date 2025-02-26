Return-Path: <stable+bounces-119696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E249A4650C
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2F17A1437
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215121D59E;
	Wed, 26 Feb 2025 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZN5C7KXq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FC21D5A3
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584079; cv=none; b=QEbGKXc0OvBs1VfVg+CzqGsZbpEh9jPStV9bhMWPGTjvTml/txOue37qiVwp2SOE+FdXCS6A/pq4HS1MUqJFkPz2ens8AGXsBUr98p1B5+AAByh5uEs06I1zaqh/SZcozV1mWN/2TGdyd495OUdljVhVlgqZw3j0Wu+wpzYA/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584079; c=relaxed/simple;
	bh=tCGUIxlIOT9JPp0Y76lTXNeEP1upEzziM5MiiY9NvUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ya1ffQfToQn4I3ORsjsbyZyBvHQjy6krJ302QiBlyAAUpAr8nrEE2EVRNU3ZZusI+EGuBBieR3iCQs8rHCFXWCACmzDNoxcFjUEMpmkkOpK/Hj4XzjayhSIy5LcgV0r5AJo7r+My33Ezl4Ic6+4TRn9p/J+/NI4HJepjjkd5aZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZN5C7KXq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740584077; x=1772120077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCGUIxlIOT9JPp0Y76lTXNeEP1upEzziM5MiiY9NvUs=;
  b=ZN5C7KXqjvyJg78lz81+biIELszPblnZdcvp/17GWZx+KoOPkuPsviJ3
   0m7+vpLn9YVn/YqihovEvSyDm5tCHnk/Eeh04uGv6BPvGizHnmHvH6Fvz
   KtiB7nQhLqa17SayJ2RYMfyOH2eMcRnT2sLbOixSvZa0EK6rbLtHSrznO
   gH6lbu/xkYzbA3n+DDDEWLyIi2U8X05LL7OHlRU1trYgu66shHI8DLSUS
   +Relb6HI0kgY8ayqWf+37JASOslegB70fQx7MA/PksL2Q8dBxE5r3f84V
   9FlX4OM0maHeEOxhBymnJ4qssbnt8xxuTp3DminE4vBLeCoQ9YYVrmuCX
   Q==;
X-CSE-ConnectionGUID: 4ihbTc5YQ/264a3218+55g==
X-CSE-MsgGUID: PpkOAT3eRjSIK3qGpRJkyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="44260323"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="44260323"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:34:36 -0800
X-CSE-ConnectionGUID: ZJZHH9WRSUGZ4wUszV7fuA==
X-CSE-MsgGUID: rLvXM2BtQNCybPA8jrV+zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116917919"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:34:34 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/xe/vm: Validate userptr during gpu vma prefetching
Date: Wed, 26 Feb 2025 16:33:41 +0100
Message-ID: <20250226153344.58175-2-thomas.hellstrom@linux.intel.com>
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

If a userptr vma subject to prefetching was already invalidated
or invalidated during the prefetch operation, the operation would
repeatedly return -EAGAIN which would typically cause an infinite
loop.

Validate the userptr to ensure this doesn't happen.

Fixes: 5bd24e78829a ("drm/xe/vm: Subclass userptr vmas")
Fixes: 617eebb9c480 ("drm/xe: Fix array of binds")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.9+
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 996000f2424e..4c1ca47667ad 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2307,7 +2307,14 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 		}
 		case DRM_GPUVA_OP_UNMAP:
 		case DRM_GPUVA_OP_PREFETCH:
-			/* FIXME: Need to skip some prefetch ops */
+			vma = gpuva_to_vma(op->base.prefetch.va);
+
+			if (xe_vma_is_userptr(vma)) {
+				err = xe_vma_userptr_pin_pages(to_userptr_vma(vma));
+				if (err)
+					return err;
+			}
+
 			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
 			break;
 		default:
-- 
2.48.1


