Return-Path: <stable+bounces-226124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMknDCWCuWmxHAIAu9opvQ
	(envelope-from <stable+bounces-226124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:32:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A64B2AE08D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1F4304B398
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053D3161A6;
	Tue, 17 Mar 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4IjZ6zH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B9221265
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764774; cv=none; b=AvhIlSwZSfEBvyitX/aTkjM0ahKS4R+p7r2yNV+kODCkyV5ize27gOY50HzMCxfstDJfgTJfojDScbkQ852IP9DD04J2+oE1z8PB+4eI8E3LZ7zTqqAcp3YdFoig5nZWPwYeYBT4qhuiJvtyvX3sXS8vF9Cdesbz+7j8/cW+7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764774; c=relaxed/simple;
	bh=cE6v11F5b/JFuNRNrI8MMtt9RfeQ0jpqwY9MsYGJwnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCaDF8wLdTSnPY/xMS+juhQ6lYdWz9m9bxCsOPXBrWTQW8jcmAD+XpYaxcnocu1LnodMh0Vp90JzxFkW3nhHuOQtTvGzTPyAGtKdH2PKjhWKlpM9uT1dz4BDmcL4/gdkoNWqEtkQETsy1KDnIehdV0hLiHboOI+Lep3KtABl28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4IjZ6zH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773764773; x=1805300773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cE6v11F5b/JFuNRNrI8MMtt9RfeQ0jpqwY9MsYGJwnw=;
  b=A4IjZ6zHg0WLrRxUftA9FLdWPxPvCMkneHlxxz3yxzK23Ogm4sInQpju
   cdTvKZgdGwrxH/igkXdEyF7GaLwx+kD0YRMahMYRHb6qZy4JAHSQ5Hg+f
   kfP9qv0kQQc0UnhrSk/m5MnZtHptvbJsfDhlx4AIg6/sDlxICSlMwimBp
   RW0dR4XnNwaKfm2Uh59gQwxzmtKkLy3KI8Ti16ycm5K8Q0Bt8qox2FUCA
   aiY8HCCcLzr0aGKnN2EFM0p+Mgw8fO8er15RrJh3cdrP4s3iQIUI23Zcz
   6JM3FdtLRAOZE49An32uDHfVJxMZWXCxh9fGuDowCozqGTKOxsw/loC/3
   Q==;
X-CSE-ConnectionGUID: alPq17f7S9SFLuGQLn0y8A==
X-CSE-MsgGUID: db+LROvUQ6m3okxI6n9XBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74718013"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74718013"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 09:26:12 -0700
X-CSE-ConnectionGUID: KbkTKm5XT5uio39gciEP+w==
X-CSE-MsgGUID: CpS6j0XsQGWApD7xns33+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226455869"
Received: from shosgclin.sh.intel.com ([10.112.232.103])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2026 09:26:11 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12.y] drm/xe/sync: Cleanup partially initialized sync on parse failure
Date: Tue, 17 Mar 2026 16:22:21 +0000
Message-ID: <20260317162220.1774730-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026031732-size-unfasten-2bf3@gregkh>
References: <2026031732-size-unfasten-2bf3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226124-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A64B2AE08D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xe_sync_entry_parse() can allocate references (syncobj, fence, chain fence,
or user fence) before hitting a later failure path. Several of those paths
returned directly, leaving partially initialized state and leaking refs.

Route these error paths through a common free_sync label and call
xe_sync_entry_cleanup(sync) before returning the error.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260219233516.2938172-5-shuicheng.lin@intel.com
(cherry picked from commit f939bdd9207a5d1fc55cced5459858480686ce22)
Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 1bfd7575092420ba5a0b944953c95b74a5646ff8)
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_sync.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index dd7bd766ae18..6affdd0a8095 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -142,8 +142,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 
 		if (!signal) {
 			sync->fence = drm_syncobj_fence_get(sync->syncobj);
-			if (XE_IOCTL_DBG(xe, !sync->fence))
-				return -EINVAL;
+			if (XE_IOCTL_DBG(xe, !sync->fence)) {
+				err = -EINVAL;
+				goto free_sync;
+			}
 		}
 		break;
 
@@ -163,17 +165,21 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 
 		if (signal) {
 			sync->chain_fence = dma_fence_chain_alloc();
-			if (!sync->chain_fence)
-				return -ENOMEM;
+			if (!sync->chain_fence) {
+				err = -ENOMEM;
+				goto free_sync;
+			}
 		} else {
 			sync->fence = drm_syncobj_fence_get(sync->syncobj);
-			if (XE_IOCTL_DBG(xe, !sync->fence))
-				return -EINVAL;
+			if (XE_IOCTL_DBG(xe, !sync->fence)) {
+				err = -EINVAL;
+				goto free_sync;
+			}
 
 			err = dma_fence_chain_find_seqno(&sync->fence,
 							 sync_in.timeline_value);
 			if (err)
-				return err;
+				goto free_sync;
 		}
 		break;
 
@@ -207,6 +213,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
 	sync->timeline_value = sync_in.timeline_value;
 
 	return 0;
+
+free_sync:
+	xe_sync_entry_cleanup(sync);
+	return err;
 }
 
 int xe_sync_entry_add_deps(struct xe_sync_entry *sync, struct xe_sched_job *job)
-- 
2.50.1


