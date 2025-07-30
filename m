Return-Path: <stable+bounces-165190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1116B158E5
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 08:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23D63AA213
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 06:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DAB1E571B;
	Wed, 30 Jul 2025 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDrflg8L"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F41199BC;
	Wed, 30 Jul 2025 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856519; cv=none; b=FOPhDuYDLiFPL8DUPArOr7g1ZGXMYQzVyrT46yylmXsEjqxr9b0FZlyZDUjh9+NI3ZNiQDt5kbajBjuqeZygkjfJGGLVmZtmWIgnjH8DBMjNPf81fSU4HOVcZsyoOvT0zc4ynMt//JuTiHpLqzoBCzZag2cOQ3wnPSOyF7GJY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856519; c=relaxed/simple;
	bh=JNZ6D3nGRFd1xsk3HwOPijD+rO+P2HFJjzPwNSl5yOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+f4kFy4kr4O+QmCyE3RAuk0UyZGBiIVIMruiH+iFoX4bEMeB2irOkNE2AJ7YepTsqp+GGluVXQzjmpH4n5aVUkdRXDFJiZnA965QqnlY9ptWZoiA9r8Ci7djPUTKiex1yp6Ukpo8NKcXdxGdx1tWSooH7MK6LlM+D0zLwstZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDrflg8L; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-615a4b504b2so1058112eaf.1;
        Tue, 29 Jul 2025 23:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753856516; x=1754461316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBkTI/UCDoqQNlnpZlPe3NHTfCsdIAJow1MJiptYraY=;
        b=IDrflg8Lxu5PWMXoE+hdwsPKFI/2HLsMqAXyb1FW09y0UzcP+K0CCDD3Od4r2LcxSj
         L6ARw5P/k2niCffhbuCZ4Xnv6/JB9wqHGL6oHfEPwwm+4LAr62iHYoAz9Yidp/j06OC/
         5C3KG3p6lbcs3nmKVF+jeUfx/3tqrLzsTPXWGaMbpJ5IHOoBLbGMQBXI5m3hbrXlsWql
         UHveqo0oG/UV/wYBBqSpKlZYrPS0KCbetoBL1cpWYXyyBzKirogQTG7JiHOZVFZqTr5S
         Qp32hmxdQU1QKQ47WxyyyE6ti9Um6rtQ8D146Vwn3SL2yC1+0g3BIkk0qIAUFiY/CXPu
         2NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753856516; x=1754461316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBkTI/UCDoqQNlnpZlPe3NHTfCsdIAJow1MJiptYraY=;
        b=LqjWqgemm1Th1pCWdLsqNerN9icm4W3RJXFLuQKWpLfG2aNqYcDfH18NzX3w0fbtNP
         ERzjo//L4IcuSxikiedT4LxoolxyzbrRdQifkvB3HViagUdXoNRfYn2p+uvo7Uz2t91N
         rtCY49ApveDTExJIDxMIYOuRrl6Q0cLXTkBjF4RjzGqrA/C+uGWORpdn4CrSGNYTfWrt
         QlEPKqEaDCZZ+vvdDZz0Ccf/aV1hyYf0FODQL41lIDUm+8hZKNMkkyaO9xNM427k8ZTH
         YuDQikNypxpK9pqJLT87uauHnEVP+serHaVD8OnKslOIjjfzA0s/gd08jIJ2jYLkmkIF
         wDtA==
X-Forwarded-Encrypted: i=1; AJvYcCUKKJzCU9ZQ6JhbHDSUX1Leb88r5SKk5XDqqYeLTrnzdcluUSRpRruqEPI3PwKI9xPrClmAt0+4@vger.kernel.org, AJvYcCWHRUwO/8BpU9xTA/uR5iPCJNYmf6bTAHF8uCepNxBXA8b0GtJgOx39Fz8ObySUae3Grt9a/GevBoNuOSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLnvNRmCEd40QtTydukelUBL1ZvD9wFWBLW2iMc43a+0JgujJ
	iFVFRsttkQ/BK09A1A0fec3zOd+ufRLjQc5GZOeyJ5PJL44zR5ceL0KHyU5vFGqXfPPyRciZs3+
	nmGTTv28yWXajdfXjAphz+7X3iVbr0Q0=
