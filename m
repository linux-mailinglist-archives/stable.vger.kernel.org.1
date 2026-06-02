Return-Path: <stable+bounces-259830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KykLBsnhHmpJYQAAu9opvQ
	(envelope-from <stable+bounces-259830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:59:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FBF62F16A
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:59:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E6+cHAZB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259830-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-259830-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25FDF30BA2D7
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB503E5EC6;
	Tue,  2 Jun 2026 13:47:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18364184540
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 13:47:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408033; cv=none; b=DdUlYiPvANc5gxHIB1h53/iipFS1/EccsRUiiZOq6jtPp6+KK0nXAc1zItpoVHSkFyUbR+Z9unwCNabk1Vrv4qlS5VXyA6cYjuYn24aXrN3c/mzslaT00ci9sCsyRpiHzVCMuSaFtjdqfeJtYY2GTbipKIRDIA/46saU9y83iGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408033; c=relaxed/simple;
	bh=NRMzpm6Pqs/j/S7942U0/U8OZBaTCVvUF2GrjcvLpiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+sAYWykaUdS2PCjBCg+G9hUlifN8nT9PwEL+Vro0OVGDSKSlvLmo/R231zRAz22b81xqi5gE8RFSFhZDfMyv2EmDzJmLokGgrHatYsj4CZpJljv7ufPtq7bfQMqEOe2ESoYmnwMwAf7Ncp9BIKFPnWOHYXnveaiswoGXstaVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6+cHAZB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5AC1F00893
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780408031;
	bh=7AR8KNknDi2PUvwcpCAHJzwwgVWb21gFCGg7IkCkN44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E6+cHAZB+ZFEwv18E6CA90GaRFy/ZO7ejsfYpOv/ldMeC0maM+fCiBCLjOz1lYBel
	 DvpSfyPdWiBtrhqslQ8Cwze8U/VcqxrZL8LxSVataZ32QByplGEJnF8QHSVL2cdhC5
	 l3I34tClVHde8siT5Qap9idIS+gxkkGHxfAYdf1SBCwjMzX9VKCTjd2uL7o5US27tc
	 L/d4OWamyCEQhZA6hofTSF9Z19W+1qOjNEaALypBjG4kfRmg40BRo/nBkaSDf87IJH
	 BM5laI4YolSSigq0g2h/e6T3lhdkmM2C6D/6uQniRX2yyP6of00wqPO9Vr6B2Rctkl
	 +Ap6PzwJ0G6zw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39697a4e16cso14644391fa.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 06:47:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8p1dXwjoX4WJJp3s3A7QmIR75bvr+ZtJygFg70hCL5FX3jpSliigRbIfFQ96k5T/+Ze87keiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8LVMLEpMGuwS2jmCgo3J9s/frUfD2aIXV5qgxFq7v+erC3TQ
	BedQBptPBYPb9Kw5e7ZpCv21gu13cB5lpprcUKy6B5Tc8NZ2+N16J/KTcFef8XcnqsSUmrnU4oL
	FfjWzhLHGeh/QuQMxD9DDdLsXvoc9jrU=
X-Received: by 2002:a05:651c:895:b0:396:9966:50e0 with SMTP id
 38308e7fff4ca-39699665460mr16085121fa.21.1780408030600; Tue, 02 Jun 2026
 06:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526184100.3BA431F000E9@smtp.kernel.org> <ah6WDkwO8eYY5f2a@ashevche-desk.local>
 <ah7PWK4gTdOYG1t_@pathway>
In-Reply-To: <ah7PWK4gTdOYG1t_@pathway>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 2 Jun 2026 09:46:33 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9nHkcgwdh7i8efAv=ka2rtX9o6ZnGZk5KeroCX2G_t3mg@mail.gmail.com>
X-Gm-Features: AVHnY4L2cA2WPdjmbtSuv3zE2yIru4VUGsgtt0gdB6Ssw87iKVwkKijC5iJKVR4
Message-ID: <CAJ-ks9nHkcgwdh7i8efAv=ka2rtX9o6ZnGZk5KeroCX2G_t3mg@mail.gmail.com>
Subject: Re: + errh-use-__always_inline-on-all-error-pointer-helpers.patch
 added to mm-nonmm-unstable branch
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, 
	stable@vger.kernel.org, nathan@kernel.org, hca@linux.ibm.com, 
	gor@linux.ibm.com, ansuelsmth@gmail.com, andersson@kernel.org, 
	aleksander.lobakin@intel.com, agordeev@linux.ibm.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259830-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,linux-foundation.org,vger.kernel.org,kernel.org,linux.ibm.com,gmail.com,intel.com,arndb.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:andriy.shevchenko@linux.intel.com,m:akpm@linux-foundation.org,m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:nathan@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:ansuelsmth@gmail.com,m:andersson@kernel.org,m:aleksander.lobakin@intel.com,m:agordeev@linux.ibm.com,m:arnd@arndb.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83FBF62F16A

On Tue, Jun 2, 2026 at 8:41=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> Adding Tamir into Cc.
>
> On Tue 2026-06-02 11:36:30, Andy Shevchenko wrote:
> > On Tue, May 26, 2026 at 11:40:59AM -0700, Andrew Morton wrote:
> >
> > > The patch titled
> > >      Subject: err.h: use __always_inline on all error pointer helpers
> > > has been added to the -mm mm-nonmm-unstable branch.  Its filename is
> > >      errh-use-__always_inline-on-all-error-pointer-helpers.patch
> > >
> > > This patch will shortly appear at
> > >      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/=
tree/patches/errh-use-__always_inline-on-all-error-pointer-helpers.patch
> >
> > Petr, shouldn't this also fix the problem with old (buggy) GCC for xten=
sa
> > (IIRC) that we encountered in some tests a couple of months ago?
>
> It might here there as well. Unfortunately, I could not test it easily
> because it required some old GCC.
>
> I wonder if Tamir could try to revert the commit 8901ac9d2c7eb8ed
> ("printf: Compile the kunit test with DISABLE_BRANCH_PROFILING")
> and try this patch instead.

Yes, confirmed.

I rebuilt xtensa-linux GCC 8.5.0 and tested printf_kunit.c with the origina=
l
randconfig and branch profiling enabled, without DISABLE_BRANCH_PROFILING.

Without Arnd's patch, the original failure reproduces:

printf_kunit.c: In function 'errptr.part.2': error: call to
'__compiletime_assert_313' declared with attribute error: BUILD_BUG_ON fail=
ed:
IS_ERR(PTR)

With "err.h: use __always_inline on all error pointer helpers" applied, the=
 same
compile succeeds.

So Arnd's patch fixes this case and commit 8901ac9d2c7e ("printf: Compile t=
he
kunit test with DISABLE_BRANCH_PROFILING") can be reverted once it lands.

