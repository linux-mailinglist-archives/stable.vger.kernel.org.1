Return-Path: <stable+bounces-166524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 262FDB1AD22
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 06:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA447A4FD0
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 04:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622EA2135A1;
	Tue,  5 Aug 2025 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GThuuEDp"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40E15E8B;
	Tue,  5 Aug 2025 04:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754368115; cv=none; b=seXB/z8v5W3RJUB7gUHTwZAI1lLwWAkrIne1cb6525vD9TspOEhlDVVjBkv4rmDNBCltISTiKuKc8ysYjAOfd03NrORuNUsBu2wHofHqM1N863h3GGVpvDX7npAdvEo1Dl5077vZ+NJFCRnZfqeNAmR9cJeVoGnUrn+ASsLNsc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754368115; c=relaxed/simple;
	bh=R7Dy9xC26bS/WYJ9jhY/pQBJT6iqPWi+su3GVktjtW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgckIbHgBX3tgYMg+QbIlUl+yu3muKF+w+VL/qNthWfGttgMNpK5OnShHcCTAP03fq1Vhj8RFadWYFtct0bt9qHecocOMYqVddwPS/9/5rPoYYFEsVWIspKzzjOgILSIhRpbGGXKl21EzvIck3B8FRa+6DT1yjZPdhc+9VL1wyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GThuuEDp; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30b6c230808so691056fac.3;
        Mon, 04 Aug 2025 21:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754368112; x=1754972912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pUaJblhwWLjukDVkQiujzO4oHldTFPlVwTgtmkljHAs=;
        b=GThuuEDpW7dwB0z+zn/s9llDIt7OZpzvlFpcZp6X1PqHhr3ou7hc4By0ng+f1D6Jpi
         H3DSZqhN5HtTZxiRczyjbgjhRLXyJDjWeBOwwbTnYIQKnbWp+5WOA8zpsi6m6nAPPDkA
         8qUx8+g4YE6t2lN7glI53SQAKMKqdirSJSuehG8ZHB6Cwd2Yln877TgClc/AZs6K08Gb
         LXg8HcRyyh28fuN2pcwHkq1OcW6tlJqUj265+qFUPhu8qYh5LyYqQV/tjJ7ncNd+Irtm
         kQxML9yhE1wBiUKWP8ZMoFDJFYsd4/9QNvfnSn0l4PA5aBkJ1QDBq9V42PwUvaBrKBpL
         FXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754368112; x=1754972912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUaJblhwWLjukDVkQiujzO4oHldTFPlVwTgtmkljHAs=;
        b=JlmmDN0o+yllMOF0ptjACnIi6xSIbnXvmpCoepw/8hJwLD47wqdHR/tPxkiS37uIfX
         EgUlULcrUODhA2Dgay/aaKeg9aUyogz9FzycGDNSZ4q0jtS55TBj6+yrwspFZq8ih+ZD
         YpWstkNv9FCy2xzkVM/TNs93lcoOGwjqyXwXTh9i5q+L32BmtZ6TuIqZ/AKLvMKKe5jz
         MZO0aCnN/ZP9vRW5omGVrUCynqWezp6Tb2ayOoqeKx0UYqTvgBR8/XQQ20SO0yryLnQG
         zziMPji1CJ6+fGBJG+RtJujmg2Y1bknBelifjt3qRiAp7QFIxc0SWv4LBqmc0zGHLTpt
         pPew==
X-Forwarded-Encrypted: i=1; AJvYcCV5U4PPpwgdsNu9L+TUwkVMIISs6oG3TseCeb6N0jx0C3unB8MEv3AM8chRhJAwXltObDTIvrK0@vger.kernel.org, AJvYcCW4ZbHDIdlU2RB/k/WFQTC/g7y4BejA0EDha6hQhLYf2DPrIYQw0F3AR9iWSuivBpt5snyfQEZnlv0Fhto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxgDI/cp/c8WV8jivq8mACdZ+OdeNO54qy9SVQ7nO0qJOb+eW7
	YGhZwkyYwB4k7ZEjo8xJzC5ZyskX3AoUK93uhVFaZ8hDh6ljZzt8Adu4ZQ2Q1xXiBBFpZ3Y1Nbu
	a3WmySAuPGILaENRk8SC8/bS3ebgziQY=
X-Gm-Gg: ASbGncu1WlkTWDyBMXeB9SW1Xt+H9UQqp+wbaHyOwZ42/2hw20ubysK3SEhbVCtCRsw
	vFQrYUVYBtyL27cQ3A3b6qoPIcXTJu+uv5WBH7t6aodGVGDBwGGBGDC3BmaADm0I3mRzZOOBgFM
	slfQI2v/RX2yvOSCwZHi8RR71kpcpv3WHpobT0XQwssYg0tqAwQ9cjxw/AcnfnJPe9dpIM6AE/y
	r35SBIgwC8NtpgNkWQ=
