Return-Path: <stable+bounces-263138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dC7QFACKL2p4CAUAu9opvQ
	(envelope-from <stable+bounces-263138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 07:13:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5D68367B
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 07:13:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cFdPugmf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263138-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263138-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0B49300292A
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 05:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561A3033DF;
	Mon, 15 Jun 2026 05:13:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94912F7F00;
	Mon, 15 Jun 2026 05:13:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500408; cv=none; b=hyzqHODP1BSHutHhH2W/qZAzi3HexGVmVvP3v2ZVv3mtl3h7+L8I5owFvGcIGf30zsVL38gHLDVGq3PaeEsw0MGroy7RpbsVTghXFyxQID9bd6EGfFdipr55tiooiaLNlwdiQeg9oTHBFFDIUoPZRSa7/da3uxqOpXJsdalHyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500408; c=relaxed/simple;
	bh=ZCSg8rgUfQxYAKXvlVX623y0p0mwC+RS4U4EbVgagJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDMuQFwqKqP2YrIrWBVMbRR1d7qPfz+TMe7tMJFZZMFIQXBhNgY+lzd4egPrrr0A6bClLb9mWrGJ8juLYLGe3sux8Mgql8ymrCIF0DpjJiayJ0R6WXuh2V6Y4MyeeLaXRWo/h/sPutmCzKirAwlxggRcxDU6ZcT41tx3MWNslAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFdPugmf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4AA1F000E9;
	Mon, 15 Jun 2026 05:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781500406;
	bh=epeNv8U8vkCS7hPNhm6n+IOPAD0EFsVk8XMbJrLmp6Y=;
	h=From:To:Cc:Subject:Date;
	b=cFdPugmfiYHll09u/96S3QqxwCqKEkUIq63q/PTJ0ku8g21xn7qD7hLMgb1kh5SuM
	 +GdUQ9w4JDfVyCeFTtIY5EtAhUsvwYXEPbh+uy7mJTcvilpnJVOBNgfHcPE+/+qsGX
	 dP1aULWNHbZ8QApShbuqVBdwCQS35fJhuZn1iig06twkfUHj/+wcaPtiJT+fNabuic
	 tE6ybrLLL9NQ07sF8f2931EF2eerlrhItUlccaQYuvchIuI3dAVMTH+idPwcDwnX48
	 e7aBuJOXtj8pLyRQ5Fn/zk7iAKDtiHLbFar8KPoLdNvwlg1AT6f50YBQJyoKClNRCt
	 MQUrCLkMzDG3g==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: nv: Drop bogus WARN for write to ZCR_EL2
Date: Sun, 14 Jun 2026 22:13:24 -0700
Message-ID: <20260615051324.830045-1-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263138-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kvmarm@lists.linux.dev,m:maz@kernel.org,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:oupton@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AA5D68367B

It is entirely possible for a guest to write to the ZCR_EL2 sysreg alias
while in a nested context, as it is expected if FEAT_NV2 is advertised
to the L1 hypervisor.

Get rid of the bogus WARN which, since the hyp vectors were installed at
this point, has the effect of a hyp_panic...

Cc: stable@vger.kernel.org
Fixes: 0cfc85b8f5cf ("KVM: arm64: nv: Load guest FP state for ZCR_EL2 trap")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 161bb2a3e1d9..2e96ac3b08c0 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -595,8 +595,6 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 			return false;
 		break;
 	case ESR_ELx_EC_SYS64:
-		if (WARN_ON_ONCE(!is_hyp_ctxt(vcpu)))
-			return false;
 		fallthrough;
 	case ESR_ELx_EC_SVE:
 		if (!sve_guest)

base-commit: 1ee27dacbe5dc4def481794d899d67b0d4570094
-- 
2.47.3


