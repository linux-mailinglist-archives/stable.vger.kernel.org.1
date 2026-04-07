Return-Path: <stable+bounces-233547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOHqNyPe1GnzyAcAu9opvQ
	(envelope-from <stable+bounces-233547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:36:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FF63ACF3F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA1430D6E20
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2933856472;
	Tue,  7 Apr 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkHLzMA+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFB39B979
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557883; cv=none; b=rjoQlHpl8Ca1WNcN5wXGO0pwnEgxvrbwiuh0FiaWxTE+liSx594DZoTwwzSh2CPgVFxueKPCSBiZJ5+1F2irukR7QBMk0N6nf7vGdCzcHzd9CS6WO+FURsuHMGv5r5aqSkME0EAyWK3kYHdmOtNe7/BCvwqjAfO0VWBtqAjl/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557883; c=relaxed/simple;
	bh=Ns5jjjTfJV+i/TeTxOZ94Cylidwstx6f3BYuQbVirBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk1Mdna/gxu823MKrlGYxR+Qw/+TJ6a6/ispETbZ/+fsRhrT/q1uR3TYattDz8DHXP9UgJ4uxmV+9HLG4SE3sTSageW+TKR2/bTNYH8GyndQDjDLzZUv0814yB2tCGymx4p/1gCBQmxdz12IDXtFRKii2yl7llAqx6kZ14jAkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkHLzMA+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0046078so19123525e9.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775557880; x=1776162680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lip3owYNVh4Y6wPGr1TWEoHeQbKxzTWWmz7TOhaw338=;
        b=PkHLzMA+A40Ne9UPX/TSZqEBXnNK41CSOz4RxOWTWJAFyL4GuxWTAv68E2S2+zBw/l
         p/ZMlU0+FwliICEB0OKppsgUA7/dFNLDTZPKrzU+o+u7MiW2dSVsY3nXW7TCbTE1DjB9
         VEem/nVN7YgHiB50Dn0+Y4JdzB78+tTnYgsfT/FTQNri1L2HL6naMWQoChYP4DMhUDm8
         RxgGYcEtfPwlgk+XIkPETm0a2PraoktNV8V6wIOUnJMvaRdJQNR+rPi/5cQ+JxrUyLOp
         qnH1Ka2xbJI41Q1qa8EdIxSfpilSuAnuUBlO1vYs0JoVi7uKjSqlHM//TnBmCZoVAJ66
         Np7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557880; x=1776162680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lip3owYNVh4Y6wPGr1TWEoHeQbKxzTWWmz7TOhaw338=;
        b=QHQlUhLMiMk+jEm8Vx2FR9Q8vKwv7JP7WeOOiZaQ6r25GeFWU2pXJbKC6g5sniRXqP
         PwPsd6EFFPFsX+4CR+nnaSsI6IKUde7pWrzKIuB12cFCDZUUtHpev/vLqEHbtauNoz+P
         Q+SypUqjuRVCse/DsqHFW1CeGTTP5/E8SzDjrZzs3BqUnfky/nuNqyLwDePwcEpAA+8A
         igoDSdmoEFz+ab+XlVbykcpPPfRdvtId7aBv4qDckmzXHK573tsamDAfl8I9TNzRgC1B
         F1aBhbAHIl2hCiHhNr1yw2qSsJozuNyIrephT4GG9LhBdGLnfmWiuZx2rwyko5VRS3an
         x0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU4qWa60ohHmP20lSsIcYS2ucTwH5TdM3XHE8mioeKWubr+Q3p+ikK/GDLTdYyR++cQ1eNUnNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYifwxV3hV3aFqdc/vO/flaN7NEbC7ARpHCc682MZmFlChJ1qQ
	AYVc29o81vQFPeKdvz5qP41wJcLypFYHeRzZ2yw4jrfVM75/yXatSYuseEd5lDId
X-Gm-Gg: AeBDieuRp2k12ymPYUqX1iUU/aNkBAqxsenKwN25IesDjvU8FnEFM5noqM0kaDExlTm
	c812maaG/Xn968NJXxyE7dpJHYEPEW2pX6h4QbAyoWy+wqYygfOh6n2Y6ei6a8X6RESIPTkNYG1
	gqJJ9ze2ckYHE+HxM3U7GyqzxVnxmacYgrVy/yzASIaoLgD+bKj1qqpt1XHsZkFo+xF1PuVsnsu
	JOXm4RoBjktKiQ96l3GudhHIN+BQB0D9X4Bbf8rKyGtF8hUeLPRiRUOjWYBQ0c1rWhS4MqqNLep
	xNiiRl3zPZpqlTwHCQAc/c40XJAGuacZA0edjbZC8ZtEAqqy0RYNtQStb3GFqnhi/5BJ0FEJO4O
	fBfTxD3b4FvCb88G48RdSCyANmf30wcuE1DdXU4u1Fq2/v2Xvf1MDx/w2zIG948l5FFanDSjUeU
	iIOEuQUmDGHxtlGqBAp5oZzhcMT+DKy3sWu9KXoZCGzp1F0WaSBPSPq62EzKZRZMQG
X-Received: by 2002:a05:600c:1c0f:b0:488:b99b:4177 with SMTP id 5b1f17b1804b1-488b99b7636mr55064655e9.25.1775557879563;
        Tue, 07 Apr 2026 03:31:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm273581495e9.10.2026.04.07.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 03:31:19 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:31:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <20260407113117.79cf04e8@pumpkin>
In-Reply-To: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233547-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 70FF63ACF3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 05 Apr 2026 13:31:50 -0400
Tamir Duberstein <tamird@kernel.org> wrote:

> Old GCC can miscompile printf_kunit's errptr() test when branch
> profiling is enabled. BUILD_BUG_ON(IS_ERR(PTR)) is a constant false
> expression, but CONFIG_TRACE_BRANCH_PROFILING and
> CONFIG_PROFILE_ALL_BRANCHES make the IS_ERR() path side-effectful.
> GCC's IPA splitter can then outline the cold assert arm into
> errptr.part.* and leave that clone with an unconditional
> __compiletime_assert_*() call, causing a false build failure.
> 
> This started showing up after test_hashed() became a macro and moved its
> local buffer into errptr(), which changed GCC's inlining and splitting
> decisions enough to expose the compiler bug.
> 
> Mark errptr() noinline to keep it out of that buggy IPA path while
> preserving the BUILD_BUG_ON(IS_ERR(PTR)) check and the macro-based
> printf argument checking.

Why not convert that check to a run-time one?
It isn't as though IS_ERR() is usually used with constants.

(There are a lot of other tests which would be better as compile-time
ones; since the run-time code just checks the compiler generated
the correct constant. So a compile failure saves you having to run
the tests; but that isn't true here.)

I'd also test -4095 and -4096...

> 
> Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@intel.com/
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  lib/tests/printf_kunit.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
> index f6f21b445ece..a8087e8ac826 100644
> --- a/lib/tests/printf_kunit.c
> +++ b/lib/tests/printf_kunit.c
> @@ -749,7 +749,23 @@ static void fourcc_pointer(struct kunit *kunittest)
>  	fourcc_pointer_test(kunittest, try_cb, ARRAY_SIZE(try_cb), "%p4cb");
>  }
>  
> -static void
> +/*
> + * GCC < 12.1 can miscompile this test when branch profiling is enabled.
> + *
> + * BUILD_BUG_ON(IS_ERR(PTR)) is a constant false expression, but old GCC can
> + * still trip over it after CONFIG_TRACE_BRANCH_PROFILING and
> + * CONFIG_PROFILE_ALL_BRANCHES rewrite the IS_ERR() unlikely() path into
> + * side-effectful branch counter updates. IPA splitting then outlines the cold
> + * assert arm into errptr.part.* and leaves that clone with an unconditional
> + * __compiletime_assert_*() call, so the build fails even though PTR is not an
> + * ERR_PTR.
> + *
> + * Keep this test out of that buggy IPA path so the BUILD_BUG_ON() can stay in
> + * place without open-coding IS_ERR(). This can be removed once the minimum GCC
> + * includes commit 76fe49423047 ("Fix tree-optimization/101941: IPA splitting
> + * out function with error attribute"), which first shipped in GCC 12.1.
> + */
> +static noinline void

While that might make a difference, I'm not sure that it has to.
You aren't changing anything directly related to the failing expansion.

	David

>  errptr(struct kunit *kunittest)
>  {
>  	test("-1234", "%pe", ERR_PTR(-1234));
> 
> ---
> base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
> change-id: 20260405-printf-test-old-gcc-f13fecda6524
> 
> Best regards,
> --  
> Tamir Duberstein <tamird@kernel.org>
> 
> 


