Return-Path: <stable+bounces-238083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDfyCqRf32k0SQAAu9opvQ
	(envelope-from <stable+bounces-238083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:51:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0EB402E32
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 159F5308EB8E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42D1EB5E3;
	Wed, 15 Apr 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ep/fjC2M"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEA33F378
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246225; cv=none; b=ZwNLuOPlZm1hu9k6CP51aY0tA9t2mTzliRPJgKVxuE3vY5lsPYm1F3v3HqGwJGvNRHnqV3RAnozYHNH3rnMiDAI5sdMG7UdMHFprCHv8yvjmcmVwewLnPU+Ub6hP8pKKWLjFStfcuQf/PLF7UzdAJzmUAUflkPxMMYbSlqJ2heQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246225; c=relaxed/simple;
	bh=VfCr+rPJKq1kVMTTHMHQRThbrVtECkkVDZnJXbrPjp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q827o75nMKoIhs/NwGVwibj2+8BFL1PBH7eg3OXPtNTudcPTsiytApJiM3y+1+AxfQiFsje5X+7mKxMMbFfactXq3+wVW08osZCvA3YN2coKBFZScAz/0baivwGtLEZ+ERl1VekRJgG4L1IIykOkH11nqB7ab1kZOFuYk4AMAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ep/fjC2M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488c21c636dso39916175e9.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776246220; x=1776851020; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vq6Sz4CUehIve65NLT0zE1BYYdLq23upzZJ4mgDlVJc=;
        b=Ep/fjC2M+YRXj6vK7d/BbrySbJjzcYBGb8gmTX5MVBqXPelCqCgAfKNNX95KbTTZf7
         zbtsg5F9c18lAW4scPJpmAcH75RfCCBHB1SwtuXvzNDILCy5Ce2b80j/jwFu/Kc39lYp
         M1K1XwS1OPiEVFkmzLik2uBQTud+PbsqFMrjKn/ff4yoscPBQpQiml9qNrnCvJMeCtuE
         whZ1dbDygrFGDaXPA4tDGf9BlwAzWnE/iGiWjs1n5en9tv+X0mJ+/uhu6tgoR1ayFdkp
         CJf+IX2XDfcMz/mF3PhLIj1Qfxnf16XFPjm5SpJTnOvyAEkgeFYr1j4fBDVbkoXWZPkF
         70Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246220; x=1776851020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq6Sz4CUehIve65NLT0zE1BYYdLq23upzZJ4mgDlVJc=;
        b=pV7azBKkKdqpg39/MyA89YWOO1VL2ok9QFx0IAGqGalFchW2K/w5wY8e/JE8sOPpI+
         bi24DAyYrq/6NrFv6HGxvc78cQEmco9SNLpQMVLMOX1dn64+yHoTZH0haPdPpOX4rp4B
         eARSR5D3NkpPHGepQhBuR1V5TGUOyGjNzacfPg/NSvdRjkN+wbhTE/AIV6bNE+E3tfh+
         LIz5DgZVxOj2utlMcfY8z/yFx1/7DaIi6DNmULyMoiGx3LjlKSUhvvr47ob9FVisbv2+
         9xKwUhVcGBCuNIZXhSpRteKp9BIf1NjAHZiB2yeqgpqjj6JbBpDDLzXbiAJyo9nU5W6m
         YiSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Te9pt6VGQtbLvbmeFkBTY9cRuOZ6MvD36cY81DX/1fzHLe4NajXZ8fKNEM3Lm1LZUWEs8NuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1TOfLdRbhrf3Dsu/0WBtqOgqBV/Rb3eSdg1pW6XrpYBxMJg+c
	41sDgAjtuk6R4UhGWz/wag1Vjl9EqAj5qjcMMBms/Ur0P/wfQiDITI9AB0TOkc3bw+c=
X-Gm-Gg: AeBDietYqEOLoFSL8vBivZho0HtfN3sfcEFMoo+nVbIGT3WwpsxH5/rThVyhdKuuxrg
	flZaw4p2NnUHo2ewrC0OEN1L67tPEP4jXwgyN8qLnjKIJ0Y2fK/lpznCal3opJFiFzGfR33zbi7
	PBuFT6FddssZqKcie7NdG/WjmxTgD/ZSGnQCq4UXi/hb6h4o0msi289IJD111Yzj9cLBjiGSLcX
	qZpwMFBdV3cBzkoJguQY1BUem64hbHtnoeFiH1gS52u504jvJ3P3d1UG0+jtkj34zfHKh3O4Kwp
	mqZbmpn8l5kW9lp0AV9toeCFXtVsHM2sFJAmKk+bAnZDe5qF1hHPQSU0zGd9FYbYJWqDaWkbwyr
	37DN1afasflJddGFiWdgjhRt/VlC8ZVyFs0mjNIREvbSNpEWPKBmHMr5m1zBs5ZXVJsvvaGmso4
	7H9JAZ8v/16SLimhVlyJSEq4tGdb0mjkUJOYZ2
X-Received: by 2002:a05:600c:608e:b0:488:a2ac:a336 with SMTP id 5b1f17b1804b1-488d688d2f0mr287988515e9.19.1776246220060;
        Wed, 15 Apr 2026 02:43:40 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f1e87fbdsm36505665e9.10.2026.04.15.02.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:43:39 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:43:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] printf: Compile the kunit test with
 DISABLE_BRANCH_PROFILING DISABLE_BRANCH_PROFILING
