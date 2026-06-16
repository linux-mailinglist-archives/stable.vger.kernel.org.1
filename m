Return-Path: <stable+bounces-263510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 54+3NOanMGrdVwUAu9opvQ
	(envelope-from <stable+bounces-263510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:33:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E568B483
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:33:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B0LclX+q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263510-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263510-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1223E3048098
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 01:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88E3248886;
	Tue, 16 Jun 2026 01:33:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5581A6803
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 01:33:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573592; cv=none; b=pFCV5IUB/dGt0oABnCCR4qGSn1nupqactGGF/TJWcJgeU11WTC10mPW33upkAax0nUNxE4nIvGQJBnDleyN3qsovGq22hTGa48tSdhNGe9xONuSM6IG2KpwUb/d6rB4sWvbVSwsir5kpwxHhXwDlLbJcGtHJI+2MwFU/TYzyFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573592; c=relaxed/simple;
	bh=svphru8FrRD8HmAIKdKMBJBsYI5lEqA671Jh12ZpzRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouILDH3VHumUq/UbB8EcZ2j77ZEJOt1FjZc3rfXQZ5IOktnSujHR7p3N7mI0nbV4K2Sb/Y23MmML6hCABce0kWUfjHat/jWJqJsLVEjaF4ZJB+cac63Q8dWKaaB3erb3zXgkPDGHqp16s5IWu04gF9u8qIxOeDe+eSAEw6TmQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0LclX+q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E5A1F000E9;
	Tue, 16 Jun 2026 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573591;
	bh=djLdwLuY11/fekE5o72vzb6nLtUGUva/OeMKkaJfgRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B0LclX+qCuyOE09wlf1y8Isb3F0HNzBkGntgvdTvVigVQF2urmGj9izoSUg19WlKn
	 Xy1agX8vy0FqAuiJEnPsyStDWgQ/4ET/BmyiFVvcvHi7wVWtyOnACUnKjK9dThYZf8
	 Sa6dVGzUs4/vhztEziiNTdUZXvgafsP3/vksddsvndgpHvW5giktAXO+jiCvaendAJ
	 E5qUDhVc8ssfu+ZtZ9f+eh3nwZ5L0z+y787VUV15ajiN8dfEYDm/NFLqtCRtRLV+oi
	 dRund5vA3IyG2j8CSmxELTxEtVwfePgu73TCu3kt7OqScWgY9wZMjrt0B5JJspxWKf
	 kr5+3Q6qdBHEw==
From: Clark Williams <clrkwllms@kernel.org>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH linux-6.1.y 2/2] kvm/vmx: guard regparm(0) on vmread_error_trampoline for x86_32 only
Date: Mon, 15 Jun 2026 20:33:06 -0500
Message-ID: <20260616013306.3850069-3-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616013306.3850069-1-clrkwllms@kernel.org>
References: <20260616013306.3850069-1-clrkwllms@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263510-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[clrkwllms@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clrkwllms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,anthropic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 339E568B483

From: Clark Williams <clark.williams@gmail.com>

regparm(0) overrides the kernel's -mregparm=3 convention on x86-32 so
that vmread_error_trampoline receives its arguments on the stack, matching
the inline asm callers that push args before the call.  On x86-64 the
attribute is a no-op and newer GCC now emits -Wattributes for it, which
becomes a build error under -Werror.  Guard it with CONFIG_X86_32.

Assisted-By: Claude Sonnet 4.6 <noreply@anthropic.com>
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
---
 arch/x86/kvm/vmx/vmx_ops.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 5edab28dfb2e..50328be40b2b 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -11,8 +11,11 @@
 #include "../x86.h"
 
 void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-							 bool fault);
+/* regparm(0) overrides -mregparm=3 so args are stack-passed, matching asm callers */
+#ifdef CONFIG_X86_32
+__attribute__((regparm(0)))
+#endif
+void vmread_error_trampoline(unsigned long field, bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
-- 
2.54.0


