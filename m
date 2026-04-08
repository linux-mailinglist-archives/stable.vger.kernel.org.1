Return-Path: <stable+bounces-233826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EfwLvYr1mkUBggAu9opvQ
	(envelope-from <stable+bounces-233826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:20:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692593BA712
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBFC13026CD0
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E913B636C;
	Wed,  8 Apr 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8up+Rj+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429963B52F4
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643566; cv=none; b=VjqkEHmcl0sEmq3OAq9+DIw9mClcFnKgnFtCY7MKvCi06GtxeZLWYr3DD0ii0VatCoYvgwcT3vzdyAJd2snhXv25RpBL71CsX6DJ1IpNF3t0uWGuFWppy7O+zwDYQIN0pf5iSfQW9WrPgw5LjVvKEbfyKin9GrurCjN7/C2YNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643566; c=relaxed/simple;
	bh=Yf3zc3v1e4y/GH6eAmt1wi2qeH0aR4z9qqbrXRsv4js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qn/AtQhW5b9qTyFf42eRMydoZJd8Q0j0uLbAl+y1rkvHKlbp9TFoH7ycppS2BUmIomLHSwSUaMzm1WbQv3uknCYC89Vgq3GVHng8Ex4e7Q31/G7ZWso/On3odXDQqYwWwShQ43hE8zVz7rGX1I5EHpPI6BfDrNpM9K2qY6ld/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8up+Rj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D9FC4AF09
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775643565;
	bh=Yf3zc3v1e4y/GH6eAmt1wi2qeH0aR4z9qqbrXRsv4js=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d8up+Rj+//U82WLElSWULoJphjfrKPM/5B9I4/T+lZfcha4Tgdf91penMzLNkJ2Rq
	 yxnWQWM9tXZc6UU980CzlBt0dQnBjW3/pyA8bdeJYM5Y1XY6t4jagpWd7vH3oxM/Pp
	 t6JRDpdg9DuliYFZorKiA4E/Szj5Fk81tP1VB6m2wtdCd3cWzr0XtUPJrVxf+k2erw
	 UVkZbckAtO8omBOn785tCMJqhd4vHDVVN5uCkrsXTrUxtpQMtmHGqaIt7QDlL6VpUu
	 WBXsKFIJmHzr68KjxgJ+LiygBz9+qETSiY1EyyDmMsUIBi6p8hBaMheJsdF8WmiSda
	 Fa2Gg7L2GRoAQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38dd9c6840aso38174351fa.0
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 03:19:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPRoaKU77RId4ICiJfIlOyD8juek6clhYF5BFbsg3r/t1m4Iyf+Fyt0jz3Rt8L18s6aH42TGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyja88yc4+nqv8H9XjsPfbYg7x5yLRxtHflsJGnVxcWeqU621LQ
	uAXpaD5zwd6cSKUABbc7kdj/f9UIpwJ2RQDca4qt/8GPese7V+pPcVdqgzcII4Sgm11wKpBrB1o
	O/qGEXATRyv617mX2+EdK74KuogDAgXU=
X-Received: by 2002:a05:651c:23c3:10b0:387:799:17f8 with SMTP id
 38308e7fff4ca-38d91bef49bmr44696691fa.16.1775643564298; Wed, 08 Apr 2026
 03:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
 <20260406111531.779571d7@gandalf.local.home> <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home> <adTqIepV2W6M_Q2o@pathway.suse.cz>
 <CAJ-ks9nPvGaYPKj5Py0OPrU1E8JgDrLNM29d+iwc3c2U6KZ0kg@mail.gmail.com> <adYAsnyZMykg3y9f@pathway.suse.cz>
In-Reply-To: <adYAsnyZMykg3y9f@pathway.suse.cz>
From: Tamir Duberstein <tamird@kernel.org>
Date: Wed, 8 Apr 2026 06:18:47 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9ni9bth243ciTynDXGWG20sSbz52jSYHPsiVdxixkncPQ@mail.gmail.com>
X-Gm-Features: AQROBzCOryPxyn0QH4broMgYgPInfrSwibuvKoeAY_wT-FaIyygJgoCooJ5Cny4
Message-ID: <CAJ-ks9ni9bth243ciTynDXGWG20sSbz52jSYHPsiVdxixkncPQ@mail.gmail.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233826-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 692593BA712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 3:16=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Tue 2026-04-07 09:34:57, Tamir Duberstein wrote:
> > On Tue, Apr 7, 2026 at 7:27=E2=80=AFAM Petr Mladek <pmladek@suse.com> w=
rote:
> > >
> > > On Mon 2026-04-06 12:32:32, Steven Rostedt wrote:
> > > > On Mon, 6 Apr 2026 11:21:39 -0400
> > > > Tamir Duberstein <tamird@kernel.org> wrote:
> > > >
> > > > > Thanks Steve. IMO that is a very big hammer and not warranted in =
this
> > > > > case. There's been talk of encouraging distros to enable CONFIG_K=
UNIT
> > > > > by default [0], which would probably interact poorly with the cha=
nge
> > > > > you propose.
> > > > >
> > > >
> > > > Branch profiling is really just a niche that is enabled specificall=
y for
> > > > seeing all branches taken in the kernel. It hooks to all "if" state=
ments!
> > > > As you can imagine, it causes a rather large overhead in performanc=
e.
> > > >
> > > > This option is only used by developers doing special analysis of th=
eir code
> > > > (namely me ;-).
> > > >
> > > > The only real concern I would have is if the kunit test developers =
would
> > > > want to use the branch profiling on their code, in which case my su=
ggestion
> > > > would prevent that.
> > >
> > > I wonder if it might be possible to disable the branch profiling just
> > > for the printf_kunit.c as a compromise.
> > >
> > > Would "#undef if" in printf_kunit.c help?
> > >
> > > Or I see that DISABLE_BRANCH_PROFILING is an official
> > > way to disable the feature.
> > >
> > > I wonder if the following change would solve the problem.
> > > I am sorry, I could not test it easily.
> >
> > Yes, we can disable it for the whole file. I decided against that
> > because narrow workarounds are better than broad ones IMO, but it is
> > ultimately up to your preference.
>
> I might be wrong but I think that nobody would want to
> profile/optimize this kunit test. So, this looks like the best
> solution because it is straightforward. The variant adding
> "noinline" looks too hacky to me.
>
> > FWIW I did test that this patch fixes the problem in GCC 8.5.0.
>
> Thanks for testing.
>
> Would you like to prepare a proper patch or should I do so?

Please go ahead with your preferred approach.

