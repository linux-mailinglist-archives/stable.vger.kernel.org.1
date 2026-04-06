Return-Path: <stable+bounces-233396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJyFJA7i02mgngcAu9opvQ
	(envelope-from <stable+bounces-233396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 18:40:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E51793A5616
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68116300DF46
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203C38B15F;
	Mon,  6 Apr 2026 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP1CikKb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684338AC90
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493640; cv=none; b=UW1SmMzIdJbHwDZnqM5YY8hFjU8RNb3Nl8jZWtrMRyCmQFbsVZw4sRK4wxTn84uot6+b9dNnlah+kwhPv16gbDAerkd1U+i235yuUq5YmJxMvjnjQQ8WTg3T4Epi2HpdGbZal/uBVoC50tMTH9FSoRJUgf8qLtCUJ5BWrPv67W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493640; c=relaxed/simple;
	bh=BhUWFvIP7ihBcU+jc08bd3YsK1SXvsYJx5QhwQCkAOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhG6++SgghemVVo8fob4OuMtJU2dxzUx2pXRJYI9fCMCal/X1SBQRJEKLtpwagHYEExg7cxzszw4aQ10ig+ZcmKF1y8zYpW2ubKzFyvJTvT4Cx0ufPBb19e/nXNg5RUG3L3mKfBezW8HNoCWwGZtxxL7If2ANMe8xxWzufg7YaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP1CikKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C45C4AF09
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775493639;
	bh=BhUWFvIP7ihBcU+jc08bd3YsK1SXvsYJx5QhwQCkAOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jP1CikKbwQOP6iP4jMBArB8FZlOewoFf/Qjj4KIcqXlAGFQVfl09gm9p9Sta5cff3
	 uFDexo2irS8ez0/nimenbsie9V9dQus3CAjRtbGHdtMA+OuC7E+93zYI7qh0pmSnAt
	 /QjpcB0d+c5JabxiXK/bqIufHIbDCGjalXSaMZlnejHvloARr1MkYhl7lAzVWSqwkB
	 U6Ti2Wad9umOyGNqGSYGf/kcO1dszBiDtwhdoVOCGAwrD8nRt1NE2ov705TVFQ4gsl
	 A6CeWLB1OOGqdbwH511p9lKi+qOHGpuHneYG+1Ec957CX7b7BJnNcbk74TDaRuA89a
	 khAinXyWwY+9A==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38deb82daa9so16000181fa.3
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 09:40:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEfTCqAML++1E9QZcR2D6IYOlmyJfJwjHmoeiCkoEzQbZcVO2XkJa/ebVuwnqj1r3u8CGeZIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3gWxS1D0NdOF6/1bA0F/TqZMLi8oonXJorjjq2132cSNS8VNS
	Lf4F6j6AmezZQ92N+kvt6Rg8mwjjqXkIDFy4kKgq0YBK6wJABamnhaZ19c3Us1km4e6l8yx/2DU
	S66k6eL9IwCc57FyKx9sEEPGN3ST0bok=
X-Received: by 2002:a05:651c:1616:b0:38a:a77a:b0b2 with SMTP id
 38308e7fff4ca-38d91d7f459mr45151911fa.30.1775493638362; Mon, 06 Apr 2026
 09:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
In-Reply-To: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 6 Apr 2026 12:40:02 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9kRm_v_HYZHDdZgcY0ge-imW5WjnUhKVfRqkeg4LmwVqw@mail.gmail.com>
X-Gm-Features: AQROBzBIgWcFRqxKnyp_ua1wtO1DHp023wBMjvMwvM83JoyEkYvqhjoYtBR8JmA
Message-ID: <CAJ-ks9kRm_v_HYZHDdZgcY0ge-imW5WjnUhKVfRqkeg4LmwVqw@mail.gmail.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-233396-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: E51793A5616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 5, 2026 at 1:32=E2=80=AFPM Tamir Duberstein <tamird@kernel.org>=
 wrote:
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
> Mark errptr() noinline to keep it out of that buggy IPA path while
> preserving the BUILD_BUG_ON(IS_ERR(PTR)) check and the macro-based
> printf argument checking.
>
> Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@i=
ntel.com/
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>

Adding tag per stable instructions:

Cc: stable@vger.kernel.org

