Return-Path: <stable+bounces-215881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI77OKsAjWnAwwAAu9opvQ
	(envelope-from <stable+bounces-215881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 23:20:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3471F128125
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 23:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB30F30BC6AD
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 22:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB034575A;
	Wed, 11 Feb 2026 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtDS9XCw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833AB29D297
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848425; cv=none; b=XOIIIuVnw0YX8s15Y730HoCWKyOGDOC5ijnuIvYLF4breFIowg+zdfSmR+UllHFDAg4bnaJrUq1kzNuxjsgAxJxtPDIdQJ5m3zlCsICM3COZB7BEpBAyg6Jy1KY8QKnpmMm8f1EZqvFrkifNZkfxfhRSf3rQqBfT0QzfNCC4OX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848425; c=relaxed/simple;
	bh=QIdzlmeRuW02yxleV9RXkd4SZV/3Vp/4Ei7AIjsUXLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5gEPh3uAxJ2YU2d8Hj1HcZYNA1/ueQNCVu78oM9icyIgu3nbQGrNfdHlCtIZ/dtdUjD8lpB7bgUY6nHt3XtiaBPGA0rl65D1Myd0M7s3qd1bN14CR+UUHdNTfz9Dm+S5uESQp+Hjc7RaQ6CVegLWZ4IGXu8v7cHNp8Q/wi7CYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtDS9XCw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770848424; x=1802384424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QIdzlmeRuW02yxleV9RXkd4SZV/3Vp/4Ei7AIjsUXLo=;
  b=XtDS9XCwMpgZNW7iqfxEUo6HEsT/XBfO0XFnNZIKOZ7SSo9+mgbCtuh8
   +PX9UkFU+/bM3eSr7KAit777IBTRw7EXcbL3gGzEaSAhKcR6L+kIQcR06
   mgVylRfgv92iFkiZPzkrZ8fMuBS/7nQH63wNcqo+lYH1iqCZIg7GM9mlG
   rOkiVnaTXC0fe3Nod+hBPpy+dLzHJJzqYvKkP5hQnthakGAZtIUIkEaZM
   CteajJeM5OTIUTiZxRAMmuAjoOlUwrixDARvHIpZJD4k/InOwC1Ol/W3+
   54sPLRBAqgMAS4qdE7WtjacWToCmV+gvuQqR8VRltK6ETzqow9lQT5i5M
   g==;
X-CSE-ConnectionGUID: fFXY9gkLQ/ipmWbvLi8CgQ==
X-CSE-MsgGUID: Gb7smWx6RBGqVle5HbuQsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="89415208"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="89415208"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 14:20:23 -0800
X-CSE-ConnectionGUID: PSgv1R+CT7WVlOaTMpnHkw==
X-CSE-MsgGUID: gkVDmZFMS/G+SouVuBqNVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="212479573"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 14:20:23 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	Stuart Summers <stuart.summers@intel.com>
Subject: [PATCH v6 1/6] drm/xe: Always kill exec queues in xe_guc_submit_pause_abort
Date: Wed, 11 Feb 2026 17:20:15 -0500
Message-Id: <20260211222020.848341-2-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211222020.848341-1-zhanjun.dong@intel.com>
References: <20260211222020.848341-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215881-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3471F128125
X-Rspamd-Action: no action

From: Matthew Brost <matthew.brost@intel.com>

xe_guc_submit_pause_abort is intended to be called after something
disastrous occurs (e.g., VF migration fails, device wedging, or driver
unload) and should immediately trigger the teardown of remaining
submission state. With that, kill any remaining queues in this function.

Fixes: 7c4b7e34c83b ("drm/xe/vf: Abort VF post migration recovery on failure")
Cc: stable@vger.kernel.org
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index de716c1fb18e..42712acf2ec2 100644
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


