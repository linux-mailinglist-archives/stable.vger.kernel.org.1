Return-Path: <stable+bounces-227177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BlQB0oku2lofgIAu9opvQ
	(envelope-from <stable+bounces-227177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:16:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF292C34F4
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A555302D596
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D972D8780;
	Wed, 18 Mar 2026 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m/EsEmpy"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAD22A80D;
	Wed, 18 Mar 2026 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872195; cv=none; b=G7mhE+AZzJeSMdjqS2t652QFGctSmdO7KUuRebbalf8YyH9WtWjzj9fAm+uX3S3IbOQ0uIGhfXjrGnQV8DraLLeXlm9vUHeNKjJsYcgeBpWGSjiqacadJkGDh3todmNpJtpqqDlDmIsoccZ5Vg3Id3laiD4xJ6aj6O2RvadYD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872195; c=relaxed/simple;
	bh=Zx6X6mshVKIiVDZnWVgEKM14U6Tf9VB20EJnu8tQevw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYfpY198gzParltIfelXX4BOGU6X4YdtNdSSe1Ku6VKB5m3qZWgUHhd9Vi41NBAXc/dqhHONUns6nNje0khHgtzOjaIN9P9YTlN2eFMwZOd19Q887jl2HPzRy7JaAi1aBBOiRT32Su17VSmkEMZTnqKqFb4E0/LrfAaB+TRU8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m/EsEmpy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7wo/54P4l0J8n7qcAtQUTmk6ENzX7xVbSdgCHR9ANyw=; b=m/EsEmpykS6bGyV5hEQsKSo20n
	ORyDyEBVvIPVqLy/RTWYq84/kF2Qkn1M66JxKtbPJQsK0WeByWdM+XohdFXhZn3J4CKctfsB2oTqX
	Qd+x4w8rBthVOJtmQjuENejAygRdW1DJ6Dalm5n88ILcvmOjpjt2DL9vt9KjOULjlBuoHJixw6069
	9tJzDROlMU2sDupRuR+M2OHueqaqlzswQHH7W2CQClNqjc0p3hjEhLv2Hjic5CohpTlQsP1/W460B
	+qIz7t+YVlIgZKStZxVOhnTLC9k7zzf154xv16G5Zp44bEUqpvrQI/ElEXFmSxOiRKGKr/B6ULGtk
	dgUTgQOw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2zBi-000000055cT-065F;
	Wed, 18 Mar 2026 22:16:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DB5E83004F8; Wed, 18 Mar 2026 23:09:39 +0100 (CET)
Date: Wed, 18 Mar 2026 23:09:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Nikunj A Dadhania <nikunj@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org,
	x86@kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [tip: x86/urgent] x86/cpu: Disable CR pinning during CPU bringup
Message-ID: <20260318220939.GD3739106@noisy.programming.kicks-ass.net>
References: <20260318075654.1792916-3-nikunj@amd.com>
 <177385987098.1647592.3381141860481415647.tip-bot2@tip-bot2>
 <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227177-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DF292C34F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 09:47:22PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 18, 2026 at 06:51:10PM -0000, tip-bot2 for Dave Hansen wrote:
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -437,6 +437,21 @@ static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_C
> >  static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> >  static unsigned long cr4_pinned_bits __ro_after_init;
> >  
> > +static bool cr_pinning_enabled(void)
> > +{
> > +	if (!static_branch_likely(&cr_pinning))
> > +		return false;
> > +
> > +	/*
> > +	 * Do not enforce pinning during CPU bringup. It might
> > +	 * turn on features that are not set up yet, like FRED.
> > +	 */
> > +	if (!cpu_online(smp_processor_id()))
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> Urgh, so this means all an attack needs to do is disable the online bit
> and it gets to poke CR4 bits.
> 
> This seems unfortunate.
> 
> And sure, randomly clearing the online bit will eventually cause havoc,
> but I suspect you still get plenty time until the system goes wobbly.

The below tries to explain the CR pinning; and shows how the above
effectively disables the entire scheme since the online bit lives in RW
memory.

That is, the sequence:

  clear online bit
  ROP into 'mov %reg, %CR4'
  (re)set online bit

is fairly trivial, all things considering.

---
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bb937bc4b00f..994e09d8c2fb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -450,6 +450,19 @@ late_initcall(cpu_finalize_pre_userspace);
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
+
+/*
+ * The CR pinning protects against ROP on the 'mov %reg, %CRn' instruction(s).
+ * Since you can ROP directly to these instructions (barring shadow stack),
+ * any protection must follow immediately and unconditionally after that.
+ *
+ * Specifically, the CR[04] write functions below will have the value
+ * validation controlled by the @cr_pinning static_branch which is
+ * __ro_after_init, just like the cr4_pinned_bits value.
+ *
+ * Once set, an attacker will have to defeat page-tables to get around these
+ * restrictions. Which is a much bigger ask than 'simple' ROP.
+ */
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 

