Return-Path: <stable+bounces-165531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CF9B1633F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29C94E7C94
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06142DC326;
	Wed, 30 Jul 2025 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF0s9VCW"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9D1917D0;
	Wed, 30 Jul 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887529; cv=none; b=qk3b40azUFVhdpmTHamvreqf22cpQ7lBeIhDWBkd46H3K64ZzuHKrb67yewo/2bSM945meFR+ANzjvr+6XowirNXz/TptqM40LgNkwJiJx1U/1ovxlNcSMwHG/+OJaZdPvLTJC8uOPH2RQ0dxyGXN7W9kSNikqZsElKLZukX4e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887529; c=relaxed/simple;
	bh=C8HNY5HrTEJgbJiCn3KWLtJZd4ppcT6oiyB2Iuk/LqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mw5MKWhjdE6ZlBKLnXM3Zcfa3uefsFqn6YiWsf6uZ3lS9Y+8AtetlXbJGQXTP8/XqRYUoN3hRRPgg0syQUESop729F4FtPpzWQcvAQeXDyB1aqpfccWzyrRN7ukBnJqw4guqHq7/jzAFHkCJ20l3kS/INWO27LVTCs/TI20wcuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF0s9VCW; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2e95ab2704fso5225580fac.3;
        Wed, 30 Jul 2025 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753887527; x=1754492327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MWkLwfL42VeqtXqStyy5GMMrcz/TRHF4ZuSrJiE4Kuc=;
        b=GF0s9VCWfbKnhbKKWp+c8OzgAwAQwikGf/+oedfpqroF6EmJVXPte6ySlewZh+naeN
         ftS78UcLnYcryG9QbbyxN6R/eHqZYKq8Yf11FpcaatUuOrrsaCK/Hf7cowtUwdjrfovo
         68XcBZ61zcPRiKA56BTbSN+yfOdGw10zX6/IxOhtr/BHNgRltilYEMMN88MXJgtZixQ7
         nouRGP1TbxGS/GjJcNjIj4PxcObL4Jg7erpwIS7BXlO5czTWan7z+78yZoAy+8DKd7bV
         9dT23gx0LtyfgDrPXoYPSnXzbODtATWOOU9AQi1C4c9gl8LzKhtg8fUuN6BKtCrTV9bx
         7c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753887527; x=1754492327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWkLwfL42VeqtXqStyy5GMMrcz/TRHF4ZuSrJiE4Kuc=;
        b=E5Ke92xQzjoUeYj/v4fBzZIIQ1/5lcKjTc4CZho6Tngt8r/pHmaCvUkP5yP7etY24y
         fCxGDgxKodRZnP2yWTpocohSME7ih+f8XZQ7zHyN0P9aQy8O0fHPmV6/he6Tq62f5yS+
         uku3RbkvBG2w47dn1NKuNIwNhyUl09tCSiVkH3EqI9KTclwnz41X0fnyp9or1B3PPbkJ
         3QtvkNSM4MQdVS5pWxIVlKD1ItcQRxKZKB8eqhsg4Y+4y2vVvvwCe0yEucbBjVuvRYGt
         6ZpgXXIR0JYsZ2Cy0Yiu/ZlGr3poPKvUMhr240aD59qVmHyaZ9p2lnPfJgExi9Y/gpdP
         JMBw==
X-Forwarded-Encrypted: i=1; AJvYcCU0gCOl6s2GxBQtLOzVS61vIeNCI+UNH62DW92jDO83PS7JZHaky2RuavklmdXRkoU2DWR79R/Z+3WAROU=@vger.kernel.org, AJvYcCWAVRPhoSI8b29OQeNbj8hwwuH5grm3CK+0ZuWqMkQf6yCKdeTaPvfV17NspcvTj8u/rINsTy1+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk162DXBoN83rxfI3X235kS53XWDBx8H07uKua5eUJcRaLHcLg
	rZX8Gu3LvkH6YUwtmlvBavgBXrsBlsQQk4lJILeVuSBnhHSwjR/vHrrTdv3nMo3rLXeNKZSlECY
	MHjXbk/oRIaByWVjd3I84poZu2uvHx7w=
X-Gm-Gg: ASbGnctmeCOzlAKGpNOwka/edgGlIcHeQyDBU/nzi4Uvo7hqwMePfjlYOVwhVq4fS0a
	MidS1QFhACXwXi+i/yNwNCm4UBIF+2rwVmG9UzDHvSB429sQAbIgfkckT1X1NNnygDb2C8umFlT
	MA4SooENVyYmTpmq+9tDHDX3fdh8td3OeIT2t2EVzEH7pGnaqxwAhieU+fGI3HmMpUSwhtQb2AB
	C3kL98t
X-Google-Smtp-Source: AGHT+IGT85piwykesRKtJ7B/VJqeCTiZL6elNW4hZYCO836mZ7x5jTfgmlLs+0Z9HYwu1pmcJMXsdJZ/qK2GYuEY1KQ=
X-Received: by 2002:a05:6871:789:b0:301:db6b:45dc with SMTP id
 586e51a60fabf-30785a1fb29mr1868007fac.11.1753887527133; Wed, 30 Jul 2025
 07:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com> <30f01900-e79f-4947-b0b4-c4ba29d18084@intel.com>
In-Reply-To: <30f01900-e79f-4947-b0b4-c4ba29d18084@intel.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Wed, 30 Jul 2025 20:28:36 +0530
X-Gm-Features: Ac12FXz5CxoabAlr444m-BoD2XsYpfb3-HiNQHW1O69JmZ6KNq7xPSsrDQlJwAQ
Message-ID: <CAO9wTFhZjWsK27e28Gv2-QqMozns47EacOQfXtTdMfLjR98MTw@mail.gmail.com>
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	peterz@infradead.org, ravi.bangoria@amd.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 20:12, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> Hi Suchit,
>
> The patch looks good to me except for a few nits below.
>
> On 7/29/2025 9:26 PM, Suchit Karunakaran wrote:
> > The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
> > wrong. Since INTEL_P4_PRESCOTT is numerically greater than
> > INTEL_P4_WILLAMETTE, the logic always results in false and never sets
> > X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.
>
> A blank line here would be useful to separate the two paragraphs.
>
> > The error was introduced while replacing the x86_model check with a VFM
> > one. The original check was as follows:
>
> Maybe to make it more precise and avoid confusion.
>
> The original check before the erroneous code was as follows:
>
> >         if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
> >                 (c->x86 == 0x6 && c->x86_model >= 0x0e))
> >                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >
> > Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
> > Cedarmill (model 6) which is the last model released in Family 15.
> >
> > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> >
> > Cc: <stable@vger.kernel.org> # v6.15
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >
>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> (without the blank lines as Greg mentioned)
>
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
>
> The alignment here seems to have changed because the extra space after
> INTEL_P4_PRESCOTT was moved before it. The current code has alignment
> matched with the below line. It isn't a big deal, but keeps the code
> easier to read.
>
>
> >                  (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
> >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >       }
>
>

Hi Sohil. Thanks for reviewing it. Should I send a new version of the
patch fixing the minor issues with the reviewed by tag?

