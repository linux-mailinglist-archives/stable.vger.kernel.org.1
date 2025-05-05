Return-Path: <stable+bounces-139665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B96AA9138
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC747A2AC7
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52BC1FBEA2;
	Mon,  5 May 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4TU5Ghu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708014D283
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746441226; cv=none; b=RUkUJwZsJ4r5LPZQWfbZE7l5gVMZQ3mW/Ypw5+dlXsU0oH7u6HBR3Vwl5B5qOs97Nxbw8sdhco6kf+FgZ3gRAv6+DteBOc5uo9xIn6h9B/KFYl8wKttQ01hqaEEHZKvxwRWCKofMGgjpL2AvpxOJOecthEsODIKszasEx7Ge4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746441226; c=relaxed/simple;
	bh=hZZcPIMOpRjDrAsSw0D4IChw6p5XTWm60/jKvfhPQ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM8Nx39F1tglO43UZPepVyjbYZOZqAaEUgsW1yKeRPvnyPLz3c11/vsn03VY+e1kOzRgWOxBFVi/8XsJCsIKErOILYI/hEttPxlO2UoRFso0LBGC0WMvblO34VVkszFqG0ZRhL4Y4TLzQ7hvsGyh6bR5KMh276Be+6iEXJQbeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4TU5Ghu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746441225; x=1777977225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hZZcPIMOpRjDrAsSw0D4IChw6p5XTWm60/jKvfhPQ7I=;
  b=S4TU5Ghusx3lkz2WzsVEE5z4uiCpGibufK61fsZ/fsZllG+1evCohv22
   NR08K3uETDMpJWJQlEoy61BlyB8D87m9uyftk9U2INjs4j0tOluLRF+1V
   /fsoFBVNRWVVMxbEuA7m98UXNU8UnIdEF2vs8l1HRjCcINhufC0E/1TND
   H+nfHK9dmqvhQb2HxFC6QA8B8iwQHEQIHNghvUKy8IZla4ntNoLw7UMcy
   rMWFzug3DSS7ESgNGhe7lZzBK+H7NghmPD3ys1iWRK0231g6Cxkso4Jv6
   IwocBsCNbinOaswXXCokE60Cu1DydhMJ/vNuXsdr7+c7LJaIceul3T0lf
   w==;
X-CSE-ConnectionGUID: 24LK5uydQAS481EFXM5eog==
X-CSE-MsgGUID: O9/UehxFRqGgTmVYp4aEMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="47301810"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="47301810"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:43 -0700
X-CSE-ConnectionGUID: kW37YnFZTwuSVnOCc3tY2w==
X-CSE-MsgGUID: jQlCQau6TtuUk6AHqNHnoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135186850"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:41 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 3/7] accel/ivpu: Fix a typo
Date: Mon,  5 May 2025 12:33:30 +0200
Message-ID: <20250505103334.79027-4-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250505103334.79027-1-jacek.lawrynowicz@linux.intel.com>
References: <20250505103334.79027-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Kreimer <algonell@gmail.com>

commit 284a8908f5ec25355a831e3e2d87975d748e98dc upstream.

Fix a typo in comments.

Cc: stable@vger.kernel.org # v6.12
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20240909135655.45938-1-algonell@gmail.com
---
 drivers/accel/ivpu/vpu_boot_api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/vpu_boot_api.h b/drivers/accel/ivpu/vpu_boot_api.h
index 82954b91b7481..d474bc7b15c01 100644
--- a/drivers/accel/ivpu/vpu_boot_api.h
+++ b/drivers/accel/ivpu/vpu_boot_api.h
@@ -8,7 +8,7 @@
 
 /*
  * =========== FW API version information beginning ================
- *  The bellow values will be used to construct the version info this way:
+ *  The below values will be used to construct the version info this way:
  *  fw_bin_header->api_version[VPU_BOOT_API_VER_ID] = (VPU_BOOT_API_VER_MAJOR << 16) |
  *  VPU_BOOT_API_VER_MINOR;
  *  VPU_BOOT_API_VER_PATCH will be ignored. KMD and compatibility is not affected if this changes
-- 
2.45.1


