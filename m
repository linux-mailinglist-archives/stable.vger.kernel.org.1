Return-Path: <stable+bounces-237919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI28OONn3mmxDgAAu9opvQ
	(envelope-from <stable+bounces-237919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:14:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423D23FC6C4
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4453013A47
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CAA3EC2DE;
	Tue, 14 Apr 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PENMDaEz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EA3E5EF8
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182917; cv=none; b=kux4dfnD9vtqrF2ajO0jNIEVufD0fOxqTJW1RtXb2EFHH0aXcZX5nXtBGCxdC4nei6laQ0IG1PF+OuTkdYISXPMXb6Xh4L7+g50js67pfXvK030thVHuFWTOg3sGH7EEg3emwri8UsuEvA2JbE4EGQSYSwAK6JEuZ2LCFjJH4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182917; c=relaxed/simple;
	bh=WfuiAm+GxtxCSHl63EibPi/fcCftHC/UuzSmwI+8K+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrpIMSW3j/WPp5yv8YYdTV3hqB+fVnwYEn6R4jCERgwF549301C/Jw2qoZFva+aQYdqITKRgWDpO+uo/1sVDyqhqPlWFMut2MhKwCZ1RqULsSaa1pzHNesStmp11TAkhR30ERSYen4TWyRBb+v0mzkOi7krZUIPnj7Dhz/U6uow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PENMDaEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D14C2BCB6
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776182917;
	bh=WfuiAm+GxtxCSHl63EibPi/fcCftHC/UuzSmwI+8K+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PENMDaEznpQfsoNKlbxTwL2ImThQowol1pynlehGWLtqxjW4FNpzPhgtHFApJANHZ
	 1JwUuqFnOpSQit8XzVf/b4uFQj6cWmR0+gGvM1JF9FWyFDQ5akASLSfF1e+47ME2qT
	 Mv9Ucnk2nupMcyZmXQRemJG4WuB3PsBl+rxF88dKXZ6EIkDheYHfcwZ4Whn+L0BoUQ
	 0x3CelyN12wcZzpGQwIbXpTF5Vu7fe1war4q2JST5Xbp8pEoD9H2mSt2zBfqnSGy4k
	 AP9wSrsNWhWJ4CwPTV3KZBuAzTN8gzUQp3nQNNMUQs2aXYAhd6HpJRR8P0fuq+C437
	 xeQCk6rTA10bw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a4053964e3so1346988e87.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 09:08:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8HQMepxGPMC5IfBnMXbQwZZbBxTNB3l5/8OD7a861D1Llm0Jqw9arV+vyJs92VFUjJY/PsXho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0i58/tX+7j/oOql0rOL8wS+tsgsYkRjcyk2Yw/PjYo70mcJe
	58zmLohedIurTUKl80ZQnvpUPh++uQqUlN11kifwSyMZecd7x4rlKmpAo8dnkm0t6JfoQCWH4EE
	nXtLy8V8QztNaJq6cNqoxvliFwp6J6fI=
X-Received: by 2002:a05:6512:1295:b0:5a4:30:9c66 with SMTP id
 2adb3069b0e04-5a400309da0mr2338847e87.32.1776182915718; Tue, 14 Apr 2026
 09:08:35 -0700 (PDT)
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
 <adZJ41Cdvfv3-dWJ@pathway.suse.cz> <CAJ-ks9mNv7pefcS9iVZfMpqpkXGHNiPP4fCD5s1ZtUxRHo0XJA@mail.gmail.com>
 <ad5gJAX9f6dSQluz@pathway.suse.cz>
In-Reply-To: <ad5gJAX9f6dSQluz@pathway.suse.cz>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 14 Apr 2026 12:07:59 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9=NzPjb=eW=7GA2On8Lzv=R1wOBVpyuH+pqNZhG1u9uUg@mail.gmail.com>
X-Gm-Features: AQROBzCCp_uZtTMr22VgqG3X0G4pcz5BWsBBXcrKGC7ururiPA0UxUWYIA-pnhw
Message-ID: <CAJ-ks9=NzPjb=eW=7GA2On8Lzv=R1wOBVpyuH+pqNZhG1u9uUg@mail.gmail.com>
Subject: Re: [PATCH v3] printf: Compile the kunit test with
 DISABLE_BRANCH_PROFILING DISABLE_BRANCH_PROFILING
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237919-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 423D23FC6C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:41=E2=80=AFAM Petr Mladek <pmladek@suse.com> wro=
te:
>
> GCC < 12.1 can miscompile printf_kunit's errptr() test when branch
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
> The workaround can be removed once the minimum GCC includes commit
> 76fe49423047 ("Fix tree-optimization/101941: IPA splitting out
> function with error attribute"), which first shipped in GCC 12.1.
>
> Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@i=
ntel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Tamir Duberstein <tamird@kernel.org>

