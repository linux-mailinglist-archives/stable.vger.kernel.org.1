Return-Path: <stable+bounces-159133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39720AEF54A
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 12:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E064A3BC3
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDB326D4D4;
	Tue,  1 Jul 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgdWDVT3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E7270EB3
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366416; cv=none; b=fly3Az/uKUNtDaJQ4aOdFD/01HC1g+CknSPB9W6HgicYs4JZZhlUXRWU1GMUJa2lymO9HnACtiZwYJcY4sq2m4JpiQCltMA4eKFBGjYGmbYkZ7/HSP1Hzuy2R2S7Y3og4bOlclkd4DsQYDhOWgO40nsZhotK7UYX8YsbXpomxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366416; c=relaxed/simple;
	bh=FtsVz8dMEtglEyB6M1i1OT01kMH8af1RF+NnEZxqUvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XmXkNRX3bL79Q7V2ZSu8bIPxy7+5VLG2L3bzLSNlka6//UEWXj4ofBGbZQzMRzgWmqWMqpyzHM4h31CnK4o7o70GYiEGIRntzFNsOSl0zh0B33BfEZrPTy0AhmtXi0XXs63zklKUPAJNQt8pYp4F3+paLUj/Pdayc8kP6D875ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgdWDVT3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751366414; x=1782902414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FtsVz8dMEtglEyB6M1i1OT01kMH8af1RF+NnEZxqUvo=;
  b=PgdWDVT3JrwPCgD6XbdInV0T8a1Vjs5FkAyzOTUrsFFPjtBo8ZrWTqxS
   NZjTLbIPtQSxpCdq+NzYhGyqHZHeNKJ4r77fjKVXjCjIAbfpEJ8ukV0iH
   hYQFqoXH7R8OIlPUVVG7+Qc2xO2Wu8CMK+iZHg9COEEnAx9SOLl5fl1X1
   YWEDrSlSoPdHGRg+StS4/T45exYDzPfEEjZpnSrkqZI6AMhoTzCPyJqUh
   XHxoFL0vaoR5VzAm49jwjEqQwqRXctxBbBuuWuuIYQwnzFvZJRAPvuXOZ
   eeL+2fZxtAggdqPv3ZKXH27JZ2Q2jpUQ6fM2FoVP7/LhvTK2CG3vmmmgl
   g==;
X-CSE-ConnectionGUID: qZ8TFogGRRifnoATcuu21w==
X-CSE-MsgGUID: 2FKaJwjoTFqlt+cICmXjfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57400621"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57400621"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 03:40:14 -0700
X-CSE-ConnectionGUID: X83Xpw3MSdyKYgJrUJjUVw==
X-CSE-MsgGUID: Aa9UjoijQkSxPEbBzyjm/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="190904891"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 03:40:12 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	stable@vger.kernel.org,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: [PATCH v2] drm/xe/bmg: fix compressed VRAM handling
Date: Tue,  1 Jul 2025 11:39:50 +0100
Message-ID: <20250701103949.83116-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There looks to be an issue in our compression handling when the BO pages
are very fragmented, where we choose to skip the identity map and
instead fall back to emitting the PTEs by hand when migrating memory,
such that we can hopefully do more work per blit operation. However in
such a case we need to ensure the src PTEs are correctly tagged with a
compression enabled PAT index on dgpu xe2+, otherwise the copy will
simply treat the src memory as uncompressed, leading to corruption if
the memory was compressed by the user.

To fix this pass along use_comp_pat into emit_pte() on the src side, to
indicate that compression should be considered.

v2 (Jonathan): tweak the commit message

Fixes: 523f191cc0c7 ("drm/xe/xe_migrate: Handle migration logic for xe2+ dgfx")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
---
 drivers/gpu/drm/xe/xe_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 0838582537e8..4e2bdf70eb70 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -863,7 +863,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
 		if (src_is_vram && xe_migrate_allow_identity(src_L0, &src_it))
 			xe_res_next(&src_it, src_L0);
 		else
-			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs,
+			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs || use_comp_pat,
 				 &src_it, src_L0, src);
 
 		if (dst_is_vram && xe_migrate_allow_identity(src_L0, &dst_it))
-- 
2.50.0


