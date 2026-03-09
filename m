Return-Path: <stable+bounces-223632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mITCKiHDrmmRIgIAu9opvQ
	(envelope-from <stable+bounces-223632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:54:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6652393D2
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26C7F3008CB4
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65113BA233;
	Mon,  9 Mar 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KndaRrAM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF6332633
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060498; cv=none; b=R1mhHufJFdcjS450B3bz3ohWKVErZmxPovIz2rAEhhr0n4K1GtC1TCS+dL8Q4fg+lKKW3a9qD3bLP0lBJHyXbpdipOeO9FH2FVZ0c0rpKcaE8XitN2nQZgz0fe5rb6vTLsGEVW15vFUC3Tcn76QVbN/NPJtTQqiWTja81K4ZLfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060498; c=relaxed/simple;
	bh=KrjlaBHqcHyHVoufitJkGT8YmVdzKT7qJG6TmKDW7Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3MOXVx+GW166Ic0f+348YvzFm5BzR2hyHgHzsTBpgj0TpzXK+Ldj73Xyie72EEf1g/mtw8tP4lu2xdlWjEk8VCGg3t83rNu8dVHjB61uUefX23KFdsTxBWPJQ3ti3VBQkcxcWO2GhAH269qly+xVgtA0RlUER1tARa6Fri0fP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KndaRrAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560C9C2BC86;
	Mon,  9 Mar 2026 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773060498;
	bh=KrjlaBHqcHyHVoufitJkGT8YmVdzKT7qJG6TmKDW7Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KndaRrAMf2M+PozoPAcV7nfPAoacKMMYbLro5aTebuMTWGRP70rCOes8Ja+8rL48v
	 Is+/36DD0cGDhMeDBdd7GijYLuFedxASJXp/gWvM+/vJ5TEao2KL0lY9w2djVPr89a
	 sAWQhvbSjEM5cfSVMpaUsIFWHEZze7JXaY6wFQC9NGPLWizLwbgxkTHnIPVUgDwA4a
	 6qblfSSBLgoYHOQot9JjoVkuei+6cwNszPV/wBm3zQ96G577quCHyHE6ebc9hDuCuM
	 2h5pWr0uJ9ecm0IY5vaWXCd1sy916jUFWcLCGuw5aBUHRR+v1uxsCwflXC9TcexeHx
	 2ESIl9XkyhblQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kim Phillips <kim.phillips@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] x86/sev: Allow IBPB-on-Entry feature for SNP guests
Date: Mon,  9 Mar 2026 08:48:15 -0400
Message-ID: <20260309124815.862405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030937-ripening-sixteen-40d9@gregkh>
References: <2026030937-ripening-sixteen-40d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE6652393D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223632-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.985];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,alien8.de:email]
X-Rspamd-Action: no action

From: Kim Phillips <kim.phillips@amd.com>

[ Upstream commit 9073428bb204d921ae15326bb7d4558d9d269aab ]

The SEV-SNP IBPB-on-Entry feature does not require a guest-side
implementation. It was added in Zen5 h/w, after the first SNP Zen
implementation, and thus was not accounted for when the initial set of SNP
features were added to the kernel.

In its abundant precaution, commit

  8c29f0165405 ("x86/sev: Add SEV-SNP guest feature negotiation support")

included SEV_STATUS' IBPB-on-Entry bit as a reserved bit, thereby masking
guests from using the feature.

Allow guests to make use of IBPB-on-Entry when supported by the hypervisor, as
the bit is now architecturally defined and safe to expose.

Fixes: 8c29f0165405 ("x86/sev: Add SEV-SNP guest feature negotiation support")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20260203222405.4065706-2-kim.phillips@amd.com
[ No SECURE_AVIC ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/sev.c   | 1 +
 arch/x86/include/asm/msr-index.h | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 92c9f8b79f0dc..efada64e80ebf 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -341,6 +341,7 @@ static void enforce_vmpl0(void)
 				 MSR_AMD64_SNP_VMSA_REG_PROTECTION |	\
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
+				 MSR_AMD64_SNP_RESERVED_BITS18_22 |	\
 				 MSR_AMD64_SNP_RESERVED_MASK)
 
 /*
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 425980eacaa84..e58204e7714e4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -632,11 +632,14 @@
 #define MSR_AMD64_SNP_IBS_VIRT			BIT_ULL(14)
 #define MSR_AMD64_SNP_VMSA_REG_PROTECTION	BIT_ULL(16)
 #define MSR_AMD64_SNP_SMT_PROTECTION		BIT_ULL(17)
+#define MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT	23
+#define MSR_AMD64_SNP_IBPB_ON_ENTRY		BIT_ULL(MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT)
 
 /* SNP feature bits reserved for future use. */
 #define MSR_AMD64_SNP_RESERVED_BIT13		BIT_ULL(13)
 #define MSR_AMD64_SNP_RESERVED_BIT15		BIT_ULL(15)
-#define MSR_AMD64_SNP_RESERVED_MASK		GENMASK_ULL(63, 18)
+#define MSR_AMD64_SNP_RESERVED_BITS18_22	GENMASK_ULL(22, 18)
+#define MSR_AMD64_SNP_RESERVED_MASK		GENMASK_ULL(63, 24)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
-- 
2.51.0


