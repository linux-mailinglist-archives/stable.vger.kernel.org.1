Return-Path: <stable+bounces-90085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F4D9BE0E4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 09:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952DE1C22FDD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709C1D966B;
	Wed,  6 Nov 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyw9o/au"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC71D966A
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881259; cv=none; b=pUzDK+TuH7csrB49p5OArwuwCpkBa/a99VpNqR8AgtQt4OazSKy56iBGjvhWe1wp4PpZHLG64V+rLEg0iMuuSTMoSKHiXDUkaRoFjYWOh/GbHj1NYmT0nxm+Z02JpMyjvxbebsDzcp+Z9gVq4yjulq/Qdq6MdPwvGekZJhBBVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881259; c=relaxed/simple;
	bh=Zbaa3THwmyR0QbbitUy47QNMG6IMEwpDVlVishwvaeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5G6SeNNh9ygeN05aYm/u4iJel9Hmtb0tGK1eFRATHNx1q5Bi3c1a4262Mab/ybsBgTRCCjjHNBGe8Ts7kVyFGO0NrHQIQ5O2Asv0ZHzkiUmiE+KVcnKVmq+KA9IrH/iBql5Vqv82vhXtCmXhsPeDPuPSTp/boH8U1Q9vZDbD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyw9o/au; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460969c49f2so189961cf.0
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 00:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730881257; x=1731486057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zWEHY0OXQFhrxfXe2dL4RGu6ZaPdsnfdH9+QncDVfg=;
        b=vyw9o/au3paMuxhE41smwgq9rM/DKrg1FE/G4jro32/SDvbPz2kg+AI1o/R7OY5hoP
         ZgtwwB9/XMvjGsg1pGCc3/KvIGqIs1E2DcgvgDG2qu9UmC4HSPZhVGZ431VqIib2Kx8K
         pUNu9+d76CwSdsPrQ98G5HbAFwzE3KzHsT1YXrVlzQgdA4LBPLC7Jd52CH5YEgXC/Emk
         ad9TCQTPJ+iNzRfursWIHJfQ5RjoTcIVh1G3mSzqGJeqNC0kq5naiRt/E0926EoTMqK8
         FHSCYKnaMxnWOPOz4pgtUgw9LkISN8rV/H2XMI3frDNRsm+umE3ZoYU+P/oQkfOdUs60
         Dr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881257; x=1731486057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zWEHY0OXQFhrxfXe2dL4RGu6ZaPdsnfdH9+QncDVfg=;
        b=wv2tioOAHBo3X8iblOwGniGlYXNKhtrmGJsbgF0Upy0bXYwjoS/cff+kY7x6ID999W
         AUn8s2cMlVo5Jw9js5SE7S2dmdrdfcLnOKx3T5q5vWPkeu9wEtKkq/c8oTcjfN1zLCIR
         y1UCSizowSOT+eB5jgomLQhK0tIvGHPQilDbLgYA7O3ou4NeOeOwwxwowHIiaJlA1gBX
         a/EPY0cw0rEh89q2DS28LCnzzTapErE5cWmhJUcJcnSZvMzxSgAEPP1Bohs/rCmjt4wd
         JmbVY3PxxWkABxcPwipkHfTMUn/7+FomU2zw1yAB+pa82UlPs6Rw/t4M0Dl/NmxRH1p6
         oGQw==
X-Forwarded-Encrypted: i=1; AJvYcCXHus+yJtNqa9UReEsPaWPqNSctVz1H/OeLO/sCuPaxVuUYRcyGEiO5gZ/Dzm43x9HXVj73RgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIY4Yfz98a07LRp9kWzfUiyBd60+2vs/QjWLc8F7r/PtaIq4fI
	niqo7c67PT36TEqgHUtrJQCgiNtd8ZECPfp4CLcn5HxvmIcMuDfwC1OA/38ndwe78ZW0ark1/52
	FVQR+zB+Bee8EoE7GVWViHm2gDyFxlp3obalz
X-Gm-Gg: ASbGnctds2l4SOIe9ueosJ4sYzvaCLkhKIPHeHC8UtplLRuKucuoim4xzVVAMTXdx5H
	atzRBkk+g6pEeL/XYhKMtKBf29KSIod8=
X-Google-Smtp-Source: AGHT+IHVRXb16/Eki75BEyW60A1+LleOmCRbbQLzOBFovvuid3gjU31QECFuGcSFQD7dc7heQpZVLYkLFMh9hgpf0Z8=
X-Received: by 2002:ac8:584b:0:b0:461:32e9:c5ee with SMTP id
 d75a77b69052e-462f0024a56mr2697281cf.0.1730881256767; Wed, 06 Nov 2024
 00:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021171003.2907935-1-surenb@google.com> <2024110639-astute-smokiness-ea1d@gregkh>
In-Reply-To: <2024110639-astute-smokiness-ea1d@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Nov 2024 00:20:45 -0800
Message-ID: <CAJuCfpEAKAePqbB74j8iCQ1JXrvZQbELkAMzdT7dWtvdros-Eg@mail.gmail.com>
Subject: Re: [PATCH 6.11.y 1/2] rcu/kvfree: Add kvfree_rcu_barrier() API
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, fw@strlen.de, urezki@gmail.com, vbabka@suse.cz, 
	greearb@candelatech.com, kent.overstreet@linux.dev, stable@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:09=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 21, 2024 at 10:10:02AM -0700, Suren Baghdasaryan wrote:
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >
> > From: Uladzislau Rezki <urezki@gmail.com>
> >
> > commit 3c5d61ae919cc377c71118ccc76fa6e8518023f8 upstream.
> >
> > Add a kvfree_rcu_barrier() function. It waits until all
> > in-flight pointers are freed over RCU machinery. It does
> > not wait any GP completion and it is within its right to
> > return immediately if there are no outstanding pointers.
> >
> > This function is useful when there is a need to guarantee
> > that a memory is fully freed before destroying memory caches.
> > For example, during unloading a kernel module.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  include/linux/rcutiny.h |   5 ++
> >  include/linux/rcutree.h |   1 +
> >  kernel/rcu/tree.c       | 109 +++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 107 insertions(+), 8 deletions(-)
>
> We need a signed-off-by line from you, as you did the backport here,
> please fix that up and resend this series.

Doh! Ok, I'll resend it tomorrow morning. Thanks!

>
> thanks,
>
> greg k-h

