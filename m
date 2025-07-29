Return-Path: <stable+bounces-165081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E080B14F5D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C169A3BBDCA
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1D31D7999;
	Tue, 29 Jul 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zgi45/50"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40422482F2;
	Tue, 29 Jul 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799905; cv=none; b=oUlI5SsqxFbbKvBmuNrWe68ncSjdsLO6bl3GzQ8rdTIlybqXr4omlIgqgNVldfa0Okjk5e1yel5mvOG0XlExUfqOlhidisLJd7layCJSD+/ZYr7GErkqjxQfQEBBoEgYHZqKIPRKvdFsHZKWIORZq0aYzvR/x1t/u3jcZqAzr08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799905; c=relaxed/simple;
	bh=brEQh0+evrmthE0np2XfgOVUvf7P/zR1bQigJp8ONEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ub1MyOQqEzs5jqDKSeHlECQURdgMJgdKR8DQ4oxgy0bp2mGol47TnCKS1JbAeI7UD4x6cQWVr9+izGMcrSHA4W7iWq7yyzY1y09kiNDF49FCQRTik4uTGlmdwUxdfqIlkFgmu8jMoPmqXk4wofvlRe2ZXpK8r0kYfSfCVkM6J2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zgi45/50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFB0C4CEEF;
	Tue, 29 Jul 2025 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753799904;
	bh=brEQh0+evrmthE0np2XfgOVUvf7P/zR1bQigJp8ONEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zgi45/50BFoUX4wmAUvho2E5b5M6t7N3J2Qpaw9au8vMffxLODnrlkB8wncNbgSB3
	 IUy5LCjny8Tddle7pDuU7PhuFLBOpcCYwD7osYo7QNe5JvNnbJmrsFpvXpPPlxCfv0
	 ICpPYhtuHdVS7oMg+jKD/0BFFPUwnc9/vJD2NXYw=
Date: Tue, 29 Jul 2025 16:38:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Zhivich, Michael" <mzhivich@akamai.com>
Cc: Borislav Petkov <bp@alien8.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Fix use of possibly uninit value in
 amd_check_tsa_microcode()
Message-ID: <2025072906-poking-basket-93dc@gregkh>
References: <20250722122844.2199661-1-mzhivich@akamai.com>
 <20250722142254.GAaH-evk-BqchvvIaZ@renoirsky.local>
 <2025072219-mulberry-shallow-da0d@gregkh>
 <PH0PR17MB4639467A94DEC056F2F46519B95FA@PH0PR17MB4639.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR17MB4639467A94DEC056F2F46519B95FA@PH0PR17MB4639.namprd17.prod.outlook.com>

On Wed, Jul 23, 2025 at 01:47:58PM +0000, Zhivich, Michael wrote:
> 
> On 7/22/25, 12:56, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org> wrote:
> 
> !-------------------------------------------------------------------|
>   This Message Is From an External Sender
>   This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
> On Tue, Jul 22, 2025 at 04:22:54PM +0200, Borislav Petkov wrote:
> > On Tue, Jul 22, 2025 at 08:28:44AM -0400, Michael Zhivich wrote:
> > > For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
> > > field in zen_patch_rev union on the stack may be garbage.  If so, it will
> > > prevent correct microcode check when consulting p.ucode_rev, resulting in
> > > incorrect mitigation selection.
> >
> > "This is a stable-only fix." so that the AI is happy. :-P
> >
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by:  Michael Zhivich <mzhivich@akamai.com>
> >
> > Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> >
> > > Fixes: 7a0395f6607a5 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> >
> > That commit in Fixes: is the 6.12 stable one.
> >
> > The 6.6 one is:
> >
> > Fixes: 90293047df18 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> >
> > The 6.1 is:
> >
> > Fixes: d12145e8454f ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> >
> > The 5.15 one:
> >
> > Fixes: f2b75f1368af ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> >
> > and the 5.10 one is
> >
> > Fixes: 78192f511f40 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> >
> > and since all stable kernels above have INIT_STACK_NONE, that same
> > one-liner should be applied to all of them.
> >
> > Greg, I'm thinking this one-liner should apply to all of the above with
> > some fuzz. Can you simply add it to each stable version with a different
> > Fixes: tag each?
> >
> > Or do you prefer separate submissions?
> 
> Ideally, separate submissions, otherwise I have to do this all by hand
> :(
> 
> thanks
> 
> greg k-h
> 
> Apologies for the barrage of e-mails; I managed to mess up the subject line on a couple, so I’ve resent them with correct subject lines.
> There’s now a submission per stable branch with appropriate patch and fixes tags.

Ok, I think I got them all figured out, thanks!

greg k-h

