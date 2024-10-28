Return-Path: <stable+bounces-89065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B49B304D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A10B280FA0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8301922DA;
	Mon, 28 Oct 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOW9gIE4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252B1D0DF7
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118722; cv=none; b=Sq8Nm2hBt3DTAiPN4ZMO6xhJOrQE8cUB8l8p5n5ENxKFl0KLegxj0BPwbe+VU6Wr5mowJmLi3awqJUsoxa8yR3V+wkx4yvp3Vb84Juaq84R2XpnzcLh/Tqo1WYCcjdS4WJTEnB0wHOQLnSnlMwM6SaNVne+jVNNeKLfhDTALoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118722; c=relaxed/simple;
	bh=SwUes2GvGHzIL5xi0/1bEwB79YJaUeHlpCxCCFod4v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCDtgLQboBUNr/mZ/3wW8wOBqfw57JbVomLRFmMWD0pyAkGJwy4MdXCRUjcEtElJC1XISYgG7Na5+fJWWwzvIAlmKhEdZx0v2w5ACEOuka2oplDv7PLljYNnFk/lDIGpCv6Y7MvoB5J+IBTZD0m8+QFXXojBApLtAmhDWFIojV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOW9gIE4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730118720; x=1761654720;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SwUes2GvGHzIL5xi0/1bEwB79YJaUeHlpCxCCFod4v8=;
  b=BOW9gIE42NRs58kccaami3GlSUzxoodZYknZCCQoyFtul4esXbwXL86U
   FQGDg/czptwlzeXUB6FGLegXZKI9UAyKpAhUQYqSWXzj4qH37NQk6ACJf
   mmE8AuaJr4BGhmsYaU2BoKPiRxuCGwH9DoRh7pxs01Vge0jsiRwepExR1
   uysUiHmf38hA4yBlN+vCMzWR2Lu+NXfyULbNif3gKiyJ5WLev+3GObKmL
   sxFWIi+aHsKTPc0WV5rDs5apwfr/5SRbXSxDvThWflJQyKMcUPbgnCD5u
   D8EJxG5wkR5Y+2W10tFXPnFdJwHjqPPNoaEz0Lol9cvaOsQTVWcBwi1CU
   w==;
X-CSE-ConnectionGUID: RCWP83a4RjW4nhw6hxGwAQ==
X-CSE-MsgGUID: lCMzLMhVRdGh0E57Z81/SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29821263"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29821263"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 05:31:59 -0700
X-CSE-ConnectionGUID: UJMFz/+WSa+LKsgJJnrh2w==
X-CSE-MsgGUID: 9xrWKv3TRkGkZmMXqf/vlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="86179149"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 05:31:57 -0700
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v3] drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout
Date: Mon, 28 Oct 2024 12:49:56 +0100
Message-ID: <20241028114956.2184923-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

Flush xe ordered_wq in case of ufence timeout which is observed
on LNL and that points to recent scheduling issue with E-cores.

This is similar to the recent fix:
commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
response timeout") and should be removed once there is a E-core
scheduling fix for LNL.

v2: Add platform check(Himal)
    s/__flush_workqueue/flush_workqueue(Jani)
v3: Remove gfx platform check as the issue related to cpu
    platform(John)

Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_wait_user_fence.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index f5deb81eba01..886c9862d89c 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -155,6 +155,17 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 		}
 
 		if (!timeout) {
+			/*
+			 * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h worker
+			 * in case of g2h response timeout")
+			 *
+			 * TODO: Drop this change once workqueue scheduling delay issue is
+			 * fixed on LNL Hybrid CPU.
+			 */
+			flush_workqueue(xe->ordered_wq);
+			err = do_compare(addr, args->value, args->mask, args->op);
+			if (err <= 0)
+				break;
 			err = -ETIME;
 			break;
 		}
-- 
2.46.0


