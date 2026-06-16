Return-Path: <stable+bounces-264037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Ce7AdZtMWpujAUAu9opvQ
	(envelope-from <stable+bounces-264037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:37:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E46913A2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:37:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=T3nsO37Q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264037-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264037-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F2CF3052DF1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670936A033;
	Tue, 16 Jun 2026 15:29:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B08D1A6803;
	Tue, 16 Jun 2026 15:29:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623791; cv=none; b=au+Wncriw6tNyX/DgtpI1QTJHnKtrm0vXjG7QxjOTpPHq0BL9VY80Hat/TtBCXhXAwO74YQYpuizlFf370hlN/DFuQIvE/rnXQKp/F4KOZFGP0YZXuP9LS/cdSK5o8camaHZ8PR+Mm9cdY1VH8wZZKGEnLdrHccwaXWDskAFYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623791; c=relaxed/simple;
	bh=qVo27lVwp8ERvnutDxk1tHAT5yMIB9J+vcLbBN3m/QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APuREWn4Dw+jBGDdNEHiOEAblbLUMJJOH+VcTMJmy7IFxRckEQnPLUWqXQJHvKXCK1Jt5uHjhIuqqgc15VbBIGz4azqPxTsBgOeYtWQx2YrtDlF660CKD6QJMrHbXpBSadcHAHofh9hnsMpWgcLlWhyqNj9CKXDQepUCIpHkMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T3nsO37Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639ED1F000E9;
	Tue, 16 Jun 2026 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623790;
	bh=Y6yT572osDs+vFCraDfdohPccbJFJFw3t3NvPmERk2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3nsO37QXkMiS6IRnFlLWcGV5ZBo6QRLUwQZXYvECORvB1RoRdMK0c5ZgX/3fUdMf
	 hyQzRSDmzu7z+XWN0v16wp6ufWedN3k/ixmT1G7aRGVjGrl63CC6E3NT65YgO1erC/
	 XGI9FYLXKrNJvEEfS7vhN9Mp/9q5OkvDWM7yxm48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joey Gouly <joey.gouly@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 7.0 199/378] KVM: arm64: Restore POR_EL0 access to host EL0
Date: Tue, 16 Jun 2026 20:27:10 +0530
Message-ID: <20260616145120.868469162@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264037-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:joey.gouly@arm.com,m:maz@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:email,vger.kernel.org:from_smtp,sashiko.dev:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 116E46913A2

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -181,6 +181,8 @@ static inline void __deactivate_cptr_tra
 		val |= CPACR_EL1_ZEN;
 	if (cpus_have_final_cap(ARM64_SME))
 		val |= CPACR_EL1_SMEN;
+	if (cpus_have_final_cap(ARM64_HAS_S1POE))
+		val |= CPACR_EL1_E0POE;
 
 	write_sysreg(val, cpacr_el1);
 }



