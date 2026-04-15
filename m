Return-Path: <stable+bounces-238050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMHpETgu32ltPwAAu9opvQ
	(envelope-from <stable+bounces-238050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:20:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC8F400CE5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40A0630131E9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9CE389459;
	Wed, 15 Apr 2026 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ah2vJXCB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A25730AD00
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 06:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233996; cv=none; b=LQKXre/r/D9jxNAoACpyGvMlo2F1eprI05/lDy8wHmSArrqc8VJU8ZBqHKnIMht+9rjGTQZISLVR+HNBI7V9IQkNk9VGVJL+Vwk5OTWtQJfmWM95a+fiBYlADlpaXgnAK65/YC+bNTH8qIQ0MwsSW9M7jNDrcOrubEIinCgnfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233996; c=relaxed/simple;
	bh=nRRDuhp9fGhe3KxDvIqOlbDeRxBcIwcFCSM/Fnul3MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bi7qQj/VXIE6kA3xS6TXoQbLtz+IcrN5HrzbI4AhhWdM4LsBqgNLrdoUGd1zH9rMQKAyUqB1gOunEQcUAJljnrUOvEW3LdEkcJUhlIMabI3ANGDdMTz9D9Fvm47UdD2XKRfz5Tk4io7nltFjjztUCAOsQtmGAhZtbc0EXRMburw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ah2vJXCB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776233995; x=1807769995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nRRDuhp9fGhe3KxDvIqOlbDeRxBcIwcFCSM/Fnul3MU=;
  b=ah2vJXCBg0GPzCCL+O3j8vEtpPayFGog3N9slOmLMUFepclnxQJENVDA
   JNR5Z5jhJAokMdJvBa9SxVsrbBi3g8l1PFK6Is61Y63SNa8GVozOkmmZi
   XKEhkEJ2zTFyLRXKThSQimvRzcdRcIiu90gbxse6EKOoNk+4tZX2hz/YT
   lTfLI6VMpM6y7GPG+S7O4b0/r/Rfbd5WmoAEy4kBuCifpl3tgKNyADfkM
   aY4Z2FzRJIK/LjZM5R0g3x7praIF/3ymsRgbDH9Tcxd/rl0OEfWhtm8+9
   nF2rS36znMUTTd40o52JVS3nc37F5ZiCuPU7HEfGAm5Rexj9UeqXVA548
   A==;
X-CSE-ConnectionGUID: p3wcpcIaRa6E/w4uyrFwKA==
X-CSE-MsgGUID: SUQSPuwcS8W8k0lNhVRLyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77080163"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77080163"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 23:19:54 -0700
X-CSE-ConnectionGUID: 2gTqIwOaQIicDzVgvdLAZg==
X-CSE-MsgGUID: Iw19URghS3OTpvPdY4k45w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227675214"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by fmviesa008.fm.intel.com with ESMTP; 14 Apr 2026 23:19:54 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v8 0/2] drm/xe: Reject unsafe PAT indices for CPU cached memory
Date: Wed, 15 Apr 2026 06:19:49 +0000
Message-ID: <20260415061951.427699-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129000147.339361-1-jia.yao@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238050-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 3FC8F400CE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series strengthens PAT index validation to reject unsafe
configurations for CPU cached memory, preventing cases where the GPU
may bypass CPU caches and observe stale or sensitive data.

Patch 1 enforces PAT validation for the madvise ioctl path, ensuring
XE_COH_NONE cannot be used on CPU cached buffers, including CPU address
mirror and userptr-backed memory.

Patch 2 applies the same validation to vm_bind, treating
DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR the same as MAP_USERPTR with respect
to permissible PAT indices.

Together, these patches close a security gap affecting CPU cached
memory access when incoherent PAT values are used.

Changes since v7:
- Rebased onto latest drm/xe tree, no functional changes.

Changes since v6:
- Corrected Fixes tags.

Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
Cc: stable@vger.kernel.org # v6.18
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>

Jia Yao (2):
  drm/xe/uapi: Reject coh_none PAT index for CPU cached memory in
    madvise
  drm/xe: Reject coh_none PAT index for CPU_ADDR_MIRROR

 drivers/gpu/drm/xe/xe_vm.c         |  2 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c | 45 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.43.0


