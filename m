Return-Path: <stable+bounces-261339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zxohIHJIJWr+FwIAu9opvQ
	(envelope-from <stable+bounces-261339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:31:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD764FBC9
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:31:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=AEHe9GOI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261339-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261339-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61958300FF9A
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2D328243;
	Sun,  7 Jun 2026 10:29:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E763290C3;
	Sun,  7 Jun 2026 10:29:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828172; cv=none; b=QKawphCoIhq+aN8XH+BWWJ8dTKZRR8FCbOXHTs5BAJ1i605TVfq73lx9R0JTcHhawXUkWP0f2/qiW2PVsNh0dLQvakHmbYM/5ismWF1FunKJzU3OMnDRPYjK+hanyrYn37ChyFo9YSVLJy70N5UiaLrJIcNXE98s4EAFKsEY3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828172; c=relaxed/simple;
	bh=+wQ0d6UKEVHBktgTlq6mqJdgzUENBFNYwZ73ZHr4EM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUniev0DInPuhEhBWcGexewclwETyR187qEKWw7xhkU5U9ziN+aq4wgwCM6rN/si4B9ESEz61KvnoWE8mD3lfz6N78cZ/iAkNmuutqCu7v6zIb78zpFfZzKquDyLK8o6b3oExiDpY/dxAAiJtqm+1efSjMS+2GbDk/O1TPKK9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AEHe9GOI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2C81F00893;
	Sun,  7 Jun 2026 10:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828170;
	bh=MkGyi5uoHG6AVpi6qnB03ZwESl0a0ctO5zELKXTj/xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AEHe9GOIcwS+cJUsW05xKYfqIrH5ZXL6DD0LtW/GdgWPO/7mFt6q4S4VpqkVskhBm
	 XCOX8EFKozk/uoMcKn5guzOV4mLiTar1X9lu/BC5zDgNu1MO7fhQruUy+BSp7SA6AX
	 oMI/33/xs9gpZSxni00yq+s4uQqk7y11QoKpHwBQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qiang Ma <maqianga@uniontech.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 7.0 160/332] KVM: arm64: PMU: Preserve AArch32 counter low bits
Date: Sun,  7 Jun 2026 11:58:49 +0200
Message-ID: <20260607095733.949017022@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261339-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maqianga@uniontech.com,m:maz@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,msgid.link:url,uniontech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4BD764FBC9

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiang Ma <maqianga@uniontech.com>

commit 1750ad1388e03fb27068cd1f22c9c8b4590fe936 upstream.

AArch32 writes to PMU event counters cannot update the top 32 bits,
even when PMUv3p5 makes the counters 64-bit. KVM therefore needs to
preserve the existing high half and only update the low half written by
the guest, unless the caller explicitly forces a full reset through
PMCR.P.

The current code masks @val down to the old high half before taking
lower_32_bits(val), which means the low half is always zero. As a
result, AArch32 writes to event counters discard the guest-provided low
32 bits instead of storing them.

Build the new value from the old high 32 bits and the low 32 bits of
the value supplied by the guest.

Fixes: 26d2d0594d70 ("KVM: arm64: PMU: Do not let AArch32 change the counters' top 32 bits")
Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://patch.msgid.link/20260526074640.791991-1-maqianga@uniontech.com
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/pmu-emul.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -174,8 +174,8 @@ static void kvm_pmu_set_pmc_value(struct
 		 * action is to use PMCR.P, which will reset them to
 		 * 0 (the only use of the 'force' parameter).
 		 */
-		val  = __vcpu_sys_reg(vcpu, reg) & GENMASK(63, 32);
-		val |= lower_32_bits(val);
+		val = (__vcpu_sys_reg(vcpu, reg) & GENMASK(63, 32)) |
+		      lower_32_bits(val);
 	}
 
 	__vcpu_assign_sys_reg(vcpu, reg, val);



