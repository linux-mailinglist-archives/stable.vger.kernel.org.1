Return-Path: <stable+bounces-83452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF699A532
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620FF1C21577
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E649F28E7;
	Fri, 11 Oct 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZY9avQ0T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770B216A3B
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653810; cv=none; b=sgnFLPG8mNvG6h4TQYMHBdszY+mYn8GUzVhvLd5P8nviJ5xEmbglozT1S7GFqAbXUfUhhfr1Gti0vTNxH9hRAlcd3dxfDb98wkVTYnUHLLvIxTny6OeDkUwOyo/+Kk5SBPtpkrLohj5umxXDgoOigJXSm5hiZGWuyFOHDEU9Gs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653810; c=relaxed/simple;
	bh=Wlp64ocQwO0ULZow76Y602j/+aNP8TFmvRUudPm7FLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQVQZx4AGSm08R/qjrZN/5VSreWg+q2Pc7mzwWw0T+BvMls2SkgX658VwezsPI3hkLM0J2T38mOY352cX7RZE5aWR6e+QL0ozdgy09ouQqUEL67ROOT4AKWO7CaRwgnbLK5TUoPzzA65lMSIs8gPWdVCn2W+DJRXNeUts8H/c4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZY9avQ0T; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728653809; x=1760189809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wlp64ocQwO0ULZow76Y602j/+aNP8TFmvRUudPm7FLw=;
  b=ZY9avQ0T9l2d5e2NpLvB49e1vCIXupx2cHfqpBaLFld0zH7mczfmE0JB
   wurE7Kg3B5Cc5dVdpUFeBQqb1ZGq7L+gVOg5XqJWmLgOnxUsNVNF3J1yG
   vH8JBY7Dj7LNfTzRBodUQieNP3uA85DOuAj8XK25rBn2altGsEQXcMja7
   NY8qAFV2QpYnzxh85LKBvIR3x1shjBLu5UrgZLBCIVxO32+ai1SjWMWDp
   p8qsr0cyxFD/Fola0nOxHqSAE1qwI/GzBd3qU7hEIlbvV4IIj+aRngSOi
   qUFmrSoRqczF6DjCTNjlCeVLCM1yYudyiJFCD50SPcQ9sHavNgn5UnbS9
   g==;
X-CSE-ConnectionGUID: cayRn+FQRwau34cN0Vb2Rw==
X-CSE-MsgGUID: ZRwAKD6RQCGUJ9Kf4ldjtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="45562371"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="45562371"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:36:49 -0700
X-CSE-ConnectionGUID: GnXBE5umT/K6mYgF1QRA+Q==
X-CSE-MsgGUID: rQj1+r7kSGqdAB200rsoXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81442200"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.149])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:36:45 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/xe_sync: initialise ufence.signalled
Date: Fri, 11 Oct 2024 14:36:34 +0100
Message-ID: <20241011133633.388008-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can incorrectly think that the fence has signalled, if we get a
non-zero value here from the kmalloc, which is quite plausible. Just use
kzalloc to prevent stuff like this.

Fixes: 977e5b82e090 ("drm/xe: Expose user fence from xe_sync_entry")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/xe/xe_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index bb3c2a830362..c6cf227ead40 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -58,7 +58,7 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
 	if (!access_ok(ptr, sizeof(*ptr)))
 		return ERR_PTR(-EFAULT);
 
-	ufence = kmalloc(sizeof(*ufence), GFP_KERNEL);
+	ufence = kzalloc(sizeof(*ufence), GFP_KERNEL);
 	if (!ufence)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.46.2


