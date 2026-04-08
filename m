Return-Path: <stable+bounces-233799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KImOJPUB1mlsAAgAu9opvQ
	(envelope-from <stable+bounces-233799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:21:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C9B3B80AE
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B613011BF6
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A4837F8A2;
	Wed,  8 Apr 2026 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="anHkQLDv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6B31355C
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632568; cv=none; b=sh7WOg0QsQD9G15iSX9xl9KiwxLJJQpERJihSfUJe1DNXrmkLimWG5LylFV81HzadhVVkfJuRLkohR2tGYyqyVnXgmbGUp3jqjrbBKD8RiWP6okH34CTb0Lt/Ohaso2f5rjjAf38Laoxlqc89FCLVb6yBDcfUMg/FdoYHDrblkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632568; c=relaxed/simple;
	bh=9mLuglNH3FKPjdhxyVkeCI6+TVHmop8uBQ9paa7GcNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGbTaByRvNOJjsroGxHlJop4OlBlTW/M18KiiPwwmtaxmWND9BfGb67m68q8/XOTyZG6JO0ViGEogqvHFYaNUUmxv6XzDP+7XSxFmZEV7OO6pfLlptQhCW24fh04KKYtigpzsRqtXROpBaYlh0dZpqhDH7aNP2W4l2oI81uwtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=anHkQLDv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso37038185e9.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775632565; x=1776237365; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+JSJPVJheZs+jLQNjabV2nmmAY4UsDd6PMBO0XLhv9Q=;
        b=anHkQLDvjlHd3vo6UVxRmhwMrwCO0zmvea4NFq6mCzyqkk6KbY6jUByGU4MsDXWU0J
         1uMbWzAD2ekurp6Lk8RD+zdRhp2RueLg3FU7akoHKQB4RHNnT0AlCoc7RjkjTvjR+uus
         Cyug1yvRzu/U7xChVSPavun9AETIsLgXKQk0CE/f42S9sqL8mvPDb3dZrVW4NkK3fctx
         J/D1rDG6Mmot9alBeBSObJtPrKFR7Iy3gIUM+vWhf03fNHQvNba4U+Bs2DqvNg6DIf7s
         oRgt3jNTuteGtNT9YuvcdaMUtuNyizftwBtMPoc33cU9X87vQhUsKiQbBZM8mXm0H/Pj
         u4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632565; x=1776237365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JSJPVJheZs+jLQNjabV2nmmAY4UsDd6PMBO0XLhv9Q=;
        b=QlrBMgKDvrTtvNG8034M/FbB6b7keGLX4cuv2/kffRSCmO91IDMdcywodEpuclTIrN
         +neT5Am7Qxkcfym/nANFeObRBnprwWUTQBooYrXBJ5OzGRMWasp0BRAWc4rJd6VeTYZL
         GCrA0++PVm0D+VR0H6YhJPPq/nPOtUhZ0+daLkvef0BLxPFDQZYKKGbx5hgRSpN7MiU3
         znzA8LJPFG+X5huBQTuxRZ2KiAhIN2BM4OSGFrdOfcUNVCkIkI8WNOoinqiZfc7cr/Vs
         jFzbBEH1NRp02OR4+Fi1WYDxABYq/JMCN1sAgp/aqsSByjA/0F6jcle7q1V8RKA31LlN
         Ob9w==
X-Forwarded-Encrypted: i=1; AJvYcCVAGcb1gMs0kRvHBqvZYmXbK52oD7bkbx++ogfTMuQbPezqxGX7W3/jFOrWTI0BP3MkXHmTVVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxmGMS75D+1DRcwcwhNr9rA2fhBUOp1nSw4OMQcU5K3o3nBeYe
	YcvWFHlriaPyTMJ2hVUaYLX5jJXCfITqMVudVd2XuaR1dV+ykcoCNB7JSlYvlDmb114=
X-Gm-Gg: AeBDievW5pAIMEJecc3qky2ir9WKtkTmG4E8coftJcTiJdplX+HSSwt67DZznnN0XGD
	UgWqtKACfEb1VMERw2+yt0ts3lR/bUtLqqS5QKSVv43N8DMmRjLFqnbCJU7nYI+HJhWU3QleBu5
	8hx1xpI5Pt3Uwqp6ahZUGNueZRUTOo8mpq8TJz4a/jdxsIckk3hF7SVPBsARqCigqJhbjf4SOYR
	jp/qTxO02pYsiphCtl6YyG3TWDDefqQZKk+Ciy+pnZT2PhLuvTdZx6CSTQgNPl05DQkBKP0Sz+o
	MHVADhTesSNryBoAXUrX6BGfSIw7/fEgRzkWg5QQubD6Of/FxZyEXmq2RmrxPGdaz5ZxDL+IRrt
	e8fWGtblARvhtWS/PtbzFGZ3JG1fOv6mMF0s5kfDYIhkeR3AXUZvkDp1qsWfAaXmyAalUpSeYRW
	681zBPwgLZb/BNLkxtBBuCmFEE/6Nv/Be52MGY
X-Received: by 2002:a05:600c:4688:b0:488:b187:d8ed with SMTP id 5b1f17b1804b1-488b187e4admr133921165e9.2.1775632565324;
        Wed, 08 Apr 2026 00:16:05 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a72baa8sm475257995e9.15.2026.04.08.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:16:04 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:16:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <adYAsnyZMykg3y9f@pathway.suse.cz>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
 <20260406111531.779571d7@gandalf.local.home>
 <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home>
 <adTqIepV2W6M_Q2o@pathway.suse.cz>
 <CAJ-ks9nPvGaYPKj5Py0OPrU1E8JgDrLNM29d+iwc3c2U6KZ0kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9nPvGaYPKj5Py0OPrU1E8JgDrLNM29d+iwc3c2U6KZ0kg@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233799-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 02C9B3B80AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 2026-04-07 09:34:57, Tamir Duberstein wrote:
> On Tue, Apr 7, 2026 at 7:27 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Mon 2026-04-06 12:32:32, Steven Rostedt wrote:
> > > On Mon, 6 Apr 2026 11:21:39 -0400
> > > Tamir Duberstein <tamird@kernel.org> wrote:
> > >
> > > > Thanks Steve. IMO that is a very big hammer and not warranted in this
> > > > case. There's been talk of encouraging distros to enable CONFIG_KUNIT
> > > > by default [0], which would probably interact poorly with the change
> > > > you propose.
> > > >
> > >
> > > Branch profiling is really just a niche that is enabled specifically for
> > > seeing all branches taken in the kernel. It hooks to all "if" statements!
> > > As you can imagine, it causes a rather large overhead in performance.
> > >
> > > This option is only used by developers doing special analysis of their code
> > > (namely me ;-).
> > >
> > > The only real concern I would have is if the kunit test developers would
> > > want to use the branch profiling on their code, in which case my suggestion
> > > would prevent that.
> >
> > I wonder if it might be possible to disable the branch profiling just
> > for the printf_kunit.c as a compromise.
> >
> > Would "#undef if" in printf_kunit.c help?
> >
> > Or I see that DISABLE_BRANCH_PROFILING is an official
> > way to disable the feature.
> >
> > I wonder if the following change would solve the problem.
> > I am sorry, I could not test it easily.
> 
> Yes, we can disable it for the whole file. I decided against that
> because narrow workarounds are better than broad ones IMO, but it is
> ultimately up to your preference.

I might be wrong but I think that nobody would want to
profile/optimize this kunit test. So, this looks like the best
solution because it is straightforward. The variant adding
"noinline" looks too hacky to me.

> FWIW I did test that this patch fixes the problem in GCC 8.5.0.

Thanks for testing.

Would you like to prepare a proper patch or should I do so?

Best Regards,
Petr

