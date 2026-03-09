Return-Path: <stable+bounces-223637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBpoDE/Grmn2IgIAu9opvQ
	(envelope-from <stable+bounces-223637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:08:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5DB2396DA
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2B85300A4D2
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B03A4F37;
	Mon,  9 Mar 2026 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVdE5J3Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8037378D99
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061610; cv=none; b=gl/Mw00Loj/FQXZukUtub2Ath3IzBvjh5TETXxLNdwZ8lhZbk39bkm2Bz6K3FrD3J4j5GfWhsH/vCb4vciCunG/DjjPfRf3OAJaZfJ07Exa4atoT8NR8Y8Vgrs/8KPql94wOvCAc2+Qiy6I8GUjNSHTX+rZzNQIKVzo08JuD2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061610; c=relaxed/simple;
	bh=D8WusAQW6nTsST/zkbJwVLlqggm3HAfugUq93a6gFik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFbRaqs9qCU40EmsbJ6tK/rXOTc5UCRO4WWwzvBpTYSNH19LiFsB8hYb+CLbwSudPKKZqktVj1GvED6ue9Di8pGrjEFeSmsHJKdiu7vAnH/z4JZuiGaROMEGG4V5pKpGbfoDwA5q5OQufpW46BVbLVEwMf2lErQEgnLkVDFFkXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVdE5J3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE7EC4CEF7;
	Mon,  9 Mar 2026 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773061610;
	bh=D8WusAQW6nTsST/zkbJwVLlqggm3HAfugUq93a6gFik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVdE5J3Zxdh/NjkUroRmryiqdJ2Rd8S/kVU7Q2taiJVT9huZVch6ZC+r/L9bF2lNd
	 8PMFFLver8C3zzFS8JI0CS0r4pGDbS+sIw9OuaUHRmAvnCVQVgFhL9nTUCoHJD6GX6
	 NcpYemqD7NrF6fpHE9sOBSCV8EeIWcLItOLpFAnomhE0siUA8E5w6WOo8mFtJfVS3U
	 thRoM+JvZu+mrvruc0KH6bY7JitBq3iuLkkQlqigBiEK/l5pBpsuqpIO6SvcM2QWCi
	 vcJnTlMUrd7UTnMEN78BvAH3RcJD5fIqY2z4MQoXfkKLPeaVFMmJ3VIeCN7J6Zz5uW
	 lt+Nf5gSuxmbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kim Phillips <kim.phillips@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] x86/sev: Allow IBPB-on-Entry feature for SNP guests
Date: Mon,  9 Mar 2026 09:06:48 -0400
Message-ID: <20260309130648.871470-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030937-dumping-dodgy-a0cb@gregkh>
References: <2026030937-dumping-dodgy-a0cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D5DB2396DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223637-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.986];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,amd.com:email]
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
index 4f61d48f25759..cdb3990a9c3ac 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -328,6 +328,7 @@ static void enforce_vmpl0(void)
 				 MSR_AMD64_SNP_VMSA_REG_PROTECTION |	\
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
+				 MSR_AMD64_SNP_RESERVED_BITS18_22 |	\
 				 MSR_AMD64_SNP_RESERVED_MASK)
 
 /*
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index afd65c8150437..749e7fe245e65 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -630,11 +630,14 @@
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


