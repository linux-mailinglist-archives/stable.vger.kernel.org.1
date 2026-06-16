Return-Path: <stable+bounces-264395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vbfZLuV1MWqXjwUAu9opvQ
	(envelope-from <stable+bounces-264395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:12:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 107CB691CE4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:12:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tgeOUHSC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264395-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264395-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F281D300BCA4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA844DB6D;
	Tue, 16 Jun 2026 16:01:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9E450917;
	Tue, 16 Jun 2026 16:01:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625661; cv=none; b=GQ4mcGXKrDLFi7RG+SW7dOG2l8JRR5qdQ1bG9mmrkydOB9acPDcoaOseZYgOjtjk4tZaGi92Z9iuHJ3dptn+K8x2rHWtZWm87l7dDDbZvVwy0b2ETUMDq+z25qAYYw6qfzLHB40MOv56QVKZo90JirCAu11xTo1lDfelJ6Ns3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625661; c=relaxed/simple;
	bh=pKFW4vPqlrvuVq3UH/nIwhU6INzWBNfY0IhNml7cTWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wgl6xKxNAkOh3lsXtTIv7SYeUZxIyR8rSUsQEEKxUo2j5G5lNCeVu4aJW10eHs+LIk1HmavzkO77p1RAZ/SzhTkVd4Mm6kJ5cPUD7k2q2AM4XFnfhl/52bNTQ2eJ1uKhZhrnIEUP1jlfL6zHAWSdTUmg+fBBPLy36mK3D42Bmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tgeOUHSC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C391F000E9;
	Tue, 16 Jun 2026 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625660;
	bh=rDRMpvcgeEO58JhADsc6bOsDH8JSFTnwLYNhGco2+rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tgeOUHSCt7cOWERqy31yJ/v87DcPOtG2Q5Z1BD8bUZD8MtE5HCU/2UD36dmASa1m4
	 XF3QiloPYJK5yrBvtLCyiYQoecHEmF8IwGFddwxqxUgZ7aMkS+MKPu/dlRgNcmYLk4
	 ayakA3/tljiEihCe4tIJzEb801W82IgX+cejDGp8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joey Gouly <joey.gouly@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.18 167/325] KVM: arm64: Restore POR_EL0 access to host EL0
Date: Tue, 16 Jun 2026 20:29:23 +0530
Message-ID: <20260616145106.120862484@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264395-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:joey.gouly@arm.com,m:maz@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sashiko.dev:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,arm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 107CB691CE4

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joey Gouly <joey.gouly@arm.com>

commit cbaffe843a942c0d3102e0f9bce0e72b029b2594 upstream.

CPTR_EL2.E0POE was being cleared in __deactivate_cptr_traps_vhe(), which meant
that any accesses to POR_EL0 from host EL0 would trap and be reported to
userspace as an Illegal instruction. This would happen after running any VM,
regardless if it used POE or not.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Link: https://sashiko.dev/#/patchset/20260602155430.2088142-1-maz@kernel.org?part=1
Link: https://patch.msgid.link/20260604105434.2297268-1-joey.gouly@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger,kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -183,6 +183,8 @@ static inline void __deactivate_cptr_tra
 		val |= CPACR_EL1_ZEN;
 	if (cpus_have_final_cap(ARM64_SME))
 		val |= CPACR_EL1_SMEN;
+	if (cpus_have_final_cap(ARM64_HAS_S1POE))
+		val |= CPACR_EL1_E0POE;
 
 	write_sysreg(val, cpacr_el1);
 }



