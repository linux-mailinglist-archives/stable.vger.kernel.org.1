Return-Path: <stable+bounces-233391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCDfJtvP02n8mQcAu9opvQ
	(envelope-from <stable+bounces-233391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 17:23:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03C3A4AEB
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFB15300F12F
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331338655F;
	Mon,  6 Apr 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2gdE/DE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986038654F
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488937; cv=none; b=cnsTSTPIa9CiK2NIEAsN2mVHLqZ91HcUKdbTu0SMB+tTCgt3Ib5JK1JAXGi3IG7/JTKj0LOqmEqw0aAU6XMK4e8rk68zFueJgKXZgnnsCoJnrbB0+BDo9lyqPcMPaZcOSW+RR9ydOGTYPEpMHWS/mSpsYDv0+iuxtW/SV9hsXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488937; c=relaxed/simple;
	bh=TNGMAD1M7XfV2g8MECbnStsriLepJV5/6Tr3MPcN3hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/fP4CBtpl4uRUwJTOXTtsbSPfUZo5t+lhpDwPBypyXOJloXqMgRLGcc42HGNp0fPVBy/2OOxZq58G4Y/0oRs/z5RSmk8lCKHLIvB3fP7I2RhoDZ7Q2iDjTN70Dot43xXJRXJzBosxd5lpiIa2NjZaCNKZwOjZnY/VfDDmn58Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2gdE/DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27DFC2BCAF
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775488936;
	bh=TNGMAD1M7XfV2g8MECbnStsriLepJV5/6Tr3MPcN3hc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F2gdE/DERo9bG9GbtIKuQVC9K7qe0H5EEVqF3kRlrtqJ391kn9LiQtNvA2MPttStb
	 qOhxiX1LeFm0rdKOf7EHuek7qh3Vx7o8teBjr01+SnhLGrXrKVuYE70BiwNZ1WVBI4
	 yKxJZJCVMiwwzocTQ9Y5vgY5y8ojSWDB01Ow5kskIGnEryXUt2YEY8G9zqH9duPJQJ
	 lOa1oJLwfoD21DNCMsWYVY+ENU2SuYlFxtmn4RvILlVvlJm1ulMerpI8URpEUT3fXx
	 znShEJzsg5zIbrjz9NG/gHxEvhZWIDmk+y1/GCaXy37zN4H+dlITuofCwUc1ZMKDz9
	 1ACjOq3n67eMQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e4a04f059so3786515e87.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 08:22:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVcQkw0iv5rjfTbZMCsEgB0/X1u/dqmjUY9mFSzxlmFu5SqehWM/w4fRXk4lBtXgzXmw1Of9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmHHQ3ocxQ/DTb8EvKVp2vRv5ENnVdw7oQdFdkqvH0kUplW+Ek
	oSxX0n1Z4ZzNd9mm8s+fM/IozqRkDpkjwoBjMvWfbGZ/e76aXzwn9avtcluJ695QPgQIJMu2s1g
	Ioq5SMUwIb7p2nXK4OHTw/hS6ffYKCI8=
X-Received: by 2002:a05:6512:39cc:b0:5a1:2c41:d28d with SMTP id
 2adb3069b0e04-5a3375635e0mr4067728e87.19.1775488935371; Mon, 06 Apr 2026
 08:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org> <20260406111531.779571d7@gandalf.local.home>
In-Reply-To: <20260406111531.779571d7@gandalf.local.home>
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 6 Apr 2026 11:21:39 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
X-Gm-Features: AQROBzD4KuvcKVeT3VeIsj7PaShRKHmAVM4qMRf--onmWDd6ekg4XVEqSvGjxUA
Message-ID: <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233391-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,goodmis.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF03C3A4AEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 11:14=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 05 Apr 2026 13:31:50 -0400
> Tamir Duberstein <tamird@kernel.org> wrote:
>
> > Old GCC can miscompile printf_kunit's errptr() test when branch
> > profiling is enabled. BUILD_BUG_ON(IS_ERR(PTR)) is a constant false
> > expression, but CONFIG_TRACE_BRANCH_PROFILING and
> > CONFIG_PROFILE_ALL_BRANCHES make the IS_ERR() path side-effectful.
> > GCC's IPA splitter can then outline the cold assert arm into
> > errptr.part.* and leave that clone with an unconditional
> > __compiletime_assert_*() call, causing a false build failure.
> >
> > This started showing up after test_hashed() became a macro and moved it=
s
> > local buffer into errptr(), which changed GCC's inlining and splitting
> > decisions enough to expose the compiler bug.
> >
> > Mark errptr() noinline to keep it out of that buggy IPA path while
> > preserving the BUILD_BUG_ON(IS_ERR(PTR)) check and the macro-based
> > printf argument checking.
> >
> > Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp=
@intel.com/
> > Signed-off-by: Tamir Duberstein <tamird@kernel.org>
>
> Another solution which I would be fine with is:
>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e130da35808f..c07e8eadfdd0 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -692,6 +692,7 @@ config PROFILE_ANNOTATED_BRANCHES
>  config PROFILE_ALL_BRANCHES
>         bool "Profile all if conditionals" if !FORTIFY_SOURCE
>         select TRACE_BRANCH_PROFILING
> +       depends on !KUNIT
>         help
>           This tracer profiles all branch conditions. Every if ()
>           taken in the kernel is recorded whether it hit or miss.
>
>
> -- Steve

Thanks Steve. IMO that is a very big hammer and not warranted in this
case. There's been talk of encouraging distros to enable CONFIG_KUNIT
by default [0], which would probably interact poorly with the change
you propose.

Link: https://lore.kernel.org/all/CABVgOS=3DKZrM2dWyp1HzVS0zh7vquLxmTY2T2Ti=
53DQADrW+sJg@mail.gmail.com/
[0]

