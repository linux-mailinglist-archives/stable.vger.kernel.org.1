Return-Path: <stable+bounces-269312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8SqPNj4LP2qOOQkAu9opvQ
	(envelope-from <stable+bounces-269312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 01:29:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266A6D0840
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 01:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Vtg3LD4H;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269312-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269312-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CD3C303026B
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 23:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CAD37DE97;
	Fri, 26 Jun 2026 23:29:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26536EAA7;
	Fri, 26 Jun 2026 23:28:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782516540; cv=none; b=OzE7nlQNnE9IMRD/3tfwQLPPdQPFPZN8N9Ezsg6qHUFGFFzue2SKLcwaYyI8x5B5JFwlSW67DQNqmAaVq7DPRZ94X5hQBEQ/HFqxGcRXzggbyEc1WeCL0GGN5JAk3rPZo/SZur+Uz640Ma8UnXw2fD4Ufnn/VZj87uIMH5UzVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782516540; c=relaxed/simple;
	bh=sLF0j9k5G3sPV9pXs8Bhs34ZVftOmCDqL0XjTnI072o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObyQOG3sIxdlB5fvt1NG2b3AvcInDlJY2OCxy+gBeBYaXzrE1lTbeBaA3ygQvRYATjxTANx20ShMLr9NPFRZJq9JD45Rake3cC9XmADN7yH7SpHq9PhCpKOmmqRVbCI6o6ryq/BbniI+x6NpZ2ojsKvPZS586my+gsvwXiaEAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtg3LD4H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370CB1F000E9;
	Fri, 26 Jun 2026 23:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782516539;
	bh=Q54CGCbAfRqpkJYxsYQ2H4AQ6E9u9/Ki7MJECVS1P88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vtg3LD4HaeTBcd33IOKYYyWyiAmjKfaAq8PPfM+fNk4iQrGGaK8jvVJZ/2i2nGTZL
	 JjZnEOaALksz7sgBG5bDAS+56TY5tUI/3qg4mZAnlXpjkjy252LGjk176kp0Jd1nyN
	 GGWNTaSd2VeuhmI0QnydHeSBwjpbmJh4sgNzHv1RBgniebFyuzacG1SsnATygkgFPS
	 bSq4j4l+aYTXxFzFkwRF/dz396dw0zU9xS6V8Z0vrKnyd/I0aQzewuEF0Qz9I79uKK
	 oL0PsNOy+h5Jp1bCMFCJDO2KFeNaL6//6q8KCc2BRacWwcFgPRJHMNMRla0xX+Cly6
	 sYzI77Du5cQTg==
Date: Fri, 26 Jun 2026 16:28:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Disable jump tables for clang
Message-ID: <20260626232853.GA547411@ax162>
References: <20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org>
 <ajulLtY29HtgWokg@gmail.com>
 <20260624093848.GA48970@noisy.programming.kicks-ass.net>
 <ajuoqIk4tSV7CmFC@gmail.com>
 <ajupfkcZTTxGP2dG@gmail.com>
 <20260624221739.GA7516@ax162>
 <20260625090617.4f3f68bf@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625090617.4f3f68bf@pumpkin>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:mingo@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:ardb@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:stable@vger.kernel.org,m:davidlaightlinux@gmail.com,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269312-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,redhat.com,alien8.de,linux.intel.com,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,ax162:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5266A6D0840

On Thu, Jun 25, 2026 at 09:06:17AM +0100, David Laight wrote:
> On Wed, 24 Jun 2026 15:17:39 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > On Wed, Jun 24, 2026 at 11:55:10AM +0200, Ingo Molnar wrote:
> > > 
> > > * Ingo Molnar <mingo@kernel.org> wrote:
> > > 
> > >   
> > > > > I'm sitting on a patch to unconditionally disable jump-tables for
> > > > > x86_64:
> > > > > 
> > > > >   https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/syscall  
> > > > 
> > > > In particular:
> > > > 
> > > >   https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/syscall&id=76612388fe7aa41a8eb88f890d451bc17255eda0  
> > > 
> > > Side note: since arch/x86/boot/compressed/Makefile constructs
> > > its own KBUILD_CFLAGS, so a change to that Makefile will still
> > > be required to universally apply -fno-jump-tables and work
> > > around this Clang optimization in the decompression code.  
> > 
> > Right. I had intentionally kept my change scoped to clang to be less
> > controversial but in the face of Peter's series, it makes sense to do it
> > for all compilers like Ingo suggested. I have no preference for how we
> > proceed here. I don't mind sending a v2 with something like
> 
> Isn't this solving a different problem?
> Jump tables are disabled for the kernel build to avoid speculation of
> mispredicted indirect jumps.
> Here they are needed to stop the compiler output containing 'things' the
> restricted environment can't support.

Yeah but if the end result for both is just -fno-jump-tables, it is not
like the reasoning really matters all that much? Maybe it matters for
the person that comes along to blame -fno-jump-tables in the compressed
boot Makefile. In that case, my patch could be added to Peter's series
with its original justification but applied to all compilers like Ingo
suggested? Again, no real preference.

> Someone building a kernel for a local machine may want to disable all of
> the mitigations to avoid their associated costs and also enable jump
> tables to avoid the cost of all the mispredicted branches in the comparison
> tree.

Then they get to deal with the fallout of such a change :)

-- 
Cheers,
Nathan

