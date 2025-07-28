Return-Path: <stable+bounces-164882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C93B13446
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 07:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881E87A5248
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 05:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5241D54EE;
	Mon, 28 Jul 2025 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS/oC5l7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00B4C6C
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753681706; cv=none; b=BILSkwImhcYJsuVcpt1QaTykbHFb5lyWo6XZavDAaBlEnLZKOCeFgFFz09tlx13pVMc6MDOXWg7hBCv0ai1Ex7YnaIcFO+KFMFoU8PgMQjQkBBMpsKJxTIMzS6JzJiNNPrlJ1lv3DWnExjVldKsgTa2/sHJyYuqalhtt8fm1+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753681706; c=relaxed/simple;
	bh=ie4Tn9QoWlDf4W6D5+RKRM2ne0npRuG4oMofVB7fzaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XFFvdv60Pd3Zm75L5ERKyZ172pbwBeen+K/oiSWujxaT9iggym3s41/XjAinTAWk+VtXY14RKSTyxM8JvxoCxTcrMxBejKZwh7NLhCxBL5OvipJBWMRVxev3xW17dxDFIrNvE2Z2DzYcSygTnMOLiFm5uCUQGJSw8h4CmVpJ+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS/oC5l7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4aeb2f73fc0so7139541cf.2
        for <stable@vger.kernel.org>; Sun, 27 Jul 2025 22:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753681703; x=1754286503; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1msMTJ6X1Q4zpAJwlSFf6cgfrOB5wt3WpYE+/fWQF8=;
        b=CS/oC5l7WvV4nC0UWgTYi/J64u3FoM81DCrCqtSB7D25ugrZxtzUmvBiPurWp3O+fX
         xl7FCsTG3/mnlMuyDgBy3sTuYT7bhyrvdBDuPAqm0Apzg+b5FFSvSnqh5Lsh5FM4+qz4
         8XCZdnEAkK9yEUdjg8eSfIyC7/Fnrt1jU39xIJQk+P61K10DO5CASfyIGhDo1wImxleN
         ePZam4mLL0CpbV7SEwyiYU4uku1jq57JOUCxvoueqTT5efb0NQTax01zYo8bUCfGuXgj
         kSlVyBAYzlGHjr2ChUcB2FTcQq3I/KZnCsV/J0MjyOKnLFNEMHpksFA9HTUfNN0DxN8W
         iPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753681703; x=1754286503;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1msMTJ6X1Q4zpAJwlSFf6cgfrOB5wt3WpYE+/fWQF8=;
        b=GhggbMkIhBD3exSFzIMvb2GRzuHIm5ZRlKimQLLvCtrZLajLnH3Ywd0suuUuDuXj0c
         TEH9PSoZZNYKmUaQSvW1iMm+zIxT9lMMMoNaBtUNM0e7tjnKC0Ols4CZFlmKgE7ZqTb8
         mL2AzNDd658A1DfP9LBUEz+24U5+yRLdd2HQho7vQTt92FNpVoOvla1W857JIz3YfCgH
         SWi/gWSNxmJokABSviO//G0hLj6boAKn8VdGG+wPFzmP9ySHFesv4wEr1g20biDOcZAY
         CqPYz8fvZQBYKmuU+zJT8YahlKf7JmGXmJDH5EA4eY1IhqzUUzb0yRl3jZkP0wgKuh7Y
         URng==
X-Gm-Message-State: AOJu0YzWv2P53C7AlDPYN1/4/NXiBU/WKfHCIK3Fj/+srlRDKiwZ1qdO
	OmSDMFb10FVME3bmGZOXF1+/tCFmF8h6qv9wP22zf7TlcfW2RIyM9xKXu+iVkbzsC5qW4LJmAqU
	m23K9MDPEvcE+P50LCnFUbBvPkNSt1elmCoeA
X-Gm-Gg: ASbGncvIBpM2ukNW0Oql8rG7BUvPJz1sDRALAan/qRVOWiDBEbSWn2ys5scJ/KIpjxH
	IzuxhjVCAnvpcK2jt3XhO+3Fey+lU2PqL3Hva8bQZsJLfye7jzKAesRlDHdbjjprjjWjwvaAwJp
	DQfKkMxckqbN3kVab8xcKSs29XyruynbqJqq5WLh6v3Oj88sHiHjSv1elNaWTROmncviDNk4nLd
	rgsv4OWFQ==
