Return-Path: <stable+bounces-233884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEN3LgBO1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:45:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAAF3BC5A8
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC6830214CF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742153C65FF;
	Wed,  8 Apr 2026 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWvUJGo7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E33C060E
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652164; cv=none; b=BWge+KMn6qYv6/jgmr1qOUEfE2PPK4b4S2f0PU72MhnJguAIEZuJLKa580yE/pjKcdcRRr0e/C3qCZezWCGONITrZJU+Me8LkdF5rH6CRI8BxLn7mbTh4y5A4j/1/7fBPNk+9AE7vODYOT28/PvhBCV/FejixUrJVvYWfW/dIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652164; c=relaxed/simple;
	bh=EHMJJ2i5PGdomPPLNMWOh9XKMvJCBgxC+n0hZy7D5Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaSjjUBDJeSb0GziQtLfA4sZOTiMM91/tM6i29FqXj/vm5HLcLeWkIKUSczcNxW0vSSo7f/S1yR/Wfl/pUfmEMzTrNopbFAPB1GHnOqDZ+SVD7hBmfSbKKsqE1zagMxwqwKJs23Acx/LWI/q411+6V/R4j7KlfZEfeyigA1LlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWvUJGo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F30AC2BCAF
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652163;
	bh=EHMJJ2i5PGdomPPLNMWOh9XKMvJCBgxC+n0hZy7D5Ko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NWvUJGo7JFCxVwUgCTMabL4ykSiRkOXlBf6rjvDVXSQpidyFETUSKL9G0HlpglLRG
	 Pojje9h9px/oGRmvRdlKcGqW+QqMvFrorvJcxyeWr5ZXVjNh9Js12Z5Yl0hGyOao6p
	 5dtGMZbwZtHfUUZ/AyEzxmkMmhTVvlAQXgBx1BL5OR+irg7d44jHTi86WGrSCGJP+/
	 89ROwMRJZHv6ceAMF4KfU/23sgzeaczalcADEwnjZOyMK1E6H5Rqz8r9FMZmJVcidp
	 VVQAARvpvVmmqVRD2zMBSF7677V6sagF8eKiwDvleTUoVKWLsEx35yM5nOR6uFfT0E
	 cITQZFXmH417w==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38df1889fb9so39737041fa.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 05:42:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrAIBtl1LthR3Sg096D6x15zDIfj1XmspITNxMRoH2QTHVf9bc2gbvS65fNbhfyMbOt6TlbRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNU5Xnsls2Ucu+nnNRRHRBJpw1XxAPBc8QtMb+aiErgDsJB3hn
	HqZmB+C4Fss9pxneJMmuKz3lqX9pvcUyp7kS7E20jO0JwW1IO6UIpRsj9qwYEhtf0RRSQeUYF+/
	Yz+fbzn/UhFDWxdTEkpGBHWbZDZWkZZk=
X-Received: by 2002:a2e:a545:0:b0:38e:6:4f89 with SMTP id 38308e7fff4ca-38e000674ecmr41439221fa.25.1775652162309;
 Wed, 08 Apr 2026 05:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
 <20260406111531.779571d7@gandalf.local.home> <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home> <adTqIepV2W6M_Q2o@pathway.suse.cz>
 <CAJ-ks9nPvGaYPKj5Py0OPrU1E8JgDrLNM29d+iwc3c2U6KZ0kg@mail.gmail.com>
 <adYAsnyZMykg3y9f@pathway.suse.cz> <CAJ-ks9ni9bth243ciTynDXGWG20sSbz52jSYHPsiVdxixkncPQ@mail.gmail.com>
 <adZJ41Cdvfv3-dWJ@pathway.suse.cz>
In-Reply-To: <adZJ41Cdvfv3-dWJ@pathway.suse.cz>
From: Tamir Duberstein <tamird@kernel.org>
Date: Wed, 8 Apr 2026 08:42:05 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9mNv7pefcS9iVZfMpqpkXGHNiPP4fCD5s1ZtUxRHo0XJA@mail.gmail.com>
X-Gm-Features: AQROBzBjVZkKJ8NoDev_fr7nf14eMEbinMrVUo8M2q3ZzfN97Edvln6shLwAQcw
Message-ID: <CAJ-ks9mNv7pefcS9iVZfMpqpkXGHNiPP4fCD5s1ZtUxRHo0XJA@mail.gmail.com>
Subject: Re: [PATCH v2] printf: Compile the kunit test with DISABLE_BRANCH_PROFILING
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233884-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1CAAF3BC5A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 8:28=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
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
> Workaround the problem by disabling the branch profiling for
> printf_kunit.o. It is a straightforward and acceptable solution.
>
> Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@i=
ntel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> Changes against v1:
>
>   + Disable the branch profiling for the whole printf_kunit.o
>     instead of using "noinline".
>
>  lib/tests/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index 05f74edbc62b..fbb2aad26994 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_MEMCPY_KUNIT_TEST) +=3D memcpy_kunit.o
>  obj-$(CONFIG_MIN_HEAP_KUNIT_TEST) +=3D min_heap_kunit.o
>  CFLAGS_overflow_kunit.o =3D $(call cc-disable-warning, tautological-cons=
tant-out-of-range-compare)
>  obj-$(CONFIG_OVERFLOW_KUNIT_TEST) +=3D overflow_kunit.o
> +CFLAGS_printf_kunit.o +=3D -DDISABLE_BRANCH_PROFILING
>  obj-$(CONFIG_PRINTF_KUNIT_TEST) +=3D printf_kunit.o
>  obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) +=3D randstruct_kunit.o
>  obj-$(CONFIG_SCANF_KUNIT_TEST) +=3D scanf_kunit.o
> --
> 2.53.0
>

It would be good to add a comment explaining when this workaround can
be removed.