Message-ID: <ad9dyQPLyob9qucg@pathway.suse.cz>
References: <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home>
 <adTqIepV2W6M_Q2o@pathway.suse.cz>
 <CAJ-ks9nPvGaYPKj5Py0OPrU1E8JgDrLNM29d+iwc3c2U6KZ0kg@mail.gmail.com>
 <adYAsnyZMykg3y9f@pathway.suse.cz>
 <CAJ-ks9ni9bth243ciTynDXGWG20sSbz52jSYHPsiVdxixkncPQ@mail.gmail.com>
 <adZJ41Cdvfv3-dWJ@pathway.suse.cz>
 <CAJ-ks9mNv7pefcS9iVZfMpqpkXGHNiPP4fCD5s1ZtUxRHo0XJA@mail.gmail.com>
 <ad5gJAX9f6dSQluz@pathway.suse.cz>
 <CAJ-ks9=NzPjb=eW=7GA2On8Lzv=R1wOBVpyuH+pqNZhG1u9uUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=NzPjb=eW=7GA2On8Lzv=R1wOBVpyuH+pqNZhG1u9uUg@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-238083-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,pathway.suse.cz:mid]
X-Rspamd-Queue-Id: 7F0EB402E32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 2026-04-14 12:07:59, Tamir Duberstein wrote:
> On Tue, Apr 14, 2026 at 11:41 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > GCC < 12.1 can miscompile printf_kunit's errptr() test when branch
> > profiling is enabled. BUILD_BUG_ON(IS_ERR(PTR)) is a constant false
> > expression, but CONFIG_TRACE_BRANCH_PROFILING and
> > CONFIG_PROFILE_ALL_BRANCHES make the IS_ERR() path side-effectful.
> > GCC's IPA splitter can then outline the cold assert arm into
> > errptr.part.* and leave that clone with an unconditional
> > __compiletime_assert_*() call, causing a false build failure.
> >
> > This started showing up after test_hashed() became a macro and moved its
> > local buffer into errptr(), which changed GCC's inlining and splitting
> > decisions enough to expose the compiler bug.
> >
> > Workaround the problem by disabling the branch profiling for
> > printf_kunit.o. It is a straightforward and acceptable solution.
> >
> > The workaround can be removed once the minimum GCC includes commit
> > 76fe49423047 ("Fix tree-optimization/101941: IPA splitting out
> > function with error attribute"), which first shipped in GCC 12.1.
> >
> > Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@intel.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Acked-by: Tamir Duberstein <tamird@kernel.org>

Thanks a lot for checking.

JFYI, I have committed the patch into printk/linux.git,
branch for-7.1-printf-kunit-build.

Best Regards,
Petr


