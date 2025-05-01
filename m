Return-Path: <stable+bounces-139403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E43BEAA648F
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 22:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965291BA5F0A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDAE24679F;
	Thu,  1 May 2025 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gV6ttq7p"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9420C476
	for <stable@vger.kernel.org>; Thu,  1 May 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130011; cv=none; b=Z5L6YRQN7yqTzoNfHE8KgccYXR8xLp+407LYUxtkHVB8CKpElZbEvGKUBeUm0zyjzHu4FTX6+6IQuriukpz8KDWjheC5W7SWViqzHjg+Pm4Qz0moCkjGLRKgT2DAEwgf9ECCGKfLrCRn48vAGVaehOiOsnblPVGvHsv+7pZqCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130011; c=relaxed/simple;
	bh=MyFAjmUyL/uuE3g/ynwaFPaTixj2tzi/RZV1fRlvyNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnBsdesVRPLi4t3YqufVpzlPSQ2vwEU88hd9L3qsp64SCZNgl8qvuEADZjd9ebd1vQGaQV+3iKSGsjTPVu3qopwjv4XILXUFA+YXDYv2zv4zdoed0UGTJfkU5ab4WiHSNhaK3fv8Snoj5llh117Vm2PKVzDEQjTdNDu5DYAJmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gV6ttq7p; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso4393995a12.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746130007; x=1746734807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyFAjmUyL/uuE3g/ynwaFPaTixj2tzi/RZV1fRlvyNE=;
        b=gV6ttq7pB/gb2XSiOwxntrOJ/rMfbcuNQ9LlyF5Z7olj1ZtYeHFj89jNObgFQwe6pR
         y0ASH+lKXIpcl/Yf70UXrBIxucKneXVysVttt+5wLhut6s243hTou02GICC1aiUnNgHo
         LtZ7L9mFQMGTNjja9lIb5DR1qHcAyfTXKS241/u6N7dO3kZxIzJtHJuxrio+nv0NXfdU
         xttkkPKfIUeswOn3E6iSnyNwy4YH/+4SkHT+wOVTzoHRZmCsQG0rige/srZw5qhWjW42
         DJw3WBror1mJ+Oj976CA3T2dludMxDsf3m1NrDE51PlxfnZa0G1+OGOt60aTwK/EqUMq
         GOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746130007; x=1746734807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyFAjmUyL/uuE3g/ynwaFPaTixj2tzi/RZV1fRlvyNE=;
        b=Wl0Mv8ELGZdzbrDdElHehcrMdDyyr06djR5smw3DUJk0hteQZn9cOZKjGmX6e2W/vf
         lSgeoB3uunumMya+XkcKgQnUtcoY9+JRdEIzHzt0Rxiz+0adAF88vxdrDi/jTGcNxhSq
         orl9AWVDX9qR6eCE16MPQqJL0iVYE2WREmkEupVNjIPC6yeoOvicTL1I30cBUFCM5dia
         HgvbkITUe++8EJJ04T/8HHxxWIyDmQASV32IhqSkO3QeoCAcDQZL1jqjNxRlalt4ZnD/
         +gjErjhC48cEc0//+I1uOUTFODaAsn8+S3AMWt69qAg+sK68lEJBF3oQWoy8XG/Jdig8
         hVrQ==
X-Gm-Message-State: AOJu0Yzuoxq1cCbVyYXwCYstlI5QNx1pd03m8NLuvPDZBdkcubL/PXaF
	5Il+oy211UhEzYeG08pxBeWl8hsEfp+a4ayOT+ffI1h1QuR88AcMXjjfdqbTGaoUDQIr6/ix49T
	2xLXNZqSR2gNp6IFAxSu+i7rFoFotUq1FDLTH
X-Gm-Gg: ASbGncv7H/kKS56ogUvzoAkCEXF7oLAADyBc3QyPoTKoh10F8GR8bujk2SS2YGaVujo
	Ylj65hvTt3CY+gRIL3yTqp7qFhHd+QTgROjN3JmqDNXFwM52qmzbIxKHegNI4wij4IV24LgOiTs
	vS/kcb6ygMqPWpH7+1O/xuDlyjgPmyR+2BxLtfuOcA8Mvzpj7Gxs5T
X-Google-Smtp-Source: AGHT+IFZl8ApBrszv3Jk5Wfcqr3bXvkGdtpK0ZXNg4EYnAVYX7oTgxLCpVZ7vK6MIuFqIRUj5X7EW9U+rA2a+083fn8=
X-Received: by 2002:a17:907:7e9c:b0:ac6:b80b:2331 with SMTP id
 a640c23a62f3a-ad17ad41fa5mr46085566b.4.1746130006619; Thu, 01 May 2025
 13:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAH4kHb8OUZKh6Dbkt4BEN6w927NjKrj60CSjjg_ayqq0nDdhA@mail.gmail.com>
 <2025050151-recharger-cavity-b628@gregkh>
In-Reply-To: <2025050151-recharger-cavity-b628@gregkh>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Thu, 1 May 2025 13:06:34 -0700
X-Gm-Features: ATxdqUGJ7cWH29HiiSByBjD4_jZfIBP0VFvZOOPmSAaOfVPwkEx6OHh5X3t4u6A
Message-ID: <CAAH4kHY7sccAgtoouC4wFEbp4beKJ-pMD2SxW_jVrVpg5FexVw@mail.gmail.com>
Subject: Re: Please backport 980a573621ea to 6.12, 6.14
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 11:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, May 01, 2025 at 09:48:59AM -0700, Dionna Amalie Glaze wrote:
> > 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")
> >
> > This is a dependent commit for the series of patches to add the AMD
> > SEV-SNP SVSM vTPM device driver. Kernel 6.11 added SVSM support, but
> > not support for the critical component for boot integrity that follows
> > the SEV-SNP threat model. That series
> > https://lore.kernel.org/all/20250410135118.133240-1-sgarzare@redhat.com=
/
> > is applied at tip but is not yet in the mainline.
>
> How does this fix a bug in these stable branches now?

I find that the inability to use the main purpose of SVSM support for
trusted boot integrity is a security bug according to the SEV-SNP
threat model.
This is a dependency already in mainline for the support patches
mentioned below. If you prefer to submit them all together, then
ignore this.

>
> > I have confirmed that this patch applies cleanly. Stefano's patch
> > series needs a minor tweak to the first patch due to the changed
> > surrounding function declarations in arch/x86/include/asm/sev.h
> > https://github.com/deeglaze/amdese-linux/commits/vtpm612/
> > I've independently tested the patches.
>
> Have you read the stable kernel rules text?
>

Yes, though admittedly I'm looking for a generous read. I haven't yet
proposed those patches for stable because I'm waiting for them to make
their way through tip to get to the mainline.

> totally confused,
>

Not my intent. This is my first time proposing a change to stable, so
apologies if I got it wrong.

> greg k-h

--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

