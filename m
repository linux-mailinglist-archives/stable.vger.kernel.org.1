Return-Path: <stable+bounces-59166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC9192F101
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 23:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93444B230AE
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35519EED7;
	Thu, 11 Jul 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eUfDszE7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F561A00F1
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732727; cv=none; b=EW7O7z9W7opFVQ+0oNzaOulJypY8AXLXyVIdlLeTcxjqGKPAUKF2TICXCCCOHCR7EYuWgFHEpkOxAAnkR707p/wdP2CdRT0TjdW8TIKIKZnysIDeFWISPpR47EuwuMEqGjPxJieyOyfkvfG6tuGnInqAki5S29wf5P4sWdvpX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732727; c=relaxed/simple;
	bh=sV9UkDpgdJI5nO8J8h6KzE9TPuuDtH2Js+kWDGsoqiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5I05AZN3jPP8HX/qark2ETO9bgAvHKZ0JjbE35bFjMDmaEYXnp1Bb9Oq6Z0qfLvkWD4FXMaRXWewHK68vPrdELcyy+bVDldv2wfdM7TLEisoFwhX98rF25coTUSM5Kfx2NtnlqA9lcZLLThjbBDd829ejCz3YnaKFQYjhmxn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eUfDszE7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ca867b23bfso1047301a91.2
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720732725; x=1721337525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9e6a5/Mi00lPqSFUCY2ruWznGIW0bflPYVcqQ/6g94=;
        b=eUfDszE7mKIwJdKcaH6UXmDUtf0R5l2Wq256el79N3S2PUfleL+kGfaAYUtS87pDM0
         twaCAk5ExyXrk3XYlZ2qZxIVKaTXBmvb6eVRtCU7GIio6OkZZCRVpsDvk/tSXFiCED2j
         Kl9V93XdnF4qYODBnFDNEr97DY7fhhFCzQKo7cY4ZmSSXuASr2MjZUKWxaJDJ0W08HJg
         SqFQk8szEOd85KIYKR2D4NvCppbtSvam9I6WMIXiKaXJIHkolp8lvNWykbIXPZAVhO9Q
         nDimd6JvjdyXHgnUMnmG87kylm+PKjPUVj5pxOtjNX2cFJe+M4sY3UNlhpKqxLba/bsq
         NXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732725; x=1721337525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9e6a5/Mi00lPqSFUCY2ruWznGIW0bflPYVcqQ/6g94=;
        b=BvPY2lXHlGIPfwIbcFtm6agJQiX4u4Ob4ie1IJehvYbBB3l3cm4MzVekPWRqfy2qm1
         GQyPvysZl0j8xRmIFh0T8fGP4NOySnjuK7k1kcsu73ZVKYQ+IcS6bj0376exTvXf6O10
         hVAe3hCoGsNs34ZgCk029NnbTlhFtCLeDaqCHxMHUxavPssSeM2PqYfHrUZX7o9bRx22
         yWkZ62dCRhdNO4yxHcj/090pVJ+KNNqQlR+PyWhQSuAiUqzZmiB36U1GlBN8FBPN1aYi
         +XIVSKGT/NcmPhkiQ8bvwnziUZuAUIdltK9KI6R9d5BULKgSwDTjxz75odbg1Ka/CGan
         ZxUw==
X-Forwarded-Encrypted: i=1; AJvYcCXr9K7Rnwn66ugWQeMd86FMH/zrmBQ6CZTirwio1hxVFeQkDg+8q8rkvtr6Qm7XuE9QyUSXBSXMIZ4olCjnziCcnu5CwHh9
X-Gm-Message-State: AOJu0YzA8QFzlC6s9Ccj2FYTc20OxxBl7tahp9ijxG5QkAe1xda/barU
	vAZM9tujDOrwK9/IQxRaukPi4Lg4eryCOU/f/ABOQUnOSCG5owYbJ01UooVWerp7e+Tyq+mw2BC
	hmNEfoOTkvCK+8KZDawzxnqu3V8lvdfnjI355ocgawjcT3pRc02uNHvVT
X-Google-Smtp-Source: AGHT+IGiV5enzDmTVIOm2s/WT/YwkVXtCf2KBIl6kclbmBVx+zOZ2q3ti8a3fIkoikgcfxRFEME+6X63EW0yPUphrO8=
X-Received: by 2002:a17:90b:1049:b0:2c9:8d58:1d31 with SMTP id
 98e67ed59e1d1-2ca35bdc26emr7540332a91.1.1720732725432; Thu, 11 Jul 2024
 14:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709110658.146853929@linuxfoundation.org> <20240709110659.948165869@linuxfoundation.org>
 <8B1717DB-8C4A-47EE-B28C-170B630C4639@cloudflare.com> <dfe78e1b-eaf9-41e6-8513-59efc02633fd@nvidia.com>
