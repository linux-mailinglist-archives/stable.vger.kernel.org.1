Return-Path: <stable+bounces-214562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCQqBWgLhWmj7gMAu9opvQ
	(envelope-from <stable+bounces-214562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:28:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C56BF7A25
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7139D3036777
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 21:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC78330D2F;
	Thu,  5 Feb 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOWEHl+A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10715330B3B
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326750; cv=none; b=VayJ6NgUJJbTmFjGs5m/IXO9ZnkBa/h18MIPKXemHJetT0yeoMbJQNQESzAil2DjdhU7e/9Y0E9ZBniCexxPWlwhsmzfD8wyKaOiTioET4Wh+yZuTtNNpnoMb83pWJvhSpYc9x+5qATKaXHEuMIUVLSNw4gnEkt/eSZ8uthMvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326750; c=relaxed/simple;
	bh=aq8mpck+up1iv1hZ8FVfEEjSLsOONTGr15C7dLpkR+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XL+5a9ulXr+wiBXbstU2733B1oQcmCi21tM9q6cSylxXu/Dhod9wNpvveXM1mjU+Xom3Tg8el1VvFIDhLB+02T5kof5jwJI6NIVJCW8izxpC8dyVLNVDCikPzMF7L6TthevwNOCTYZuFfIiE7+MZ9mekHHw7gV2qKg12WsrWOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOWEHl+A; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770326750; x=1801862750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aq8mpck+up1iv1hZ8FVfEEjSLsOONTGr15C7dLpkR+Q=;
  b=DOWEHl+ALmCWyzVP1OD9cXJZiLZ1S7ljOZHtUuMtxtPqGqC7PLA7vx+i
   p5+eO2V7rIreJlVIae/bLc6KkVxCGODZniPy1IqeGxLRtsPWwTRbTYDQ2
   2LJp16uZRrScdpIbAwhrakREfVOf9VFeCqzzIdheqQRRXZ2FxpHaO0hxw
   cakmUOaOVDu/kwzpifCxzFvYxcTt4xZlsxvSmrQUmeCHNfFraYWnPxV0X
   fcOGa5OX3wx141AjcWEWY5dPVpmTmpP4slmsaoWuqP+lWKgCTNaNnpEyc
   fz7uP3S9Zg0n6yx8nCOUfiaYAsPs8aw4m8oTcqVcwbyHCenR95vOXt2qn
   w==;
X-CSE-ConnectionGUID: w+PTi76DTDegOh8yZzLb6w==
X-CSE-MsgGUID: iA9WL3eCTZ2i0lry5oPx1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71529183"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71529183"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:25:50 -0800
X-CSE-ConnectionGUID: EJozZNWdTH6KCCpUj/gfRw==
X-CSE-MsgGUID: 6SxbDbdSTSavmIAjnfOt0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215175699"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa005.fm.intel.com with ESMTP; 05 Feb 2026 13:25:49 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>,
	Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	nathan@kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 6.18 2/2] sched/fair: Have SD_SERIALIZE affect newidle balancing
Date: Thu,  5 Feb 2026 13:31:57 -0800
Message-Id: <d8d440fab07b7a8a2a675820aae237740df08cd8.1770326432.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1770326432.git.tim.c.chen@linux.intel.com>
References: <cover.1770326432.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214562-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.c.chen@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,infradead.org:email,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 6C56BF7A25
X-Rspamd-Action: no action

From: Peter Zijlstra <peterz@infradead.org>

[Upstream commit 522fb20fbdbe48ed98f587d628637ff38ececd2d]

Also serialize the possiblty much more frequent newidle balancing for
the 'expensive' domains that have SD_BALANCE set.

Initial benchmarking by K Prateek and Tim showed no negative effect.

Split out from the larger patch moving sched_balance_running around
for ease of bisect and such.

Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Seconded-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/df068896-82f9-458d-8fff-5a2f654e8ffd@amd.com
Link: https://patch.msgid.link/6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com

# Conflicts:
#	kernel/sched/fair.c
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3bf1bfd31877..327ef4bbe38b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11781,7 +11781,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		goto out_balanced;
 	}
 
-	if (!need_unlock && (sd->flags & SD_SERIALIZE) && idle != CPU_NEWLY_IDLE) {
+	if (!need_unlock && (sd->flags & SD_SERIALIZE)) {
 		int zero = 0;
 		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, &zero, 1))
 			goto out_balanced;
-- 
2.32.0


