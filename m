Return-Path: <stable+bounces-184115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B776DBD07B2
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 18:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517133AA96B
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB6C2F25FC;
	Sun, 12 Oct 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7fl5JkC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFE21FF49
	for <stable@vger.kernel.org>; Sun, 12 Oct 2025 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760286297; cv=none; b=qCpmDq0bbhFsqRIbYbBs1Szl+F/ZvBJFuF3y+LXV6QcRitCTXRYzsUDRVtbs/kvQ3bEuEtXV90YSKH7uDokGkwEGd4zH8T2uwY0RdB5kYpGfD6z2qxz/gYvzC8//45KBccurJDw/dqyvHjxebJ8YkagZxMMsHbjbI8wvSOTCwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760286297; c=relaxed/simple;
	bh=xHHym88myZOd7aaiKYFZ9MPVS85fSOsn4zeeR9sBVM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mw3hThQgshy/EnSZEJ/CGAG63rhvYv2QmzeSUlBu0aOBxSnbCRMDaacmlwMkaI5jm+u6QMJAgk0sbxThZrVwUA0RQHWY0fcGGIiwmDW90lN+Kyh6CxTtYf+zZKYZexEe6kKRslMaHCUNkmjusQ/0GjlNWuDGvuGk40HqDc5108E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7fl5JkC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36a6a3974fdso37121641fa.0
        for <stable@vger.kernel.org>; Sun, 12 Oct 2025 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760286286; x=1760891086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHHym88myZOd7aaiKYFZ9MPVS85fSOsn4zeeR9sBVM8=;
        b=f7fl5JkCh8227UfM5iwlPphMaCIcPcKrUp7nRC66/FVoWqE/SQzgFDFNMm2nfwlumo
         h8JtuDAxcKB9B7ZFctr9jeSb6T7vMeOKXTAaj2dcKnJkUdCtQ7oUMxfgBtrHtx172jvW
         y+NsenAf347wl+K2d745Jfd4fCHeZBScpI2hfC1ssUy9V4LnenguXeXOrDi8+sfxaOcS
         hYgln8e9qNNlBnUxSxpsxThD2zuNpAHPHpPKJoq9Izg0BCUf9pqpHNMqY3+Px6FaiTL6
         fN6YbcEtFJZ7WGOouQdFptTkGSuxg6TFuaOFhgSZrLnj1epjkzR+eRXSAT8nDsb2YG0Y
         UxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760286286; x=1760891086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHHym88myZOd7aaiKYFZ9MPVS85fSOsn4zeeR9sBVM8=;
        b=u9Y8jLWCrCuG7av+XxOsGZ0D+/G80ejmIjadDuZrRzc679CU/L7RAC9sp3Wl9M9x5/
         ciu9A3I+kEpYTQIFg3q9M+Ialse4WQY76Iwh803S8R1XpK2nBzjDDq5YqQoGt7WmkCkT
         xbwZnTCaV8SwpzFuE9fI5Wg20f4rHgI9wxQ6C630vZGp+7/fisAPms12ZbobNVpGuwWS
         +/NNOodb2iAYcCDGC4T5dqvPAbVa0MWtIrGGqXMYazVLxxeuLVMxIIVtPl3OPbNH/axr
         128CikDNLLi+iNgwqXgEgXmFkwn2kG6KzctwR0QVNZlxxzed+McP4vtxaM7SrqPfLeDb
         REDg==
X-Forwarded-Encrypted: i=1; AJvYcCUkG6G1vwTePmOcGR1b8VrvIHkB3Nl94hD8kvoMttnYoKjnYZdzzW/I0gJlyCXFsQSwo4yf9ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIgHv0spsXu9zcSyZb6QpuVvSoSPEmm5MTM4W5Sh5AQTZ65mc
	flHnBgGDyf0Eyv+VZvUsBrBha5bSWXbc1cCAoabEPahLI4Vxi/1265l3n5DKP2Y0Lh4nvkcI0VP
	0m2K4TblyOO4fmSwHJpCQx/YD1700AbQ=
