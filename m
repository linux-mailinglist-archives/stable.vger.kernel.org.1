Return-Path: <stable+bounces-108016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA24DA060CF
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CA23AC6E4
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3E20124F;
	Wed,  8 Jan 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXa2eMUm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060C201001;
	Wed,  8 Jan 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351411; cv=none; b=jScV55YrfKjYEyqyvq8MIkLNln3LaFX+STXEGUpIwa8smGkG+a5wpP21aPpmhBWSz9bgpCudAABnH94eMt5iY1rAS0iKZjzwXaJUBcGQGTCSuGBDxrwGe/dMLVyLQsDj2vCO2oIdU+8PT6NyGfAoRTFc1D9BhgFN11u6jQmPs9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351411; c=relaxed/simple;
	bh=663mL/wHqsOelnhTWNBHUolfaiAiUnHfLHdgRa7cEKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4y3tGxE4wf8UEhOqWgvU+iFEjUk6dGYSlty+k+cAnyg0/MSYnZ1Qi6FWkF0Pg/Kv/LtjjycRzswbBKBxP2GwS1KlmTecESDaDSLWJWITEneVznjcAhRm1UDl6rqzfPzMAn0JG5/SRWEH9xqBUsY7p52kWPi5hvfqA+yQckfTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXa2eMUm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d900c27af7so134929476d6.2;
        Wed, 08 Jan 2025 07:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736351409; x=1736956209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=663mL/wHqsOelnhTWNBHUolfaiAiUnHfLHdgRa7cEKc=;
        b=jXa2eMUmDmQ/IvUcFhtgbnH/gGrv4ifG52Ey+k+BnZirfxXKIbnYUloAJu18HuKzeg
         cujWeto6sEdS5T1aX+cr5RxO2ht8PVhCLEGiWCeFm+JJBMCp56fiEOR9knSkolqCoYoP
         FqVgwMhGwRbvFq/a1oYIBrY5p2Y5XYiPjsUzO0LVJNPBdOtOYrQNW6RVoOxhBYVm42f4
         xyHJvgecS874Y9dHwwNu6muq8DBvzS+cLL9Su5JpfdiF6B8WBXb+RhO5fKiKcGDnI3Rc
         2XgCp5z80GD1e+nAvJXmphpMkk8i2AIVVkMaPFUjx06rAzJ6ZbZZIxBH/idcqWSLdxio
         ncWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736351409; x=1736956209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=663mL/wHqsOelnhTWNBHUolfaiAiUnHfLHdgRa7cEKc=;
        b=o3Z/TnDbYmY0RVX7EXsqMoGqZlX88qXTjVNXk/9zu6neSOFQYmGenBSLojthaiBQ67
         KvnWMB1p8qF08hhF7dq0/DvmRu+MBCdsPKVeldo/yarYnvsLBYwEwndDNYakm96uj+mk
         P+cZWuNhr+T7lgkOyg2+K0B+CcunGXoRC9xtDTDsnaHD0dSsL7Hkx9z7OvpgM3ZZLttu
         weikShgn9Xn0ZQtU8uV4qPEiiiC0QBoKA4bS2p6dRlHqZHUQLxkIfQADoCZYbKKstIHt
         l0U5KTr+QgbsrUP3HUVhrkDV7qhe1dCEPOQuEQ0KBLoEqK8A9PfVM0eQNV/1llFEVQMp
         t6QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4d1+lfqPmEej5XHq6WzbJkZ1BuleYtcwHV+SrBmLy86SonA+na4/fAekcJj9ntITyo4srPKLoSnIieAU=@vger.kernel.org, AJvYcCXXaHRIVS5CwB4Lt/tgkmxmfPyVT8iKecpzapEkhgY0+JIuDBHl6/Srp40BNGY5S/y8jIl5w19/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3dJamhWIA0WaF8BU7ao5XTst/ajSVNGdx3gz6K0WSJZfGUIj
	i3Z17jPplkUajUn5OVgztijJcD4Cfm/RpBVCHfZN6OgqVuomX4eXFkHx+paeY7/wWvcoJ8mct8f
	7b2Kv6P2uAnGOXJxPUm8CSn7ca1Q=
X-Gm-Gg: ASbGncut/GrIBeAu+nkNv63CHBGq15yNGub3/9HpfnjjNx/QW5mvXFR6pI9sFZJDC7P
	jAqcEHcHno2JjNkTJrfWS7OZZwJzYlpoQaR7TA2w=
X-Google-Smtp-Source: AGHT+IG+63EtOhDnrCHSjhF6lazy8k8xjOrpZg0xQsQYkT32Inl5S5jcsXMUS6WBs+UHNx64ATrDpXdmxdRBN/uBffw=
X-Received: by 2002:a05:6214:449f:b0:6d8:a4fd:d253 with SMTP id
 6a1803df08f44-6df9b22d70emr56150356d6.21.1736351408935; Wed, 08 Jan 2025
 07:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com>
 <SJ0PR11MB5678847E829448EF36A3961FC9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYV_pFGCwpzMD_WiBd+46oVHu946M_ARA8tP79zqkJsDA@mail.gmail.com>
 <CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMWWQRzQ@mail.gmail.com>
 <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com>
 <857acdc4-c4b7-44ea-a67d-2df83ca245ed@linux.dev> <CAJD7tkZ+UeXXvFc+M9JssooW_0rW-GVgUMo3GVcSMCxQhndZuA@mail.gmail.com>
 <CAJD7tkbb1W_de-8nFfNif8LrkDsw6VnZyPowAt67xBpV5mL3sg@mail.gmail.com>
 <CAGsJ_4y=kP1yhnpDmpTgs-6Dj1OEHJYOOuHo7ia3TjNq+JRYSw@mail.gmail.com> <CAJD7tkadoYEvCPx6wARTBDseWmroym=H8L60MPgbF5JJX+9OSg@mail.gmail.com>
In-Reply-To: <CAJD7tkadoYEvCPx6wARTBDseWmroym=H8L60MPgbF5JJX+9OSg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Jan 2025 22:49:57 +0700
X-Gm-Features: AbW1kvbu9OvcJKSIkNlMys8ykTcz32E6i4Oop0mw4VMYPzfy2vU9G3foGtSsz9U
Message-ID: <CAKEwX=MWotmH2YOC-Sdb5Krzt43ogCy8kqJnCLDRm7Db=evDOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vitaly Wool <vitalywool@gmail.com>, Sam Sun <samsun1006219@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 10:36=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
>
> Oh, I was not talking about my proposed diff, but the existing logic
> that allocates the requests and buffers in the hotplug callbacks
> instead of just using alloc_percpu() to allocate them once for each
> possible CPU. I was wondering if there are actual setups where this
> matters and a significant amount of memory is being saved. Otherwise
> we should simplify things and just rip out the hotplug callbacks.

My vote is for ripping the hotplug callbacks (eventually) :) In
addition to the discrepancy in the number of possible and online CPUs,
we also need a relatively smaller memory size for the discrepancy to
matter, no? Systems with hundreds of CPUs (hopefully) should have
hundreds of GBs worth of memory available (if not more).

Anyhow, we can just go with the diff you sent for now (and for past
kernels). Seems simple enough, and wouldn't get in the way of the
eventual hotplug logic removal (if you decide to pursue it).

