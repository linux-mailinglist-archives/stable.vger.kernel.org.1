Return-Path: <stable+bounces-239280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDZcCKJh5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:25:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 993464312E5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A43FA367B556
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAEE33D4F5;
	Mon, 20 Apr 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgOHq1Y+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF833B6FC;
	Mon, 20 Apr 2026 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699844; cv=none; b=Q4ST6puM2FUTNsqSnDolX9eI4HgN6L0Wm9Uc0rJVMrNf1xMjim1oDih63HpzkCv9fSl/kIZpr0d20tOJdZeU9LIvwU3eVqDLMX5NXDjcvpuqpN/szYoTk6MWALB45ZBHFsXjCGM+LMx6F6abXZUnngNEFc3GdGX0jL4SBNgClMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699844; c=relaxed/simple;
	bh=jLCs7Jkv1A1epTMqBUAGPEXP+2MJwIlcZGehOXBYUo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxU8zQ9fOYvxb9/sVRarApJYaLDyt29nnkrHVaDxkTOVo+E7irtFUt3DHxMR1t+n2Mb8nf5pCeJOkO41TAXFfqYEapvRVuKTqdpO5F7n8bY1aAqePCil0tr3El9BMRN7U3cQ9d8TvGSf/XhY98S5xybMMOC9MKItP1L6+LWLGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VgOHq1Y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD72C19425;
	Mon, 20 Apr 2026 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776699844;
	bh=jLCs7Jkv1A1epTMqBUAGPEXP+2MJwIlcZGehOXBYUo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgOHq1Y+w51y3LqgYeuZTRPttA857ESHu2VadFGUL6klFLXKZKQz1wHTTcu49fwgX
	 1ULgQ0iEKBD5T4N1skPOqsvZ7o75E5ffqLOepGJssma7EGqkIC+KXbVT04GqqIm1I5
	 8u46VbVVc3nHRHseD7CGfR3Ko5bKD+eT5nJpX3TQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 7.0 02/76] x86/CPU: Fix FPDSS on Zen1
Date: Mon, 20 Apr 2026 17:41:13 +0200
Message-ID: <20260420153910.903780184@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
References: <20260420153910.810034134@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239280-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,alien8.de:email]
X-Rspamd-Queue-Id: 993464312E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

commit e55d98e7756135f32150b9b8f75d580d0d4b2dd3 upstream.

Zen1's hardware divider can leave, under certain circumstances, partial
results from previous operations.  Those results can be leaked by
another, attacker thread.

Fix that with a chicken bit.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    3 +++
 arch/x86/kernel/cpu/amd.c        |    3 +++
 2 files changed, 6 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -674,6 +674,9 @@
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_TW_CFG		0xc0011023
 
+#define MSR_AMD64_FP_CFG		0xc0011028
+#define MSR_AMD64_FP_CFG_ZEN1_DENORM_FIX_BIT	9
+
 #define MSR_AMD64_DE_CFG		0xc0011029
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	 1
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE	BIT_ULL(MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT)
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -943,6 +943,9 @@ static void init_amd_zen1(struct cpuinfo
 		msr_clear_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 		clear_cpu_cap(c, X86_FEATURE_IRPERF);
 	}
+
+	pr_notice_once("AMD Zen1 FPDSS bug detected, enabling mitigation.\n");
+	msr_set_bit(MSR_AMD64_FP_CFG, MSR_AMD64_FP_CFG_ZEN1_DENORM_FIX_BIT);
 }
 
 static const struct x86_cpu_id amd_zenbleed_microcode[] = {