X-Google-Smtp-Source: AGHT+IFIS1hFyYOw/9z6OJKAUPK2nSzN8AAYXHZ9FkI4yxF1y66ZgTuQnJuTQv+2chhzYF8MdeJXC/Mkx+G6boaagR4=
X-Received: by 2002:a05:6808:8817:b0:433:fa6d:9104 with SMTP id
 5614622812f47-433fa6da581mr4488124b6e.24.1754368112374; Mon, 04 Aug 2025
 21:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804175901.13561-1-suchitkarunakaran@gmail.com> <e72b9895-c143-4818-901b-7d8ab26b8e91@intel.com>
In-Reply-To: <e72b9895-c143-4818-901b-7d8ab26b8e91@intel.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 5 Aug 2025 09:58:21 +0530
X-Gm-Features: Ac12FXxcxa8VGuquMz0SHNBAIz0-JkLlAXxmrFhAbK7ZsWIdngczcCwY7oz2ODc
Message-ID: <CAO9wTFiy0FjY61Czs3Zz7MyS3OxHS0=2+nbf+_yWYAEKYr=YBA@mail.gmail.com>
Subject: Re: [PATCH v4] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	darwi@linutronix.de, peterz@infradead.org, ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 02:07, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> Hi Suchit
>
> I would strongly suggest spending more time understanding reviewer
> feedback and incorporating it before sending another version. Most of
> the comments below are a repeat from previous reviews by multiple folks.
>
>
> On 8/4/2025 10:59 AM, Suchit Karunakaran wrote:
> > Pentium 4's which are INTEL_P4_PRESCOTT (model 0x03) and later have
> > a constant TSC. This was correctly captured until commit fadb6f569b10
> > ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks").
> > In that commit, an error was introduced while selecting the last P4
> > model (0x06) as the upper bound. Model 0x06 was transposed to
> > INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
> > simple typo, probably just copying and pasting the wrong P4 model.
> > Fix the constant TSC logic to cover all later P4 models. End at
> > INTEL_P4_CEDARMILL which accurately corresponds to the last P4 model.
>
>
> Please use proper spacing and line breaks. Posting this as a single
> chunk makes it very hard to read.
>
> > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> >
> > Cc: <stable@vger.kernel.org> # v6.15
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >
>
> No blank lines between these 3 statements.
>
> Please take all review comments seriously, even if they are nits.
>
> https://lore.kernel.org/lkml/2025073013-stimulus-snowdrift-d28c@gregkh/
>
> > Changes since v3:
> > - Refined changelog
> >
> > Changes since v2:
> > - Improve commit message
> >
> > Changes since v1:
> > - Fix incorrect logic
> >
>
> Patch-to-patch changes go below the --- line.
>
> You have been provided the same feedback by other folks as well.
>
> https://lore.kernel.org/lkml/61958a3cca40fc9a42b951c68c75f138cab9212e.camel@perches.com/
>
> https://lore.kernel.org/lkml/2d30ee37-8069-4443-8a80-5233b3b23f66@intel.com/
>
> If you are not sure, please look at other submissions to the mailing
> list that do this.
>
> > ---
> >  arch/x86/kernel/cpu/intel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > index 076eaa41b8c8..6f5bd5dbc249 100644
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
> >       if (c->x86_power & (1 << 8)) {
> >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >               set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> > -     } else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
> > +     } else if ((c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
> >                  (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
>
> Again, this changes the previous alignment. You do not need the extra
> space before INTEL_P4_PRESCOTT. Avoiding that would keep both the lines
> aligned.
>
> https://lore.kernel.org/lkml/30f01900-e79f-4947-b0b4-c4ba29d18084@intel.com/
>
> It's acceptable to ask clarifying questions, but disregarding review
> comments frustrates reviewers and inclined to ignore future submissions.
>
>
> >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >       }
>

Hi Sohil,
Thank you very much for your time and the detailed feedback. I
sincerely apologize for the repeated mistakes in my submission. It was
never my intention to disregard any of the review comments. I was just
focused on the commit description and, as a result, was careless in
properly incorporating the prior suggestions and formatting
requirements. I understand how frustrating this can be, and I truly
appreciate the patience shown by you and others throughout the review
process. I will take greater care moving forward to ensure that all
feedback is fully addressed before resubmitting.
Thank you again for your time and guidance.

