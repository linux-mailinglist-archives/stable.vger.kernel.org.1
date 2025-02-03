Return-Path: <stable+bounces-112045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE93A260BA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 18:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C78163600
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AE220C021;
	Mon,  3 Feb 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1wh9Oo/"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858512063EF
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602117; cv=none; b=u0fSo4tbxcMvYsOPtMowf5INs9h4z7g9dX27CxPTo3fjLciL7La7nN4gJsTLPJIadeM8U0tdZMxTrIqsWiJ0SS8jAR1durav6JOsjwsPuxijUv1b0PXOW1ERrcSek8j8w49Gubt6YrEJWOVWH4+wQvi7BbWnZ024eGB3iaJZhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602117; c=relaxed/simple;
	bh=zjXH5kws7+knI9DbmzEjGDquVdWrIc8UIpcNiHa4Cuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLAlFXv4+RGUSZZ8JiurGPYZS88qnUjhxzWf0/zYGYyKylGbmq4g3rhgeGy19SzmqbsT2khaydSUKZFSgrmzMMVQrpv6vuRGFUEFmeXnVWdZiOD0Qkvb64GXvYRN6xC/FoAzxZJNhdH2CFzsZsPUJKtf3qYN24lk1KcGNpSCwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1wh9Oo/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401af8544bso9200e87.1
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 09:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738602113; x=1739206913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb2BWOjM2AxjI76h/fY+Q764chvs+1zrd6CSA4WoxvA=;
        b=t1wh9Oo/wJM/NN0AkF00PPNx55xN0ddUy56xgPrZy94mOKU2k1w04PEv7S4WhPGb25
         zCKIg5+12ILkvLgIBFv9EHnCxjOWMcOqOySk6qIdg0z+EAHMlIU9u6QOO/B/3pV9wihf
         RdI5y2nyTqz0Rb/LwVbV7ykuOrVy+ijVQFlP7O053XSc7nUzpm582h/xJOPEk97Zh7Uv
         nWanz2VaAh7RNHxKqYwl1r/Ju31JytWtfS2aFqNJyhmswBXWP0G55sPXRAekZmcVJQIs
         yxlZxWFkJRDCPOIhSJfRL6METjSTpDHebPlFiKvebWxXpffyFCIzyWHuSzYOTNuglV8b
         Np+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602113; x=1739206913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb2BWOjM2AxjI76h/fY+Q764chvs+1zrd6CSA4WoxvA=;
        b=XoRRk0idb6BzjL2LUUh8LoHj4MZBiupTzbb5BmS4dy7aoVc5z7ZJequH8nJoZiGrd8
         KDvHjyTU4Mb9A3e59ZPFN9K5A1g2PUv8qc1TirSAjwOv5DpM2BgQLYkr6AQzUAdixHnZ
         tD5BWpKg6VU5Ri3FfZu13KFyErI87Wd+sILAd2TC9XtGa/tDlzSkrfNIswWQ+1hbpCwb
         4kdrpZU1QINzgjV6Ma75lQfGHGLHJACVsXagNRLpPQvb/A+AfYZieuNOS0rwP4+GON9T
         DfaWErKZLK5K9NpUG/b8lfHGJH1IPZC22nOgcje6DCkqZBBmOubaUoZXFSFJIm7mAo/C
         uIhA==
X-Forwarded-Encrypted: i=1; AJvYcCWy+iqTBjCJwvBEtF2XmROYWnzAOlGcNKKGiM/+x3Nm6hWHFGuUjGMVcxRFiuv96cJDpN+VcQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiupn9JkfHe+SWGyuaMBebROC61TC+aehRk6MMlWQiqS05RLsn
	kNMom+MpUEW7ErEfORuBfuFoDVrg0c1IjI+fn7nePN8hyNVW90cveKG7Z0L0PbDni90GVmCJXI7
	iv9LGEr1sn2TR14f2lsGagf2r8Ue6eQ5V3chI
X-Gm-Gg: ASbGncs3AJgAVlenzaR5xgIUr87+9bs5t2KQDoYKa+Qg1QukNH4uqh7Vgh3/QkVLZIj
	MYsSnp4PZOzQlCu0WiTBJ+qnuUUVgP8O7mGULKZ4wF//AF+1xU4fLh85gnyyn572fbG0v5rX0gP
	lrM32DTfEI5zBzFCkX+Sbln5QC7c64Gw==
X-Google-Smtp-Source: AGHT+IERgbXu4cZMbowmhVW8KSIRv9nsWeHKT5DJAWPkiUFMWjoeG2P3EHYpBuBLck0a8kHsQSZGuCEMrY5xfJ73NYU=
X-Received: by 2002:a05:6512:aca:b0:542:7130:badc with SMTP id
 2adb3069b0e04-543ffa52a17mr4941e87.5.1738602113129; Mon, 03 Feb 2025 09:01:53
 -0800 (PST)
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
 <CAGtprH-n=cfH_BJAmiNMoRbqq0XdGCf3RE67TYW8z7RARnsCiQ@mail.gmail.com> <baiv6tl2lkr25i2ry2q2jaylu5y6hhioqfwhc4yafk2uwqbgf5@sqxlpg2r6kcc>
In-Reply-To: <baiv6tl2lkr25i2ry2q2jaylu5y6hhioqfwhc4yafk2uwqbgf5@sqxlpg2r6kcc>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 3 Feb 2025 09:01:41 -0800
X-Gm-Features: AWEUYZm1pUNVQSKvKstcecqYl2-3LVWaTH9LroDV3vXolYlnD_tCGouWLYwnW2U
Message-ID: <CAGtprH-5bL44c7ZQHKsDuOQNNd4dsBd-uR8GT9OyqffEXW963Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 8:00=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov.=
name> wrote:
>
> ...
> >
> > Are you hinting towards a model where TDX guest prohibits such call
> > sites from being configured? I am not sure if it's a sustainable model
> > if we just rely on the host not advertising these features as the
> > guest kernel can still add new paths that are not controlled by the
> > host that lead to *_safe_halt().
>
> I've asked TDX module folks to provide additional information in ve_info
> to help handle STI shadow correctly. They will implement it, but it will
> take some time.

What will the final solution look like?

>
> So we need some kind of stopgap until we have it.

Does it make sense to carry the patch suggested by Sean [1] as a
stopgap for now?

[1] https://lore.kernel.org/lkml/Z5l6L3Hen9_Y3SGC@google.com/

>
> I am reluctant to commit to paravirt calls for this workaround. They will
> likely stick forever. It is possible, I would like to avoid them. If not,
> oh well.
>
> > > > 2) acpi_safe_halt() -> safe_halt() -> raw_safe_halt() -> arch_safe_=
halt()
> > >
> > > Have you checked why you get there? I don't see a reason for TDX gues=
t to
> > > get into ACPI idle stuff. We don't have C-states to manage.
> >
> > Apparently userspace VMM is advertising pblock_address through SSDT
> > tables in my configuration which causes guests to enable ACPI cpuidle
> > drivers. Do you know if future generations of TDX hardware will not
> > support different c-states for TDX VMs?
>
> I have very limited understanding of power management, but I don't see ho=
w
> C-states can be meaningfully supported by any virtualized environment.
> To me, C-states only make sense for baremetal.

One possibility is that host can convey guests about using "mwait" as
cstate entry mechanism as an alternative to halt if supported.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

