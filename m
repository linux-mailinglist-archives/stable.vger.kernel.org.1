Return-Path: <stable+bounces-136684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2294A9C30A
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECC592692B
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C822A800;
	Fri, 25 Apr 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mnv59EDv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAE21D5B7
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572216; cv=none; b=N2aik6ZrVWSK3iTovjD1/M6jI8WgqGIql/t2QwiRAlzvGkOcqIqazEBUcZGpQ9VPyx+wdrFrbY+YTIKsD3Zr5W7S5AW9yBEIs3fV83z/9ocnW+WFwng8u0FJzXPKHCpxkELQ1demxLxsltmWZ9HOwMXkAW7hq0nomk+EhyMLhD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572216; c=relaxed/simple;
	bh=+m+0kuSUJdQFmmrF1bmH6qkQTpdV6D6PKYj1zGH7pYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvucqP12XYHDadrY60d+vaBCDmsKwRVGgEiti6wZQpjUMMnkkIVl09CV3wZksdyywHAwbjsQmB6rtq59LN1k0qZyM/Zvr1YhAVxNa1xU907R7Xu5GdHwuVOBXQ5ixO4m6zIEno6ygRu0VKU173xcHzzTW+Wuah6qs5pI5ucX0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mnv59EDv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso366999766b.0
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 02:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745572212; x=1746177012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbCF6GPsGRuKR4Mj+yIy/O+VoxM/hOlvfGyfJOoA4OI=;
        b=Mnv59EDvdxQfR0P5IHKv7NjgNK1MGYXEfY0FPc8ft1SYr3GbYAPka3a93Wiy0hfEgs
         CSBeg1PaCArXKUVIpJBF6hXATr3sg0s4i13nu8lFBI/WXUlESZuMs3DsFatL4DJjh+e0
         EoOACoBgcuB2Ayf4DTCbR19/ySjIDgPc7FsK3xXkzUrN41HR9rUAUjs6q2M8Lj2/QyjA
         mrI6D7KH+D69DYFhQ4pNLZVhKhCJBMP3iPppKUAGJt+JmCjTj4FivW8107OfkF5UhKXV
         hWWS8YQFVbWOWxQsI+FEa36dDzHXW0HKlEI+R+unvzP3pD6kYXQBXnBIiNQeNor78uuZ
         9UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745572212; x=1746177012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbCF6GPsGRuKR4Mj+yIy/O+VoxM/hOlvfGyfJOoA4OI=;
        b=sz2YPU6YLn1yfEcP+3D6+rz/Rg1K+81FbIYqu9cJMjSFvQZUoTVkGBAMR1i92HhnlK
         Na/5o80T6ATZlIGDX/XPvStVEUH4vP0RS1loVaZ1M7P1n9VPDQNitwx9IzAbRZ6bkmma
         l3rct/gd7ZDKKbbOd2JdOTTakOghwkNz6xLHPLi9JwKeWU/5t9UBBCbGgM/TFId6h8n7
         /CAkOVjok7SV4hC5pYbs1+7jPyFZPynHktht4g6MN1OnbrMldI8k+RECAWJkqJKYYCME
         K/MLe8Giv2CK2ZRqYR6gmzEkraAmzq9AEtL2CgL9MtrUxa09lWraM28aHZYmYgFTmtdC
         rRkQ==
X-Gm-Message-State: AOJu0YzqlPRmVxoqIWXEjfZBq9AkfTqbmObnmvtBz2f/FwtFWFp5BzIh
	6Ya1YUUCjUxbIjHSXPtgXwNRAzEHYADBRROKHLL0/NElu0vtt/5bfKD0QV4DSQwAVQ8wbLK649S
	NsEepJiVzTDljv+xodB0yIagEb9cNLfpka/0GAA==
X-Gm-Gg: ASbGncsnwXrKb5Oc8vzqKNeZEdxOe1/6iaAS7/SPPBWMadTb6msKfWxGsub8Cu44qQg
	1ra6skPgiAbpyRHwmkFIYEUI4bGEltnRmm34+nTWd0/hTkGRcVEASNqPQeHXPKSaiD+xtwSmCUt
	M/DAbYrJoNIuFpyN4vsPzTNN7m6iCivsc6
