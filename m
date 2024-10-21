Return-Path: <stable+bounces-87598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532809A701F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 18:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821B31C2082A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D21E7C32;
	Mon, 21 Oct 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34wMObpb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8A1EB9F4
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529532; cv=none; b=fY+giImjFiS1LJt3a0+lj5XrJAc54YJf/fTPkqBLuh4jYaq4bQcfFwUkNvYiNP0OaEYHt+IDa8n8oABJOeSq2LHaIQ0cpAVLFqGc78xVBezaDQBIEFKmdfOpEVTv2EXZJQ29mH8wsNCQJjBg1O9qhKGKYzDYGYxxaspN/JjyLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529532; c=relaxed/simple;
	bh=EUJbbfo3ZAUD6jEYt7KoSrq296Z8+HF/5pZK7t+FuoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRNiiEvZ9K1ArORMqAY96rApPPigncNDFVH6TbHpZeOCOao3mbD04kd9/7eDXpGMgooC67BeD90mv0AymRtnUAl2ecsOmvbx43oVNtPImTiqJb/G0qZKpZJcXc3WaH4qG6BQo6MMsreoYkxTRkg5kBd7t01l6hKCJBNFyTn+khU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34wMObpb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460b295b9eeso5311cf.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729529529; x=1730134329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/QsgZ/kRVrlMOQCEc1BgaY0+yz9oCMONnpajHxu5tc=;
        b=34wMObpbi09QOkkwRgF77WLPbK85j8j7M/71zwtloZ/kJjutR5ppQwvTUHyQUMww6x
         EoinQ0jeUYUMhFJIcXlgKAqmCu1Fnze9C45inKMNKc7rgg2MptMBs7NtuqoDbs42xyhC
         9TpRrVtsK325+9ymtL4/KBdWLgGjQwDJnvbvizqHl0LxkkHnp0dgs5W5Qa1qoVas3Uoa
         G/cPsX0UWtJW3ylJB+ZC5YfWrWzmPKQDtIoGlyQcEWzOD4/y8RsBn/utbM8X2cfVjeAe
         3eKO2udNyLalg9eCpbm5IUmGAyKA8eCzahnWUWlFDlDCtaIGb+J51+SgrB5KpehwBw8u
         iYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729529529; x=1730134329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/QsgZ/kRVrlMOQCEc1BgaY0+yz9oCMONnpajHxu5tc=;
        b=pfnmYrSFJ20yg0eUWitBbFly69YOPTTWD1RRCgjmuSnJE/5MCgkh0f+TcSvCND1Crg
         me30muVX7CLKF2GvCxM1laGmgKzpQnLViHtksNyDJgE+ad/KWleUnZ2xKy2GLaWR3znw
         15+5Fu6NPobBbA/Og62vQEL1tmqJpr1uB5RI2lzRRcj8Cj74Qvm/bh1SB/knfqgBWI5s
         Y0bAX2DGwDXgJUudpmXfcglG3MpeFxKKynspZWX70Pb7L5MdjBFr/z+DRHB5SNdJJ901
         Y8x/NNyeMHCZ9WvdDp3d4g/WLaRpsteMZ+DCKWc3fmwnCKfGRpOjDpW6dHod7V9leLsZ
         cYyw==
X-Forwarded-Encrypted: i=1; AJvYcCWuR8r4OfrqJyarYPE9iSgARY5AFBGZR7liTfSWqjukm/4Jkh2pSOz+0o8ryWpzjN5x9yTlvaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRqBGgxD2zYoSSKcRz9Km4ZN8Tzk4KQDWQWZ0uCR0ETzkkyrf
	SCsI42djvF5OrqsADZXXzs/fyi9AoCkGq1SO/sbPKAH6GsaFcja61XLzTC9soD5wdX5mNln+UFB
	qIIchp3odA8F9mGkt1fkQSFUA3f/vUJpdR9/taQP6cuXWkNEY0cHX
X-Google-Smtp-Source: AGHT+IGaW/ZxR9IpEgTweuDCf8gX8oQpuR0fk7PkCThDqlXbRiZhW3pbNa6IePcJOgoKrKgLXRstMLz7Y4GbgtnqZ9c=
X-Received: by 2002:a05:622a:1115:b0:460:48c3:c352 with SMTP id
 d75a77b69052e-460be418992mr4914301cf.1.1729529529041; Mon, 21 Oct 2024
 09:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102259.324175287@linuxfoundation.org> <20241021102300.282974151@linuxfoundation.org>
 <a4163f51-cc1a-0848-d0fd-e9b94dafc306@candelatech.com> <ZxZ_uX0e1iEKZMk5@pc636>
In-Reply-To: <ZxZ_uX0e1iEKZMk5@pc636>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Oct 2024 09:51:58 -0700
Message-ID: <CAJuCfpGwBixidbi1D-+6b6BrM7Ggob-1NZApo_+dny_T2qNAzw@mail.gmail.com>
Subject: Re: [PATCH 6.11 024/135] lib: alloc_tag_module_unload must wait for
 pending kfree_rcu calls
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Ben Greear <greearb@candelatech.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Florian Westphal <fw@strlen.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:22=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Mon, Oct 21, 2024 at 09:16:43AM -0700, Ben Greear wrote:
> > On 10/21/24 03:23, Greg Kroah-Hartman wrote:
> > > 6.11-stable review patch.  If anyone has any objections, please let m=
e know.
> >
> > This won't compile in my 6.11 tree (as of last week), I think it needs =
more
> > upstream patches and/or a different work-around.
> >
> > Possibly that has already been backported into 6.11 stable and I just h=
aven't
> > seen it yet.
> >
> Right. The kvfree_rcu_barrier() will appear starting from 6.12 kernel.

I have 6.11 backport for this fix which also includes
kvfree_rcu_barrier() backport. I was waiting for this fix to be merged
into Linus' tree and now I can post it. Will send it shortly.

>
> --
> Uladzislau Rezki

