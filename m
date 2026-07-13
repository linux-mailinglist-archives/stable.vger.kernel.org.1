Return-Path: <stable+bounces-273723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id arbnGsDpVGo2hAAAu9opvQ
	(envelope-from <stable+bounces-273723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:36:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B3374BAA3
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:35:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=t+mWyFof;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273723-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273723-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F6E3228562
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202D040BCD2;
	Mon, 13 Jul 2026 13:19:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F4422552
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948758; cv=none; b=nS3yiNTYsV1/2f22bka1G+eQLKr1HyV8omAmLbHSWadPuU81YDaJjH66P6wq+gKY+6N2kJg+V66Y3IS5GGedyz5LOGsJ3yPNTtnpXNNJ1PnGlrBgx0G1/zxiTE0uZegMmVs3I2xneYwH00hyW9whvB+cDTTq/Tr4EDWTXK8f3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948758; c=relaxed/simple;
	bh=TfMguYQK26w813T1+ffH76FDdocaYOEv8a3Yu2uw48Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b/18AScYiIKVKlpSIlOv8D7LfZv4A4eTqrFxrPN6vQlDG9T0RukpZCjx1lmlRS1sbcvOOjaASZt+He/8XwffyVJhSj1U8qSn/Uez9YUgPNaC1kSb2Q5/uYdXPD4MR+57+qjC02x7jtyRCbt9UjaFpvxIN35W0sFVZ+xVRmhLXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t+mWyFof; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CF41F000E9;
	Mon, 13 Jul 2026 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948757;
	bh=67mVBdqJvT8wMCzlNZnLMgwcILElYx3ZViySjnpJ35U=;
	h=Subject:To:Cc:From:Date;
	b=t+mWyFofX8aZgAI51RxJ7EUQFS4FJWmCURQhDRvYZYHqMiHUKEA1CE4T0rEigMcOZ
	 d4oDpCHkFYFwK8GImlau30ANZBqf6XLCdNbj7kij25UpVSXjSBSb+Skxdb8kh4sKGW
	 QG7knrcYlg7JH6lyxK2dUOuB7yj+wd31nbUVm1cY=
Subject: FAILED: patch "[PATCH] x86,fs/resctrl: Prevent out-of-bounds access while offlining" failed to apply to 6.18-stable tree
To: reinette.chatre@intel.com,bp@alien8.de,sashiko-bot@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:04:56 +0200
Message-ID: <2026071356-onboard-immortal-5433@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273723-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:reinette.chatre@intel.com,m:bp@alien8.de,m:sashiko-bot@kernel.org,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sashiko.dev:url,intel.com:email,gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3B3374BAA3


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x fc16126cc11d9f507130bf84ab137ee0938c900e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071356-onboard-immortal-5433@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc16126cc11d9f507130bf84ab137ee0938c900e Mon Sep 17 00:00:00 2001
From: Reinette Chatre <reinette.chatre@intel.com>
Date: Tue, 9 Jun 2026 14:02:27 -0700
Subject: [PATCH] x86,fs/resctrl: Prevent out-of-bounds access while offlining
 CPU when SNC enabled

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

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 03ee6102ab07..569894d6e5c8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -259,6 +259,11 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
 
+	if (cpumask_empty(&hdr->cpu_mask)) {
+		pr_warn_once("Domain %d has no CPUs\n", hdr->id);
+		return -EINVAL;
+	}
+
 	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	hw_dom = resctrl_to_arch_mon_dom(d);
 	cpu = cpumask_any(&hdr->cpu_mask);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 0e6a389a16bf..a932a1fea818 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -135,10 +135,10 @@ void __check_limbo(struct rdt_l3_mon_domain *d, bool force_free)
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
+	bool rmid_dirty = true;
 	u32 idx, cur_idx = 1;
 	void *arch_mon_ctx;
 	void *arch_priv;
-	bool rmid_dirty;
 	u64 val = 0;
 
 	arch_priv = mon_event_all[QOS_L3_OCCUP_EVENT_ID].arch_priv;
@@ -161,22 +161,27 @@ void __check_limbo(struct rdt_l3_mon_domain *d, bool force_free)
 			break;
 
 		entry = __rmid_entry(idx);
-		if (resctrl_arch_rmid_read(r, &d->hdr, entry->closid, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, arch_priv, &val,
-					   arch_mon_ctx)) {
-			rmid_dirty = true;
-		} else {
-			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
+		if (!force_free) {
+			if (resctrl_arch_rmid_read(r, &d->hdr, entry->closid,
+						   entry->rmid, QOS_L3_OCCUP_EVENT_ID,
+						   arch_priv, &val, arch_mon_ctx)) {
+				rmid_dirty = true;
+			} else {
+				rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
 
-			/*
-			 * x86's CLOSID and RMID are independent numbers, so the entry's
-			 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
-			 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't
-			 * used to select the configuration. It is thus necessary to track both
-			 * CLOSID and RMID because there may be dependencies between them
-			 * on some architectures.
-			 */
-			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->hdr.id, val);
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