X-Google-Smtp-Source: AGHT+IEDiUQoCeCkdaqKZY5GeNs5fUR0TZONdrwa1UKz+kZ7GIIQAgJ8JomgxWmwrpKsoOCZQbhq0JsFNfNhFkbHLmc=
X-Received: by 2002:a17:907:84a:b0:ace:55d8:227d with SMTP id
 a640c23a62f3a-ace73b469fbmr129960366b.54.1745572212481; Fri, 25 Apr 2025
 02:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425055702.48973-1-shung-hsi.yu@suse.com> <aok6og6gyokth2rap7qdhtmc4saljzg43qbrvtbeopjuuq6275@hptib2h2wpac>
 <2025042523-uncheck-hazy-17a9@gregkh> <apmmx7mdgfznnzc3k2wqxpds7vpq2vy3emkuulql7u4c6uvrfm@ui7jkyfopcxh>
In-Reply-To: <apmmx7mdgfznnzc3k2wqxpds7vpq2vy3emkuulql7u4c6uvrfm@ui7jkyfopcxh>
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Fri, 25 Apr 2025 17:10:01 +0800
X-Gm-Features: ATxdqUGb2hZS5e6G64uIYtkZOv8jcxDmCl6HZsSulIpjDO-IscpnKO0Oy_7sPAQ
Message-ID: <CAJFoxQPCnx3j4nHEssaPDSD+cZGpmHr4cCPm1SAB+UPCoBKnOA@mail.gmail.com>
Subject: Re: [PATCH stable 6.12 6.14 1/1] selftests/bpf: Mitigate sockmap_ktls
 disconnect_after_delete failure
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 4:59=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
> On Fri, Apr 25, 2025 at 09:17:13AM +0200, Greg KH wrote:
> > On Fri, Apr 25, 2025 at 02:35:59PM +0800, Shung-Hsi Yu wrote:
> > > On Fri, Apr 25, 2025 at 01:57:01PM +0800, Shung-Hsi Yu wrote:
> > > > From: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > >
> > > > commit 5071a1e606b30c0c11278d3c6620cd6a24724cf6 upstream.
> > > >
> > > > "sockmap_ktls disconnect_after_delete" test has been failing on BPF=
 CI
> > > > after recent merges from netdev:
> > > > * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> > > > * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> > > >
> > > > It happens because disconnect has been disabled for TLS [1], and it
> > > > renders the test case invalid.
> > > >
> > > > Removing all the test code creates a conflict between bpf and
> > > > bpf-next, so for now only remove the offending assert [2].
> > > >
> > > > The test will be removed later on bpf-next.
> > > >
> > > > [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@ke=
rnel.org/
> > > > [2] https://lore.kernel.org/bpf/cfc371285323e1a3f3b006bfcf74e6cf7ad=
65258@linux.dev/
> > > >
> > > > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > > > Link: https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.sol=
odrai@linux.dev
> > > > [ shung-hsi.yu: needed because upstream commit 5071a1e606b3 ("net: =
tls:
> > > > explicitly disallow disconnect") is backported ]
> > > > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > >
> > > I missed that 5071a1e606b3 was added to 6.1 and 6.6, too. Please appl=
y
> > > this one for 6.14, 6.12, 6.6, and 6.1.
> >
> > It's already queued up for the next 6.6.y, 6.1.y, 5.15.y and 5.10.y
> > releases, and is already in the 6.14.3 and 6.12.24 releases.
> >
> > Did I miss anywhere else that it needs to go?
>
> My bad, the patches I sent and I want to have backported is
> 82303a059aab, the first line in the patch
>
>   commit 5071a1e606b30c0c11278d3c6620cd6a24724cf6 upstream.
>
> is wrong.
>
> I'll send v2. Hopefully that will be easier for you.

Actually 82303a059aab hasn't made its way to Linus' tree yet. Will
wait for that to happen before sending.

Shung-Hsi

