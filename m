Return-Path: <stable+bounces-124104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB13A5D1BE
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 22:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D01C3B765B
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7722A4DA;
	Tue, 11 Mar 2025 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7Mc0q7f"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC3F199FBA;
	Tue, 11 Mar 2025 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728464; cv=none; b=NXx3vs8hJFerkDltPkMJjGg+HVS5lSV4zEw4UFH6Y1xYRpwKVzLZgSubLHJUGnijqtb35gmaU+Q36D/an6tf4SJs0hGnkuMNofPjmMk3D1mxQP1TjCo7AauE/U/91QC7eFWix1BEwl5unTi84scUnecg5ql7+vLzMuJdzXubMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728464; c=relaxed/simple;
	bh=RySRmGN7QEUscAcUVJoj8rAsRn30HsVo+FaOWJuWJUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIBLqq3UVI60+gXSIoidrNUo/VIhsndC5ndK21RiyqD8z4GVNkhHYiQJ4nMO3tvtYHtnGw+jfk91rKB6bHOe7yxk70d/CDUTifD39Q+nUkq6hVlYMYHTrOvTL7uOsJB81uMGd8Ik3joh4PInHTKp4d5a8amQ6pXF7OaTK9lAXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7Mc0q7f; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54943bb8006so6588090e87.0;
        Tue, 11 Mar 2025 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741728461; x=1742333261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1vCAYs2+HS8N6oXN8AwJ/mQrtuleOrUuEO9RrFrTq0=;
        b=I7Mc0q7fFjqzq7YvxnYfXrs/Qd4yBNUuS2rdUUk0eHM9zxdSlC3bbQ3mZKhtXbDroH
         mZQUW2nCy+ox8BlXJpoj2wSEXWy6JpzunodxxDsu3+PztU8JoHF8qhowBVQuva6akmA0
         uFYu3BzI8ts8egzoL2a87Db3K4NTLkA6LMM+BuBjcu1LZZa5ACoJc7vrwdM8gfmQ/QOA
         qIDoalkG2ttDxxTK7F1/HLUDvltve5fXTGitk8YRnkALHwTrgJrQYIpmrlNmnLK8XKg4
         t+9I8lHmVHir6yJ8HwGXlVEJy009moReExUWxSm9sCVZRYHDrx/VzJQlSplx6wNpScvh
         hStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741728461; x=1742333261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1vCAYs2+HS8N6oXN8AwJ/mQrtuleOrUuEO9RrFrTq0=;
        b=J2ujwgOwvROflRZDCUg+RZgVzvY+hM3Xu8gm+sDaYuIWc4IJnCHF+hXgUJ5Y/csawo
         rM9zPecj1bacTJsam839IL4nnWdBXDTbvbk6fzzHhIPeI54VWwAdyjjKdqU2oHIsr/bw
         clAtrkaIZGf9/kF0l5+TTYsH6ZBtGUw0660iddb5KXp2JILkLEwRMKrmDDGuP1cI5TUO
         stLrhHoPF33Qc2vIYIVBxxDgslhd1q7CMrpEny1pqzSTWh/So+r1/zcdfx5BXOUISVUI
         E4hMUr95dfJ4qzvy/OhH0bvhH4hwTE6V2nfUmqbyFqebRvOPH05oD4+5AJYKV5wPq1O2
         SCXw==
X-Forwarded-Encrypted: i=1; AJvYcCUEVUyYIJygj8/85XdxuaCXIKR59lRNiVTHC5y0FTDiLTtXZlT+e8ckdrUb2yT+yGhq1SapKo6XWuTUK5o=@vger.kernel.org, AJvYcCUFPR0kjPsPqFDDEwL4kN30ZjKZseMl/9+/qtMKOeny+D3hdl7Jwo6oinlYMokdBSkn5jgrarTs@vger.kernel.org
X-Gm-Message-State: AOJu0YyUM25Sk+RmwO/cWoTozuxyXLR7O4AwscKS6iWCAR2TCLtY+otT
	EFdhqq3u3MDPdTd4DUw6QFKFArEF+rtyi3WrVJJkxr+oh9DADWLWA/0YHQzLvYxyTxVCmRMovru
	MvRV5RTqJa1dY789k3jmlMuD9oA==
X-Gm-Gg: ASbGncuBsEYA6eX+y2QhnDFa+QDliL6GpnW3cZBTKTrBpoAgZynQsad0QwlhuJZk9h6
	KM4bntMTy9omHzYwLHu2XGmfvB+aukM+lrCQIqYYZHbP/ASm/7oAd1AaaYRr504v63aI8NBA4K0
	VDRB9m/FB/fiP+PqnvvtrQzIAo3UhCcQbSVRv4pZ7T
X-Google-Smtp-Source: AGHT+IExocT9OHPMkoNh7jznRb+VH6zvLrdry9m9QAnOlyhuVld6D0rz18Hg4oBPR0MBjKC4x0+xY4P017C69l+cH2g=
X-Received: by 2002:a05:6512:2393:b0:545:2950:5360 with SMTP id
 2adb3069b0e04-54990e5e2a1mr6488284e87.22.1741728461002; Tue, 11 Mar 2025
 14:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local> <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local> <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
 <20250311143724.GE3493@redhat.com> <20250311174626.GHZ9B28rDrfWKJthsN@fat_crate.local>
 <20250311181056.GF3493@redhat.com> <20250311190159.GIZ9CIp81bEg1Ny5gn@fat_crate.local>
 <20250311192405.GG3493@redhat.com>
In-Reply-To: <20250311192405.GG3493@redhat.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 11 Mar 2025 17:27:29 -0400
X-Gm-Features: AQ5f1JrDtOpE1AmrTRUKjtjMNQWZddx7ieBy0n0_rM-8K_GwNJibunhuIGzb4u8
Message-ID: <CAMzpN2hb7uD6Z410YFPYiGQvsV6-9b8iMXXCtfJYJ7ATwO-L5g@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
To: Oleg Nesterov <oleg@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:24=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 03/11, Borislav Petkov wrote:
> >
> > On Tue, Mar 11, 2025 at 07:10:57PM +0100, Oleg Nesterov wrote:
> > > See the "older binutils?" above ;)
> > >
> > > my toolchain is quite old,
> > >
> > >     $ ld -v
> > >     GNU ld version 2.25-17.fc23
> > >
> > > but according to Documentation/process/changes.rst
> > >
> > >     binutils               2.25             ld -v
> > >
> > > it should be still supported.
> >
> > So your issue happens because of older binutils? Any other ingredient?
>
> Yes, I think so.
>
> > I'd like for the commit message to contain *exactly* what we're fixing =
here so
> > that anyone who reads this, can know whether this fix is needed on her/=
his
> > kernel or not...
>
> OK. I'll update the subject/changelog to explain that this is only
> needed for the older binutils and send V2.

With it conditional on CONFIG_STACKPROTECTOR, you can also drop PROVIDES().


Brian Gerst

