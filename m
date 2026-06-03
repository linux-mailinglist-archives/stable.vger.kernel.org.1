Return-Path: <stable+bounces-260067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ZLzKXAcIGoiwAAAu9opvQ
	(envelope-from <stable+bounces-260067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:22:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17446637714
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:22:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=S+HyY4tW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260067-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260067-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69203301DC19
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 12:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9982747A0D1;
	Wed,  3 Jun 2026 12:14:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3647A0C3
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 12:14:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488875; cv=none; b=Vq1n4nOfPbXX6MA76E8zAysji2MmYj94XrKfntkEbtzozv+2JJpm9I27lwvaGhmkC8bF1pwbCvIaz0X1fsRKOBe/l24D4sLs9SETvAXsBXZ75mUQcih9jNbFBlMEYgVtjfL+4MT0ogz2PqpYEOfLPdT6KodApHAqVsFfQKd0GBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488875; c=relaxed/simple;
	bh=V91GoT1tM9md2KozCeXm5aypOv5ZJavURFlxJQSbmOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9YeReN5iGbN557aSD1MUE2X1JaycE6HwlKkdyt/ENipC3Vo0Tb/dN1smKYymzuEq43OuuqVC1YeliX+7EI1LhlnSbxCsDzyvIiXEI0AjIsexY1NKQROgsp1e5tTGe3iP6L7mn1fdYYfjylABBWoPWm/Vd5SG+HHv7Wp1oAwYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+HyY4tW; arc=none smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780488873; x=1812024873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V91GoT1tM9md2KozCeXm5aypOv5ZJavURFlxJQSbmOM=;
  b=S+HyY4tWdqBan90PUEeOW+o/1VyJZlZ9d/GgRZJ5MG97XDQQgCJ6Gn9C
   c4Ab1eaHQzeZj/AR4Mx8uqCynJBFzMbpCbk5jrnImy62sFsHkbPFimxaJ
   p/w5Ki8y8H2OptbyXRMvSFTzlFMIaXHHbD2VcLO/4MoAzZ3WsSzJ0iu7P
   0n6A183VpGGABjOzeXtsDBKIuhpAOS1fGLPuAiPmOMTrQjwGbV51Vn5iY
   rPyFS77qtLzxVJxibBMmoTvD1i+UW2RBuml+yyS0sG+59HgTUos9jm4tM
   bCfvNgPjGdoeMejWGNyvl8l9/CaVKR+HeUl7ISm475xMihBPIjgRuqCGM
   g==;
X-CSE-ConnectionGUID: us4zkw+mQEeN+ipyVMf2eQ==
X-CSE-MsgGUID: UA/xNjc7RUuypLH/5OEMyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92401552"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="92401552"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 05:14:32 -0700
X-CSE-ConnectionGUID: IqpauxNfTm2NjNmmAceq9w==
X-CSE-MsgGUID: w60EvJPMShKLRvi01WjSiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="249301240"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 05:14:28 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	rodrigo.vivi@intel.com,
	nirmoy.das@intel.com,
	umesh.nerlige.ramappa@intel.com,
	thomas.hellstrom@linux.intel.com,
	matthew.brost@intel.com,
	niranjana.vishwanathapura@intel.com,
	thomas.hellstrom@intel.com,
	fei.yang@intel.com,
	himal.prasad.ghimiray@intel.com,
	matthew.d.roper@intel.com,
	maarten.lankhorst@intel.com,
	joonas.lahtinen@intel.com,
	matthew.auld@intel.com,
	stable@vger.kernel.org
Subject: [RFC PATCH 2/3] drm/sched: fix drm_sched_tdr_queue_imm to not corrupt timeout value
Date: Wed,  3 Jun 2026 17:36:41 +0530
Message-ID: <20260603120641.473434-5-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
References: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260067-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sanjay.kumar.yadav@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:rodrigo.vivi@intel.com,m:nirmoy.das@intel.com,m:umesh.nerlige.ramappa@intel.com,m:thomas.hellstrom@linux.intel.com,m:matthew.brost@intel.com,m:niranjana.vishwanathapura@intel.com,m:thomas.hellstrom@intel.com,m:fei.yang@intel.com,m:himal.prasad.ghimiray@intel.com,m:matthew.d.roper@intel.com,m:maarten.lankhorst@intel.com,m:joonas.lahtinen@intel.com,m:matthew.auld@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjay.kumar.yadav@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17446637714

drm_sched_tdr_queue_imm() sets sched->timeout to 0 and never restores
it. This breaks all future TDR timers — jobs get timed out instantly
before they even start running on hardware.

Use mod_delayed_work() directly to fire the TDR worker immediately
without modifying the timeout field. This preserves the original
timeout value for subsequent job submissions.

Fixes: 8ec5a4e5ce97 ("drm/xe: Resume TDR after GT reset")
Cc: <stable@vger.kernel.org> # v6.13+
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4.6
Suggested-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 818d3d4434b5..be144e244745 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -212,8 +212,8 @@ static void drm_sched_start_timeout_unlocked(struct drm_gpu_scheduler *sched)
 void drm_sched_tdr_queue_imm(struct drm_gpu_scheduler *sched)
 {
 	spin_lock(&sched->job_list_lock);
-	sched->timeout = 0;
-	drm_sched_start_timeout(sched);
+	if (!list_empty(&sched->pending_list))
+		mod_delayed_work(sched->timeout_wq, &sched->work_tdr, 0);
 	spin_unlock(&sched->job_list_lock);
 }
 EXPORT_SYMBOL(drm_sched_tdr_queue_imm);
-- 
2.52.0


