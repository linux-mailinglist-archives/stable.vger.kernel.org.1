Return-Path: <stable+bounces-254735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HJ7EWv0F2q5WAgAu9opvQ
	(envelope-from <stable+bounces-254735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:53:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A28F95EE04A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF44330908B5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31E34FF78;
	Thu, 28 May 2026 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W4k8yKR6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171535200D
	for <stable@vger.kernel.org>; Thu, 28 May 2026 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954425; cv=none; b=uzmNrzamDa028d1bWyUExDwatOhH4m2C8mQ6Nl0G/CiEWBmlKPf41pRYINUBSXJzyw9gyr8LEXTexk4GfYlrJk/Gj56Af33YB+W2vbodbSh8I6Ga85DJj8g6VWQ2G2cspeiidvAWUle75SBo0wh+Fu4ImrjtmoF8gcKX38nPeII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954425; c=relaxed/simple;
	bh=vWhfDMGsf8W4UepdfLtpRXeK8SBes4Qrx/YAWv81NoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cF1sjvdg2h0qST/Vfht2L76yJWsq41qm+UmkJJhvwgP9OFBOHPaFbvTObE3WzzhKh6uEsBz1BVA9mxVxQegG0NhQhRqMgb8yRPICLvxsip++FtQnntl3AY+e1qVaGh2t6POX899txAMRb4L/g/LOugxubyM375NCiybYwZbwkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W4k8yKR6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13D81F000E9;
	Thu, 28 May 2026 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779954424;
	bh=Lmb2CNnP2A5pY06fGvSgTUET/4KYMpQA36OV4jRpKAM=;
	h=Subject:To:Cc:From:Date;
	b=W4k8yKR60veLjXzhWv15kPp6BGQKTbIO018BnATn2SxGUUZJJPGeT7k+WzT3Jj+Gm
	 rdUuCptOuNYoM6ju/NhoVzP36qAcz39Xip08rASPqFa7d2PDIvyn5Jsqj5h87u2+Nm
	 9JuNvKyBBnJVc/fl/dMNfSU40GenkKDSw42tZPxE=
Subject: FAILED: patch "[PATCH] x86/mm: Disable broadcast TLB flush when PCID is disabled" failed to apply to 6.18-stable tree
To: thomas.lendacky@amd.com,bp@alien8.de,dave.hansen@intel.com,riel@surriel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 09:46:11 +0200
Message-ID: <2026052811-otter-banister-f094@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254735-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,surriel.com:email,intel.com:email,alien8.de:email]
X-Rspamd-Queue-Id: A28F95EE04A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 44126343d58c68adaa8343fbf1c07dd20078c35e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052811-otter-banister-f094@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44126343d58c68adaa8343fbf1c07dd20078c35e Mon Sep 17 00:00:00 2001
From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Wed, 20 May 2026 12:00:50 -0500
Subject: [PATCH] x86/mm: Disable broadcast TLB flush when PCID is disabled

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

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 146f6f8b0650..99801e844b30 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -92,6 +92,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
 	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
 	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
+	{ X86_FEATURE_INVLPGB,			X86_FEATURE_PCID      },
 	{}
 };
 


