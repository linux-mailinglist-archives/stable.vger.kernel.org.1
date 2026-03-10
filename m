Return-Path: <stable+bounces-223982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPd7KLz9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7AF24A4CB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 455DF31A9E83
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82136EA89;
	Tue, 10 Mar 2026 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPLz0pcr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F682D24B7;
	Tue, 10 Mar 2026 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141115; cv=none; b=Oha5DIFM475OqTrg2gIKiVE0l0/sUgkSaAwLJEhmM9gdMwEHnl3jQv4f6cxbuaEsYRp1KsMXPweGEFV6JWES5yAFMhUxNPrXZAmdzNmD17OOXLZNRYRXMJ8cescAEdb+uc/ZQoBw0sAOkZfFvSzAug4QVP99MymDrgP/hMDUj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141115; c=relaxed/simple;
	bh=2pPWkafpi+YBDiCbZW/4MEOkpfB+X4nUw2i7lZU/KqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1onHLb1xsqWHZsYqwQej/Azv3wXgHJAMjojxaHS2lI4gOisyEWcYsrm/6hDvp1LEphD54n8kbQmolR4Uu3KerSgtKL4nTVwp6cXqS3a02yIwUD+9XR5nLAGLDxA4VH+EpmLhUShhaZHqso/tmeEL4Aix9j2RdgTAmutsfC6lTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPLz0pcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56E7C2BC86;
	Tue, 10 Mar 2026 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141115;
	bh=2pPWkafpi+YBDiCbZW/4MEOkpfB+X4nUw2i7lZU/KqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPLz0pcr/zyDF3KqxFsaQbot4O0IWYGbwHBZbc6/1GjrOtAr+Tbs8F3guYDlEb5Bv
	 0E7JTu8XNHOUvvViyq7w+iq+5CyTz84fWsz2tnmVbbVn8Xf3bSWXeOzcWwjw3JwtI1
	 BnYsKPYKQmWY3LPpY/+v9FjaW4Z6Z0F6INRRCTFDkwLtMq8C2tef7MiNRh3flFcklP
	 Gbq6bLga/qD4EoYUiP++EH1gMUfnQRLdTZOWH2reMzvSBZBtIO7Wm94li4wJhW8rFI
	 pi+IoAsuM/6I4I+WGUj/iIckmGm9H22l+JYTJziocrZl0es4tUqklzAyHUAtku1vKu
	 g93g5BzBPUU6Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zide Chen <zide.chen@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 117/311] perf/x86/intel/uncore: Add per-scheduler IMC CAS count events
Date: Tue, 10 Mar 2026 07:02:44 -0400
Message-ID: <3c609e10b02360974f3057e444313316e7e65619.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA7AF24A4CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223982-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:email,msgid.link:url,infradead.org:email]
X-Rspamd-Action: no action

From: Zide Chen <zide.chen@intel.com>

commit 6a8a48644c4b804123e59dbfc5d6cd29a0194046 upstream.

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

Fixes: 632c4bf6d007 ("perf/x86/intel/uncore: Support Granite Rapids")
Fixes: cb4a6ccf3583 ("perf/x86/intel/uncore: Support Sierra Forest and Grand Ridge")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260210005225.20311-1-zide.chen@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/uncore_snbep.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e1f370b8d065f..a338ee01bb242 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6610,6 +6610,32 @@ static struct intel_uncore_type gnr_uncore_ubox = {
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
@@ -6657,7 +6683,7 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
 	NULL,
 	&spr_uncore_pcu,
 	&gnr_uncore_ubox,
-	&spr_uncore_imc,
+	&gnr_uncore_imc,
 	NULL,
 	&gnr_uncore_upi,
 	NULL,
-- 
2.51.0


