Return-Path: <stable+bounces-214508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIA3CCrChGk45QMAu9opvQ
	(envelope-from <stable+bounces-214508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:15:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4CF5181
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7484D300BD86
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB5F3ACEEE;
	Thu,  5 Feb 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqNujL+D"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED02C0F91
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308132; cv=none; b=HyECsWVfusIeVgfDTkQTIRdnfi0gjiojjXG21mNp4YpBRe5177mCrZhBB5d8qjYgq7hVo2lsJajACNFPXjYL+gQp50TvQONZrlYimq4TuWzPur1KtydYh6ABarIGYF4LvQInDFgUirVgpcbDalJafk/rn1eyYfU6l0mvV7ToHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308132; c=relaxed/simple;
	bh=jSTGMS76wzaOXx16IoRmWUKxzuVmR27lmFqETn3KgOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaZ44y0JRuJ4eVrXwEJNXdBc3CspdNzIWM1mv1WQKu9eHlGSjqPkMG5WuKNjyHQb+BtStF3Gad8T1E06Gte4xLut8iKfXHMaeBSyhdUwbBAIbSQhg4H86Knq+10g3qc0E6sddRzmWzqlMCgorR6hLn7HjXbemR+st1+sRKppiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqNujL+D; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770308133; x=1801844133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jSTGMS76wzaOXx16IoRmWUKxzuVmR27lmFqETn3KgOM=;
  b=jqNujL+DcxIhWLMfVx1PVGKyxQ2CK+XIMbfbkBA2AMzsyX5FrmFSJNPV
   sZ6TeA7OAPInr2+ZXsun0i3oTmaJtaZLcSPcShBfeMP8kuu5RZc1q4TCt
   2IOMwqI+hJl+a7HLkP+5auZQkwuRjMbEM4FlFsj79wx26mhKZ2hVgyeKU
   0dCxiOWFw5iMNKRPn070OUzxfeJqj02FRCEk58ZtBDa1KFrgdteZpvhZi
   i56qMSgYKcT1GSGq4EX+omHhXhp7UGgw7N9KuJHHm8E8pXxeQFtIhFgSC
   wOlhh6JvYJpFOlpWFSWegIciQt10U4cQrxZHoz/Gr6k3g1nJouXsG2Kh8
   Q==;
X-CSE-ConnectionGUID: SyyXoQ6ZQPG7ncm4YX9YzA==
X-CSE-MsgGUID: XFCzrQRCT52Qx9h/AwKBkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82142977"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82142977"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:15:32 -0800
X-CSE-ConnectionGUID: fx2G/4XkS1GuMC2Xq9k9zg==
X-CSE-MsgGUID: 0fgGELw1QF6L/H6IXH+iSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210379389"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.45])
  by orviesa009.jf.intel.com with ESMTP; 05 Feb 2026 08:15:32 -0800
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v3] drm/xe: Add bounds check on pat_index to prevent OOB kernel read in madvise
Date: Thu,  5 Feb 2026 16:15:29 +0000
Message-ID: <20260205161529.1819276-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203172045.1154546-1-jia.yao@intel.com>
References: <20260203172045.1154546-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214508-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79B4CF5181
X-Rspamd-Action: no action

When user provides a bogus pat_index value through the madvise IOCTL, the
xe_pat_index_get_coh_mode() function performs an array access without
validating bounds. This allows a malicious user to trigger an out-of-bounds
kernel read from the xe->pat.table array.

The vulnerability exists because the validation in madvise_args_are_sane()
directly calls xe_pat_index_get_coh_mode(xe, args->pat_index.val) without
first checking if pat_index is within [0, xe->pat.n_entries).

Although xe_pat_index_get_coh_mode() has a WARN_ON to catch this in debug
builds, it still performs the unsafe array access in production kernels.

v2(Matthew Auld)
- Using array_index_nospec() to mitigate spectre attacks when the value
is used

v3(Matthew Auld)
- Put the declarations at the start of the block

Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.18+
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/xe/xe_vm_madvise.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index add9a6ca2390..091e450b781c 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -246,6 +246,10 @@ static int xe_vm_invalidate_madvise_range(struct xe_vm *vm, u64 start, u64 end)
 
 static bool madvise_args_are_sane(struct xe_device *xe, const struct drm_xe_madvise *args)
 {
+	s32 fd;
+	u16 pat_index;
+	u16 coh_mode;
+
 	if (XE_IOCTL_DBG(xe, !args))
 		return false;
 
@@ -261,7 +265,7 @@ static bool madvise_args_are_sane(struct xe_device *xe, const struct drm_xe_madv
 	switch (args->type) {
 	case DRM_XE_MEM_RANGE_ATTR_PREFERRED_LOC:
 	{
-		s32 fd = (s32)args->preferred_mem_loc.devmem_fd;
+		fd = (s32)args->preferred_mem_loc.devmem_fd;
 
 		if (XE_IOCTL_DBG(xe, fd < DRM_XE_PREFERRED_LOC_DEFAULT_SYSTEM))
 			return false;
@@ -291,8 +295,11 @@ static bool madvise_args_are_sane(struct xe_device *xe, const struct drm_xe_madv
 		break;
 	case DRM_XE_MEM_RANGE_ATTR_PAT:
 	{
-		u16 coh_mode = xe_pat_index_get_coh_mode(xe, args->pat_index.val);
+		if (XE_IOCTL_DBG(xe, args->pat_index.val >= xe->pat.n_entries))
+			return false;
 
+		pat_index = array_index_nospec(args->pat_index.val, xe->pat.n_entries);
+		coh_mode = xe_pat_index_get_coh_mode(xe, pat_index);
 		if (XE_IOCTL_DBG(xe, !coh_mode))
 			return false;
 
-- 
2.43.0


