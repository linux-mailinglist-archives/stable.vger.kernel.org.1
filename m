Return-Path: <stable+bounces-274120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NiHNHQu8VWqzsAAAu9opvQ
	(envelope-from <stable+bounces-274120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:33:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C25CA750E1F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:33:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E0pEpwer;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274120-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274120-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44EEC3052CF4
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 04:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468A1C6FF5;
	Tue, 14 Jul 2026 04:30:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC51C861D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003410; cv=none; b=IIfBTN81u9MNiCiiMucAyuM38XLM3xbJd4CIIdyistYBsGfaa5Cs6hokbpIHX273NHiu0KzkyPVycl4jqebeVFLFAa6B8BgB2dUm6KoM1ypKT7fOUSnz0BX9NIH0TKkSaJtWsQORxS0jOeehkHPxtIMz8TVZm/vubENfCqdxM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003410; c=relaxed/simple;
	bh=D1F8BS5Gm4yez8XborKQAIv3+GKQxynFgEE98rHc8fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izUs8Zq7fPNG9o9sQuPf36ezDJwtpkc8jowjwaGe8qhp3EH5BPb/EXkKyI19toEXp7Srgdd+eowTY9i5qXtpFEoNp47vOsgHy20s7+IIts+W5HEJwVcXDdBW0WkO9c3LC+jB0invvU0Nq1ymXr/fBFk1kYhsYc7VuRVGHzXlPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0pEpwer; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC131F000E9;
	Tue, 14 Jul 2026 04:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003408;
	bh=mICutwBK0EOWPaJt4dE51Zi2P/cBrQAMNeIDmrK7FQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E0pEpwerZ5on1SZjEJueqR+tDisH+rxCo7p0Qm6oHWrPgUwUU3XP/nWrugGaN5EC6
	 zlMkcPhEWousOPzNLjodpXrvbdJVTUZGdmUn92RHdi8ep3+pZkiO5gPo8jrkX/KePJ
	 tSOo0BPQVLz2CZSDscTbrcb5h8VL/ivI2BvGaKw9sWSbw9mjhzZfnErSVFitdy7ker
	 89YKeBPmL/ZOXqwRecAg8x0WUPQAdUhL+J8RC2eAwz75CjDI1KB+ta1w7lCchOvIcn
	 6GuAybIEZr661VHrQeKeYMNc+hXUC0k37FQpYblJm+PhzYKA2E6pnk/vz9iKQFnT0Z
	 q+rcLNdFlWlBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] x86,fs/resctrl: Prevent out-of-bounds access while offlining CPU when SNC enabled
Date: Tue, 14 Jul 2026 00:30:04 -0400
Message-ID: <20260714043004.2500830-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071357-shifter-degree-6c12@gregkh>
References: <2026071357-shifter-degree-6c12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274120-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:reinette.chatre@intel.com,m:sashiko-bot@kernel.org,m:bp@alien8.de,m:stable@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,intel.com:email,alien8.de:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C25CA750E1F

From: Reinette Chatre <reinette.chatre@intel.com>

[ Upstream commit fc16126cc11d9f507130bf84ab137ee0938c900e ]

The architecture updates the cpu_mask in a domain's header to track which
online CPUs are associated with the domain. When this mask becomes empty
the architecture initiates offline of the domain that includes calling
on resctrl fs to offline the domain. If it is a monitoring domain in
which LLC occupancy is tracked resctrl fs forces the limbo handler to
clear all busy RMID state associated with the domain.

The limbo handler always reads the current event value associated with a
busy RMID irrespective of it being checked as part of regular "is it still
busy" check or whether it will be forced released anyway. When reading an
RMID on a system with SNC enabled the "logical RMID" is converted to the
"physical RMID" and this conversion requires the NUMA node ID of the
resctrl monitoring domain that is in turn determined by querying the NUMA
node ID of any CPU belonging to the monitoring domain.

When the monitoring domain is going offline its cpu_mask is empty causing
the NUMA node ID query via cpu_to_node() to be done with "nr_cpu_ids" as
argument resulting in an out-of-bounds access.

Refactor the limbo handler to skip reading the RMID when the RMID will
just be forced to no longer be dirty in the domain anyway. Add a safety
check to the architecture's RMID reader to protect against this scenario.

Fixes: e13db55b5a0d ("x86/resctrl: Introduce snc_nodes_per_l3_cache")
Closes: https://sashiko.dev/#/patchset/cover.1780456704.git.reinette.chatre%40intel.com?part=9
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/16137433df42f85013b2f7a53626795cbd6637b9.1781029125.git.reinette.chatre@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 47 +++++++++++++++++----------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c117fba4f8da92..b4dcfe6d0831ac 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -338,14 +338,20 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u64 *val, void *ignored)
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
-	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
 	u64 msr_val;
 	u32 prmid;
+	int cpu;
 	int ret;
 
 	resctrl_arch_rmid_read_context_check();
 
+	if (cpumask_empty(&d->hdr.cpu_mask)) {
+		pr_warn_once("Domain %d has no CPUs\n", d->hdr.id);
+		return -EINVAL;
+	}
+
+	cpu = cpumask_any(&d->hdr.cpu_mask);
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
 
@@ -382,9 +388,9 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
+	bool rmid_dirty = true;
 	u32 idx, cur_idx = 1;
 	void *arch_mon_ctx;
-	bool rmid_dirty;
 	u64 val = 0;
 
 	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
@@ -406,22 +412,27 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 			break;
 
 		entry = __rmid_entry(idx);
-		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, &val,
-					   arch_mon_ctx)) {
-			rmid_dirty = true;
-		} else {
-			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
-
-			/*
-			 * x86's CLOSID and RMID are independent numbers, so the entry's
-			 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
-			 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't
-			 * used to select the configuration. It is thus necessary to track both
-			 * CLOSID and RMID because there may be dependencies between them
-			 * on some architectures.
-			 */
-			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->hdr.id, val);
+		if (!force_free) {
+			if (resctrl_arch_rmid_read(r, d, entry->closid,
+						   entry->rmid, QOS_L3_OCCUP_EVENT_ID,
+						   &val, arch_mon_ctx)) {
+				rmid_dirty = true;
+			} else {
+				rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
+
+				/*
+				 * x86's CLOSID and RMID are independent numbers,
+				 * so the entry's CLOSID is an empty CLOSID
+				 * (X86_RESCTRL_EMPTY_CLOSID). On Arm the RMID
+				 * (PMG) extends the CLOSID (PARTID) space with
+				 * bits that aren't used to select the configuration.
+				 * It is thus necessary to track both CLOSID and
+				 * RMID because there may be dependencies between
+				 * them on some architectures.
+				 */
+				trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid,
+							      d->hdr.id, val);
+			}
 		}
 
 		if (force_free || !rmid_dirty) {
-- 
2.53.0


