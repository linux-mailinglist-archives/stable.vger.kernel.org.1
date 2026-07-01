Return-Path: <stable+bounces-270149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wplZKBj+RGqv4goAu9opvQ
	(envelope-from <stable+bounces-270149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 13:46:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8D6ECF45
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 13:46:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MPBrgAU6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270149-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270149-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D92C3067C8A
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E727948094F;
	Wed,  1 Jul 2026 11:45:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86843C060F
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:45:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906328; cv=none; b=EGkscl2s2dqRM5o1pGs3497y2TfF+MyHHwoldsrVlHfX77ZnSwVl49rRtn5ujh8RNXab+JMrzQD9coOunPF+q82yCt43i2u7g9imk/89GsNwttvfG2wGNlKI17gkFNanOuTu6J5+nbnVwM7E7KBYxodLh99kPZFLBfhYWPtM7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906328; c=relaxed/simple;
	bh=yY++beBrEYp8b4rwSg/82vP/T0D2SHR5CaVAZG/7az4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3d36j4xhi+6x84/YXfqAW6R7hVXpEDHQqMRW83h2bKzj1TP/hGtPitkY07AsnY6cOIQORxy/zjppnaIjVZpMoObV5/RPOzmZMgJUyO37DtTvsp+RfYxTxTo8fVYgzg6wcDDF4IoBAJRGv5hqghDBkNfZ00aTEMDMFhtNVl7PY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPBrgAU6; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782906327; x=1814442327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yY++beBrEYp8b4rwSg/82vP/T0D2SHR5CaVAZG/7az4=;
  b=MPBrgAU64VnLMcAo8043Qg8nnjLPyPNR8Gn7mnDXzaTJikinwY+nhdNP
   ayTwbuvW4Dt3oC6Bn5Kp3bU6yqUc2MEGVTn73sjL0HWAf7pcVQu5Nfoa3
   TXyGn2FkdrBHxNMyJCSAK33QUs8G7qNIu/hQarm9NuPKI5VeRLqLftypm
   VUSzW6GmgSihTgSfOejWSoi+sEPmGUMqsWgH0YSlBhNCt8aC9zQwlmWXr
   PQsn2/oU53htOtJ0anj1xfH6KCzcQYVJE9p8PoZZVKbUC0Jx5Go9VCqq8
   /d+ORGPzGb9tlZiHjKG9vtpFvcwQEbGOgyHuTrcZTj2pQO8LzOTtm6R0N
   g==;
X-CSE-ConnectionGUID: udQNKtExRBasMnL4xqlOyQ==
X-CSE-MsgGUID: qOCxqBRGQs2blxvFEWUidw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="95020789"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="95020789"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:45:26 -0700
X-CSE-ConnectionGUID: txcxdr6OQl+SOyVeOyJJZA==
X-CSE-MsgGUID: pZg1y71zTeOU2DrmG8tHGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="282622128"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:45:23 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development <dri-devel@lists.freedesktop.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Fix NULL deref on sched_engine alloc failure
Date: Wed,  1 Jul 2026 14:45:13 +0300
Message-ID: <20260701114513.221254-1-joonas.lahtinen@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270149-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:joonas.lahtinen@linux.intel.com,m:martin.hodo@intel.com,m:matthew.brost@intel.com,m:daniele.ceraolospurio@intel.com,m:tursulin@ursulin.net,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FD8D6ECF45

Avoid using intel_context_put() before intel_context_init() in
execlists_create_virtual() as the kref_put() inside would lead
to NULL deref on the IOCTL path when sched_engine allocation fails.

Discovered using AI-assisted static analysis confirmed by
Intel Product Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 3e28d37146db ("drm/i915: Move priolist to new i915_sched_engine object")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 .../drm/i915/gt/intel_execlists_submission.c  | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 1359fc9cb88e..e693b0c9d2a3 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -3932,11 +3932,11 @@ execlists_create_virtual(struct intel_engine_cs **siblings, unsigned int count,
 	struct drm_i915_private *i915 = siblings[0]->i915;
 	struct virtual_engine *ve;
 	unsigned int n;
-	int err;
+	int err = -ENOMEM;
 
 	ve = kzalloc_flex(*ve, siblings, count);
 	if (!ve)
-		return ERR_PTR(-ENOMEM);
+		goto err;
 
 	ve->base.i915 = i915;
 	ve->base.gt = siblings[0]->gt;
@@ -3968,10 +3968,8 @@ execlists_create_virtual(struct intel_engine_cs **siblings, unsigned int count,
 	intel_engine_init_execlists(&ve->base);
 
 	ve->base.sched_engine = i915_sched_engine_create(ENGINE_VIRTUAL);
-	if (!ve->base.sched_engine) {
-		err = -ENOMEM;
-		goto err_put;
-	}
+	if (!ve->base.sched_engine)
+		goto err_noput;
 	ve->base.sched_engine->private_data = &ve->base;
 
 	ve->base.cops = &virtual_context_ops;
@@ -3987,10 +3985,8 @@ execlists_create_virtual(struct intel_engine_cs **siblings, unsigned int count,
 	intel_context_init(&ve->context, &ve->base);
 
 	ve->base.breadcrumbs = intel_breadcrumbs_create(NULL);
-	if (!ve->base.breadcrumbs) {
-		err = -ENOMEM;
+	if (!ve->base.breadcrumbs)
 		goto err_put;
-	}
 
 	for (n = 0; n < count; n++) {
 		struct intel_engine_cs *sibling = siblings[n];
@@ -4065,8 +4061,13 @@ execlists_create_virtual(struct intel_engine_cs **siblings, unsigned int count,
 	virtual_engine_initial_hint(ve);
 	return &ve->context;
 
+err_noput:
+	kfree(ve);
+	goto err;
+
 err_put:
 	intel_context_put(&ve->context);
+err:
 	return ERR_PTR(err);
 }
 
-- 
2.54.0


