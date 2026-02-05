Return-Path: <stable+bounces-214563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPKXODwLhWmj7gMAu9opvQ
	(envelope-from <stable+bounces-214563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:27:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCF8F7A06
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D90BA3024473
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 21:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626C3314D1;
	Thu,  5 Feb 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGjThKZ4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074E3314C2;
	Thu,  5 Feb 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326837; cv=none; b=e/76zR/lQuRojvG4RpxR1YhUN4WlPKjUZJzxwcI0hSCldaz0e9+VE1zSAQQwlBMLIDae4Ucqxap6tLkhMf59b4nXEatXAXYvEXuR3yFIBd6pAy+S7ClNqrvBBTrJH6oiRbfWOYJBMME45+K0E7rAdJ1RYz8r3ZlQpMsOE8EbGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326837; c=relaxed/simple;
	bh=F0OsRiumGCPR/F8lFe7rFbOQQOtUq7L2ZdEym/44wck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZLZLVp7Q6z60c+c8cq/9Zd1rsJue7EWOq8LMZOPvg4d2M5R2V9oEggMl6IR44h4MkPwumL/ibJ3cK/DvweTm1MJ8DF8/RyuFMqnI8atbTYrq1170yBu7RY1fOwJbtpZ8F+INi6Ql67o8865SeedqxjA1Rmd332C+Fb2QMv0Uu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGjThKZ4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770326838; x=1801862838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F0OsRiumGCPR/F8lFe7rFbOQQOtUq7L2ZdEym/44wck=;
  b=TGjThKZ4R3NIGhZ2P1LYA3mEYeAhCPmHTFVLEfLMYpf2Eg2FPALUVrLJ
   H6CO5STPMLPTbL0Q4xKR7mE6u1YfR4B9cZJcDM6n8kLFcRDhNugEW6Vkl
   GHJaOz6eO/eJMTSZi44VwQR+ZFapM5UbTvugH0CtoWAh6aPOLd695Ci0z
   mR/K63wH+hPauaUP1EZqh5UD4Hi5v9S+Quq+/RXPikTDSHVKu9GN28CcD
   nCEffbaGjAZSTMJyUtJUcOZdu6nKmpYHShkBdahKeGcZVNd3AepNDfbqY
   rgBe8Edz4OnC2eunYwsAwDVodUAE7VBHdaw6SISJMdzNqEUAoHrsGj77t
   A==;
X-CSE-ConnectionGUID: FmPdkZF5RpeR8PzDdouQ9w==
X-CSE-MsgGUID: fQN+yCLrQMKgBBbZ1yx/HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="75386232"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="75386232"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:27:17 -0800
X-CSE-ConnectionGUID: k530dzxVS8mHFc3ESPgWmA==
X-CSE-MsgGUID: Xl/hwu03RPqEHpX02k23EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="233617364"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 13:27:16 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 6.18 0/2] Fix NUMA sched domain build errors for GNR and CWF
Date: Thu,  5 Feb 2026 13:33:32 -0800
Message-Id: <cover.1768948644.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-214563-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.c.chen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 5BCF8F7A06
X-Rspamd-Action: no action

While testing Granite Rapids (GNR) and Clearwater Forest (CWF) systems
in SNC-3 mode, we encountered sched domain build errors in dmesg.
The scheduler domain code did not expect asymmetric node distances
from a local node to multiple nodes in a remote package. As a result,
remote nodes ended up being grouped partially with local nodes with
asymemtric groupings, and creating too many levels in the NUMA sched
domain hierarchy.

To address this, we simplify remote node distances for the purpose of
sched domain construction on GNR and CWF. Specifically, we replace the
individual distances to nodes within the same remote package with their
average distance. This resolves the domain build errors and reduces the
number of NUMA sched domain levels.

The actual SLIT NUMA node distances are still preserved separately, in
case they are needed when building sched domains. NUMA balancing
continues to use the true distances when selecting a closer remote node
for a task’s numa_group.

These patches have been merged upstream.

Thanks,
Tim

Tim Chen (2):
  sched: Create architecture specific sched domain distances
  sched/topology: Fix sched domain build error for GNR, CWF in SNC-3
    mode

 arch/x86/kernel/smpboot.c |  70 ++++++++++++++++++++++++
 kernel/sched/topology.c   | 108 ++++++++++++++++++++++++++++++--------
 2 files changed, 156 insertions(+), 22 deletions(-)

-- 
2.32.0


