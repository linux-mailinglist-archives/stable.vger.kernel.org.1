Return-Path: <stable+bounces-139157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF6AA4BB0
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1673A2275
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DDC25B660;
	Wed, 30 Apr 2025 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejvkNdfv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF77C258CEB
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017309; cv=none; b=UnmHjUd2eDC4MVB06eppoPdFnxSu+7xPBMgsSF9bW1LKmTS9SvlbddlcmtZhlJWYPGVieTXn6jZ/77ZBe29+yh/KFG/irQ+fFROfdCeFEfDWeNoNvTdmnbl91HvmM9vLhAmxxmFb5mxVtgKE+oyhCzQI5Q2rGbQ2Cyh8d2EhsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017309; c=relaxed/simple;
	bh=tlybjJEFLY5dFKgu4t8gDeZaMIHsgMFguHDfPW9FR7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf0/aeY0luW8mtUBppqTVrZNXaVHr9Smwu9wh2yOvCMZQTEdCRUCPXGf0+IoKXt0GBkC7fts5fI1np8jU1LMMMEKzcLn5vBr+uGDKgGohJu+bR+MJEMZPvHgkiovLeTp4exrW0/2EUOSOavg1KvWpzjtS/TpV84LCvH3gR/nspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejvkNdfv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017308; x=1777553308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tlybjJEFLY5dFKgu4t8gDeZaMIHsgMFguHDfPW9FR7k=;
  b=ejvkNdfv2dGTSAEEF49lQwYk4eGlEW9rRywAQyTV741/V8kalcz6y84X
   Ms8LgAX3eDhZ5xRb6Tox6S/r/acBSP6mAeZLeiO8aHQbFlu5v+XqKiVOS
   84dBi+nGHl4dFhAqIWVUKqUSaGcBpm/7FlJshpWwNoyQ+5tS0IhqLNYZ+
   F9mZ6/YEDNvuXDp/6V2U9hK9VIgzy4UTZOOBimLi3c8E0vvDPrQbqSdZU
   LhKz+dN9QZ5N31JYtDZIJCdJjvERgPpOvA4wnwBnB6sXdMRPxwBu7UjSB
   3dpw74y3F5u99VAmkGKIPysB/IQ3hfLkg3GpxnbdIBHEwyBpA5I/iE9/V
   w==;
X-CSE-ConnectionGUID: 2zMOCxWFRv+UitCEPZtF+A==
X-CSE-MsgGUID: /NTMnFipTbejF0j2tLsYmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51488506"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51488506"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:28 -0700
X-CSE-ConnectionGUID: iXfGASkbQJ27AyV5QBKJTA==
X-CSE-MsgGUID: YW3gEngyTlS/yqZEE85IeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138925409"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:27 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/7] accel/ivpu: Fix a typo
Date: Wed, 30 Apr 2025 14:48:15 +0200
Message-ID: <20250430124819.3761263-4-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
References: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
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

Cc: <stable@vger.kernel.org> # v6.12
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


