Return-Path: <stable+bounces-233801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHvOIPkC1mlsAAgAu9opvQ
	(envelope-from <stable+bounces-233801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F63B813C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B3CA300D146
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D703806A3;
	Wed,  8 Apr 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N5sLbBXX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DC377EB2
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633106; cv=none; b=XiNmu2J0f9cnT4YldEfqOWdq514hIqOuPv+/zoqZtZF20ELwOHhaEM97qcX2cdL9W1S6MoUpqcaCo2boWS2gm703iqBzBnQuNgJeywINPAAXXmlHHr8cA1M5WctV6Ac+32c6YfpjT3YpWQ6lh8ZSZWitYmJctEkxEaFmqBlGVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633106; c=relaxed/simple;
	bh=oitZO+Vh5EguyREMnhieBgzXee72g0XB25Nxdl/kqpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq16ZjyLhalUJ3mqc98xl8zC0ogACzIjLkcRLxEw14IZJadt+RRFIxRB9V/cZo9lHHSLSpzuR80NujQMJLSj7UR4gLAzpF6DZLOFvEw0BbNQtX7iYu9no8Ujmu2naVgvByZvBO7E44iY8VE+zFqLiodm7YSMPEPSETbMG7BxCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N5sLbBXX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso6157962f8f.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775633103; x=1776237903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqshG4+rR2i//whvag3I3lmaZu5klX7uBWNX5BGuGpc=;
        b=N5sLbBXX+tOsRugIhEqtRpqNuJyQ3SvUQuhynCH+4IaCXUpPkOKS/dS/apg3ik9a2P
         YoVqAShLtpXIihhMw7qn61bgr8fRa9WkQOxB/4pFjFCQgLxYYSX9pSy8YFPawONw9q5T
         RsnzkM9zBKtYgFATmrT+NmHekwTBZOfWy84G8HqRUhH//jof9LXvzegbZSn1yrhVz2l6
         O12D4yYU1XKikxcC7YH/KWoyQPL5dvzNH8Bj8mRvrVfx3xlOGChJ3kQ26oFwzGhjfW0+
         dCG3mSvFVPzcz2gzl3/691OUhLYeH0acOc+pfAlygsFIklHquq9OrXelyYUv8wgzlYTe
         403w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633103; x=1776237903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqshG4+rR2i//whvag3I3lmaZu5klX7uBWNX5BGuGpc=;
        b=gujL7ts+MGU2kxEixQB5CCk6+x+Ws+j/5g+dFxALpsEs6/+YPnZmjfbVPkpOpeNkZU
         wFcts3vs5TrMjJVC10D/cUdLA35UHPZS2x25POyU6bnEZWKfLOT9FrmLCxmYst1MlFHy
         geJBb8qbTvJNdUOGWyTuZweuDsiXfTuvd3w4BkxgD0PACy2FpCaVl+XjrxwTKB8+Kovv
         fBuK53gCd5cCsM96ak4ZQLRv3Ma+IUNiGs66jaM8oadOJPhowpj7wy5W2KfXr4ZGBKK7
         H36N9oU9murbOh0j+XIodEloru8rgU9+z+2DsTvhhHCddZ0Ped+bjUlXOg9cyQpHwnfu
         DM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjkSNrjMXvTZqq8xG1tZmStcGX27/iOW5IqxYQpy448A7CodKuuBSf7BxVYLt+AiQYobjaKSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFft2Ztnt81WdCCXiAaEl1yl8YzwO8So0YRdoGJuzLi6K4Bgjh
	mEgyCHTVfm6QUgg2tsFjLzBQQ0MKcLJXHWf7DmuITSTEnZC2ScPX7Ea3awXwdqI3lI9N2MYwV8V
	UsNDod5A=
X-Gm-Gg: AeBDies6R7hfJB7Df4CpFnd9kHthrWJkmCDYpCAzuKyKNxLpZKP6a9T6Gl9WDoxo/Ob
	ilpRcrh+F4dpoDK+FnIqRp93LjP55tV/f8kf5e4lrQjeAtmd4C5Fb/LU0b1VCwDIE1Z6ecdmo3e
	X8F5O3yzWS8upMiUMma2wabBY4Dth9wS1gX4eMVnHWbf6EjtBglHO5rfdlASrkPfX6YMv/msuNd
	J3WQYtgvU0kZ5cB46qsrQ4ZdBHMer46y4eedX4DDsoWN1St3Tln+fE+a755h3neVKHuemPZ8Fz1
	hEtpzcWLmLY1JrnohqBsVCapAtIKEzxAbSkd9RnnVj13yLGCUmAGkqYIjdiyw7hDgNwWUzYrO9d
	yuDrYra6Qkcb/PfkqO1FXsDmkxintyxmTQ7zz2M3l1moCETH33odDj47AMu6mjxZ5Xl0E4pdkYA
	DNLfObHicWZkiIyyHQdSJkr4IN7g==
X-Received: by 2002:a05:6000:18a9:b0:43d:4c:22a4 with SMTP id ffacd0b85a97d-43d292e84acmr28030513f8f.40.1775633103201;
        Wed, 08 Apr 2026 00:25:03 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm57510075f8f.0.2026.04.08.00.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:25:02 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:24:58 +0200
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <adYCyvTlIoTdnKcL@pathway.suse.cz>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
 <20260406111531.779571d7@gandalf.local.home>
 <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home>
 <20260407160809.48d5fe2a@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407160809.48d5fe2a@pumpkin>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233801-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,pathway.suse.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Queue-Id: F05F63B813C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 2026-04-07 16:08:09, David Laight wrote:
> On Mon, 6 Apr 2026 12:32:32 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 6 Apr 2026 11:21:39 -0400
> > Tamir Duberstein <tamird@kernel.org> wrote:
> > 
> > > Thanks Steve. IMO that is a very big hammer and not warranted in this
> > > case. There's been talk of encouraging distros to enable CONFIG_KUNIT
> > > by default [0], which would probably interact poorly with the change
> > > you propose.
> > >   
> > 
> > Branch profiling is really just a niche that is enabled specifically for
> > seeing all branches taken in the kernel. It hooks to all "if" statements!
> > As you can imagine, it causes a rather large overhead in performance.
> > 
> > This option is only used by developers doing special analysis of their code
> > (namely me ;-).
> 
> Is there any way to stop randconfig picking up options like these?
> It is rather a waste of brain-cycles trying to fix them.
> If you want the option to test a specific bit of code it is easy to
> hack/disable any problematic parts.
> 
> Even having the KASAN/KMSAN code compiled into allmodconfig is a PITA
> when you are trying to check that code compiles to something sensible.

This does not look like a good idea. KASAN/KMSAN are very useful
features. People will want to keep them working. Removing them from
randconfig would just postpone detection of the problem. We would
need to deal with it sooner or later anyway.

Best Regards,
Petr

