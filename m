Return-Path: <stable+bounces-223520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPcRA2uermmqGwIAu9opvQ
	(envelope-from <stable+bounces-223520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:18:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C385236E00
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7778F300C393
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781DE38F936;
	Mon,  9 Mar 2026 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gChEZ/N3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21938F24F
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051481; cv=none; b=CWY6iA9rUvENkl8KNWHYOdCPsdHvaP/KKX5J9e6Hv3FLuZEaxu71mwKiHmdauF3aFRzOU9Dbb+6MdIlRDlPsixC2ZZCFJZ7+iebDzmj9x/a20RTpl8jmBrTU8j41MACXLZ/Q1GSWIefU1Ryzz9mWFpmapgAHF7rUhIKqJLIjGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051481; c=relaxed/simple;
	bh=XlM8pdkPnb6Npo+pWjvLuChz6KemJ55D6aVk/nx8CNo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QkjqdbmNBIHX6X5nD8/dGfA/Qf+zI9hly3ss+2CvejgKW6aIV9+hxm/1DC0Y3bpEDPdGwajLaAqpDswP0Khi/4FD9Rw47XCmDF+z9j5j22uoRchgpuUWMsgbD01x+finKHxkUVABmBC5U4eXgGojE0geKPz/PvknZP6rpmzjzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gChEZ/N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7954DC4CEF7;
	Mon,  9 Mar 2026 10:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051480;
	bh=XlM8pdkPnb6Npo+pWjvLuChz6KemJ55D6aVk/nx8CNo=;
	h=Subject:To:Cc:From:Date:From;
	b=gChEZ/N3fuuKYHPIoC1svyYgzImPzo1wDfWVCkGljNpd5FWFGLKemA5YFpCXeYQS9
	 3tmT+t1iOkFg3bUxOf+1KW/Q14oX0VBFzyqf5LOUrCOwoiKY4dmR10kZUhDLkVt3O+
	 iC1JzA9+9EIFFUW6Dmo89hFcnbku33sK7QQBjtBs=
Subject: FAILED: patch "[PATCH] perf/x86/intel/uncore: Add per-scheduler IMC CAS count events" failed to apply to 6.12-stable tree
To: zide.chen@intel.com,dapeng1.mi@linux.intel.com,peterz@infradead.org,reinette.chatre@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:16:06 +0100
Message-ID: <2026030906-onion-junkyard-156b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C385236E00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223520-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.323];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,msgid.link:url,infradead.org:email,intel.com:email,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6a8a48644c4b804123e59dbfc5d6cd29a0194046
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030906-onion-junkyard-156b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a8a48644c4b804123e59dbfc5d6cd29a0194046 Mon Sep 17 00:00:00 2001
From: Zide Chen <zide.chen@intel.com>
Date: Mon, 9 Feb 2026 16:52:25 -0800
Subject: [PATCH] perf/x86/intel/uncore: Add per-scheduler IMC CAS count events

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

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 5ed6e0b7e715..0a1d08136cc1 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6497,6 +6497,32 @@ static struct intel_uncore_type gnr_uncore_ubox = {
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
@@ -6544,7 +6570,7 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
 	NULL,
 	&spr_uncore_pcu,
 	&gnr_uncore_ubox,
-	&spr_uncore_imc,
+	&gnr_uncore_imc,
 	NULL,
 	&gnr_uncore_upi,
 	NULL,


