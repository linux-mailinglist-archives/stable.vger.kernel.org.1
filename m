Return-Path: <stable+bounces-219844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKJ+G/SeoGlVlAQAu9opvQ
	(envelope-from <stable+bounces-219844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:28:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4251AE56C
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9047305EB92
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA3F3A0B37;
	Thu, 26 Feb 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M7I3K3Cn"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120644D03B;
	Thu, 26 Feb 2026 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133772; cv=none; b=SHX3/OCVFF/p6bjcdblnBejRh6AvXokjGHSjBUlFglDBt3mcnqVDNHaUahE376nrSZNwYN3OppPYEnJ0QEBug8AGzZOflP6B3rRVXtS9rYJebMdlSa+n9R9kkaWVCqM7kPOAnd7vdLMfdBxPzjzfp28AY7R9yj1/h+I6LmYj+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133772; c=relaxed/simple;
	bh=cb1bqT/DyufGoiraamw97UXPG1JGCmZej7kN3sii3Oo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gS89OzT6pQG8TJ+cqSi0YJl6YSvjYfDHydcMlNLt91PFMjhYJS7JuPdNY2NYB8s0Jxtiy2T+ykTZ4twLo52FiyXw7RYH05RnzI1U/oMx3U4vLYnQk5z2cLyQvF5w73MMQ+LaG1S9+xDMvNLVMIKxDWRP/Wyig6Qiy+M/Iv/qa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M7I3K3Cn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 012C140E016E;
	Thu, 26 Feb 2026 19:22:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OpU2h84bZxTp; Thu, 26 Feb 2026 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772133760; bh=8wxk3CG822GStoTXpJkk6I+gTYjesTORh2udWCdWL1c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=M7I3K3Cnal1Gd6LlkHqTIgzwDi52wfXMFhEmJaYIz4/mZb88Iu88OVecPruDhyOI3
	 GgqB/8+ykX3M1h7dsd/nLZo8LfewJ1cyyskBKxdgF8IYVdzz8/yOQz2E9vZKQOWUGP
	 N0oTLX/vxhBnLOIr0hP2aKsMMvsujavnCGCTy8v/q086AyR9itCh1d5rGiPJGs+HXW
	 96UMF0N5OGm7S/qJaVDF443lOoCNY4k7aYINjFB4wcn/Ya0/ssvBquUAFyIHev41qI
	 4uhMWobOmL6TedrlGThIHWTrTnWAYzslU8nGj65a28ZvWnA2U8RydTlYtwPAXQ7Hgk
	 sfVPppRYHeq5cWRVZ0sOa4P6HiGjKDzAKEaAk6ZmV/RIPdmaRPzKNCwLg5FliDdDbd
	 lIkFsdSRlGP7J35gQ0qsHupR1k8zGv+gplq9yC9FpF1MjfW9UDrVmuHzc0xaKVI86u
	 yxHlgp3ceeqzaMEQA8RR/VAMb9lGSog1ex0GWlmf/71KG4poSIjXdZIrbiVOaTvYgP
	 SbbPfZxw5SFmf+2a9W5x8C0Mxfm6z/Wwoy/S3JUnkYH7cLWs8r+MHInXegu3Bz4btE
	 5FXx94yeeYo8DY3dOSiV7Fy5ODQRxhtjb6s12wIve/tWLsE+ngU9A55QbSvUPCNlN2
	 yQoAIXTBTqMHGYVHsHZ7j0U4=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3033:6db:bde8:b104:c2ae:3935:ab76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0D6A40E00DE;
	Thu, 26 Feb 2026 19:22:29 +0000 (UTC)
Date: Thu, 26 Feb 2026 19:22:25 +0000
From: Borislav Petkov <bp@alien8.de>
To: Changyuan Lyu <changyuanl@google.com>, thomas.lendacky@amd.com
CC: ardb@kernel.org, dave.hansen@linux.intel.com, kevinhui@meta.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, stable@vger.kernel.org,
 tglx@linutronix.de, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot/sev=3A_Move_SEV_decom?=
 =?US-ASCII?Q?pressor_variables_into_the_=2Edata_section?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260226191612.1962381-1-changyuanl@google.com>
References: <5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com> <20260226191612.1962381-1-changyuanl@google.com>
Message-ID: <19F7B76A-8DC7-4CA9-9646-90931AF78CD7@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	TAGGED_FROM(0.00)[bounces-219844-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,amd.com:email]
X-Rspamd-Queue-Id: 2E4251AE56C
X-Rspamd-Action: no action

On February 26, 2026 7:16:11 PM UTC, Changyuan Lyu <changyuanl@google=2Ecom=
> wrote:
>On Wed, 4 Feb 2026 09:01:00 -0600, Tom Lendacky <thomas=2Elendacky@amd=2E=
com> wrote
>> As part of the work to remove the dependency on calling into the
>> decompressor code (startup_64()) for a UEFI boot, a call to rmpadjust()
>> was removed from sev_enable() in favor of checking the value of the
>> snp_vmpl variable=2E When booting through a non-UEFI path and calling
>> startup_64(), the call to sev_enable() is performed before the BSS sect=
ion
>> is zeroed=2E With the removal of the rmpadjust() call and the correspon=
ding
>> check of the return code, the snp_vmpl variable is checked=2E Since the
>> kernel is running at VMPL0, the snp_vmpl variable will not have been se=
t
>> and should be the default value of 0=2E However, since the call occurs
>> before the BSS is zeroed, the snp_vmpl variable may not actually be zer=
o,
>> which will cause the guest boot to fail=2E
>>
>> Since the decompressor relocates itself, the BSS would need to be clear=
ed
>> both before and after the relocation, but this would, in effect, cause =
all
>> of the changes to BSS variables before relocation to be lost after
>> relocation=2E
>>
>> Instead, move the snp_vmpl variable into the =2Edata section so that it=
 is
>> initialized and the value made safe during relocation=2E As a pre-cauti=
on
>> against future changes, move other SEV-related decompressor variables i=
nto
>> the =2Edata section, too=2E
>>
>> Fixes: 68a501d7fd82 ("x86/boot: Drop redundant RMPADJUST in SEV SVSM pr=
esence check")
>> Cc: stable@vger=2Ekernel=2Eorg
>> Cc: Ard Biesheuvel <ardb@kernel=2Eorg>
>> Tested-by: Kevin Hui <kevinhui@meta=2Ecom>
>> Signed-off-by: Tom Lendacky <thomas=2Elendacky@amd=2Ecom>
>
>Reviewed-by: Changyuan Lyu <changyuanl@google=2Ecom>
>
>>  [=2E=2E=2E]

Did you test it too to make sure it fixes your issue?
--=20
Small device=2E Typos and formatting crap

