Return-Path: <stable+bounces-87999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CABF9ADA97
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3761C218AC
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0F1714B2;
	Thu, 24 Oct 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/sBgaEy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FAE16F8E9
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741146; cv=none; b=jeiA/Sx+LaAsAUFxEi+lqpDGoxXfuedtebwTN1HB2WCyC+0HhrbDkNIn44XNLUAAZu2IzTB00GWvazKlBjDP/2Jo0vdx1Hd2hMdGOF98MQ0UJrJ4cJBxt1OPyX8w6ccuCWTtPIy/o2CMobWLhWOIwlCfxHVUNg7lMl1rO0ErpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741146; c=relaxed/simple;
	bh=TeNrs+Nx5w59WODSEG5n3Nt7tSdMwoprf1yH7i+lOGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYIjtIC16xOoSwNHNEGgiLh9rN32jlbUPBJSV90WtEuv2wrmqO5aYf5K7C+ucI805o40zf/Y0uTMr+7dswAcC6I5YZXmq4XRKG5nUTdx0PP5on7VSi1kr6SaulxQGBrWru1HoV0/l0uxG4jCeaa3lWZy1+7B7hj2fQd+gWnVTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/sBgaEy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741145; x=1761277145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TeNrs+Nx5w59WODSEG5n3Nt7tSdMwoprf1yH7i+lOGc=;
  b=m/sBgaEy1SlhdxN/o+rnFHeiCjgKclbplYY7uXF7sgn19CBiqDpQyCd2
   44O4CXZ4LfYARmZ7hnleQctoFvpL1iHj1J9JJOnOkH8U6q1qjd0dKgYBV
   KRdU4mD+lvwIvDwkd/tJb0GIImAEUUrT1UEOveSXutAP7K0VGyQZj6h/5
   Xr7BjTs7qeerjY4t1Dwn9fomBNCalvaue5wT7R4qEncn9BlCq/PXEEFSc
   D+6a9n/dWbDYr2LqYQCTriqlkYIcA/rkxxQAQFHEPkcBlq5g104h7eNHr
   rSbfxB9OehVrvwWBI4bYiNsyN7NErgdsfWEJL8hp6w9keRz06LZVjb+ZF
   w==;
X-CSE-ConnectionGUID: EVkNFc0xSOWV+xqECCzBug==
X-CSE-MsgGUID: EEpI9wtNSgyE9V3I3WRHRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33265006"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33265006"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:53 -0700
X-CSE-ConnectionGUID: 39a54zb/SouU0w0GEDRJKA==
X-CSE-MsgGUID: xWxpWluYQmq+GWyQPQv/mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384998"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Shekhar Chauhan <shekhar.chauhan@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 21/22] drm/xe: Define STATELESS_COMPRESSION_CTRL as mcr register
Date: Wed, 23 Oct 2024 20:38:13 -0700
Message-ID: <20241024033815.3538736-21-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejas Upadhyay <tejas.upadhyay@intel.com>

commit 4551d60299b5ddc2655b6b365a4b92634e14e04f upstream.

Register STATELESS_COMPRESSION_CTRL should be considered
mcr register which should write to all slices as per
documentation.

Bspec: 71185
Fixes: ecabb5e6ce54 ("drm/xe/xe2: Add performance turning changes")
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Reviewed-by: Shekhar Chauhan <shekhar.chauhan@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240814095614.909774-4-tejas.upadhyay@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 076afe5b5777c..667671e482141 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -80,7 +80,7 @@
 #define   LE_CACHEABILITY_MASK			REG_GENMASK(1, 0)
 #define   LE_CACHEABILITY(value)		REG_FIELD_PREP(LE_CACHEABILITY_MASK, value)
 
-#define STATELESS_COMPRESSION_CTRL		XE_REG(0x4148)
+#define STATELESS_COMPRESSION_CTRL		XE_REG_MCR(0x4148)
 #define   UNIFIED_COMPRESSION_FORMAT		REG_GENMASK(3, 0)
 
 #define XE2_GAMREQSTRM_CTRL			XE_REG(0x4194)
-- 
2.47.0


