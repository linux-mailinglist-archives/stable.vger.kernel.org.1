Return-Path: <stable+bounces-233601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHJrJ3IK1WnMzgcAu9opvQ
	(envelope-from <stable+bounces-233601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:45:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA983AF668
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0C3730AAEB7
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E23B8944;
	Tue,  7 Apr 2026 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixYs0iIu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD03B8939
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568934; cv=none; b=hAOQPbUBcOUupzTZaZdYOp/uKdUAt5r9iGXVP6lqhJLvV+FVI7ESqAqlXmFblqDd/nujcL1GmvCna+CvvtsMr5Ev0PD4BL84e3E3OGvuhxvlrt2MPalnEAN4Gb597f1pf+D16EatPcycUqnK3GjVTl+DugUspR6zsKDo6L1NgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568934; c=relaxed/simple;
	bh=8xv2+/I502oembwKC1hgQHH6HXnvjGguCZ3vQ07H8o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifFL6yfDxKzZROG4oawbF/PLYcNrfB360gZDjBM6ckYqst5J6fpxZYkv+JO9fSG80kV/44SnHClUA0UE4HvY0v427+oEktAiHWrX2Je/vxggtDL+KZztOBghL31A5i33RDYaBgbMcwj1hKnC//VCt5JhUoc57Dv6dT+3E7ffS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixYs0iIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5CBC2BCB0
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 13:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568934;
	bh=8xv2+/I502oembwKC1hgQHH6HXnvjGguCZ3vQ07H8o0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ixYs0iIuod8OfgmQDbfcGhlCO2YMaYJuxq/5gjLGIHPmeyA5fQVmKI9w1sUXs13US
	 gta9NWI3OSsiAM+07oKalPiNQ8kDQuvF3R3dNMp21Y9bf+CpBQNoFVKwyhHBUhPGbV
	 yDvuorTbc5s91oCIC8Xl/OwJyDZOLmdWjTZ6CP6+n2hsLpNG3255OquiXJQL7KVIxO
	 xBGEdwrpmsDOKUFiF+29VDLGujWUYbmWcBpAouF3sCdObej0wT0fjhPGRdlfqU+GGo
	 8PV6lXnxOlCp5l5ZK/y07D9ThjVTGAaDlLKV7uurua+tCySf8hI18DTLXSH43YQ2tk
	 NjW10dP6A6kfg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38df1889fb9so26878741fa.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 06:35:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6+50Lu8JQOTFULB2ghPwFZx0+W9yPo+65v/HU3vlglYVCWMbIAi8np/QRLSRBWYfa2w+xf3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRJAYAB4kFRZxAk8MbQWdLqFgCt0oM6lxc3FCNEGhcRJE0yoI
	HjOHoPtagToQkwDBOqyoq7crDli3txZvZTcXLGnyL0d+72n9NzddY6FzuiUK8qFt05ngC0gZViI
	Oykv0+x/GxAhB9SEYKb6eYuhXe/iQpXI=
X-Received: by 2002:a05:6512:39c5:b0:59e:5c8f:a5 with SMTP id
 2adb3069b0e04-5a337550532mr5193763e87.4.1775568933230; Tue, 07 Apr 2026
 06:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
 <20260406111531.779571d7@gandalf.local.home> <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home> <adTqIepV2W6M_Q2o@pathway.suse.cz>
In-Reply-To: <adTqIepV2W6M_Q2o@pathway.suse.cz>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 7 Apr 2026 09:34:57 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9nPvGaYPKj5Py0OPrU1E8JgDrLNM29d+iwc3c2U6KZ0kg@mail.gmail.com>
X-Gm-Features: AQROBzD1P1WfwP-_hpTHUA78ggaqKXTjMOawjo65XdowZFSEyuwcxJWRICng4sA
Message-ID: <CAJ-ks9nPvGaYPKj5Py0OPrU1E8JgDrLNM29d+iwc3c2U6KZ0kg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233601-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEA983AF668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 7:27=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Mon 2026-04-06 12:32:32, Steven Rostedt wrote:
> > On Mon, 6 Apr 2026 11:21:39 -0400
> > Tamir Duberstein <tamird@kernel.org> wrote:
> >
> > > Thanks Steve. IMO that is a very big hammer and not warranted in this
> > > case. There's been talk of encouraging distros to enable CONFIG_KUNIT
> > > by default [0], which would probably interact poorly with the change
> > > you propose.
> > >
> >
> > Branch profiling is really just a niche that is enabled specifically fo=
r
> > seeing all branches taken in the kernel. It hooks to all "if" statement=
s!
> > As you can imagine, it causes a rather large overhead in performance.
> >
> > This option is only used by developers doing special analysis of their =
code
> > (namely me ;-).
> >
> > The only real concern I would have is if the kunit test developers woul=
d
> > want to use the branch profiling on their code, in which case my sugges=
tion
> > would prevent that.
>
> I wonder if it might be possible to disable the branch profiling just
> for the printf_kunit.c as a compromise.
>
> Would "#undef if" in printf_kunit.c help?
>
> Or I see that DISABLE_BRANCH_PROFILING is an official
> way to disable the feature.
>
> I wonder if the following change would solve the problem.
> I am sorry, I could not test it easily.

Yes, we can disable it for the whole file. I decided against that
because narrow workarounds are better than broad ones IMO, but it is
ultimately up to your preference.

FWIW I did test that this patch fixes the problem in GCC 8.5.0.

