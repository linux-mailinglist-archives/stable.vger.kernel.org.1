Return-Path: <stable+bounces-232595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMg6FbxIzGmmSAYAu9opvQ
	(envelope-from <stable+bounces-232595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:20:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13E3725D8
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B923046E93
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494B45BD67;
	Tue, 31 Mar 2026 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esdDgrvC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499B346AD7;
	Tue, 31 Mar 2026 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995526; cv=none; b=RlnuqnyJ2GJBTcSFdnkiTRmXrIRdASoB4nhAB9joxovC6HyRrpzogoUkfO6JvIotAJ5QdEwem24p0ckLlc3wscm2lWck0ei9TOlorOMT6j67sdgsXGPYebBbtfPAjHEwB+H0gDWH8SkMPZLG0/DazGS+hCyc5XYHCl8pkslW0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995526; c=relaxed/simple;
	bh=wUdaIIELWJl+i7uH46Ifi81pzzNyIffVW8w36LxytFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D4MHjfXv1Dz5MRusVQ+5TKkZrDk1FK3iVf8+bSkTQTN9mLuR8Yd5XFqVQoLpaQnWA2e6LNjRkvV+pZcTE+Bnu2cEEn5rZYztv7AwCyo/Wysl5YkI/6QKLMekBoRBlVDndnXuty1hrDOYWw7LqKiGNHGazT6cEBv40j9gPvPt3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esdDgrvC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774995525; x=1806531525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wUdaIIELWJl+i7uH46Ifi81pzzNyIffVW8w36LxytFw=;
  b=esdDgrvCmxvga0NPVS0jm53qJelONBCjpCSjoRI9b6pywYs84qGgXmo+
   3JVt6aqTSArztaZr64bpk6SEDfGNK54pQTnbmSFFj/4RuvwC637Ql3zXW
   yLjlDYoufuptKoGXh3brDvMW/7vBZjtzmonH0/zfPPBzYT4fmEllQYn07
   rLLY/WcKSsDGQzdVPkU7xdPBFo70jsGrThoXa/un3t3VO2jXivG/mE9sx
   dV0gCx4jqgR68DTF6VQ8ckS80beDqTYejKF+TS7SlaF5w4GJQK1HpbluH
   Xs5Sqb8PLQ6UmuWqFwL2lVSj2LOB9A6bD4QLMAvL/g8bB66yjVpE0R4BB
   Q==;
X-CSE-ConnectionGUID: lMH+abpSRUCBRLgEixH7Ug==
X-CSE-MsgGUID: 4DRMpt7XTTCOLNYD6V8oRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87416319"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87416319"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:18:44 -0700
X-CSE-ConnectionGUID: auU7s6NqTF+xcTm0JNyBkA==
X-CSE-MsgGUID: thBuCzoaRAiTE/lR+URFNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="225668430"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:18:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Carlos Santa <carlos.santa@intel.com>,
	Ryan Neph <ryanneph@google.com>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] workqueue: Add pool_workqueue to pending_pwqs list when unplugging multiple inactive works
Date: Tue, 31 Mar 2026 15:18:39 -0700
Message-Id: <20260331221839.1033423-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,google.com,vger.kernel.org,kernel.org,gmail.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232595-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC13E3725D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In unplug_oldest_pwq(), the first inactive pool_workqueue is activated
correctly. However, if multiple inactive works exist on the same
pool_workqueue, subsequent works fail to activate because
wq_node_nr_active.pending_pwqs is empty — the list insertion is skipped
when the pool_workqueue is plugged.

Fix this by checking for additional inactive works in
unplug_oldest_pwq() and updating wq_node_nr_active.pending_pwqs
accordingly.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Fixes: 4c065dbce1e8 ("workqueue: Enable unbound cpumask update on ordered workqueues")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

This bug was first reported by Google, where the Xe driver appeared to
hang due to a fencing signal not completing. We traced the issue to work
items not being scheduled, and it can be trivially reproduced on drm-tip
with the following commands:

shell0:
for i in {1..100}; do echo "Run $i"; xe_exec_threads --r \
threads-rebind-bindexecqueue; done

shell1:
for i in {1..1000}; do echo "toggle $i"; echo f > \
/sys/devices/virtual/workqueue/cpumask; echo ff > \
/sys/devices/virtual/workqueue/cpumask; echo fff > \
/sys/devices/virtual/workqueue/cpumask ; echo ffff > \
/sys/devices/virtual/workqueue/cpumask; sleep .1; done
---
 kernel/workqueue.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b77119d71641..b2cdb44ccb56 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1849,8 +1849,20 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
 	raw_spin_lock_irq(&pwq->pool->lock);
 	if (pwq->plugged) {
 		pwq->plugged = false;
-		if (pwq_activate_first_inactive(pwq, true))
+		if (pwq_activate_first_inactive(pwq, true)) {
+			if (!list_empty(&pwq->inactive_works)) {
+				struct worker_pool *pool = pwq->pool;
+				struct wq_node_nr_active *nna =
+					wq_node_nr_active(wq, pool->node);
+
+				raw_spin_lock(&nna->lock);
+				if (list_empty(&pwq->pending_node))
+					list_add_tail(&pwq->pending_node,
+						      &nna->pending_pwqs);
+				raw_spin_unlock(&nna->lock);
+			}
 			kick_pool(pwq->pool);
+		}
 	}
 	raw_spin_unlock_irq(&pwq->pool->lock);
 }
-- 
2.34.1


