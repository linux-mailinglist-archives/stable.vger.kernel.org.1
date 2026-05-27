Return-Path: <stable+bounces-254589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBNTEEP3FmrUywcAu9opvQ
	(envelope-from <stable+bounces-254589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:53:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6485E55B1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98019307F8BA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE73F42189B;
	Wed, 27 May 2026 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ji+Kgosh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF33D5252
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889498; cv=pass; b=OCC5ZZtSSAQ/ftvVVGruekhBaSpgWl4NIdkLwn9YDdCod0wisp5TSxQk5PPtZP+gI4lNIBuxmJCsojngVrmwECaV0zqW82JIzuOIl5BHcnzxdVgOlCJ5y+omagLwoewwM8VG3SwvBNHjl0eaKvqcU2FL1oaPGtjm9HBt3kwqP7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889498; c=relaxed/simple;
	bh=it+wgDrDOUaTkC3IcpK4tnekNIzifQ1ajZKOntQ0lUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVrRmNuS5W3sGcwJDShi6dh9TlTW91MtXOkanaC97thMiy/edYpqQQo+WWRTVdW6NpSy95bShgYyzoNnNmkfcrkpzH2orAWQ3UQzPA0SZZsEhjwHGcYmyH0oHsEO18r+06YN42CMKlV4C6DJGaIKAfFCfHR9v9CxDsL2LvtZ1Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ji+Kgosh; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso300a12.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779889495; cv=none;
        d=google.com; s=arc-20240605;
        b=RQSavS+B+22ppIgtVS/Uy0qwpHq4gWyv0nFuFGCyfSCx+YoQ+JHrPf4YgqLp+CQpsv
         llVK8c8M4NCCXQSC5lTaTCiLRGz52LknwvQnzDSFt86jw2hRGwXElxSYzjHdvycvlbwz
         Q5JJr9dEqrtuWQ7cW5J6+zA3W9Xlc6U8tLHJNenMLx/oSL/i0e3uzmq9TsjC1tvXTZRs
         dyoIhF9CUn1QSUt6SEpGWzDQkZ0x4paghXp4lQubBkF+a5muhYvVzsUD5BCvZtvc12D/
         nBDCxweQRFcCvXaYMzkBxTuII4GpQz8m0tO+IkqBu3KRCAOpdQh8AIpUdux3C9pzlmKi
         iTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=it+wgDrDOUaTkC3IcpK4tnekNIzifQ1ajZKOntQ0lUU=;
        fh=qKxBpcvwZshQzDTJxcocePoa+60iHBaeqCngW6kjNNI=;
        b=KJIaI5t47Ea+tUNQhvMxzc7zfPRZvFOxK9rQBl7jPXSbQ9NXTWrttbCv4N+0Fo1UwG
         rl6RapBcde0A6v3Mpti0BsXZzLA0zBW5UgqHgvG3GX2ZOsyQUSkXY2xQ/MLcpiMnWsmV
         +piVmyhgva5pVWeR2+U7tGdT7n6stYsycFv9UmUE7xEDRfgLmyCvU0av+y4RRoo+5ECf
         Ooi9V2A4cEsaEoE8o/61jHq/uALvcJ/n06c/Lk+wrLGBdw5vc/CNZdFsapMPSwB9Ibz3
         SCksnhs1A6WWwvkp/W72gq2Da1Ncfh6AzQWrOWMZp3i1yfOR3jx2aayQqhnWRuEmjCIf
         gyYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779889495; x=1780494295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it+wgDrDOUaTkC3IcpK4tnekNIzifQ1ajZKOntQ0lUU=;
        b=Ji+KgoshnUgwZ6ZlzEJhuwi26Z4oR6h3CQO9rOpKb+bTQFbNXyV3pBHrrl9bnkgzsW
         Rn7nyEC+EBrSatgEDC2Yi6BZV24R82kBK4wqX0z4elhr7zJTDuYOfqotNoC0KRoYaWVA
         HR/CwWBYxz2UASgAV9Pwl51NjP+xbqlRDV3GK4p7a44aN2zNGZqMtXgzYTzm7JXki5jH
         0NTAc2RIB+dnITKZZA4lrpU2dFR3+xvlWggSiX5j/39uuygoGEeo+5rqv5k87Pq9qiyl
         4QH5YmPDzGA18uUAnFvf092xKrcZdgAFO99ZW11Jlbz99LdOJGewH0oJwakmKDo8PAZ+
         jP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889495; x=1780494295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=it+wgDrDOUaTkC3IcpK4tnekNIzifQ1ajZKOntQ0lUU=;
        b=CFbypPZFpXifYAjg4u6AcLNFTPIV5hnGKE4xIfWiv9nJfw3cbAnANR8+zAwr61oMoi
         sL3aoQamu+U1pAhduc2ZtcFd7XwUWekNMjXbNY3OqiWEZSNv0xrXRd5H9pWbXnUHrjgr
         KcEKf3Ak8kpmh3XJahQIosYG53V2DDfGFgEFsJ2QUlrxATqgDB2OrBDLBySmXV7Xxxqy
         V0JELfHUNwWlGYbKRflGaWd+46+9kF4VPRwsRnEpUR54FkedJAWABI5bqAQhpn4fa+6u
         hmIqp1DaQ8CsT/K6GBSbdbl+HBCbRwdt5w+G1EI/qHS77Q+fZwF8HrMTReddgbvBobC/
         cVtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rnGR0RrPbX6r7ZqguAxkH29tRjEv5hux6P8H2CTGI1QsAJrEE/eyrNw7cRLUWmU4TbbzObfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpvuo1N324sDx08JWLng2t9SqAAGizt1xEMj5OCZ+YDj941ZYH
	T4fkrpH1e9iBep/z9fYHfkFKRvsg6W5j3CVFAfdL6dkOhw9j5wKrDElqH+QJ3UaDBpEjyyptfpx
	Z9FWRSo/dlrZDP0Kn+yhiNHyrJdxiUU0wZl1kWJW+
X-Gm-Gg: Acq92OE3PCiyxCKeh8Xf3yOvlL7sQ1DejgD64x6+lfXP/5clCwf60RPTVsJWwkYfuYi
	tu98cXoBEffQ40YbiLkFR1NXJJt2n+MPd4MrRX5KoDcGnfzKVeIEvE5IzhpMhd6cry+3VB9fKEY
	RKf4H16+0l1hC+XzKF2PWx+0MnnwyC1gbq/DRnfWNUC4lTJge5dvbtGDkb5z9knqaRQYZrbEiSA
	a+dZBSEmywZgIegSFxV4+r+rd2Sn4iT7bcSFEmVxkA9cDP/gCyxwSncfEMHkvw2d5D/GxdC0HX3
	IhaBQpdNJ1XQO3oJGESLAp/LGmJ9CSYiYlCfRP0VXZXIAq4=
X-Received: by 2002:aa7:ccc2:0:b0:688:9c23:24aa with SMTP id
 4fb4d7f45d1cf-688fd170966mr201286a12.10.1779889494816; Wed, 27 May 2026
 06:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org> <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
 <20260527-kuchen-fassbar-hauer-4b6fc31e3395@brauner>
In-Reply-To: <20260527-kuchen-fassbar-hauer-4b6fc31e3395@brauner>
From: Jann Horn <jannh@google.com>
Date: Wed, 27 May 2026 15:44:17 +0200
X-Gm-Features: AVHnY4IwVOUJ6HpRAEw8Ai0JNxQIpmPDN57CZnT6PMEZZ7u42kilPF7NCJg2FkA
Message-ID: <CAG48ez1OfP4umNSeGzw4YhZi3dcb1jsy-vrKUwMc9+SLpt3isA@mail.gmail.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with exec_update_lock
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254589-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xmission.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AE6485E55B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 2:01=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Tue, May 26, 2026 at 08:22:38PM +0200, Jann Horn wrote:
> > On Mon, May 25, 2026 at 9:56=E2=80=AFPM Eric W. Biederman <ebiederm@xmi=
ssion.com> wrote:
> > > Question 4.
> > > Is it possible to use a seq_lock instead of reader writer semaphore?
> > > Or is that only for non-sleeping readers?
> >
> > Linux seqcounts are 32-bit, which means they are always kind of dodgy,
> > but they are particularly dodgy if a reader can be forced to sleep for
> > an extended amount of time. I don't see a reason why we couldn't, in
> > general, use a 64-bit sequence count for readers that may need to
> > sleep while reading.
>
> I have a patch series for this that I started working after merging your
> series for precisely this reason: performance. It's a few days old now.
> I've tried various approaches and I started with a simple 32-bit counter
> as the POC. See appended (untested) patches.

It looks like there is a missing patch at the start of the series,
patch 1 uses exec_update_seq_begin without defining it.

I think performance improvements from seqcount use like this
(accelerating the fastpath) are different from what Eric was worried
about?

