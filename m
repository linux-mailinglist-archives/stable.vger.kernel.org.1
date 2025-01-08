Return-Path: <stable+bounces-107933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18856A04EC2
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 02:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200D07A1421
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147BB197A6C;
	Wed,  8 Jan 2025 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxGyRQfR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB1149C55
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299158; cv=none; b=gXf3FwFPvXsQRdB+IJe/WpJeMa1yME1ilc4j2AlCmeNOJWdob06shPCbfWkcMow2JAW8Yx2X7TwDQiUokC0BCAjvxG7Ph2wBOzO87tx/ap+h0DdtoZ+wUg26wtxo7ufG2RmUcOaKhqRo+cQoeoNS8OiAr3SvV8a3GehtgiGBOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299158; c=relaxed/simple;
	bh=O43PpjO9+bRZRRGZM0tbNhr2og/HW2/S5M6vi13lcTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vr4ZC1BCRr+IQdMZ/OfYpCgmcMB3OKBuOOy2DReJhlD32F+l4qQkeF8nVJX+2Qw4AeU5YkxsOYYZnARBVbbks2SkKtw9xTyWlofYh9ghlbHXwMHvGKecI9urYZlMyN3QWlUVKAXLtMKoW0aV2l833HeiCbofwPpoWM4qAuE/W6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxGyRQfR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d8fd060e27so121009936d6.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 17:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736299156; x=1736903956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui/nm90nu1hiwAHJrrBotziY8KnV1phLxDPsBYQHW0s=;
        b=NxGyRQfRZ+3uFko/8a4hJ2fxbaaQoWglTiYIUunJrC0TZu7ACypM+Ny0vmsFiByznD
         iFn6dtW3l3dic84ur7aqsmpRyHnEWN4QwdAeo7v7sq55xqLmecIMaN3QzgtQQEupkXcp
         uQDUTCkUmVVZ8Mm/dbMca/Ikbnu64eU9ZN2jIfan+Q+Zn73K6D7HvSRj88Nw2frEXXt4
         mEoY3DTHpPhXEWBzdqhKyVeluKffiWS08uByGHQRn8Qwt+zZOnmHsiaQcH5ScoUkkPYt
         umWTCHC27kpG1LzXjohyxEG8YBM0agu/Bw5nA+z/EzQVPN45sJK0hee2q8ePesfYXZho
         zCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736299156; x=1736903956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ui/nm90nu1hiwAHJrrBotziY8KnV1phLxDPsBYQHW0s=;
        b=RkScE7uJ8OCecHK2GRa6C6ZJSRtnd+P+PmhntjQ9jbGnfV7VG/gAucSCszG0u3O5cF
         jhkvT+nb/RiPV4lKjMHhrfoUC7p+7tEWjPZD1NVwq+01bLPeWE7HvX5QWj0S2vNK+Rb4
         DWVV2HusGnBRqTcrBsFtuGeT1tgQNUmYYgtMOXO6AEntICuW/F4f2NtItT7J1hhICRsp
         EG3nvkwl5V7zyl7P/XMZ/U8GKUMPjBKEKKOSE//HID2Y2aWLelcMWpHWp8sJWnDXqr+k
         tL0K+EcQfS6dpOv3ps+57QZKWLHWIjhV2txb3QYv36rjSbCGHllzuhQuFt1Q1auG0l7D
         fEpg==
X-Forwarded-Encrypted: i=1; AJvYcCU/3gzyE4xdroaI8Gp4CFkIEsJjCWaW4bpNgHqejFvv3ep57XKDo/TFHZGJz0P2HBL1PVpIB9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3Vf0ZJKIeJvWJ0CVgO5PIwjnF0iJuwcXq1wXOz6/2T3CZn6U
	opqNQRpzS5niweiWS8V6WwI2wzYrwST5ucnfJHw6AtwC6nthebY7CUJBw1pNyMCfIc67fgTCIVH
	3f5vflDXN8QkPatbdavGUvspdruXzolG06iy4
