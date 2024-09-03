Return-Path: <stable+bounces-72836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC09969E6D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2691F249D7
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B001A42CC;
	Tue,  3 Sep 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xF/qSqYD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5D1CA6BA
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368055; cv=none; b=UUU2VBahwAtfydTritcULLWY/36tGccPjl6R7R50Lhk+8rJzik0RacB+y0M/jPxaH16x3nATELgDGBNlGVS8a3x+fEQHI9fqGj5cSAtcdx1aR1jNXqOMvLtO8TNjXpK6kAG0qm3/WcSy9efwUjxlQ3pEv1AN5Xsx98yk4gP1j4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368055; c=relaxed/simple;
	bh=1sQBXbrxFIepozBp6rnoQlrnGCfeK/Fpe+8jGrr1poA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbE6V0un77TMwSi1tZK85u+jmWUlxWuMZ1hTL38OE5M9TZgK7wDPEdEMia5nCsw3Pc7z/oN0vG4boyruzinV+p5he7QZZDxan8NHryh/CPdO2NNkBZ6d72yjW3A7JWvufpMbAdy8X9X0hXj9qfCKg7Oky+4LHw8Xl01g30K41W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xF/qSqYD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so584410366b.1
        for <stable@vger.kernel.org>; Tue, 03 Sep 2024 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725368052; x=1725972852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EDBDFztnJ7QXRoMHA2gILDtQaFW+5NDgEd/OR5D7qQ=;
        b=xF/qSqYD5OArC0KIDCAZXJnbE/Zpk65OIwi7S7bYHHRUQkJrxJ8cwcgzsKTRylhZoP
         LQeJ8qxYpCZl9gha3ygopcLBYApnrEvb9JEP8v6Nn1RirvQT389Ghs5Yrfmklxeg/sgc
         VAeXbgqEtHMk9JABwMzQ3s1htl00LhvSaHlKIMiOnyFIb9oLubvTR4cn9GBLzThne9xH
         TC534VEg+gNe0k/jdDIU6kgp9K+Gsx4SacrE7i/bnuNwV/LeT7erdUqiANCPMVIPMKtu
         7cuGNkaONUG4yTFD6LA1geRh6VRhG698PHP5NF2CdcznKiapEND09UvD6KiTC75SsAZH
         Zrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725368052; x=1725972852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EDBDFztnJ7QXRoMHA2gILDtQaFW+5NDgEd/OR5D7qQ=;
        b=tYqIsgNMyttE4Yy49SWuh72pg4vjOVsDFeFBD4uWA31FtXTr1A/8SahjWB4lYLE4PN
         EoKVxv3ltwMZbmejWYbpZwj+4Z9SxO5i5qGNdtDbpgoLd3RPBPIGlsRNTGYQ2K4ZCqTR
         N/VLrYOY+Kvq+zWe3WEbqvn7QKaLK9Q6t411J4IUfR7fO9Fzm3vKz3EcMItkDzbUOBZi
         rjx3x7fmyHruyx0bc8tWIEK+QGQCO9aHYE1mFgnmjdBjnGb4pGZ5PZOwIAqoAXwTHTje
         1AIVJ8eufSmXgMoj0TySy3xAtlbD/0XU4g/d9k4TccdH8vl8uD+mLDywvKheW1mKCBLu
         nK2g==
X-Forwarded-Encrypted: i=1; AJvYcCVjbcECvrnUc9/y8HVhoqfP7pPwwJXI+HsWE7sKlgxfPSN+Ot6D0xjJ4ZDfZ2NVlBV9ItjtVZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0quL2nn/olzKJXQeuCMYG6A0Sh1qBp2hpQ44PeSfP+G8it1I
	9q++YPriIZ2VRW3FQdUocLkBhkclboZLcrkc7pzxfE3vsQEeg4ZODN9ClaJBGDNBZ7bglMzjA+h
	kFIwip/7bSG8j+GAHAeb01Z1BJCyBFomCmQKk7Fk2NAyKiUZK5Ycp
X-Google-Smtp-Source: AGHT+IGMhRSDzER85v0Usuyk6HaZqJzCZmoVnPlKt+9m2DPGiVR7zgy1X34wbIdjxq2rxCpi5bJ1oQh3i/P43zRUBXw=
X-Received: by 2002:a17:907:3e9c:b0:a86:a0ec:331d with SMTP id
 a640c23a62f3a-a89fadc0cfdmr506031266b.18.1725368051226; Tue, 03 Sep 2024
 05:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024072924-CVE-2024-41041-ae0c@gregkh> <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>
 <2024090305-starfish-hardship-dadc@gregkh>
In-Reply-To: <2024090305-starfish-hardship-dadc@gregkh>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Sep 2024 14:53:57 +0200
Message-ID: <CANn89iK5UMzkVaw2ed_WrOFZ4c=kSpGkKens2B-_cLhqk41yCg@mail.gmail.com>
Subject: Re: CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:07=E2=80=AFPM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 03, 2024 at 11:56:17AM +0000, Siddh Raman Pant wrote:
> > On Mon, 29 Jul 2024 16:32:36 +0200, Greg Kroah-Hartman wrote:
> > > In the Linux kernel, the following vulnerability has been resolved:
> > >
> > > udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
> > >
> > > [...]
> > >
> > > We had the same bug in TCP and fixed it in commit 871019b22d1b ("net:
> > > set SOCK_RCU_FREE before inserting socket into hashtable").
> > >
> > > Let's apply the same fix for UDP.
> > >
> > > [...]
> > >
> > > The Linux kernel CVE team has assigned CVE-2024-41041 to this issue.
> > >
> > >
> > > Affected and fixed versions
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >
> > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.=
4.280 with commit 7a67c4e47626
> > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.=
10.222 with commit 9f965684c57c
> >
> > These versions don't have the TCP fix backported. Please do so.
>
> What fix backported exactly to where?  Please be more specific.  Better
> yet, please provide working, and tested, backports.


commit 871019b22d1bcc9fab2d1feba1b9a564acbb6e99
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Wed Nov 8 13:13:25 2023 -0800

    net: set SOCK_RCU_FREE before inserting socket into hashtable
...
    Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")

It seems 871019b22d1bcc9fab2d1feba1b9a564acbb6e99 has not been pushed
to 5.10 or 5.4 lts

Stanislav mentioned a WARN_ONCE() being hit, I presume we could push
the patch to 5.10 and 5.4.

I guess this was skipped because of a merge conflict.