In-Reply-To: <dfe78e1b-eaf9-41e6-8513-59efc02633fd@nvidia.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Thu, 11 Jul 2024 22:18:34 +0100
Message-ID: <CALrw=nHVvVNA5M7=jAspdcOnmDFz=zL6axC6vv6j=t1HbsaO9Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 046/139] selftests/net: fix uninitialized variables
To: John Hubbard <jhubbard@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Willem de Bruijn <willemb@google.com>, 
	Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 8:16=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
>
> On 7/11/24 8:31 AM, Ignat Korchagin wrote:
> > Hi,
> >> On 9 Jul 2024, at 12:09, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
> >>
> >> 6.6-stable review patch.  If anyone has any objections, please let me =
know.
> >>
> >> ------------------
> >>
> >> From: John Hubbard <jhubbard@nvidia.com>
> >>
> >> [ Upstream commit eb709b5f6536636dfb87b85ded0b2af9bb6cd9e6 ]
> >>
> >> When building with clang, via:
> >>
> >>     make LLVM=3D1 -C tools/testing/selftest
> >>
> >> ...clang warns about three variables that are not initialized in all
> >> cases:
> >>
> >> 1) The opt_ipproto_off variable is used uninitialized if "testname" is
> >> not "ip". Willem de Bruijn pointed out that this is an actual bug, and
> >> suggested the fix that I'm using here (thanks!).
> >>
> >> 2) The addr_len is used uninitialized, but only in the assert case,
> >>    which bails out, so this is harmless.
> >>
> >> 3) The family variable in add_listener() is only used uninitialized in
> >>    the error case (neither IPv4 nor IPv6 is specified), so it's also
> >>    harmless.
> >>
> >> Fix by initializing each variable.
> >>
> >> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> >> Reviewed-by: Willem de Bruijn <willemb@google.com>
> >> Acked-by: Mat Martineau <martineau@kernel.org>
> >> Link: https://lore.kernel.org/r/20240506190204.28497-1-jhubbard@nvidia=
.com
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> ---
> >> tools/testing/selftests/net/gro.c                 | 3 +++
> >> tools/testing/selftests/net/ip_local_port_range.c | 2 +-
> >> tools/testing/selftests/net/mptcp/pm_nl_ctl.c     | 2 +-
> >> 3 files changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftes=
ts/net/gro.c
> >> index 30024d0ed3739..b204df4f33322 100644
> >> --- a/tools/testing/selftests/net/gro.c
> >> +++ b/tools/testing/selftests/net/gro.c
> >> @@ -113,6 +113,9 @@ static void setup_sock_filter(int fd)
> >> next_off =3D offsetof(struct ipv6hdr, nexthdr);
> >> ipproto_off =3D ETH_HLEN + next_off;
> >>
> >> + /* Overridden later if exthdrs are used: */
> >> + opt_ipproto_off =3D ipproto_off;
> >> +
> >
> > This breaks selftest compilation on 6.6, because opt_ipproto_off is not
> > defined in the first place in 6.6
>
> Let's just drop this patch for 6.6, then. Thanks for noticing and analyzi=
ng,
> Ignat!

We noticed on 6.6 because we run some selftests for this stable branch, but
by the looks of it the patch needs
4e321d590cec ("selftests/net: fix GRO coalesce test and add ext header
coalesce tests")
so it will be broken for every stable release below 6.8

Ignat

>
> thanks,
> --
> John Hubbard
> NVIDIA
>
>
> >
> >> if (strcmp(testname, "ip") =3D=3D 0) {
> >> if (proto =3D=3D PF_INET)
> >> optlen =3D sizeof(struct ip_timestamp);
> >> diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools=
/testing/selftests/net/ip_local_port_range.c
> >> index 75e3fdacdf735..2465ff5bb3a8e 100644
> >> --- a/tools/testing/selftests/net/ip_local_port_range.c
> >> +++ b/tools/testing/selftests/net/ip_local_port_range.c
> >> @@ -343,7 +343,7 @@ TEST_F(ip_local_port_range, late_bind)
> >> struct sockaddr_in v4;
> >> struct sockaddr_in6 v6;
> >> } addr;
> >> - socklen_t addr_len;
> >> + socklen_t addr_len =3D 0;
> >> const int one =3D 1;
> >> int fd, err;
> >> __u32 range;
> >> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/tes=
ting/selftests/net/mptcp/pm_nl_ctl.c
> >> index 49369c4a5f261..763402dd17742 100644
> >> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> >> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> >> @@ -1239,7 +1239,7 @@ int add_listener(int argc, char *argv[])
> >> struct sockaddr_storage addr;
> >> struct sockaddr_in6 *a6;
> >> struct sockaddr_in *a4;
> >> - u_int16_t family;
> >> + u_int16_t family =3D AF_UNSPEC;
> >> int enable =3D 1;
> >> int sock;
> >> int err;
> >> --
> >> 2.43.0
> >>
> >
> > Ignat
> >
>
>