X-Gm-Gg: ASbGncvVG0uo8wT6mFTbKVRT2JeXnz5KXC5YYzZYzH0ZuCMxQFkslbWXiRrTLSN4FCY
	mozRDwJ3+LTRpUpBGS6cfMDFCLRB02qQDS7kIOtbam9htm0x6r4fdovQ3jcNiGzQ01+JBRodNb/
	lRfa877+Aq0nzqa976BPO5NABFF1pGuR7gqFXXj0nckbRGeEXF8U7mgDqh2YAFYORvh+vhkNK8p
	0D+talo/2iUdmXoCwHGEKpVLg4LTQ==
X-Google-Smtp-Source: AGHT+IFhgRosSR72T+vNr0bx5hr3ciS38puiGjuj01JgbYBPEjB7f2hpeWkGLda67/RjHPy2kUR5TUoZLWCQGjWUJzc=
X-Received: by 2002:a05:6820:210d:b0:619:64d1:8b8b with SMTP id
 006d021491bc7-61964d1a470mr358563eaf.1.1753856516508; Tue, 29 Jul 2025
 23:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
 <2025073013-stimulus-snowdrift-d28c@gregkh> <CAO9wTFihpoVsf-SZYn6yUhCSuN9cBXFGWeGegDsS1QHk4wS7-Q@mail.gmail.com>
 <2025073024-musky-smashing-812e@gregkh>
In-Reply-To: <2025073024-musky-smashing-812e@gregkh>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Wed, 30 Jul 2025 11:51:44 +0530
X-Gm-Features: Ac12FXyTmCZhlXPJ6VHRvUCE8qUeiyA07qunSM3G46ojasxIgFGJg8XhQqlKO9E
Message-ID: <CAO9wTFiRCgFvyboh_K=HWYMtfgj3OGr=fcHFDkNBa9EHMyCtcQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 11:25, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 30, 2025 at 11:05:31AM +0530, Suchit Karunakaran wrote:
> > On Wed, 30 Jul 2025 at 10:22, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jul 30, 2025 at 09:56:17AM +0530, Suchit Karunakaran wrote:
> > > > The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
> > > > wrong. Since INTEL_P4_PRESCOTT is numerically greater than
> > > > INTEL_P4_WILLAMETTE, the logic always results in false and never sets
> > > > X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.
> > > > The error was introduced while replacing the x86_model check with a VFM
> > > > one. The original check was as follows:
> > > >         if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
> > > >                 (c->x86 == 0x6 && c->x86_model >= 0x0e))
> > > >                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> > >
> > > What do you mean by "original check"?  Before the change that caused
> > > this, or what it should be?
> > >
> >
> > Original check in this context refers to the change before the erroneous code.
> >
> > > > Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
> > > > Cedarmill (model 6) which is the last model released in Family 15.
> > > >
> > > > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> > > >
> > > > Cc: <stable@vger.kernel.org> # v6.15
> > > >
> > > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > >
> > > Nit, no blank lines beween all of those last lines.  Hint, look at all
> > > of the patches on the mailing lists AND in the tree already, you have
> > > hundreds of thousands of examples here of how to format things :)
> > >
> >
> > Sorry about it. Should I send a new version of the patch removing the
> > blank lines?
>
> That's up to the maintainer(s) of this subsystem, if they want to
> manually edit the change or not.  As it's the middle of the merge
> window, no one will probably be doing anything for another 2 weeks on it
> anyway, so just relax and see what happens :)
>
> thanks,
>
> greg k-h

Hi Greg,
Thank you for the clarification. I apologize for the mistakes and
appreciate your patience in reviewing.

Thanks,
Suchit

