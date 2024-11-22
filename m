Return-Path: <stable+bounces-94661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258B9D6531
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA46C161745
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E404188583;
	Fri, 22 Nov 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcuSVUaZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4191DFDA2
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309674; cv=none; b=iB/NN5DI9F46OHEgfwhGZylnlK3wncO0rX6JpTROYjRRJONuJ6LEJT6NzvvcVhT+9dMn+WL45DQGm86fY4TL/ohyT/cKcXVGvCA4eqDUouhz9jwKJnLLUdlhe4TxEzPlhGdSCA//LD0HbWjEjYZ3E7aX+2vgVHewXfv70BfCC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309674; c=relaxed/simple;
	bh=mwBj/PvcX1jISdYsIeDyp8GBWy6S07XrpocpfjucLo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgj86XS3AoI3brqlzsEW8U8o4x+zpG/VI2+GuYcnELmwinm1zWb6aJZXKe+lnwmln9m6btUwZUcT2zjBZ3U5boZmO4VqGQ8y2tsXfUuo8HslAXzsotFZBRWtzHB4Ewepsw38mUmFjIuvYuvvQp75nWSgsB5FHyQdzKQbWO4JFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcuSVUaZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309672; x=1763845672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwBj/PvcX1jISdYsIeDyp8GBWy6S07XrpocpfjucLo0=;
  b=NcuSVUaZAsIPkztShsigz7UCnKwklIe1MRjHi7R3l2wkIkp4Dv7QxzdD
   A7/HZ4it19QsZF03xTYZAkBStdI6C6L4amDPT4kuVkNBKfHR3bXwybVsw
   RZ53Q/SyoR8/aVI3VpW+dJmqeCo1uXk110ibQWzhroJ9tz3Qr7xO6s8hx
   z9zAUfrHc6uGqo9zHwckFHR+S1zvIoX8Oeb3tyTLMQG1QQE2QJRXfzqUn
   Se6ErTCJRkJdQJ5MDG4XJuESnD53By3P9tllYT1Q9Pjyh+1ADWsUKZGkp
   xKAAQxscEYREZtVKq37bAD7phRwAxqOg45s+D/y4rVIAIgEvueBmi656K
   w==;
X-CSE-ConnectionGUID: PbiaRFhVTy6xtmAaluv1ag==
X-CSE-MsgGUID: 36L1PSd8Te2nPIrtDiAeoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878280"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878280"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
X-CSE-ConnectionGUID: 2k8gUd5DSRi3/8TNoqGk+w==
X-CSE-MsgGUID: cIWGg8+lRqmTadol8BLWQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457282"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 24/31] drm/xe: Do not run GPU page fault handler on a closed VM
Date: Fri, 22 Nov 2024 13:07:12 -0800
Message-ID: <20241122210719.213373-25-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

commit f96dbf7c321d70834d46f3aedb75a671e839b51e upstream.

Closing a VM removes page table memory thus we shouldn't touch page
tables when a VM is closed. Do not run the GPU page fault handler once
the VM is closed to avoid touching page tables.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240911011820.825127-1-matthew.brost@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_pagefault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index 730eec07795e2..00af059a8971a 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -212,6 +212,12 @@ static int handle_pagefault(struct xe_gt *gt, struct pagefault *pf)
 	 * TODO: Change to read lock? Using write lock for simplicity.
 	 */
 	down_write(&vm->lock);
+
+	if (xe_vm_is_closed(vm)) {
+		err = -ENOENT;
+		goto unlock_vm;
+	}
+
 	vma = lookup_vma(vm, pf->page_addr);
 	if (!vma) {
 		err = -EINVAL;
-- 
2.47.0