X-Gm-Gg: ASbGncsP8qkHMXGNpaQ6eYg7a+EEMRu4/KYkbs7qkKWvk2CVbwFrBdUfbnMwFkpOCNM
	SrrHkeeo0pMNkedomwsiL8rYpNjkEiMIpNPSFV0HAG57lQgD0BKMJMnkyo3zaQbS7r4a2
X-Google-Smtp-Source: AGHT+IH4J2SKUpnFZyyVLN4Qg9fAKWpzHuENS2WvmbnxNJzLlL15coTgvUIzPQl02hxTPiazkkUBplmVXRb8t9+betA=
X-Received: by 2002:a05:6214:240f:b0:6d8:959b:c307 with SMTP id
 6a1803df08f44-6df9b1b4ff6mr24748566d6.10.1736299155963; Tue, 07 Jan 2025
 17:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com> <SJ0PR11MB5678847E829448EF36A3961FC9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678847E829448EF36A3961FC9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Jan 2025 17:18:39 -0800
X-Gm-Features: AbW1kvZ69maJZ5IJd1-Eie-61nDs8BoZJ0F9xpyPZkIfZ8epOJ6RDLev_OkXxk8
Message-ID: <CAJD7tkYV_pFGCwpzMD_WiBd+46oVHu946M_ARA8tP79zqkJsDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vitaly Wool <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>, 
	Sam Sun <samsun1006219@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[..]
> > > Couple of possibly related thoughts:
> > >
> > > 1) I have been thinking some more about the purpose of this per-cpu
> > acomp_ctx
> > >      mutex. It appears that the main benefit is it causes task blocked errors
> > (which are
> > >      useful to detect problems) if any computes in the code section it covers
> > take a
> > >      long duration. Other than that, it does not protect a resource, nor
> > prevent
> > >      cpu offlining from deleting its containing structure.
> >
> > It does protect resources. Consider this case:
> > - Process A runs on CPU #1, gets the acomp_ctx, and locks it, then is
> > migrated to CPU #2.
> > - Process B runs on CPU #1, gets the same acomp_ctx, and tries to lock
> > it then waits for process A. Without the lock they would be using the
> > same lock.
> >
> > It is also possible that process A simply gets preempted while running
> > on CPU #1 by another task that also tries to use the acomp_ctx. The
> > mutex also protects against this case.
>
> Got it, thanks for the explanations. It seems with this patch, the mutex
> would be redundant in the first example. Would this also be true of the
> second example where process A gets preempted?

I think the mutex is still required in the second example. Migration
being disabled does not prevent other processes from running on the
same CPU and attempting to use the same acomp_ctx.

> If not, is it worth
> figuring out a solution that works for both migration and preemption?

Not sure exactly what you mean here. I suspect you mean have a single
mechanism to protect against concurrent usage and CPU hotunplug rather
than disabling migration and having a mutex. Yeah that would be ideal,
but probably not for a hotfix.

>
> >
> > >
> > > 2) Seems like the overall problem appears to be applicable to any per-cpu
> > data
> > >      that is being used by a process, vis-a-vis cpu hotunplug. Could it be that a
> > >      solution in cpu hotunplug can safe-guard more generally? Really not sure
> > >      about the specifics of any solution, but it occurred to me that this may
> > not
> > >      be a problem unique to zswap.
> >
> > Not really. Static per-CPU data and data allocated with alloc_percpu()
> > should be available for all possible CPUs, regardless of whether they
> > are online or not, so CPU hotunplug is not relevant. It is relevant
> > here because we allocate the memory dynamically for online CPUs only
> > to save memory. I am not sure how important this is as I am not aware
> > what the difference between the number of online and possible CPUs can
> > be in real life deployments.
>
> Thought I would clarify what I meant: the problem of per-cpu data that
> gets allocated dynamically using cpu hotplug and deleted even while in use
> by cpu hotunplug may not be unique to zswap. If so, I was wondering if
> a more generic solution in the cpu hotunplug code would be feasible/worth
> exploring.

I didn't look too closely, if there's something out there or something
can be easily developed I'd be open to updating the zswap code
accordingly, but I don't have time to look into it tbh, and it's too
late in the release cycle to get creative imo.

