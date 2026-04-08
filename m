Return-Path: <stable+bounces-234925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIYFM8So1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:13:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5EE3C2989
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 200D83037E41
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEDF3D75C3;
	Wed,  8 Apr 2026 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNWufQeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A133121F;
	Wed,  8 Apr 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674118; cv=none; b=G5CZDqrd1FRrH1jFTtZcxRJGX1wROGZzspjKCy9J+neTynKbV4lbOzCgIZeetSia3iAda63Lnc8zBlW9Tv57Uefjdz9ZouHoZKeEjz58T4Ct/+WqWQoj/ymHNV9z2TI/Cq21tslYEln2IfkRX/AbrVGkPmNMtfoxA6n5eG9ug0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674118; c=relaxed/simple;
	bh=Un9vnCqDHMzb5z12neur1JQRUCBqbC8t4QvjvwwI6/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUwxNCANG8mSuQXbTuEM9nkTuJI/dCI3sXoQQyZCV9Yg/7CVK/bMAL6Mbw/hysO3NK8SkkEq+aX54cTMUr+h3NXMdOLKUw33NiiO1aFSohNtiv/EvLb6gqZStzbkenHKVlGYNFGcp7KtW+rl1B8KtY9NEppA83dx59+aa7o6idY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNWufQeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A81AC19421;
	Wed,  8 Apr 2026 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674117;
	bh=Un9vnCqDHMzb5z12neur1JQRUCBqbC8t4QvjvwwI6/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNWufQeCa/TXrLmmK/KN5RSk0t/+h/BTywmnoat7O4FQGkL6i6Jn32waikuWlYQ3A
	 ry5KmiMUYdf8pQS4zHG006RdXYhIahMfL1AvlBE1zAZBEroE8qyS6lmENTcvckbtZe
	 CPDgNJMXqnx99GVM//5nXSwSnt1mdbaHMwFlVvEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikunj A Dadhania <nikunj@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	stable@kernel.org
Subject: [PATCH 6.12 217/242] x86/fred: Fix early boot failures on SEV-ES/SNP guests
Date: Wed,  8 Apr 2026 20:04:17 +0200
Message-ID: <20260408175935.204626092@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234925-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,amd.com:email]
X-Rspamd-Queue-Id: 5A5EE3C2989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikunj A Dadhania <nikunj@amd.com>

[ Upstream commit 3645eb7e3915990a149460c151a00894cb586253 ]

FRED-enabled SEV-(ES,SNP) guests fail to boot due to the following issues
in the early boot sequence:

* FRED does not have a #VC exception handler in the dispatch logic

* Early FRED #VC exceptions attempt to use uninitialized per-CPU GHCBs
  instead of boot_ghcb

Add X86_TRAP_VC case to fred_hwexc() with a new exc_vmm_communication()
function that provides the unified entry point FRED requires, dispatching
to existing user/kernel handlers based on privilege level. The function is
already declared via DECLARE_IDTENTRY_VC().

Fix early GHCB access by falling back to boot_ghcb in
__sev_{get,put}_ghcb() when per-CPU GHCBs are not yet initialized.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@kernel.org>  # 6.12+
Link: https://patch.msgid.link/20260318075654.1792916-4-nikunj@amd.com
[ applied GHCB early-return changes to core.c instead of noinstr.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/coco/sev/core.c    |    6 ++++++
 arch/x86/entry/entry_fred.c |   14 ++++++++++++++
 2 files changed, 20 insertions(+)

--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -253,6 +253,9 @@ static noinstr struct ghcb *__sev_get_gh
 
 	WARN_ON(!irqs_disabled());
 
+	if (!sev_cfg.ghcbs_initialized)
+		return boot_ghcb;
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
@@ -649,6 +652,9 @@ static noinstr void __sev_put_ghcb(struc
 
 	WARN_ON(!irqs_disabled());
 
+	if (!sev_cfg.ghcbs_initialized)
+		return;
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -176,6 +176,16 @@ static noinstr void fred_extint(struct p
 	}
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+noinstr void exc_vmm_communication(struct pt_regs *regs, unsigned long error_code)
+{
+	if (user_mode(regs))
+		return user_exc_vmm_communication(regs, error_code);
+	else
+		return kernel_exc_vmm_communication(regs, error_code);
+}
+#endif
+
 static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long error_code)
 {
 	/* Optimize for #PF. That's the only exception which matters performance wise */
@@ -206,6 +216,10 @@ static noinstr void fred_hwexc(struct pt
 #ifdef CONFIG_X86_CET
 	case X86_TRAP_CP: return exc_control_protection(regs, error_code);
 #endif
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	case X86_TRAP_VC: return exc_vmm_communication(regs, error_code);
+#endif
+
 	default: return fred_bad_type(regs, error_code);
 	}
 



