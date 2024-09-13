Return-Path: <stable+bounces-76060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8317A977F19
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DBD1F20F0A
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179B19CC34;
	Fri, 13 Sep 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kt5UHgOw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C71C2316
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228837; cv=none; b=Cr6PHPdgYsXU0lUx5abOXVQygwUyxvsNyvjq/U0cmoO9XsmaBYYIosB4N+NCg0RjYDgC1YGrKL1bDM+3ruhxKtxIVqWd00/aCcsHITxE9N2VMO6/S354xdYyj9TY8UJEB146KgPK06XGRKBieWNDzbU1uWyuVyInu321+41DJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228837; c=relaxed/simple;
	bh=VSREkogkTS0YL1zLDNSmjcGWshYNnY6/tpxyX7kLXv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2cuB4wVD49h6N7CYxC2a7J9XlBdkwf9GWIfkaRsG4AHP7isa45jiH0IAY3TdvaxrGbxu8Q+EG+HgSBA2yCEQkUPj5o4uO90K0bEazNhVpMx3M4KAvRS+k0pO4Op3VeXZ+BW6yulElHcugBdPNc5IMfLmiDpdXyDxI+UPLl+xLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kt5UHgOw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726228836; x=1757764836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VSREkogkTS0YL1zLDNSmjcGWshYNnY6/tpxyX7kLXv8=;
  b=Kt5UHgOweOkYkDNR118Ws/oRfUM+BVXNlwpv1p+bj2b/taH6sc+2zfNT
   3pIBywRjLfDnKIV15eFZh4hYPwtBfLM42Wm29rIYMReKK6Yr/1B4aZQvf
   3l/SAnbxQxOzq7vV9raYNOBgBMRazeKkuOFGsEsQjNmp+lGHfjH7LbzRi
   A70P7wNTBK312shWHHaF8WqK6zIbJjmjYOyoY7mRL7Xo2+DFoV6TL2pO6
   GuBM7+JtvKSD2Aik5Kp8CdzTKPUm3p/Vj15zcmLAYp6cfiORy4q5Xzz26
   T/9P1pVafO1eqEj0tIXrqx6VjtStIxi8XclVdQ/1DYKSeIHJdHGT1KakG
   g==;
X-CSE-ConnectionGUID: WNcIQaoUR3mp/eHPJuGmUA==
X-CSE-MsgGUID: 8gpt8+uPQsaFPZv+L83QRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36473334"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="36473334"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:00:35 -0700
X-CSE-ConnectionGUID: x9ds3quBTzSYDOok44wDsQ==
X-CSE-MsgGUID: tcvZ4fsWRqyjTQqL3eUq+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68532648"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.158])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:00:34 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/xe/vram: fix ccs offset calculation
Date: Fri, 13 Sep 2024 13:00:24 +0100
Message-ID: <20240913120023.310565-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spec says SW is expected to round up to the nearest 128K, if not already
aligned for the CC unit view of CCS. We are seeing the assert sometimes
pop on BMG to tell us that there is a hole between GSM and CCS, as well
as popping other asserts with having a vram size with strange alignment,
which is likely caused by misaligned offset here.

BSpec: 68023
Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/xe/xe_vram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index 7e765b1499b1..8e65cb4cc477 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -181,6 +181,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt *gt, u64 tile_size)
 
 		offset = offset_hi << 32; /* HW view bits 39:32 */
 		offset |= offset_lo << 6; /* HW view bits 31:6 */
+		offset = round_up(offset, SZ_128K); /* SW must round up to nearest 128K */
 		offset *= num_enabled; /* convert to SW view */
 
 		/* We don't expect any holes */
-- 
2.46.0


