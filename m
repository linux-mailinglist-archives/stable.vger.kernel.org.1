Return-Path: <stable+bounces-256690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL22DobWGWqjzQgAu9opvQ
	(envelope-from <stable+bounces-256690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:10:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1CA60716B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA0E430B237D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B3F3FDBFD;
	Fri, 29 May 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG2swdoJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B423FB7F2
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078072; cv=none; b=D4F5ilJymliCr69SAzjv6BaDHWt8OYcFwqAaPzDLcDkEXzO/UfVoXDeT3hvDfDJCBl5Ke21A6MDmqsps2WvKUUr+UqeAfraXX+nypN6wKYxAxnrYCcYqKHiWa3HSO31+U8GG6nnXHewoqmIqaznziTpu+Zb0SDUfManxuGZo9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078072; c=relaxed/simple;
	bh=IyY/lwyWYhS5V7U8wGFT91cqaG7vhEF98HX7pB4MzEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eimveNKXh/HEuLiOonPh9NzDKn0ScPgn75PVvw4P3ePXY/ylDLwQxC9iSGu3IRK2OVhWDpVLx+YZ2kcLTXEXIJDLoB1nU2EYL8uVKc6QMfvRMlL+CIDmbw1Vpl65OeeZTqdwTsBNl1osxxOn66u8mxadD0rppv8GEsu8fnevASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG2swdoJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7501F00893;
	Fri, 29 May 2026 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078068;
	bh=OFcPptDmGab3q0xWhalTnsnOP6uOzPlgFc1VXrOdlSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OG2swdoJyBSs44+huxocc1Z9zisXi08vRLJmNMd8LCeapCnCOWRqToHlcDzpzXyU7
	 rdrbSqvPJWBPsjt6+ynFWNBhzWSN4CxN7eSE8nu0ffaX6wUz7y2utxd2aYgDjeRiLH
	 VQ7YWw8bElT7adtejo8q2ySMnLxteoBXOvVt/tmp5cmQ6CHfUMlBmW0pt064VR2BeW
	 wegdGMh/2Ek/E+p9yvc6dhS9CYfbo+6zpjw7LkVcCKfZM8n1P2oC+mkTgjCUnLNCa+
	 6vPIz9XTuLmbQcj7aOkBETWWg9kTA/b947TxY5Rhgya7HpOWP33QWoZuR3BICXvNHF
	 gMlo6pUDbJxQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Rik van Riel <riel@surriel.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] x86/mm: Disable broadcast TLB flush when PCID is disabled
Date: Fri, 29 May 2026 14:07:46 -0400
Message-ID: <20260529180746.1509509-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052811-otter-banister-f094@gregkh>
References: <2026052811-otter-banister-f094@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256690-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,surriel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alien8.de:email,amd.com:email,msgid.link:url]
X-Rspamd-Queue-Id: AF1CA60716B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tom Lendacky <thomas.lendacky@amd.com>

[ Upstream commit 44126343d58c68adaa8343fbf1c07dd20078c35e ]

Booting with "nopcid" clears X86_FEATURE_PCID and keeps CR4.PCIDE from being
set to one. On AMD CPUs that support INVLPGB, broadcast TLB flushing remains
enabled.

There are two checks that decide whether the global ASID code runs,
mm_global_asid() and consider_global_asid(), that key off of the
X86_FEATURE_INVLPGB feature. Once an mm becomes active on more than three
CPUs, consider_global_asid() assigns it a global ASID, after which
flush_tlb_mm_range() takes the broadcast_tlb_flush() path using a non-zero
PCID. Issuing an INVLPGB with a non-zero PCID while CR4.PCIDE is not set
results in a #GP:

  Oops: general protection fault, kernel NULL pointer dereference 0x1: 0000 [#1] SMP NOPTI
  CPU: 158 UID: 0 PID: 3119 Comm: snap Not tainted 7.1.0-rc3 #1 PREEMPT(full)
  Hardware name: ...
  RIP: 0010:broadcast_tlb_flush
  Code: ... 89 da 48 83 c8 07 <0f> 01 fe eb 08 cc cc cc ...
  Call Trace:
   <TASK>
   flush_tlb_mm_range
   ptep_clear_flush
   wp_page_copy
   ? _raw_spin_unlock
   __handle_mm_fault
   handle_mm_fault
   do_user_addr_fault
   exc_page_fault
   asm_exc_page_fault

All processors that support broadcast TLB invalidation also have PCID support,
so it is only the "nopcid" scenario that is of concern. In this situation just
disable the broadcast TLB support using the CPUID dependency support by making
X86_FEATURE_INVLPGB dependent on X86_FEATURE_PCID.

  [ bp: Massage commit message. ]

Fixes: 4afeb0ed1753 ("x86/mm: Enable broadcast TLB invalidation for multi-threaded processes")
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/b915acfd63e8b2a094fdeb8dc608738072518764.1779296450.git.thomas.lendacky@amd.com
[ adjusted insertion point to after X86_FEATURE_SPEC_CTRL_SSBD ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 46efcbd6afa41..155df2e586749 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -89,6 +89,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
 	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
+	{ X86_FEATURE_INVLPGB,			X86_FEATURE_PCID      },
 	{}
 };
 
-- 
2.53.0


