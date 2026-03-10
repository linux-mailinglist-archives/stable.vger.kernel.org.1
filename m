Return-Path: <stable+bounces-224596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHaWHVagsGkwlQIAu9opvQ
	(envelope-from <stable+bounces-224596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:51:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D894225915D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBE83181DF4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52538D693;
	Tue, 10 Mar 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqUQR3kN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57F2FE042
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183043; cv=none; b=L1Eu80hBsSDRCh7hppjI0oEa+JhW7lKGXYvBQB4NVfaidGw1NCeBytBaYmKnDKQVHigYzFwjBv9VGEu+fwnentQ1EX/rTHsJJmA/4TU+ZJvmnlUKG6gGw1dyRZ6V8nZMGFZD08R1xLm8QoUs11ydQSlh18fXY4RDp5yDb1yVe98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183043; c=relaxed/simple;
	bh=tg6eATn+DjxTL9bL2/6WODzKwQNcIQ8b2ky1QFKzL7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/bt4cronjgKnwk5w1qzVdqi4mOLIP9QMKg/cOCT1EhScCW/1r4v96/HhSuSfM/Xva6gFFnGdhg6WpLII9MOBoQFwztNWcS/NGod7S/rLTk4e0THQfJA888H3xAjFFp/2KHkNFx4g2QC1WM25+AwEGqqPUQRTQ9kJl0a6zvnDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqUQR3kN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773183042; x=1804719042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tg6eATn+DjxTL9bL2/6WODzKwQNcIQ8b2ky1QFKzL7M=;
  b=nqUQR3kNRyvWfWhy16Xadpfq4w2iMvhgbZ2a+QOKQWxxZoeTHdpYy7UU
   bGd/WvlAhjtpO3O+iHUtZSm2JXGCDuyU/rgPbboSd6wkQ9wsa2gxwqUl7
   zwHUyajY/UGE53LAoo+7mf12X7bBasMKDEYfmeQRayjWQllRsc4knLaYK
   WDx9K65OEKteX9DSdnF78PUTwh29aa2r6vXF185UT5JMoIcXlXe+FQDIH
   PUZp+HqA7gE2UIcvEvYKsqYReInHrB6/BnbtyXS6nAaXXGI6vUY7xQh5O
   HfJuJI9GkMkdWeaUXcC6f2WHn8ESDH6vmUvSNbhz3yklULAtHds0QVGcf
   A==;
X-CSE-ConnectionGUID: cWsqR0fxSB2Ya2h93BtxHg==
X-CSE-MsgGUID: IzEfZYPeSje6iU/o1tEJvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61817878"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61817878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:50:42 -0700
X-CSE-ConnectionGUID: GtIoALu7T+Cor/WVVgaz9g==
X-CSE-MsgGUID: vMmiEN8TSNaLBeUHaP28cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220440987"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa007.jf.intel.com with ESMTP; 10 Mar 2026 15:50:41 -0700
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	Stuart Summers <stuart.summers@intel.com>
Subject: [PATCH v9 1/7] drm/xe: Always kill exec queues in xe_guc_submit_pause_abort
Date: Tue, 10 Mar 2026 18:50:33 -0400
Message-Id: <20260310225039.1320161-2-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310225039.1320161-1-zhanjun.dong@intel.com>
References: <20260310225039.1320161-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D894225915D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224596-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

From: Matthew Brost <matthew.brost@intel.com>

xe_guc_submit_pause_abort is intended to be called after something
disastrous occurs (e.g., VF migration fails, device wedging, or driver
unload) and should immediately trigger the teardown of remaining
submission state. With that, kill any remaining queues in this function.

Fixes: 7c4b7e34c83b ("drm/xe/vf: Abort VF post migration recovery on failure")
Cc: stable@vger.kernel.org
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index ca7aa4f358d0..b31e0e0af5cb 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2763,8 +2763,7 @@ void xe_guc_submit_pause_abort(struct xe_guc *guc)
 			continue;
 
 		xe_sched_submission_start(sched);
-		if (exec_queue_killed_or_banned_or_wedged(q))
-			xe_guc_exec_queue_trigger_cleanup(q);
+		guc_exec_queue_kill(q);
 	}
 	mutex_unlock(&guc->submission_state.lock);
 }
-- 
2.34.1


