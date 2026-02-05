Return-Path: <stable+bounces-214560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FyGC2ELhWmj7gMAu9opvQ
	(envelope-from <stable+bounces-214560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:28:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0B7F7A1B
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2816A30338BC
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 21:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C62330D54;
	Thu,  5 Feb 2026 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5Q7ptp0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498E1A76BB
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326748; cv=none; b=smAsgTJdwNFTtoX/xqLBJSOoI3ZeUkBkcN9OTpI//av4kW599XZCnr00Jmk7puDbkt+PwmFTqO8lzwy3pRIkj8LtZ+TnOyGfFIsJi7Zpr1bPpaHq080ujT0661TRl67rQG1ItzkSqWopQcVj0HGVrb3Ckj50WpEAU2IWf8IgXzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326748; c=relaxed/simple;
	bh=T+xsP/3fml7WhRkdmRz4pmlMJefBxdAQn+mBHHSbBCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hqy96yKCdUwsci+QifxjIuFJJm5GbmQejLzU47p2lwGSKDXHln/txpYdHtPrB6Wp5zZnnc4A4WGFdN6xZtYByDi7bSNlmQozJE58QCQ5/6dOUQj1/tcCyeK6bzebvCW8o4c0oluarPaBTYAobkjVjHsdEJjnpqvTcRnTf/nUwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5Q7ptp0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770326748; x=1801862748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T+xsP/3fml7WhRkdmRz4pmlMJefBxdAQn+mBHHSbBCE=;
  b=c5Q7ptp0AbyZtQVjXcQsdHE2mjzwUBRCLiJO2iI1IpQGkEtv/HVUJ0Pp
   PnzocMFK/LkUJJyOYXtzGUU2HI71WUvNbB4B3ZIHghYk0+O1y4qhLnDE/
   LckqlFwbb8jAHLdyRqdHMnikR0sRfTVSlhyYHTtQXDdV/3Hv+kv1RQdUw
   VFVthFBgwSwK+kApTJ8NVBPoIvk5QNiV7xbwGRmA/TtuxAbLQA2CEMpgw
   Wi8vRoXzctxWt2xyjwL05piAtfi3H7l+WT0f2SBhl5fRfh5AEHMWGZDnd
   2CpZw83WDBSWTZM38dgh+p/1HPfxaXiFiqCqgUY5R0oyGfXV44kDSMgBx
   A==;
X-CSE-ConnectionGUID: oLuJVnO5QQy1CRk/vJw3NA==
X-CSE-MsgGUID: GenmAsoTTs6rv3/xaWCZNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71529145"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71529145"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:25:47 -0800
X-CSE-ConnectionGUID: MuBJFfPfSliQwSQUQFcEvg==
X-CSE-MsgGUID: P/8uF3qkR+GRiVPVek+pRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215175676"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa005.fm.intel.com with ESMTP; 05 Feb 2026 13:25:46 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>,
	Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	nathan@kernel.org
Subject: [PATCH 6.18 0/2] Acquire sched_balance_running only when needed 
Date: Thu,  5 Feb 2026 13:31:55 -0800
Message-Id: <cover.1770326432.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.c.chen@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214560-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 7D0B7F7A1B
X-Rspamd-Action: no action

Balancing sched domains NUMA and above are serialized.
Currently, multiple sched group leader directly under NUMA domain could
attempt to acquire the global sched_balance_running flag via cmpxchg() before
checking whether load balancing is due. Fix unnecessary
sched_balance_running acquisition and also put newidle balance
properly in serialization.  This improves performance for OLTP workload
on large core count machines.

These patches have been merged upstream.

Thanks.

Tim

Peter Zijlstra (1):
  sched/fair: Have SD_SERIALIZE affect newidle balancing

Tim Chen (1):
  sched/fair: Skip sched_balance_running cmpxchg when balance is not due

 kernel/sched/fair.c | 54 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

-- 
2.32.0


