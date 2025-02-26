Return-Path: <stable+bounces-119687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D15DA462E5
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCFB189D7F1
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDF192B77;
	Wed, 26 Feb 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWb+oE74"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733622256D
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580350; cv=none; b=SODgjogZFP53W7YBZSFqUD/TC5VGOOd+je8QsGET1rRhdF3n1qjZOjxPlzf1eJL8xrCUuqjR7A+VwFcZ/VkNrxhYpRGUSFQxaJvHHwRSZBh02q9WgQ3cmOhSf5KXZA3csqHgpDEXz94yAclmrCeH7+j+plf17tzfTlGLM4tCHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580350; c=relaxed/simple;
	bh=1xje41uCepRrRXg3A3edi3Mg9Y3fBjuttj6Mnw8furo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/f6mIFOubgLO6Y3nyV9Z423dDIpp+7Gx4JfLR49TQmsKjYgYTWBQEr4EiE5iqE1e/AQpGVD6xphSZTs+PA3dsRSSAeb6foJshpNI762TtvbV3KqJC8l1WfJSoEn44asAtALDk0FpxljYvpg5vxvoKhCCk+sZ/ia+AGwAsLiZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWb+oE74; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22342c56242so38285ad.0
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 06:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740580348; x=1741185148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td9asxPNprcMZQkvIe996BJRz0iK1TqPUGnP0/ABMBE=;
        b=gWb+oE74KGT/ffjSYhI9knAAG02nDNmIqpwPgndBTLi+3Bnze37K72F0LiBn/AvZzu
         eRrdn8M2vCONtNGEndrmi4jyhiHEtPEi/cP+T+A81XkKChrfJ6ksGkOkvQ0Bk/EKm0TQ
         JKpLmTaz97+pp7F/4Xx7Y73LHSPRoXQrn5oWqRPonRrYg9L+V89fZohX+TJwfWnLhRv/
         EXy8v4/niZC+go+YOdjcebK5julupkTw45CM6yKoJJy0gKnt048tfwafbJFwp6slapPT
         V2ubURY+MKmJBRgkDZ9POYeNxMDoYbAoHTa5YtoRuJkzh1aAZL+a7PlWeGW7UII3JWKZ
         znLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580348; x=1741185148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td9asxPNprcMZQkvIe996BJRz0iK1TqPUGnP0/ABMBE=;
        b=KwUNBrrvIWyA+Syzk8jPprpWMLwoYwO4sPGXMVoYvyS+xQ3lHsenD9v6TbGouef9fV
         sveohC+/h4m37qzeewCLhuFclRDNJ9ikGBgAWlGSVyrcK9D0SiTUFNTRjOn37L3p2N5l
         cwMZtoriZnrhM2MR+O4H0XQPpcQ1Xg8+Fy4JVrbqQT0Y1TVqL7xJVWAWyEfdhKaxOLii
         uaLG1VRIukMYeWNrLI0u08dUFHn00eyNC5fS7lDEYQu1dPC7zzzcfxtNB/h/rM5DiYM3
         JCll9hNIrIVI896gsak+rDjCkEXRYKkGJFgSMzC1KuOGMUil8W3GLwcXobK6wSi0BiTz
         36qg==
X-Forwarded-Encrypted: i=1; AJvYcCVOLyewQk9sXGK09qjPbksVSqJS08kXDdpOR/oB3cd+j4JOCWXYbn0PRM0l85l4WRM96udok5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLxqSc+h2YrHJB2YMPaP27jHBysfYmCyaS0c/bIKqdkhyBIfH
	UEkflLmMdIT0gorVcrEA/rttYGnIpiE9I+wngXmt9i5D4ZTJ/jGU87Pi3NIOP2PjeH3NP4ust4L
	DXzsDbuU4OE99blCYZq4Ko58NK874krmXCQGN
X-Gm-Gg: ASbGncuIOhvzwRLjVC3H7jNBi2EAMZ4FnAfPGcznv5Ag1fqnGWg4KJHzzrod/fP/9Fb
	fw/vbkkG/ZdowzyZ6mVrBIT1cpffv4AG//wf5ekAbk2TsP27GAoFcTw3PP5CT7evroyU/rQc+qk
	DVu/4tZw==
X-Google-Smtp-Source: AGHT+IEV7oIAxW6mnHKhBlIrbZwecYCm5nSGQwXbP+kYpROVcMIbhN327FZxfj24JStSXf63AwfCMV6rWezOiQiGmYU=
X-Received: by 2002:a17:902:ea0a:b0:216:21cb:2e06 with SMTP id
 d9443c01a7336-22307a97497mr6478505ad.19.1740580348078; Wed, 26 Feb 2025
 06:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226114815.758217-1-bgeffon@google.com> <Z78fT2H3BFVv50oI@casper.infradead.org>
In-Reply-To: <Z78fT2H3BFVv50oI@casper.infradead.org>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 26 Feb 2025 09:31:51 -0500
X-Gm-Features: AWEUYZn6pM-y42p_MFAy4Xy3EXUzYgSyyByB_sRAby2IurtgY3iUwDA_grGzwRU
Message-ID: <CADyq12x8eJ8ASq6WOEkFFbmJYajLnPd+qM8+QP1W76Add=S67A@mail.gmail.com>
Subject: Re: [PATCH] mm: fix finish_fault() handling for large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Marek Maslanka <mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:04=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Feb 26, 2025 at 06:48:15AM -0500, Brian Geffon wrote:
> > When handling faults for anon shmem finish_fault() will attempt to inst=
all
> > ptes for the entire folio. Unfortunately if it encounters a single
> > non-pte_none entry in that range it will bail, even if the pte that
> > triggered the fault is still pte_none. When this situation happens the
> > fault will be retried endlessly never making forward progress.
> >
> > This patch fixes this behavior and if it detects that a pte in the rang=
e
> > is not pte_none it will fall back to setting just the pte for the
> > address that triggered the fault.
>
> Surely there's a similar problem in do_anonymous_page()?
>
> At any rate, what a horrid function finish_fault() has become.
> Special cases all over the place.  What we should be doing is
> deciding the range of PTEs to insert, bounded by the folio, the VMA
> and any non-none entries.  Maybe I'll get a chance to fix this up.

I agree, I wasn't thrilled that the fix looked like this but I was
trying to keep the change minimal to aid in backporting to stable
kernels where this behavior is broken. With that being said, do you
have a preference on a minimal way we can fix this before
finish_fault() gets a proper cleanup?

