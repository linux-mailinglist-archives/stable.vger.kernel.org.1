Return-Path: <stable+bounces-112057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D9A26663
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 23:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB1A1885B13
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5320FA99;
	Mon,  3 Feb 2025 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/mFp8K6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4B1FF7B8
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738620536; cv=none; b=XtZJfduehGGfAcWML/0FgrpYwU3kyIo+wG/8LUtOyLiu9g9H2P6ATNWjUsIwLl9aKDXc0OSlt2l4gpSq1Mhb6eAzkNXRc6XTaHJHvreWX9YRTO3HNXcZcgsEgjaJntyLwA9S1GF7kDSG0U4VWDYwnAvJU7eA2xImiLnWDj/BULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738620536; c=relaxed/simple;
	bh=5RAtnqgSsJW3L/OucE/O3ftfhIA9MkIbq8HBQmwo9mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPXtf6Icq3guT6+HeG3l/S9MvGF7iL0Oiy0FqPkWQlIsOPff8j2NgnePyDaJsrJxlmzZ6gQ9AG0T2t1lwieUg8PfEPragQIllDgQQ5YUNknDrxeHR2zYf/CE3RjLXtv9p4aoDASIR8TkM625kO5xFwr1ITAu25pjrAyOjJ+OWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U/mFp8K6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e3a2264e1so2395e87.0
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 14:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738620533; x=1739225333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSoo65ANk1ACUgD5CEe1MmfBfCx6K8V18L1pZv5jKUg=;
        b=U/mFp8K6kOjCQUGiq16ftHdAizOEbwDtF9bX6JgYYEGcB4azgC7vabPNLgPgp7jtek
         e90myPCj9lWjYJEOK/B0TaRn5Gp3wsMyq4xG5wCv46IkAQRHCC4NKSzC2yaAm8OsX9IR
         zJih8KUdou5DJNFsOP2tbHcPc/vl6IpAeANflVFesYVWSr1JUGBrsGTMCNNwNN+GFLrH
         jruNnmI5rj688tjLcN2HnM+qaRtBfH9greqjaHkUfAGMJqxefld0uAjZyZcHjn8kALgL
         PE8VBKF6uOhXyaCDqlVC6DrqcnwFwqRogcwPdP00eDyajK6yYkR/As9Zg2gjtNcT/MeX
         HQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738620533; x=1739225333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSoo65ANk1ACUgD5CEe1MmfBfCx6K8V18L1pZv5jKUg=;
        b=H5Ni4zr3sPWRJ+KCiYIuePRjOOlLa/ghp/xFwrC1QfsTTfsXMOYNZBVke5qXh65flN
         ebsvwz4GP+N1Ob1DCm8Yv62PAWEESV+cT/BsYUl+ffIdWbOsAogZVvfjT+94Rpqh/AOh
         +GtMdYREWpoltxwE+Kj6tAcNwMKS9x2SyjwG7UfdxHo/kjtwVa8jrgbiLH05/LeJ60Ad
         ovstjyCGGQpQSyLcgX972xqKcHpsceOfWJnijezogfiZDIhSl7odg70aUCjMNVP87i29
         5eq/JNlfDVKlhstGlNcImQNingYNTVQXls1wWbH4ANbsgmV8sMn2RpBHGV2GBw/3egG1
         Ijww==
X-Forwarded-Encrypted: i=1; AJvYcCX19LtOUWa6pvE9D5WjzOeZqubrcNahITGQ+O0NXYLMYF1uZ/M0z6+FsjNbhHDSsrqQ0usyBdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTO8Pq6v6RnRo1mlaK1iuVXd68wlBBrsWWqEj8aKdqguqEKybs
	+dHRB/fBBabzGZ7z7Yf0V8UYXqaMb3rN/L7Mi+pMACbKbv4ydVSgEi4T5pgOpD6RzR+seEabtUv
	IZi8G7QbPVaFr5A+DScER5g6gXiLLEWez7PjL
X-Gm-Gg: ASbGncuFciRidk4W/50h9Kqx3dRQBGLky7V0UBKtoZ02ZI4nWZWzd0l8u1s+CW5j4QX
	+UHD0cIaIllwophl99I9vgyend5kPi9+RVZ4nJWJR+URwQyTDKsZBonqcW55hEjGzabiezi+oYY
	R7WYUnZe4AsBBBASDMPwvCXy/bF5VWig==
X-Google-Smtp-Source: AGHT+IHtm70vTgHPrrcUuJwFAa+5zFIj4hqVrwA8yzRqmy3Y13vzkDTGy11M0PhuNPkDVSVa0ZHRUqRBsdcAg8i1d2U=
X-Received: by 2002:a05:6512:3b2a:b0:542:92ba:a08c with SMTP id
 2adb3069b0e04-54400bd712cmr17275e87.1.1738620532535; Mon, 03 Feb 2025
 14:08:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129232525.3519586-1-vannapurve@google.com>
 <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
 <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com>
 <wmdg54v56uizuifhaufllnjtecmvhllv35jyrvdilf4ty4pfs5@y4zppjm2sthr>
 <CAGtprH82OjizyORJ91d6f6VAn_E9LY7WptN-DsoxwLT4VwOccg@mail.gmail.com>
 <2wooixyr7ekw3ebi4oytuolk5wtyi2gqhsiveshfcfixlz3kuq@d5h6gniewqzk>
 <CAGtprH-n=cfH_BJAmiNMoRbqq0XdGCf3RE67TYW8z7RARnsCiQ@mail.gmail.com>
 <40418980-6e5b-48eb-bc35-7ffaf3221fd9@intel.com> <qzl5vkhykj4anuvjrhfco5qoeuib3oskffnxnqbcszotttnnqa@up5b4xl5l55g>
 <702c5acb-6bab-4940-a8f1-c346373167bd@intel.com>
In-Reply-To: <702c5acb-6bab-4940-a8f1-c346373167bd@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 3 Feb 2025 14:08:41 -0800
X-Gm-Features: AWEUYZn4lp_A5AbUjUHimrHcFYW36fbGNYwCsxNdJcmy9mUWfgPSBJE-b3l4FDY
Message-ID: <CAGtprH-grdiE2AaagnYNUQC4ytSMxErYoh_Xyg2Nwmto33Yyyw@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 1:19=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 2/3/25 12:09, Kirill A. Shutemov wrote:
> ...
> > But Sean's proposal with HLT check before enabling interrupts looks bet=
ter
> > to me.
>
> "Sean's proposal" being this:
>
>         https://lore.kernel.org/all/Z5l6L3Hen9_Y3SGC@google.com/
>
> ?
Yes.

>
> Is that just intended to quietly fix up a hlt-induced #VE? I'm not sure
> that's a good idea. The TDVMCALL is slow, but the #VE is also presumably
> quite slow. This is (presumably) getting called in an idle path which is
> actually one of the most performance-sensitive things we have in the kern=
el.
>
> Or am I missing the point of Sean's proposal?

I think you have captured the intent correctly.

>
> I don't mind having the #VE handler warn about the situation if we end
> up there accidentally.
>
> I'd much rather have a kernel configured in a way that we are pretty
> sure there's no path to even call hlt.

+1.

