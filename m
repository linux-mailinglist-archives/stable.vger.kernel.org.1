Return-Path: <stable+bounces-217489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KsEG01Rl2nswwIAu9opvQ
	(envelope-from <stable+bounces-217489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:07:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B2D161781
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32673302812B
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C134FF78;
	Thu, 19 Feb 2026 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFnHLGds"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904D334C05
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524425; cv=none; b=Ft3qwHoH3/YJ4KX+KS9mN2na998y1z/loZ3OhGYTp38i48PPQTMQZfjyEmGM/5Qek8nRCOo3c4/OlzqhbKHMh5z0Qdc2db1SbztFlA9le1h6vN3kbd0xFGqu5CG7qL/xnCc73dQBKx1/Rw1MnSGB6GYdA+RDc8m7SEYjxyCDFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524425; c=relaxed/simple;
	bh=QIdzlmeRuW02yxleV9RXkd4SZV/3Vp/4Ei7AIjsUXLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCpMlTnzQObL9JLADS7t1yeMDSrRUq1HKUwg2zrxrroVvXPqAHtCG0dsCyIaR8i1rDmk3fNKsfJh94LyH0MLtGEpYS/6cfD5zrw0iU3YfeKNrSWVGwn92kM2FQsO3a2VsNeTyhFfvahc4eCb89X865hUCA2FDILe6O9DTgwwJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFnHLGds; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771524424; x=1803060424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QIdzlmeRuW02yxleV9RXkd4SZV/3Vp/4Ei7AIjsUXLo=;
  b=BFnHLGds5n4oL7VkyCI1QgcFBRTxW9zm5Oc6F7OemEr5DJkUqJl8HlzU
   goIFcAnuIqEgS9V/tyNcrtKjwdyXNczcLX3yAAar/OxIK5WvAFYrf5iV7
   NLW3LJO39eguLdspY9nn00nxriIvB3ORyoxYwKKY8s1AIuQJ+oNLV1FY0
   QMwdhl6k+spdBBo9uV0fr+zLjCDPcVu9793hBYCWjUySx0OZHvkNbP7Ue
   z2aVaLEU9nS9Cz8N2uv/qFsw5HFLHSHpnaZxbKhcnGwo5Qooaf7a0YjoZ
   ScCOJsjjRmPdUk3Lxi6VCAfTQfDSa46frJurM3cFhV6twoDu4EY7n3A6e
   Q==;
X-CSE-ConnectionGUID: 0/X+Nk3IQVi5frz5MFGtHA==
X-CSE-MsgGUID: PfJV+gcjSvC5qgrlQsQMlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76482812"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76482812"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:07:03 -0800
X-CSE-ConnectionGUID: zAodoqX7RFe/mi3qygbY9A==
X-CSE-MsgGUID: FQOP7MgsS92zsAkqgPQ3mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="245189015"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa002.jf.intel.com with ESMTP; 19 Feb 2026 10:07:03 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Wajdeczko@web.codeaurora.org,
	Michal <Michal.Wajdeczko@intel.com>,
	Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	Stuart Summers <stuart.summers@intel.com>
Subject: [PATCH v7 1/7] drm/xe: Always kill exec queues in xe_guc_submit_pause_abort
Date: Thu, 19 Feb 2026 13:06:55 -0500
Message-Id: <20260219180701.2418453-2-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219180701.2418453-1-zhanjun.dong@intel.com>
References: <20260219180701.2418453-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[intel.com:s=Intel];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217489-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:email]
X-Rspamd-Queue-Id: A8B2D161781
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


