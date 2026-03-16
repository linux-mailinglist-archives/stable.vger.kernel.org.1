Return-Path: <stable+bounces-225505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDxZBOmvt2l3UQEAu9opvQ
	(envelope-from <stable+bounces-225505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 08:23:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB72958E3
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 08:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77F71300F18B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCE34D910;
	Mon, 16 Mar 2026 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZDfm4sF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27017BED0
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645798; cv=none; b=Jy6ZDQvKHwkZPWgqv/0x/1QX+5cLlyKj86zs9Xy5GVMvgf2PLpkSKCxlb8Xf+aa4D1MTQqKRPPgFGNxThVL0T1OyLAo54zExKIv80xw9s1zZh3+T4JS/g0lbBsY8rYZeIlVda7trA6LnhkbLD9XcqKJ4eCrvbAUEqeoJb38Tqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645798; c=relaxed/simple;
	bh=47VKoQYDkWv2tzbnKOFCXxXvAH+nspEI5oRz9Pwv7sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROIWDfK0qR4z+JjFS6onNcvQdUvRjlq7zxSyGb7z6bxkqe53Qi16LoW8rzMBxrixl4wnPy7K/SG54Y1+zpVlcw5AhZpqLTVCqj6P1GaETYLGUCB93FZs9CsmeYgex/2W/oNdLL4E69N3uG0mvGyFAyh4Jq72GlAquK8MhnzIKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZDfm4sF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645797; x=1805181797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=47VKoQYDkWv2tzbnKOFCXxXvAH+nspEI5oRz9Pwv7sg=;
  b=SZDfm4sF3nMI2hK3ZgKw+YKAcHhk5Y5umMUFV3lRETdu0TgvU3tc0AZ1
   GjVpiGLvgWA18eItfJzHkAM7cpG9fAOAuCwIHjrZCHQGFUgY/H97S1UZ8
   snMX/tWr54Zn3scdfZ9JF5n5atOs3SvKaiAFBcrPOGTM7b85vKxKrHE1J
   gz+gpYxZPbY9BHuBLvcfD8hpN8ryOrLZXAjF8xWiVT7MSry3IVgTfoq3w
   ILBPFt2EgAit3z8nhEZEavI3F5WGuvwMftGWagel790Z2CW5K+u5mvtXp
   lvwyqfNfb2HIoWNax/toyLsDpWiEyVzES1O124Xvxy4dnuu+1SutmUtf/
   w==;
X-CSE-ConnectionGUID: y2mQBHAdQNqEEFM9Siwm0w==
X-CSE-MsgGUID: Tvr+S+13S7eXKhJRzSBhrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92038911"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92038911"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:23:17 -0700
X-CSE-ConnectionGUID: WK5kSOrRTtanKQxoaIpKEg==
X-CSE-MsgGUID: mXNosqZSTniozV8niz3sRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226497585"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by fmviesa005.fm.intel.com with ESMTP; 16 Mar 2026 00:23:14 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v5 0/2] drm/xe: PAT index validation for CPU_ADDR_MIRROR and
Date: Mon, 16 Mar 2026 07:22:55 +0000
Message-ID: <20260316072257.255372-1-jia.yao@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225505-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EAB72958E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series strengthens PAT index validation to reject unsafe
configurations for CPU cached memory, fixing a potential security issue
where GPU could bypass CPU caches and read stale sensitive data.

The first patch adds validation to the madvise ioctl path, rejecting
XE_COH_NONE PAT indices when applied to CPU cached buffers (including
CPU address mirror and userptr mappings).

The second patch extends this validation to the vm_bind ioctl path,
ensuring DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR is treated the same as
DRM_XE_VM_BIND_OP_MAP_USERPTR with respect to PAT index requirements.

Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
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
 drivers/gpu/drm/xe/xe_vm_madvise.c | 46 +++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.43.0


