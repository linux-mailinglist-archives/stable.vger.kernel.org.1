Return-Path: <stable+bounces-217720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJOdIdAsnGmcAQQAu9opvQ
	(envelope-from <stable+bounces-217720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:32:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC113174F08
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26C72302642E
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A235C1AC;
	Mon, 23 Feb 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/v57GEz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXHwFG81"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4334FF41;
	Mon, 23 Feb 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842655; cv=none; b=s5AJ8htWY3Kd2ujnmPxaKC4oqFnr9aPMp5pV7EegYWaOo+st0e7H1NVCscJzi3H9bS7m2kfPYzR2pn/2/v0CB70VfuTkaz+M1crdO5AbH99oDdJFE0Mybbg+9u99mr4ryXqOBI7XiZphnfK2nAgvY9HmI5d170x0XOObHy5x9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842655; c=relaxed/simple;
	bh=qnVIFbm1j4rtKlvtvGWiRFAMyvCCAKGcDPhd1pHIJZ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I8lNakdhlAz6NhNPWaNtDSWNDwNGWNr3U77QYG3B7vonRDIceVv0gletDGxyLSZ3SS4kAH5udawM+z2ZxckMWSJyXQR1dp/z3n6Qpkl9locUQS4kx9I+4Cl8ifhQrByLpTNjqUc2UI6M4VRZgo8EQt4c/seYiLeO7HAN9AjB9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/v57GEz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXHwFG81; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:30:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIXnMDP6SWiGCWv6ySuJmJBgBaWkeCyUDqIL3hBumbc=;
	b=F/v57GEzm+wu7rOrXchSlrNY8QjhPkVInUEoZ/qh+H0kxgzovqJpjtPnHKArLOgHxHpQTy
	IAzNohXn7MS/mwhe7htqOpdZE/Vp5bw9v0ezOLao59j8ik52MKelv1UX+Ge32UJCL6ZPDR
	RCZBjvHzmUGJSMXTyTB5jRVT/k+Gt9itlYvMW/aM55ImWZGuVDj0TBtAMC8bZs5YGAraGV
	bUZludpg247hXORYWcb/Cf8GJEeFOVyapP+/MYKi7zsAnOd1phDG9RiLxcqXpXelA1Iby3
	kwP/n8/kLIG4eIm7uQkgoRk14QKT9ozm7H6L2kftmKiZe8ippu/Wjuz/fbgYEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIXnMDP6SWiGCWv6ySuJmJBgBaWkeCyUDqIL3hBumbc=;
	b=kXHwFG81uTZbWT60ptrfRvr7o33x0v6jBuMsIDZsMzEZYkKsKe6Q2+ofeZ21385GiWwESS
	qypxjCfUIZNcEYAA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Add per-scheduler IMC CAS
 count events
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260210005225.20311-1-zide.chen@intel.com>
References: <20260210005225.20311-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184265133.1647592.517494925626141391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217720-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:dkim,intel.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: AC113174F08
X-Rspamd-Action: no action

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6a8a48644c4b804123e59dbfc5d6cd29a0194046
Gitweb:        https://git.kernel.org/tip/6a8a48644c4b804123e59dbfc5d6cd29a01=
94046
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Mon, 09 Feb 2026 16:52:25 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:25 +01:00

perf/x86/intel/uncore: Add per-scheduler IMC CAS count events

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
Fixes: cb4a6ccf3583 ("perf/x86/intel/uncore: Support Sierra Forest and Grand =
Ridge")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260210005225.20311-1-zide.chen@intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 28 ++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index 5ed6e0b..0a1d081 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6497,6 +6497,32 @@ static struct intel_uncore_type gnr_uncore_ubox =3D {
 	.attr_update		=3D uncore_alias_groups,
 };
=20
+static struct uncore_event_desc gnr_uncore_imc_events[] =3D {
+	INTEL_UNCORE_EVENT_DESC(clockticks,      "event=3D0x01,umask=3D0x00"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch0,  "event=3D0x05,umask=3D0xcf"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch0.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch0.unit, "MiB"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch1,  "event=3D0x06,umask=3D0xcf"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch1.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch1.unit, "MiB"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch0, "event=3D0x05,umask=3D0xf0"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch0.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch0.unit, "MiB"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch1, "event=3D0x06,umask=3D0xf0"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch1.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch1.unit, "MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_type gnr_uncore_imc =3D {
+	SPR_UNCORE_MMIO_COMMON_FORMAT(),
+	.name			=3D "imc",
+	.fixed_ctr_bits		=3D 48,
+	.fixed_ctr		=3D SNR_IMC_MMIO_PMON_FIXED_CTR,
+	.fixed_ctl		=3D SNR_IMC_MMIO_PMON_FIXED_CTL,
+	.event_descs		=3D gnr_uncore_imc_events,
+};
+
 static struct intel_uncore_type gnr_uncore_pciex8 =3D {
 	SPR_UNCORE_PCI_COMMON_FORMAT(),
 	.name			=3D "pciex8",
@@ -6544,7 +6570,7 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR=
_NUM_UNCORE_TYPES] =3D {
 	NULL,
 	&spr_uncore_pcu,
 	&gnr_uncore_ubox,
-	&spr_uncore_imc,
+	&gnr_uncore_imc,
 	NULL,
 	&gnr_uncore_upi,
 	NULL,

