Return-Path: <stable+bounces-270115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k6ZsOE/CRGqn0QoAu9opvQ
	(envelope-from <stable+bounces-270115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 09:31:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1D86EAA85
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 09:31:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GpCd+XdB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270115-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270115-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F085C301750B
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A453B47DF;
	Wed,  1 Jul 2026 07:30:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28D37AA81
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 07:30:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891043; cv=none; b=UXBCC+wACOYUSATGOcnkXwSgiaiVpvMWoQ3loKo1TqHslQnEUF7ucgmxDvlIlg0J1Q0EiMpRTdcFWzmv72gyuXTC935/FFm436g90ra+gCbNL+FFOv565D5oLfM/N4so0vFJoE16FkLIePqrmILM/XNwVXwhhDKdVP24dmOT/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891043; c=relaxed/simple;
	bh=OYZHIPEYhfsH8T3WnWawsBUJdLa7fxv2rMb2oeqcjf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUxuX03KgcPTCJ8A6gsFBhVU5uydQGX/werkQpqD6P552n182Ts+j9jNRlFlCyZs15QheNEJ4J5ZqJ+Dz88oUH5HtPP2mZtzVbHaLqc2+HF6cfGB+cIADUKLnMaZ+ohso6XUkD/KgGDUO7QVf3ekFH8VI9ipYDt5/2WesHSaSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpCd+XdB; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782891041; x=1814427041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OYZHIPEYhfsH8T3WnWawsBUJdLa7fxv2rMb2oeqcjf4=;
  b=GpCd+XdBX2A3evL7kB5aLasNMspqJesyS/itM1KfFkMIu4zWD5t5vKU7
   GvZZ7qN/oLlJs50vmi8uS5Rruz2tLun6Tdu+uKWFTttkSyOOvHLQ4V0tT
   EBYQkCGJo3HEjbrn8e9NCv3cwZYuRdBCJruE6ELwMZsO8tPYGdQxUjpYg
   e0dlT3MSlASU1UzXt7V7l3Ivp6QlD667uinGvRFtAfN1iMWOWqz0uzmsD
   Ac7I/tivvojSeReB8NuPlqXeHGsg3k1bALGCLhXknC1Ewf9soehG4Z0ac
   xowlFdD+SuIibhm8iG/82/CJBRyuBln8qv/Eh0dtl/5D/Sc2Q12DlaXAj
   g==;
X-CSE-ConnectionGUID: TImtRMpjSSytqPa3OSD2ew==
X-CSE-MsgGUID: wlVqZtkZSwu3rmprBok7Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94996795"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="94996795"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:30:40 -0700
X-CSE-ConnectionGUID: IEWKBaZ+TW+Od+RCPtAZMQ==
X-CSE-MsgGUID: jDGjoYNlTJmF5eatM12dSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="276792913"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:30:37 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development <dri-devel@lists.freedesktop.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gem: Do not leak siblings[] on proto context error
Date: Wed,  1 Jul 2026 10:30:30 +0300
Message-ID: <20260701073030.44850-1-joonas.lahtinen@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270115-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:joonas.lahtinen@linux.intel.com,m:martin.hodo@intel.com,m:faith.ekstrand@collabora.com,m:simona.vetter@ffwll.ch,m:tvrtko.ursulin@igalia.com,m:maarten.lankhorst@linux.intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,intel.com:dkim,intel.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,collabora.com:email,ffwll.ch:email,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C1D86EAA85

After a successful BALANCE/PARALLEL_SUBMIT extension on context
creation, error during processing of next user extension leaks
the siblings[] array. Fix that.

Discovered using AI-assisted static analysis confirmed by
Intel Product Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 22 +++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index aeafe1742d30..87fce2adfeef 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -769,8 +769,8 @@ static int set_proto_ctx_engines(struct drm_i915_file_private *fpriv,
 		struct intel_engine_cs *engine;
 
 		if (copy_from_user(&ci, &user->engines[n], sizeof(ci))) {
-			kfree(set.engines);
-			return -EFAULT;
+			err = -EFAULT;
+			goto err;
 		}
 
 		memset(&set.engines[n], 0, sizeof(set.engines[n]));
@@ -786,8 +786,8 @@ static int set_proto_ctx_engines(struct drm_i915_file_private *fpriv,
 			drm_dbg(&i915->drm,
 				"Invalid engine[%d]: { class:%d, instance:%d }\n",
 				n, ci.engine_class, ci.engine_instance);
-			kfree(set.engines);
-			return -ENOENT;
+			err = -ENOENT;
+			goto err;
 		}
 
 		set.engines[n].type = I915_GEM_ENGINE_TYPE_PHYSICAL;
@@ -800,15 +800,21 @@ static int set_proto_ctx_engines(struct drm_i915_file_private *fpriv,
 					   set_proto_ctx_engines_extensions,
 					   ARRAY_SIZE(set_proto_ctx_engines_extensions),
 					   &set);
-	if (err) {
-		kfree(set.engines);
-		return err;
-	}
+	if (err)
+		goto err_extensions;
 
 	pc->num_user_engines = set.num_engines;
 	pc->user_engines = set.engines;
 
 	return 0;
+
+err_extensions:
+	for (n = 0; n < set.num_engines; n++)
+		kfree(set.engines[n].siblings);
+err:
+	kfree(set.engines);
+
+	return err;
 }
 
 static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
-- 
2.54.0


