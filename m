Return-Path: <stable+bounces-273241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aCfFK/n2UGqb9AIAu9opvQ
	(envelope-from <stable+bounces-273241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 15:43:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F873B5DF
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 15:43:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=oTdTng3B;
	dkim=pass header.d=linutronix.de header.s=2020e header.b="wS/lSW+h";
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273241-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273241-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44396306473E
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90DF4071F9;
	Fri, 10 Jul 2026 13:38:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089363CBE97;
	Fri, 10 Jul 2026 13:38:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690720; cv=none; b=HYx7VY42jqAa+LBq+OrFDknPupt3z6qrpGuz81w2KSz2XSlbmjmYiRykTCprafGlioG+txgU6Pmi/6B4VV3K1rxmvoSn0DB0+8LaeDO+4jE5SQZH6lMTZsfNUf8CYZ8UGW4FEHJUTNaSrobrIbnlf01Kn0Z/tjQCDfZXEhocbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690720; c=relaxed/simple;
	bh=p/pSWXkPajt4W/HhkIRl8Muz2waGLdsiCEbj8UA7lUA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KkgfON+pulbqOt+KhpPI8tAU/gCZbzQZeuSymTxpBHB9sNS51JcPcKVQvcx6ITPqzrHUcGWX9l+UeMDt2O8HJoQvWhT9AYzBhJWxt80wWw9++5uUAlKvBYnl3mwujhbhlxyXO4+4j4SOZZ1QbGo+zE2QFQ53K+LuWfpjehsOFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oTdTng3B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wS/lSW+h; arc=none smtp.client-ip=193.142.43.55
Date: Fri, 10 Jul 2026 13:38:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783690716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPDL/peFF0h77rFGOflU7cgVbSdnIBgE0Q8pHOrPHwg=;
	b=oTdTng3BL2cCXLem514vSsqqX+7hOfXFphJweQbcpWxvuTf6xnVWUuqcHA7+TFyzeunor+
	SG2bYDDiJPIodifFDUKRiZzW0h2/84sNu5hmiJnCtFPzep1QU93Y0AhoCsmI1KinyuitZb
	dsqNOAUzi6cRgz6rfAje1r1W+enbqXXH49i4VkQ8mkCJBMNVHuaW3gdbb4BbCKewbdVulh
	d6W6gYZBckuNmrBuk8LdW/XdGEYVxAajr5TWYDySzKQnjalJFbXpz6bSVggxMAOLQnAWPe
	of6Jh5P26PEieh1x8DQ/uXQjxZxUDrkD2AJ688Ghn/Q88HbqjHctr/JbWF1guA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783690716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPDL/peFF0h77rFGOflU7cgVbSdnIBgE0Q8pHOrPHwg=;
	b=wS/lSW+hRLHKr4+gGankcObxruPqLLq/Ly8r6BYYDs39Sl9o+Bdg55G3M1uFkBkA94TkNJ
	NAo4niEZj27i88BA==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/lbr: Fix kernel address leakage
Cc: Ian Rogers <irogers@google.com>, Sandipan Das <sandipan.das@amd.com>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca898a29725f6b2f30518354cdc2e432db66c43cf=2E1783680?=
 =?utf-8?q?119=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ca898a29725f6b2f30518354cdc2e432db66c43cf=2E17836801?=
 =?utf-8?q?19=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178369071458.744054.8995849321113951897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-tip-commits@vger.kernel.org,m:irogers@google.com,m:sandipan.das@amd.com,m:mingo@kernel.org,m:stable@vger.kernel.org,m:peterz@infradead.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273241-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tip-bot2:mid,amd.com:email,msgid.link:url,linutronix.de:from_mime,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,vger.kernel.org:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F0F873B5DF

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2a892294b83f541115c94b0bb637f39bef187657
Gitweb:        https://git.kernel.org/tip/2a892294b83f541115c94b0bb637f39bef1=
87657
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 10 Jul 2026 16:15:27 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 10 Jul 2026 15:37:53 +02:00

perf/x86/amd/lbr: Fix kernel address leakage

A user-only branch stack can contain branches that originate from
the kernel. As a result, kernel addresses are exposed to user space
even when PERF_SAMPLE_BRANCH_USER is requested. On AMD processors
supporting X86_FEATURE_AMD_LBR_V2, perf can still report SYSRET/ERET
entries for which the branch-from addresses are in the kernel.

E.g.

  $ perf record -e cycles -o - -j any,save_type,u -- \
        perf bench syscall basic --loop 1000 | \
        perf script -i - -F brstack|tr ' ' '\n'| \
        grep -E '0x[89a-f][0-9a-f]{15}'

  ...
  0xffffffff81001268/0x717a90a38f1a/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a39157/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a2c628/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a41b60/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a260db/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a260db/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a8bef1c30/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a8e4d3c90/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  ...

The reason is that the hardware filter only considers the privilege
level applicable to the branch target. Extend software filtering to
also validate the branch-from addresses against br_sel, so that any
branch record whose branch-from address is in the kernel is dropped
when PERF_SAMPLE_BRANCH_USER is requested.

Fixes: f4f925dae741 ("perf/x86/amd/lbr: Add LbrExtV2 hardware branch filter s=
upport")
Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/a898a29725f6b2f30518354cdc2e432db66c43cf.17836=
80119.git.sandipan.das@amd.com
---
 arch/x86/events/amd/lbr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 5b437dc..9d9c961 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -127,7 +127,8 @@ static void amd_pmu_lbr_filter(void)
 		}
=20
 		/* If type does not correspond, then discard */
-		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
+		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type ||
+		    (!(br_sel & X86_BR_KERNEL) && kernel_ip(cpuc->lbr_entries[i].from))) {
 			cpuc->lbr_entries[i].from =3D 0;	/* mark invalid */
 			compress =3D true;
 		}

