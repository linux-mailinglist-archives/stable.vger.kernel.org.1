Return-Path: <stable+bounces-222509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y4aFMnQbpWnk3QUAu9opvQ
	(envelope-from <stable+bounces-222509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 06:09:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236DB1D305E
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 06:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBCE43017016
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 05:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B352C21C3;
	Mon,  2 Mar 2026 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="UfbA+ojx"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57428852E;
	Mon,  2 Mar 2026 05:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428142; cv=pass; b=BnrEO/eJhtedjxMIjt+PTEl0mJ35KqXtk2aDnxBXhzMDhAb9xoMuKcieei0U1HKQ9CQR9n0NgL+aGhF/3GOTFhCqyG5OBOR2GG7xYVXAsCnA9J8eN6/MvQGUOlyxs6PeuKdffkSYl+ZRD67EBStXHiaJ69jwNUNMa4KysduszfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428142; c=relaxed/simple;
	bh=tyNO1d8CAgcg6kM+zlvjsxd9tfKLG5g4U4EngbVxKCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNi8a/GgijW8sxMJYhrjGfpJR57EHiiXnuZdXD8d+oTmKq5GxJhJ8XoHYGxMBeFOGbHgWOrVOuL6lAoIVLD0zR1Xstz6xYhShRP5YLFq/i1A1gtFNwJzRzI9QprreKbmIpHqkSaw161tc/xFO2KZpUzJ/xJ6bbrtOJp/nmuelFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=UfbA+ojx; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1772428119; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kw+yRG86FogYdHfd1hHzfvHkhEtsnQvmicWnLHH0ZOeTf8vgUXyEvdF0O/zKEIxDYDkluP2x98meuaqtnyf9ArOiQebO6uY7vmUYQ3nZwQow89Ys+z1RGFgJc+51mwDSXaoJ8IESGmzn92x7Bg1Ggnl7NiJJC7vcB2g8pSPFOk4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772428119; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aq793r2RqnoJrRErZq+ZuyOttVmFHFdjZKiyEUBr6dc=; 
	b=S8ZPR/+RtC51GwuddojsdVPZknc+FS3T17PzdR2BKFRcsbNlkz6g66xiYRNc4R7QBVFTW+KBn6cEaa9Hh9ByUl5ua4a6F9dDE2J7GbgWuYYSADDz368jx+3OQ6s5GQ5+8vh0n8VIsz97FmGGRFjBm1pcP76+Lhq7OXwWZE9y3v8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772428119;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=aq793r2RqnoJrRErZq+ZuyOttVmFHFdjZKiyEUBr6dc=;
	b=UfbA+ojxvI9tAkili1Mm/VWQH0fA2KB9dfa9gun4Yisi9QtKTIqV3j5QAuJdCUGt
	BsEozq4gFeJWSdSzLPlyE6fwfXbAkS9gDAyxWu4HOOUEQCMPzUBQupffS1OCRLNXE+T
	hs0KrZxEtgqPFXRs+OT9oq93d5zVLM78r9XDlTFg=
Received: by mx.zohomail.com with SMTPS id 1772428116913556.802951201051;
	Sun, 1 Mar 2026 21:08:36 -0800 (PST)
Date: Mon, 2 Mar 2026 05:08:23 +0000
From: Yao Zi <me@ziyao.cc>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
Message-ID: <aaUbR-vuxmuRhAsC@pie>
References: <20260228173704.62460-1-me@ziyao.cc>
 <05f84fa5-d0df-4bab-80a6-5ff2c418b5ec@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f84fa5-d0df-4bab-80a6-5ff2c418b5ec@citrix.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.84 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222509-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	NEURAL_SPAM(0.00)[0.975];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziyao.cc:dkim]
X-Rspamd-Queue-Id: 236DB1D305E
X-Rspamd-Action: add header
X-Spam: Yes

On Sun, Mar 01, 2026 at 04:29:13PM +0000, Andrew Cooper wrote:
> On 28/02/2026 5:37 pm, Yao Zi wrote:
> > Zhaoxin C4600, which names itself as CentaurHauls, claims
> > X86_FEATURE_FSGSBASE support in CPUID, while execution of fsgsbase-
> > related instructions fails with #UD exception. This will cause kernel
> > to crash early in current_save_fsgs().
> 
> #UD is the expected behaviour of the FSGS instructions if they're not
> enabled.
> 
> Are you saying that this specific CPU enumerates FSGSBASE in CPUID, and
> permits setting CR4.FSGSBASE (without #GP for a reserved bit), and the
> FSGS instructions still do not function?

Yes. Without any workarounds, the kernel crashes in current_save_fsgs(),
which is the first use site of rdfsbase, instead of identify_cpu() where
CR4.FSGSBASE is set up.

> What happens if you read CR4 back after trying to set the bit?

CR4.FSGSBASE is set correctly, I wrote a small patch for testing,

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261cae40c..d89a2cc71147 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2048,8 +2048,13 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_lass(c);
 
 	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
+	if (1) {
+		pr_info("%s: enabling FSGSBASE\n", __func__);
+		pr_info("%s: before enabling, CR4 = 0x%lx\n",
+			__func__, native_read_cr4());
 		cr4_set_bits(X86_CR4_FSGSBASE);
+		pr_info("%s: after enabling, CR4 = 0x%lx\n",
+			__func__, native_read_cr4());
 		elf_hwcap2 |= HWCAP2_FSGSBASE;
 	}

On BSP I got,

[    0.298016] identify_cpu: enabling FSGSBASE
[    0.298021] identify_cpu: before enabling, CR4 = 0x1200b0
[    0.298027] identify_cpu: after enabling, CR4 = 0x1300b0

and on APs, CR4.FSGSBASE seems to be set by default,

[    0.414981] smp: Bringing up secondary CPUs ...
[    0.415211] smpboot: x86: Booting SMP configuration:
[    0.415219] .... node  #0, CPUs:      #1 #2 #3
[    0.001869] identify_cpu: enabling FSGSBASE
[    0.001869] identify_cpu: before enabling, CR4 = 0x1706b0
[    0.001869] identify_cpu: after enabling, CR4 = 0x1706b0

> ~Andrew

Regards,
Yao Zi

