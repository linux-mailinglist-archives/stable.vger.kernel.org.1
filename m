Return-Path: <stable+bounces-231415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKudM0m7y2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:17:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D38613695B9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3780301DA51
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D553A9D99;
	Tue, 31 Mar 2026 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O49ZhHue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEB271443
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959428; cv=none; b=RGQmSit/XFXCjCBjcXDAz+zi8lsDTBkf5UCO5TTwizE9dciy3lS4kc1YvbsGojG9+c9vlE9X/1hlpGnTRmKis0ezr25ePZ3uswDs+XfdFJtAVHuq5tKDQexJeOjgUWR97EiOjX0lPQPcpqxzrl1lqj2Qqr1teNr63USZgP9Zj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959428; c=relaxed/simple;
	bh=T6ptbdpTzlGbsB528d0JWQS23w+4AcDOQ331jz4Jh50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3WnCo/svuqRchjS4oyT6TNiefGkqsZ+sttXbdEkdIT0G2CnC+uHgzfGSrvz45wj74Obl4lpzqeCp0IUBR8NMosYVqjNAeKHfctICSGoSex8L3I2clvP0/AShhjBDryUt9esroWNk/ckMVI6jbC3IvpjpNcdW7wxNWpDiBk7mvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O49ZhHue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE9EC19423;
	Tue, 31 Mar 2026 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774959428;
	bh=T6ptbdpTzlGbsB528d0JWQS23w+4AcDOQ331jz4Jh50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O49ZhHueeL5ZauEI0pN0D61mH9Gmko8c4AwJW8WY80/SbfcnYpy1u1ZOVm6YrIt/S
	 kWbG7AmxE+mX9NyoB2RXmCM+oqnG49yHrYGymIE1POHQ7dRjDaaL8vZGD8r/4pJlfi
	 ewERh9RXcxFju71uBpf+drScXtgHy4CA2z/tJaCOsh1le7k2XCWTyvstsnCw3/lV+x
	 VL/MREM0hBFaFqpBrawOHJeICvTFSTlJQQX+RDlYdXHVe0tltnDWKdKCpIZFE2mr4S
	 NoSVnr6LPTBgOW/rP05FD8v2muNe5VJayLAKXk0oP0qaQlb2l4ocgeyb1lKZ3FTPL3
	 W9Nsb9GFQhQmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikunj A Dadhania <nikunj@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] x86/fred: Fix early boot failures on SEV-ES/SNP guests
Date: Tue, 31 Mar 2026 08:17:06 -0400
Message-ID: <20260331121706.2197458-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033022-wiry-prodigal-d8ff@gregkh>
References: <2026033022-wiry-prodigal-d8ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231415-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alien8.de:email,amd.com:email,msgid.link:url]
X-Rspamd-Queue-Id: D38613695B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 arch/x86/coco/sev/core.c    |  6 ++++++
 arch/x86/entry/entry_fred.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index d5329211b1a7e..2be730765f835 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -253,6 +253,9 @@ static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 
 	WARN_ON(!irqs_disabled());
 
+	if (!sev_cfg.ghcbs_initialized)
+		return boot_ghcb;
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
@@ -649,6 +652,9 @@ static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 
 	WARN_ON(!irqs_disabled());
 
+	if (!sev_cfg.ghcbs_initialized)
+		return;
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 563e439b743f2..9f50f0c1c00f5 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -176,6 +176,16 @@ static noinstr void fred_extint(struct pt_regs *regs)
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
@@ -206,6 +216,10 @@ static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long error_code)
 #ifdef CONFIG_X86_CET
 	case X86_TRAP_CP: return exc_control_protection(regs, error_code);
 #endif
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	case X86_TRAP_VC: return exc_vmm_communication(regs, error_code);
+#endif
+
 	default: return fred_bad_type(regs, error_code);
 	}
 
-- 
2.53.0


