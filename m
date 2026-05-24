Return-Path: <stable+bounces-253981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ms6lJ0BeEmpTygYAu9opvQ
	(envelope-from <stable+bounces-253981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:11:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E15C119C
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 684C8300532F
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 02:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD01F5842;
	Sun, 24 May 2026 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RPcD/Lyi"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C01D2192F9
	for <stable@vger.kernel.org>; Sun, 24 May 2026 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779588664; cv=none; b=rrJaSWIqjpABhVABMeNXYFttu2tjrjrMxRjkDDomey7A6c3E5sspAbfwSMZ7y2S5Ai+rYF072mplQ8QAikM5nwlg3WFNuv+e+w+I9bq80EINcD/+Exm+9X3lDy36YjbBVmHDcDBlK81NMfhsKo2t1g8B6KaoLlWdEQkh4s+5xzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779588664; c=relaxed/simple;
	bh=G8XuKIoF2CKNP2nacRxsP2eioNxlrWvpPocyd7speC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUu6mGJq3Hzg2CDEI4boVHWauJmtlSmSoUDK7PENydOkvBrHRwtwc5uxvcud/vfraJK1JumCYZtyJ5kHdr1yoiqKR/nHam0gaDk0Jo/YkaT28IJBnuUtUV2EL2owJDxWcSs0iBpfuVevqbxEwpMZ8zMPTrGbu5q7seaJGCQNCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RPcD/Lyi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C531040E0140;
	Sun, 24 May 2026 02:03:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6Xc1_UwVJTuD; Sun, 24 May 2026 02:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1779588205; bh=JPnibbUU5yT/ZMOaw7cPfoR+MT5dLis2/tfJ3gUHzQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPcD/LyiuHW5J0mfUuVrGG1/RPKCyhN9rHCaZQzKhsGBmVog0gomsmlW0+IZXg+br
	 p61aIFqaDIHsNKSZc4bcqVoPjkDoxNK3jymah4lRfuBnJgeoEF1CGfhpm4/DSSbNbB
	 o68jiZAhdp8tmGIpgqZfe0X+4BPQjvkyq0DQJT/CfgtnZ7rW+Kglv8qK0qlEWVZNXF
	 gyYWI7236STz9m+jf3jN//BHSpr4EdGjSAfwCpzMDyID7YrsQSkwg0kepH5mkpUMqW
	 RAtGSJViMyLboekEWcdpE/9C3qJFkYkzFJko3mANcyWPrafP02zfRZsrVZ806+x1T9
	 Q+Z5zXCcatT5sL2d0IOweAnn92p7LoMXW9ED691KEa9b1RbjkKixI7fWytc9lcygXu
	 MQSOVFeEDArfejCecMpJdQPxSGIdh/lsDG4dtDxNjcSKcDQUXVhds6AqszW+Xn3AJX
	 cNHUp2b5VIqcNJG71CRnbZ/YTExS8lzqvnkZswJvdP3ATunkUKPqxyFQgUASvJVSzf
	 XVHjksbNcpkt3KLegwLETVVTC3eoDARtXYwrlHpXCoiWTC7ywqLNpcsQHARjo6FVOM
	 Vh1zKNSRjJX5aPEesT8hqyc1BLMNgrYWDh+mdddJtCBtY2E0+kRI7xcJCJMBXqMWL0
	 u5LIMnMIpE7xOEiSYjF2s2Z8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00:b8a3:f58e:8829:9ca6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3056E40E00C0;
	Sun, 24 May 2026 02:03:21 +0000 (UTC)
Date: Sat, 23 May 2026 19:03:11 -0700
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Jan Ingvoldstad <frettled@gmail.com>,
	stable@vger.kernel.org
Subject: Re: Linux 5.15 bug in vdso_read_cpunode() in segment.h introduced in
 2025, commit ac9c408ed19d535289ca59200dd6a44a6a2d6036
Message-ID: <20260524020311.GCahJcXxBMmgUUaWNv@fat_crate.local>
References: <CAEffzkxUELNHBzABxVmekE2C_MFuPyfbsvO33MXZy46pNRU7xQ@mail.gmail.com>
 <CAFULd4Z5vE7v37+4J5MLCttnG=cF0XX+Y_T0p1yeY36dL6i5Kw@mail.gmail.com>
 <DB2B5B4C-200F-4C0C-B14F-F58E0CF4078F@alien8.de>
 <F51A475F-F50A-4DE2-A098-871047496301@alien8.de>
 <2026052230-obtrusive-prowler-86c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026052230-obtrusive-prowler-86c2@gregkh>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253981-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fat_crate.local:mid,alien8.de:email,alien8.de:dkim]
X-Rspamd-Queue-Id: 9B0E15C119C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 07:14:10AM +0200, Greg KH wrote:
> On Thu, May 21, 2026 at 04:47:43PM +0000, Borislav Petkov wrote:
> > On May 21, 2026 4:46:11 PM UTC, Borislav Petkov <bp@alien8.de> wrote:
> > >+ stable
> > 
> > Now for real!
> 
> Ok, so what are we to do about this?

Right, it looks like Sasha's AI picked it up, judging by his SOB below.

Now, we don't really need to backport it to stable and I didn't CC:stable
because of that...

But yeah, it needs to be reverted because the binutils version for 5.15
doesn't support the RDPID insn mnemonic and that patch is not fixing any bug
anyway, AFAICT.

Thx.

commit 64f14b1ab6f39a704b62bf9b3fa28803cf2b3ebe
Author: Uros Bizjak <ubizjak@gmail.com>
Date:   Mon Jun 16 11:52:57 2025 +0200

    x86/vdso: Fix output operand size of RDPID
    
    [ Upstream commit ac9c408ed19d535289ca59200dd6a44a6a2d6036 ]
    
    RDPID instruction outputs to a word-sized register (64-bit on x86_64 and
    32-bit on x86_32). Use an unsigned long variable to store the correct size.
    
    LSL outputs to 32-bit register, use %k operand prefix to always print the
    32-bit name of the register.
    
    Use RDPID insn mnemonic while at it as the minimum binutils version of
    2.30 supports it.
    
      [ bp: Merge two patches touching the same function into a single one. ]
    
    Fixes: ffebbaedc861 ("x86/vdso: Introduce helper functions for CPU and node number")
    Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
    Link: https://lore.kernel.org/20250616095315.230620-1-ubizjak@gmail.com
    Signed-off-by: Sasha Levin <sashal@kernel.org>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

