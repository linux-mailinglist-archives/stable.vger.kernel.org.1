Return-Path: <stable+bounces-215577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOlAFxiDimlaLQAAu9opvQ
	(envelope-from <stable+bounces-215577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:00:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF9115E10
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5EF3300692F
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 01:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10A262808;
	Tue, 10 Feb 2026 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6szORnG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACC24468B;
	Tue, 10 Feb 2026 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770685203; cv=none; b=f4YJTzz68Rrib0ACD2gCZ+qbOBhQVlZ9dqM5KccTHOOkEww9m+wFAYQLQam6RjwT5wqku7fDIQIoVqtsuO7O5nLkV5yf9NaUcDqGbjyOhZ1TISInxuOikp5WbGr67bjWlqn5uu+hc+7wr4s1eLqcwoyM04k6IVleFDZz/Loh2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770685203; c=relaxed/simple;
	bh=f7KaVYORxj9M7EdJPJflrezD2xBqdlhlpP8CvhFo0To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7b8RITG024jmZUlebSK2hmi9ulT4xylt6snL7W9Tp7ioGrbHnEhOBi3O+ogsAe/zHsqyr2NGXrdnTZGoi8OUXz8q2QDLtGemvFtOR+M0kWMQ4IVCnuKtU+V6tInEp+qxC08KXn1JdX8T8glhsOpUY6xXi/aeCJwIIaIYV8KKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6szORnG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770685202; x=1802221202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f7KaVYORxj9M7EdJPJflrezD2xBqdlhlpP8CvhFo0To=;
  b=K6szORnGFxC89kiECjgMsOCMXhEUoRabGjeWLptBk0/f1W80xlXMbs7Y
   lYCAz7Pwcvr9zTx8lUVMmTzzqCGaXOB876k3Vwqx3qWDP9+sn9CWWRj2T
   gbQ7hpYib2cMo1d/zqjtJFsSXl+z1/JSc/4fBhPQzUnCm9yWd6kYPYHc/
   v+GQ8tsJFsE8szdIQY+tn6adMx8GJq2FEfTEi9NiZL+KuBiXuOVdlAEhs
   7JMFCi0huGinr2kSB2GChxhFqAHCbSVPJk+j/iFaUR44jT7kmYQAklb5N
   L3exMdzT1N3C3+yue+jZKlYYk7tlpnzrJPkAptXZqDEj9rpqFJ289/l5Z
   g==;
X-CSE-ConnectionGUID: a/NfNcEXTVeWvC0FZAwkSg==
X-CSE-MsgGUID: Kd/Z8k5xRq6b3I5g2zSkHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71907363"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71907363"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 17:00:01 -0800
X-CSE-ConnectionGUID: kw5CcZapS+acpGVAbbA9Jg==
X-CSE-MsgGUID: vGVT8iykS2CbjOpGd5JHpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211773536"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 17:00:01 -0800
From: Zide Chen <zide.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Babu Moger <babu.moger@amd.com>,
	Tony luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Add per-scheduler IMC CAS count events
Date: Mon,  9 Feb 2026 16:52:25 -0800
Message-ID: <20260210005225.20311-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215577-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zide.chen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50AF9115E10
X-Rspamd-Action: no action

IMC on SPR and EMR does not support sub-channels.  In contrast, CPUs
that use gnr_uncores[] (e.g. Granite Rapids and Sierra Forest)
implement two command schedulers (SCH0/SCH1) per memory channel,
providing logically independent command and data paths.

Do not reuse the spr_uncore_imc[] configuration for these CPUs.
Instead, introduce a dedicated gnr_uncore_imc[] with per-scheduler
events, so userspace can monitor SCH0 and SCH1 independently.

On these CPUs, replace cas_count_{read,write} with
cas_count_{read,write}_sch{0,1}.  This may break existing userspace
that relies on cas_count_{read,write}, prompting it to switch to the
per-scheduler events, as the legacy event reports only partial
traffic (SCH0).

Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Fixes: 632c4bf6d007 ("perf/x86/intel/uncore: Support Granite Rapids")
Fixes: cb4a6ccf3583 ("perf/x86/intel/uncore: Support Sierra Forest and Grand Ridge")
Cc: stable@vger.kernel.org
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e513056f4562..b78a1782fc39 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6640,6 +6640,32 @@ static struct intel_uncore_type gnr_uncore_ubox = {
 	.attr_update		= uncore_alias_groups,
 };
 
+static struct uncore_event_desc gnr_uncore_imc_events[] = {
+	INTEL_UNCORE_EVENT_DESC(clockticks,      "event=0x01,umask=0x00"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch0,  "event=0x05,umask=0xcf"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch0.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch0.unit, "MiB"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch1,  "event=0x06,umask=0xcf"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch1.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch1.unit, "MiB"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch0, "event=0x05,umask=0xf0"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch0.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch0.unit, "MiB"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch1, "event=0x06,umask=0xf0"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch1.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch1.unit, "MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_type gnr_uncore_imc = {
+	SPR_UNCORE_MMIO_COMMON_FORMAT(),
+	.name			= "imc",
+	.fixed_ctr_bits		= 48,
+	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
+	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
+	.event_descs		= gnr_uncore_imc_events,
+};
+
 static struct intel_uncore_type gnr_uncore_pciex8 = {
 	SPR_UNCORE_PCI_COMMON_FORMAT(),
 	.name			= "pciex8",
@@ -6687,7 +6713,7 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
 	NULL,
 	&spr_uncore_pcu,
 	&gnr_uncore_ubox,
-	&spr_uncore_imc,
+	&gnr_uncore_imc,
 	NULL,
 	&gnr_uncore_upi,
 	NULL,
-- 
2.52.0


