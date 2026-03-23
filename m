Return-Path: <stable+bounces-228685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBLfFlhmwWlQSwQAu9opvQ
	(envelope-from <stable+bounces-228685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:12:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8FB2F7BA5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B86031C44AB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC9E3AF669;
	Mon, 23 Mar 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="llaaLgnl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4873AEF28;
	Mon, 23 Mar 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276852; cv=none; b=e6zjoxcIgzD5p+qiQhZqY9hLfqLwiGT3flA6yPa44uNyIumWTx6Lg98LCO4QGADamgKAE6JYars4qJaedEokslJCNP/vN9G8MdmW7+aDCupbuKttOoFBUhZH2XnIa9qw9JIAHuGR85w1/BLCJdNlGv6eGoPo5z2nnGVvSbAtsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276852; c=relaxed/simple;
	bh=kE/ImQAckUGHjhJC6rdfeSEeem/EOEjR/2/5PQaQ/qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5mC/GjXW4JyeQFFzJCPGnJ5Zk9r+zlccQ/z0jC/jitzYwBI1YOHclLMJyr96TlkAO7e40+HStavEpqcEU674EhwR0nylgdra6oFPpOxR6GgfAC32VQRDItIvBpOQnZFdjZDjXv+EsofUHN4LFKueYQrmDOTQ3PcOCUsN0L84LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=llaaLgnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A7CC2BC9E;
	Mon, 23 Mar 2026 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276852;
	bh=kE/ImQAckUGHjhJC6rdfeSEeem/EOEjR/2/5PQaQ/qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llaaLgnllQ6ZYBSHbzN6E/xTQYELJZXyP0HP2Q9lxWwa2WDQ6NBOR9oeVz7VNZlgx
	 di1UTQvxsPVMJ6rIgBNscN21MPM5NAvJc8F6nuQdfnGcVKeHt3Tn/emqNn5L4GI+RN
	 XQP1PNuUn8hXYy9hQ0qL+cEWxTY9qy9C0POuVqWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kim Phillips <kim.phillips@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 227/460] x86/sev: Allow IBPB-on-Entry feature for SNP guests
Date: Mon, 23 Mar 2026 14:43:43 +0100
Message-ID: <20260323134532.073201079@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-228685-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,alien8.de:email]
X-Rspamd-Queue-Id: DD8FB2F7BA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
[ merged missing SECURE_AVIC into RESERVED_BITS18_22 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/sev.c   |    1 +
 arch/x86/coco/sev/core.c         |    1 +
 arch/x86/include/asm/msr-index.h |    5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -357,6 +357,7 @@ finish:
 				 MSR_AMD64_SNP_VMSA_REG_PROT |		\
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
+				 MSR_AMD64_SNP_RESERVED_BITS18_22 |	\
 				 MSR_AMD64_SNP_RESERVED_MASK)
 
 /*
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -78,6 +78,7 @@ static const char * const sev_status_fea
 	[MSR_AMD64_SNP_IBS_VIRT_BIT]		= "IBSVirt",
 	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
 	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
+	[MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT]	= "IBPBOnEntry",
 };
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -691,7 +691,10 @@
 #define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_BIT)
 #define MSR_AMD64_SNP_SMT_PROT_BIT	17
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
-#define MSR_AMD64_SNP_RESV_BIT		18
+#define MSR_AMD64_SNP_RESERVED_BITS18_22 GENMASK_ULL(22, 18)
+#define MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT	23
+#define MSR_AMD64_SNP_IBPB_ON_ENTRY	BIT_ULL(MSR_AMD64_SNP_IBPB_ON_ENTRY_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		24
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f