X-Gm-Gg: ASbGncuBE0niPaLEjmDU0pqmCe3PsIMWxKYIiA6sTcDfaJY3x3VYk3qDaY+YSPuICwH
	lCwXCC+K+ulnqyI2bXH65Q52HLlxsI6e0nf9oAhuODlR0UfPn8Vct4gPtbSLeZUlvfZSBkN7nWB
	YIsFycU4A9unko65ZFxmBNhegj4uD/3Z8PTGAUqTLHFhIeS5ArAEFc6ZCVO3NOSg6tymGn/K7t+
	0/P+iOfF/zEmFBAlV/7Zt3j+YnzSyAkSOniR+xYv0GlO1M=
X-Google-Smtp-Source: AGHT+IHbp9fLesE9fRfFU1OCdKqmJ3f/YpBdvaYb2oWJtdqR/O4JdORrr2ySKDMtffDfeZl21q3J/Lf+ZkwmtLeC3rg=
X-Received: by 2002:a2e:bd16:0:b0:338:8b9:293a with SMTP id
 38308e7fff4ca-37609d72b5emr47292941fa.13.1760286285372; Sun, 12 Oct 2025
 09:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012142017.2901623-1-sashal@kernel.org> <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com>
 <CAFULd4b1oey5YntK9aY0HubiE21gQWqToC7F4HUCYX0GKEKuSQ@mail.gmail.com>
 <627794F9-8F8C-409B-876B-BF465D8A12C9@zytor.com> <20251012161733.GAaOvUnV8pgVvLs2i_@fat_crate.local>
 <ACA49E7E-D6B9-412C-9C04-64738FEA92CB@zytor.com>
In-Reply-To: <ACA49E7E-D6B9-412C-9C04-64738FEA92CB@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 12 Oct 2025 18:24:33 +0200
X-Gm-Features: AS18NWAZT8bxNnZte3H5kQC1cZVQq5EIwOVmtMd9ZoEhDBOY5qZ_AUDSVBR_bFM
Message-ID: <CAFULd4Zn=NkmX248bL25jz9MvRw1kJMiEASDSyvgh73j8zHjvQ@mail.gmail.com>
Subject: Re: Patch "x86/vdso: Fix output operand size of RDPID" has been added
 to the 6.16-stable tree
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	stable-commits@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 6:21=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On October 12, 2025 9:17:33 AM PDT, Borislav Petkov <bp@alien8.de> wrote:
> >On Sun, Oct 12, 2025 at 09:10:13AM -0700, H. Peter Anvin wrote:
> >> Ok, that's just gas being stupid and overinterpreting the fuzzy langua=
ge in
> >> the SDM, then. It would have been a very good thing to put in the comm=
it or,
> >> even better, a comment.
> >
> >The APM says:
> >
> >"RDPID reads the value of TSC_AUX MSR used by the RDTSCP instruction int=
o the
> >specified destination register. Normal operand size prefixes do not appl=
y and
> >the update is either 32 bit or 64 bit based on the current mode."
> >
> >so I interpret this as
> >
> >dst_reg =3D MSR_TSC_AUX
> >
> >which is a full u64 write. Not a sign-extended 32-bit thing.
> >
> >Now if the machine does something else, I'm all ears. But we can verify
> >that very easily...
> >
>
> MSR_TSC_AUX is a 32-bit register, so the two actions are *exactly identic=
al*. This seems like a misunderstanding that has propagated through multipl=
e texts, or perhaps someone thought it was more "future proof" this way.
>
> I think the Intel documentation is even crazier and says "the low 32 bits=
 of IA32_TSC_AUX"...

Intel SDM says:

Reads the value of the IA32_TSC_AUX MSR (address C0000103H) into the
destination register. The value of CS.D and operand-size prefixes (66H
and REX.W) do not affect the behavior of the RDPID instruction.

Uros.