X-Google-Smtp-Source: AGHT+IFNHUomgHF/myUU2TcuRDE6Px+AQUc5ieh7pFWbbJn8OKNFAOVViB9SClPwD97Os6EHm4L8nDTSKegMh5zcLL0=
X-Received: by 2002:ac8:5a53:0:b0:4ab:62f0:3ba3 with SMTP id
 d75a77b69052e-4ae8ef33304mr109961831cf.16.1753681703018; Sun, 27 Jul 2025
 22:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGvw722wvDKxrmhm--3xu2Ck7fG0Z4PAOyeNaN27bwccbVLRGg@mail.gmail.com>
 <2025072520-pedometer-abstract-f159@gregkh> <CAGvw721RvLiV+G4Y7UVKyVerm2bQFfRNBixD=NXytrg=8s2EXA@mail.gmail.com>
In-Reply-To: <CAGvw721RvLiV+G4Y7UVKyVerm2bQFfRNBixD=NXytrg=8s2EXA@mail.gmail.com>
From: Arin Sun <sunxploree@gmail.com>
Date: Mon, 28 Jul 2025 13:48:10 +0800
X-Gm-Features: Ac12FXy0IamdIOUgSpUBpZGN4SnmjMbICUR3XKuyYLJlYuLhH4JV47OJBRCygbU
Message-ID: <CAGvw7203sxpwoykZostfOZawmynre8fbaT2-67YL0h=FvAFE_A@mail.gmail.com>
Subject: Fwd: [stable backport request] x86/ioremap: Use is_ioremap_addr() in
 iounmap() for 5.15.y
To: stable@vger.kernel.org, x86@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Arin Sun <sunxploree@gmail.com>
Date: 2025=E5=B9=B47=E6=9C=8828=E6=97=A5=E5=91=A8=E4=B8=80 09:28
Subject: Re: [stable backport request] x86/ioremap: Use
is_ioremap_addr() in iounmap() for 5.15.y
To: Greg KH <gregkh@linuxfoundation.org>


Dear Greg K-H and Stable Kernel Team,

Thank you for your quick reply and for explaining the backporting
considerations. I understand the need for tested backports across
kernel trees to prevent regressions and appreciate your suggestion to
upgrade.

Regarding your question, we are indeed planning to upgrade to the
6.12.y release in the future, as it aligns with our long-term
stability and feature needs. However, due to constraints from our
partners and current production dependencies, we are not able to
migrate at this time. For now, we'll focus on workarounds to mitigate
the issue in our 5.xx environments.

Thank you again for your time and guidance in maintaining the stable kernel=
s.

Best regards,

Arin Sun

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B47=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=BA=94 20:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jul 25, 2025 at 06:32:50PM +0800, Arin Sun wrote:
> > Dear Stable Kernel Team and Maintainers,
> >
> > I am writing to request a backport of the following commit from the
> > mainline kernel to the 5.15.y stable branch:
> >
> > Commit: x86/ioremap: Use is_ioremap_addr() in iounmap()
> > ID: 50c6dbdfd16e312382842198a7919341ad480e05
> > Author: Max Ramanouski
> > Merged in: Linux 6.11-rc1 (approximately August 2024)
>
> It showed up in 6.12, not 6.11.
>
> > This commit fixes a bug in the iounmap() function for x86
> > architectures in kernel versions 5.x. Specifically, the original code
> > uses a check against high_memory:
> >
> >
> > if ((void __force *)addr <=3D high_memory)
> > return;
> >
> > This can lead to memory leaks on certain x86 servers where ioremap()
> > returns addresses that are not guaranteed to be greater than
> > high_memory, causing the function to return early without properly
> > unmapping the memory.
> >
> > The fix replaces this with is_ioremap_addr(), making the check more rel=
iable:
> >
> > if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
> > return;
> >
> > I have checked the 5.15.y branch logs and did not find this backport.
> > This issue affects production environments, particularly on customer
> > machines where we cannot easily deploy custom kernels. Backporting
> > this to 5.15.y (and possibly other LTS branches like 5.10.y if
> > applicable) would help resolve the memory leak without requiring users
> > to upgrade to 6.x series.
> >
> > Do you have plans to backport this commit? If not, could you please
> > consider it for inclusion in the stable releases?
>
> Note, this caused problems that later commits were required to fix up.
>
> Can you please provide a set of properly backported commits, that are
> tested, to all of the relevant kernel trees that you need/want this for?
> You can't just apply a patch to an older kernel tree and not a newer one
> as that would cause a regression when upgrading, right?
>
> But I might ask, why not just move to the 6.12.y release?  What is
> forcing you to keep on 5.15.y and what are you plans for moving off of
> that in a few years?
>
> thanks,
>
> greg k-h

