Return-Path: <stable+bounces-217517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGH+Nw+Dl2nozQIAu9opvQ
	(envelope-from <stable+bounces-217517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:39:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103C7162E67
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95E9330055DA
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371F306480;
	Thu, 19 Feb 2026 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxqgpX1x"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328C2C1589
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537162; cv=none; b=Fck/FrWilNL8mKL7jKWvg/EDZuCCOcsKqMMe7M7ZSlSkp5N/RkqwGqrkekJbOyLgvablkW1oy+H1Nko17QUSEtOUzpXG+fa+OWNugAnXOKky0CBkZCMCvU0WAJAonevl1+qItpa9naB1j9+M9keWBJohYebPb6JVY68jzklvhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537162; c=relaxed/simple;
	bh=J3wqUnhxgRS2rtgAzsaqWlWzoEIPlmSwGBjU5lxnwAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzvPRGp7hoQVzPOQaj7RIyPoA5YYzozAaNdU5N+8Rj+9Xd8llQm5sZBiWY+5YWFZOV2hlW3ILzqUMRtseFmIaV4YH0LWKl4kSYcG2/qL2QCnD84AqZnhfn88CgKUxSYm+U9LsDBsJcNaEZMiIwfbJQXOqV4GWCPfCDCZrzCvxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxqgpX1x; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771537162; x=1803073162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3wqUnhxgRS2rtgAzsaqWlWzoEIPlmSwGBjU5lxnwAM=;
  b=TxqgpX1x6+hhs58teHA8+mXELAPuUk0ASITRxNSSTLQJ9/wwq1rvmaHe
   JHeymez3SvLDz9/ScwdNOrfOahaAquo2cTNlnWQ7xYAwalOxWbJwzNdKk
   BiCTCLEoV/ZkovBokYF2YHFXPU5RSRIjSSu1g2iA6f0ouP4lQSsbS/FNi
   deUml3psUEILrhNcCd/9KGYHTgWLmsA8E9mTo7nC4T/kFIZa2SxXhvPa4
   E8xQVPx+hifVTN3P2/stzi1Yqd0G/eC8aAOyfUlrdJAn5ab4v4NnCkOYt
   KfFYe6IGWkJ4RbnzKBCEYM6wzKl2dkoPZhemlfFbke+NaU9nAhR0WWhPn
   w==;
X-CSE-ConnectionGUID: bZpfCvNbSjWQvM7u5gBqUA==
X-CSE-MsgGUID: UNNLKQHMRfqCJDCAMQ/ccQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="90044700"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="90044700"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:39:21 -0800
X-CSE-ConnectionGUID: vCfZLI4WTnWu+VhONT8EXQ==
X-CSE-MsgGUID: hrt+txn6SmurklkFGMKqig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="212526348"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kkoning-desktop.intel.com) ([10.245.244.197])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:39:13 -0800
From: Koen Koning <koen.koning@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Koen Koning <koen.koning@linux.intel.com>,
	Chunming Zhou <david1.zhou@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] drm/sched: fix module_init() usage
Date: Thu, 19 Feb 2026 22:38:57 +0100
Message-ID: <20260219213858.370675-3-koen.koning@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260219213858.370675-1-koen.koning@linux.intel.com>
References: <20260216111902.110286-1-koen.koning@linux.intel.com>
 <20260219213858.370675-1-koen.koning@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,nvidia.com,intel.com,kernel.org,linux.intel.com,amd.com,pengutronix.de,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217517-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[koen.koning@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid,pengutronix.de:email,amd.com:email]
X-Rspamd-Queue-Id: 103C7162E67
X-Rspamd-Action: no action

Use subsys_initcall() instead of module_init() (which compiles to
device_initcall() for built-ins) for sched_fence, so its initialization
code always runs before any (built-in) drivers.
This happened to work correctly so far due to the order of linking in
the Makefiles, but this should not be relied upon.

Fixes: 4983e48c85392 ("drm/sched: move fence slab handling to module init/exit")
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Koen Koning <koen.koning@linux.intel.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 9391d6f0dc01..d10c1163719f 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -235,7 +235,7 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 		       &fence->lock, entity->fence_context + 1, seq);
 }

-module_init(drm_sched_fence_slab_init);
+subsys_initcall(drm_sched_fence_slab_init);
 module_exit(drm_sched_fence_slab_fini);

 MODULE_DESCRIPTION("DRM GPU scheduler");
--
2.48.1


