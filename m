Return-Path: <stable+bounces-19755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E02853503
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A955B2148F
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F05F491;
	Tue, 13 Feb 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHDy1Hfe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677755EE7F
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839129; cv=none; b=ho4+hlRliqfZ2Cqod7+ukqzh1U8QZwZHdxEIkKoj9aoYSP9irtGtT3TjGajawVgNN9r20nvZD1Nt093tPRKRTDDXw/TKfp4Uuc3P3qD9IZKUQvkt3B+s03DOivfR4eL8OuUnjasmU//YKQZqmIStiI5hUUa5tOhHTHl1Z7rWh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839129; c=relaxed/simple;
	bh=+/Eg3fKlMGekNo4yQ3rdUF3VeqRNJ0tYyXOMZSXk47w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lS3ZclZj1bszgUTdbjiV8CB8+hjBI66BEPjahVEoT9ysO6qm3xK7HWBrq9SV7UXHiuIAZDs7PbYGceUj5m+M3u6MbALPJ+4nx+LlBHhcX6/jDWGv5x7C3mhxI51HBcCdMTtZgyxPBBKEpeP5hRilqb5hm9xBf/sZEj/7t5Ek5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHDy1Hfe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707839125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mC+O0WAY8x9UWake37mLtLpIEPCaj8+5EiUT3ECyHuY=;
	b=eHDy1HfeSy5xVkYMjOx0FdORZ+d4Fa3wpbDsqmeU62W1Btzclh/yv0IsBnTwa/anu/fD4I
	bzMmjVepNC4cX1+6EElf6ruUxzxPAfttEnxARN57E6s0MMhgtsu8GVBljoaeTBA1iUAfvA
	iOMEQjILSEGjUODFEPoNOjcQDzEfF9w=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-8KW4kLefMUWeMHwFvlRubg-1; Tue, 13 Feb 2024 10:45:22 -0500
X-MC-Unique: 8KW4kLefMUWeMHwFvlRubg-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7d2df8a3e4dso3393143241.3
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 07:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839122; x=1708443922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mC+O0WAY8x9UWake37mLtLpIEPCaj8+5EiUT3ECyHuY=;
        b=AsQXlNuGXIQiIo+AklviRKS/Ri7obbfNEVuiFSbpBu07kx6CcXQABRh7YSfGqnlSQL
         neYKEXbUE/e+MWheaKuTl/PZS1KoKgSywabWCSSNdPHNLr9EJCqocrDfz1utTA4G+J+Z
         RbMGa1AUJ54K4SehMxsysScZSlIW2suYHEred3bWQWYgcyidyUl2qdLk0kJmtTFNwrKs
         2gn1O47qgn7SnMEJRvCOCPDGVNfmnJ5sgd8gqFDw56+u5+fj239roSPmYsgTQjcMWys8
         6cx6ak7pu5BdU+1fQYZ8I5J1tb8HPLwrE016lPCKnCjhJtiuY4eAQWkaxLb1BxIyxwg7
         SQjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLG5lYwfVkH2FPALsmfzqA9bNxDT/+Vt2RsCxcVysJcZJbFytVagtd2R+7XSxGLW0B4aSQ7+UCJAxWJGw1gsrYgrt8H03s
X-Gm-Message-State: AOJu0YzcsKfmS7YxgfuDZcGb0JtHMmYjRcLk/syiP2BDpWboqLweTuBk
	mLGAYXKp3/2o1L2b+wj6/rZ+yovZRSz1kMvcxQxjU6XIPvDAr9wdkT4LTwNVMuS2eADydbnmn9m
	DhHii+xHRGND7Ce/8AoOHfggnF1gBh9/NpAEdY0uotjCS6pIVgjj3psqBSnveLQsXQGTZPcc8mF
	EMYwsy6uquu0hFssjOrNqsT1R962hf
X-Received: by 2002:a05:6102:2404:b0:46d:5e5a:5e80 with SMTP id j4-20020a056102240400b0046d5e5a5e80mr7770274vsi.31.1707839121833;
        Tue, 13 Feb 2024 07:45:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5uZRjDeJV9I7SDi5aFF14RvjRJfCYm3XpvfMki8n9aEbHyODKiVLPo9TTtcP8SbrbzA5HrAm6y05wjIoyygo=
X-Received: by 2002:a05:6102:2404:b0:46d:5e5a:5e80 with SMTP id
 j4-20020a056102240400b0046d5e5a5e80mr7770086vsi.31.1707839120113; Tue, 13 Feb
 2024 07:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230902.1867092-1-pbonzini@redhat.com> <2b5e6d68-007e-48bd-be61-9a354be2ccbf@intel.com>
 <CABgObfa_7ZAq1Kb9G=ehkzHfc5if3wnFi-kj3MZLE3oYLrArdQ@mail.gmail.com> <CABgObfbetwO=4whrCE+cFfCPJa0nsK=h6sQAaoamJH=UqaJqTg@mail.gmail.com>
In-Reply-To: <CABgObfbetwO=4whrCE+cFfCPJa0nsK=h6sQAaoamJH=UqaJqTg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2024 16:45:06 +0100
Message-ID: <CABgObfbUcG5NyKhLOnihWKNVM0OZ7zb9R=ADzq7mjbyOCg3tUw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/cpu: fix invalid MTRR mask values for SEV or TME
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zixi Chen <zixchen@redhat.com>, Adam Dunlap <acdunlap@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 6:21=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> On Fri, Feb 2, 2024 at 12:08=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> > On Thu, Feb 1, 2024 at 7:29=E2=80=AFPM Dave Hansen <dave.hansen@intel.c=
om> wrote:
> > > I really wanted get_cpu_address_sizes() to be the one and only spot
> > > where c->x86_phys_bits is established.  That way, we don't get a bunc=
h
> > > of code all of the place tweaking it and fighting for who "wins".
> > > We're not there yet, but the approach in this patch moves it back in =
the
> > > wrong direction because it permits the random tweaking of c->x86_phys=
_bits.
> >
> > There is unfortunately an important hurdle [...] in that
> > currently the BSP and AP flows are completely different. For the BSP
> > the flow is ->c_early_init(), then get_cpu_address_sizes(), then again
> > ->c_early_init() called by ->c_init(), then ->c_init(). For APs it is
> > get_cpu_address_sizes(), then ->c_early_init() called by ->c_init(),
> > then the rest of ->c_init(). And let's not even look at
> > ->c_identify(). [...] get_cpu_address_sizes()
> > is called too early to see enc_phys_bits on APs. But it was also
> > something that fbf6449f84bf didn't take into account, because it left
> > behind the tentative initialization of x86_*_bits in identify_cpu(),
> > while removing it from early_identify_cpu().  And

Ping, either for applying the original patches or for guidance on how
to proceed.

Paolo


