Return-Path: <stable+bounces-159132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1E6AEF52A
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 12:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22A517F0FC
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21D270EA1;
	Tue,  1 Jul 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="25gycr33"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702427054C
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366066; cv=none; b=rFowD1uEHeabeAQDOMZE1uZUd276HJ5j8mA+JceCskzVTAR6KohOWb8SP9n9ihfT0hBD+FL2rV29awNXuHOcfWweCDFyJYHKjRgkW+y4QCEoZjq1Z8B9sHU8o9RcBwVPnMTev/2DQamPEn7dp2JXiiL8du1t585yzojU/Bq4NSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366066; c=relaxed/simple;
	bh=mlpMmzdWBdqODn8nxplDCEWI1NG6aMwmsjqN3xDfy7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1fP9c30pt+iANqFn4HG7CX0lQjSKaP598qjMixuYkZsRSLpGjJHxX6KAo0N5GJdzl8+P+fKeH//e0hnz458W8whglum/BXnoM/FN2hPZYV8ab0Nspu2nX6fktyUv5va56tNjCfM+BfWVWUdrG6mwko2r+esBZwiIqmhjXnzpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=25gycr33; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso6621a12.1
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751366063; x=1751970863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp4bVSGoIFyW3QSZPFAFfubzk2+mLro6i9/ObDTSNoc=;
        b=25gycr33jzOPxfgfitWE2++05d9Yjm4ZG7O5Iws0y/AP0EG7wxVHDD98UPriKb1RiB
         pnWlqtYMZb+VGTkqIp7EmLQulU6Hhn0S0WPcDHFi/yTOZv+ORpzcPbcHrwlDUvBsJw5h
         XeBbQJ8iyNLx9jkhgzYPTCeegfla235zDdM4vzM1OM7W8DfL4Xyz7JU+SUfKj+9AiCbq
         C8ooIVx6JXE+M0mvVjklq0jpC/jDbSuBhA1DUikKSZp4Sr44wB5jHEp8rooqHZf2yzW6
         geV/6ofX8QnIz+lOm8SsGBEHSH+LhUo+0cBMpeMogUSjO0gExTHm/rcXIWwimHnK4mmN
         p2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751366063; x=1751970863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp4bVSGoIFyW3QSZPFAFfubzk2+mLro6i9/ObDTSNoc=;
        b=KuDv0hPwvkzZ5N4Jkw9WELs7vUB5dcH9/6kOLyezvy0FFGdoVWqJSGaMd9P5f7UgR2
         AzjjbpLmoEVLmlyuBbq2VwgW1cfXNzqyNKDDfYwc78k8Bz10AZLHz034ZnIDsrE2eNtP
         NHqktg8OLZpqTeNGWDXwTGxFXhVVyXH8uP6u3XQV2UA/IFeCJ4XvOTPe8TE6qARXFfhi
         GR2syApphmEcZEwCIk9MvxNuwEK5Z5gSeLilWOvj0VHRPTqmZui6mF8Jl5nn/VLtxUSt
         k72ZLneF+1mxCtL/uO9HSJLR8LS1vFNT1NkTLKcwdPB5pNPlKvM0+jYHjCJHhPvb6FXC
         fd7w==
X-Forwarded-Encrypted: i=1; AJvYcCVi8Bv4cfsxik5Dlx9QeofEKhMPtaG2ijKHDL210UB8++UKuQbw+c5xLeR+prg5oKbOOiZwx2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6bnRh/PXkIMYid4l0+EoPIn+LN+lROKSpJG1dARVvfiuo+WQp
	GCioOKijJreOPq3d3Xg+5eMzFvzakrN93GwwlHmLss9UJpH4s6ahhaWdAL4o5K2jYZBViq2fThh
	z+G4RXqSUCggb29DGvuNS7WJZm79oC06pcdb1u1Lr
X-Gm-Gg: ASbGnct7tajB7hORLxVSEIWgkuqOv/eys7CANBhoA7mM6meE3KD/FDDTwimj/4rULih
	Q02GywGXwo7N2LsInlMyZE2pFbFb2Ytt8nQf3m972Jz/jzdRVnWEdirf7dKpr4mgTqxp6ukPb/b
	IN1MdpNuFBH+ZZc/R5GMB7q462kNkuCeT8kQM4VufR/gyVhFd/6FFNDwjeFjvnMTjqHoYAU50=
X-Google-Smtp-Source: AGHT+IECcsWBgg3PF6i48r44nlp9IbtTj/EJFncm5u1sICXIyrAefpX9CpH2gIQ3ueQKjUmMICOM70+9nQx4/JJS8NA=
X-Received: by 2002:aa7:db87:0:b0:60c:bf83:65fd with SMTP id
 4fb4d7f45d1cf-60e38aaa441mr50137a12.7.1751366062867; Tue, 01 Jul 2025
 03:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-x86-2level-hugetlb-v1-1-077cd53d8255@google.com> <9179e1cd-d635-4e70-931e-4a85c2e6932b@intel.com>
In-Reply-To: <9179e1cd-d635-4e70-931e-4a85c2e6932b@intel.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 1 Jul 2025 12:33:46 +0200
X-Gm-Features: Ac12FXxhb8kBzQck0JMDVfWECd6qOpwCqgTE5nperjslnwlAJZeksR8-H6YaZhA
Message-ID: <CAG48ez3YcgPz+oQ4shMjaviPNeZjJYg8K3iDPJkLaOKbcgASNw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Disable hugetlb page table sharing on non-PAE 32-bit
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Vitaly Chikunov <vt@altlinux.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:39=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
> On 6/30/25 12:07, Jann Horn wrote:
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -147,7 +147,7 @@ config X86
> >       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >       select ARCH_WANTS_NO_INSTR
> >       select ARCH_WANT_GENERAL_HUGETLB
> > -     select ARCH_WANT_HUGE_PMD_SHARE
> > +     select ARCH_WANT_HUGE_PMD_SHARE         if PGTABLE_LEVELS > 2
> >       select ARCH_WANT_LD_ORPHAN_WARN
> >       select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP   if X86_64
> >       select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP       if X86_64
>
> Does pmd sharing really even work on 32-bit? Just practically, you only
> ever have 3GB of address space and thus 3 possible PGDs that can be used
> for sharing (with the 3:1 split configured). You presumably need *some*
> address space for the binary to even execve(). The vdso and friends go
> somewhere and we normally don't let anything get mapped at 0x0.
>
> I think that leaves _maybe_ one slot.
>
> Barring something some specific and compelling actual use case, this
> should probably just be:
>
>         select ARCH_WANT_HUGE_PMD_SHARE if X86_64

Yeah, makes sense. I was also thinking that it would be more
reasonable to restrict this to 64-bit only, but figured it would be
less risky to make this more specific change.

But now that I think about it, it's not like stuff is actually going
to break from this change, worst case the kernel memory usage goes up
a bunch in a very unlikely configuration... so yeah, I guess I'll
resend this later with "if X86-64".

