Return-Path: <stable+bounces-232638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAjsBntwzGnJSwYAu9opvQ
	(envelope-from <stable+bounces-232638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:10:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 806B4373613
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8823028EFD
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 01:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DFC27EFF7;
	Wed,  1 Apr 2026 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kos11N42"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A472AE68;
	Wed,  1 Apr 2026 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005669; cv=none; b=REes9E4AZkFnbpkh50V5o8gmcoxKAcIWLZjvd4Vi1EtC0I6Izl0Njn9bqYlq9GA5HduMxCge/zWjFHd+H7MDciGwh/MU/p6sqvEjj7UUZpafOAgpFOB21Q3JNpgUVHm7xCYMx6Qz4/elzU6Y4yGeV7mWj3ElalpfxQ22GI9Mb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005669; c=relaxed/simple;
	bh=GLAKlABRqthQzbsSCazQZWFbmhY4kPHJe9oDq89F8xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JvXX2OgyT6QoOfzS6rFkkyACQ3x9dPniu6GXindgeQIjM71yWq1h3FbrStEw6w4spftmBTii92aBneglk9CbfQQCWG6+Lk9i1DT2CTwfGMeivOEGLgfBzI3CGuj6MKw6+SYQxs6WZTshUfdAODFLtVovpvjGZZyFVxKrTF9V4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kos11N42; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775005667; x=1806541667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GLAKlABRqthQzbsSCazQZWFbmhY4kPHJe9oDq89F8xc=;
  b=Kos11N42iF5+VwoZRFuCU22/FDRDzGifGch/yduwvJoebNtl1a4gRYnE
   vyuU1XkXYCPpqnaxdDMTKaS6KyJ/rxOYw8NBrA687l5liOQlE+q/pxd5d
   HMYrDSOSQjfl51VoUC7bwyzMu29TQLk57IkWMYPMdI6+mwFoCbpa5/Qj1
   tydQA2F2c2wHC+9Ud4sadDqYFxJcDdePV534QQCsFw3/usLH7fZ8RdhTG
   BJVtPV21NwQiuljY8F/nz+BEhhxz4jmz1oUxBg9xxMjWBeAOoGwB3tPvi
   431sWMqHn7N3oHxbypBRbRLkJ/ckOP+jM8OLY3iCkEFt3X3jw9flVvE3d
   Q==;
X-CSE-ConnectionGUID: rLZbCrbCQz+MNBd5rDpslw==
X-CSE-MsgGUID: 7hHzCZjhS+OlfW4kFDHUkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75918655"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75918655"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 18:07:46 -0700
X-CSE-ConnectionGUID: B1AUn3utTvWGeRd8hOwkcg==
X-CSE-MsgGUID: i2ctNmmjTXeAUvQ400KjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="222132370"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 18:07:45 -0700
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
Subject: [PATCH v2] workqueue: Add pool_workqueue to pending_pwqs list when unplugging multiple inactive works
Date: Tue, 31 Mar 2026 18:07:39 -0700
Message-Id: <20260401010739.1053192-1-matthew.brost@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,google.com,vger.kernel.org,kernel.org,gmail.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232638-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 806B4373613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In unplug_oldest_pwq(), the first inactive work item on the
pool_workqueue is activated correctly. However, if multiple inactive
works exist on the same pool_workqueue, subsequent works fail to
activate because wq_node_nr_active.pending_pwqs is empty — the list
insertion is skipped when the pool_workqueue is plugged.

Fix this by checking for additional inactive works in
unplug_oldest_pwq() and updating wq_node_nr_active.pending_pwqs
accordingly.

v2:
 - Use pwq_activate_first_inactive(pwq, false) rather than open coding
   list operations (Tejun)

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
 kernel/workqueue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b77119d71641..bee3f37fffde 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1849,8 +1849,17 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
 	raw_spin_lock_irq(&pwq->pool->lock);
 	if (pwq->plugged) {
 		pwq->plugged = false;
-		if (pwq_activate_first_inactive(pwq, true))
+		if (pwq_activate_first_inactive(pwq, true)) {
+			/*
+			 * pwq is unbound. Additional inactive work_items need
+			 * to reinsert the pwq into nna->pending_pwqs, which
+			 * was skipped while pwq->plugged was true. See
+			 * pwq_tryinc_nr_active() for additional details.
+			 */
+			pwq_activate_first_inactive(pwq, false);
+
 			kick_pool(pwq->pool);
+		}
 	}
 	raw_spin_unlock_irq(&pwq->pool->lock);
 }
-- 
2.34.1


