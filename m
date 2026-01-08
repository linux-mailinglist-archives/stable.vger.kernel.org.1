Return-Path: <stable+bounces-206385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CE2D05004
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0B733266D0F
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492342D8370;
	Thu,  8 Jan 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6mP/TCd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A7F2D47E3
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890248; cv=none; b=uv/LcG4cv4cBkjgagkLNoXzPV4FR9tkJIhR7qO/DiGOh1uG3dV3eHIxSQS3azNBj65WJsIBvjYHV3G2Hz7v0Sq/2qQBs1BM6NRnKYvzcSd1SUIL7+WnK8/RnYRg9UTII7oLTQyNOYOXhysZt/4zEKFx8+0pMk1a+uJ45pK9HUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890248; c=relaxed/simple;
	bh=oiUJOqy4+7szk5Y7VIQU5zTbc+NUVFVNGpKBy1cwMy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMA2XjebsIxHt6dVIgUJKCxcJigp8h75HFFU4cvJBOh/HBbm4Jo9gZ2me5pFoMzCidpMfGX35gBS7KIE/Vg4v05iRQCqmWhf9Vn2yAU8gMPv7HaELVwrYSa39VLfhw+WFEsj5fNRwPy0xm5oHZT6+O4Q4H7iLL4o1sTFfeF2PbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6mP/TCd; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee0ce50b95so20016881cf.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767890245; x=1768495045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTBWtsdOdEJC2lJNr/ZVJNmgBqrVXGpeJsYz8CSdWns=;
        b=D6mP/TCdn3jVffNeeuPjAgnCx+SB1iPZBGU1oy6+8SyL0WX/5Pp1tNdkfmxhqiUjsb
         O0s6DAoF41DPkBZ4pJOc9V8Honapajjzbj7qjAEmlpxGeKTbpmrlfA2RTgd6YM3NwQL1
         3FbQtX0rOzpp7r9LBfPGWMscdRRopH5A19CcL5DW8FtUQvFf4fZ95Iihyuobop3hFRot
         CeGntQJOsByxWeFCZ6hQ8Kou1KoiX6s+h7K3E3y2Xjka/HYrRPb8eWoBQzNmN4ovhrv2
         o59EUzt4hasHN87sHDKlfkITF/Ow32xIMN1yybh+EPC0WTsWmr6Su+JnJDIYMqylkfO5
         Mbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767890245; x=1768495045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTBWtsdOdEJC2lJNr/ZVJNmgBqrVXGpeJsYz8CSdWns=;
        b=dpgRGmkt9fTzUZF7WHm1DGHVgcw1iW2kHLWTkkNr/TWwd4cjLfZqkbJ+PUcdAEKrG7
         r5jShPaB0mxoPQYVlI80odn2s0S5nHDPGWFC9ANSPuwSEpYkIeZPEh6U1q9QpveQ3a3R
         2K2Y1pvKuYQNLjcnqgKrhY0IaTkkKudWE/BCjPbeDH6LP14QQ9zRBi/q3BDjw5GwpIiI
         LjzwvBIG0EWUfAdju055317nLlP4MQScWrzTYxwgr7+7E3ad5WkYOqj1M3Qt1CaTr62i
         rKTJ/ZyIcyDzJ88yccz6DG1VSMFNWgY/b+lS+25ce2P6ghyJmzUPn4jld68JBccSc3cM
         08Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWDZqImtjhEH5LPe1cXGpAEIfQFptEgXnXHTWykrF3SINkPbaO+E26Ube8D4DTnDtzzVv9jTXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmh74na5L6okMc6eNdE7M6EeXH10vZk6qkkt6cbvNLq6Rbuvf
	YzHbcdXGzDbqH6G9HaX0NdPTrsuBbTsOxgDJO/zH47Jf3zwkM0JFnpr6qYs+eTaoeoZxBKGIk2m
	7wPA5nAVUHTK0M3ucpfhQdEDhW4Sm6t2Hm281vDeG
X-Gm-Gg: AY/fxX5HX4OTlAxpvQgIIg28idyXN0fyqaqVYwRmFVaCpKpkpDbd872igT1DW7ChtFe
	n+q4IRQ73Zz2pFwRGMzdeGnnGoEn55QqKkHnvtR7zugmFATbSR4vYdOWzgamM6Egh6Shpq91T1A
	mE7wkGM0Dec90hQODeY0Ni1xwExm+U1zJ6r6jzK30NR27bDvu0TH3iX+m7RYyHDIf1uRVmjL2Ol
	95Nh8CPSPDffC20v/TEGB1qlnWRlghQV27KPnBMeHZcptLcfgtZmikxsWKqS/wdDXxc5A==
X-Google-Smtp-Source: AGHT+IE2f3jpfVr0DitkgQW0hgUpjNRprB0PR+qzZgf0vZaVTjpsGhCNA+19FxT3hPHaBT/ttMh7PhhiKWRsFSyPKyE=
X-Received: by 2002:a05:622a:7291:b0:4ff:a8c1:b00e with SMTP id
 d75a77b69052e-4ffa8c1bf36mr109817591cf.2.1767890245238; Thu, 08 Jan 2026
 08:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105232504.3791806-1-joshwash@google.com> <20260106182244.7188a8f6@kernel.org>
 <CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
In-Reply-To: <CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 17:37:14 +0100
X-Gm-Features: AQt7F2pZbYuFwcYb8xyVXNJG4r7Uvb6KoQWlgEB11-noITK7mtV2kImy1DvF0ZQ
Message-ID: <CANn89iK_=W8JT6WGb17ARnqqSgKkt5=GUaTMB6CbPfYuPNS7vA@mail.gmail.com>
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
To: Ankit Garg <nktgrg@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Catherine Sullivan <csully@google.com>, Luigi Rizzo <lrizzo@google.com>, Jon Olson <jonolson@google.com>, 
	Sagi Shahar <sagis@google.com>, Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 4:36=E2=80=AFPM Ankit Garg <nktgrg@google.com> wrote=
:
>
> On Tue, Jan 6, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Mon,  5 Jan 2026 15:25:02 -0800 Joshua Washington wrote:
> > > This series fixes a kernel panic in the GVE driver caused by
> > > out-of-bounds array access when the network stack provides an invalid
> > > TX queue index.
> >
> > Do you know how? I seem to recall we had such issues due to bugs
> > in the qdisc layer, most of which were fixed.
> >
> > Fixing this at the source, if possible, would be far preferable
> > to sprinkling this condition to all the drivers.
> That matches our observation=E2=80=94we have encountered this panic on ol=
der
> kernels (specifically Rocky Linux 8) but have not been able to
> reproduce it on recent upstream kernels.

What is the kernel version used in Rocky Linux 8 ?

Note that the test against real_num_tx_queues is done before reaching
the Qdisc layer.

It might help to give a stack trace of a panic.

>
> Could you point us to the specific qdisc fixes you recall? We'd like
> to verify if the issue we are seeing on the older kernel is indeed one
> of those known/fixed bugs.
>
> If it turns out this is fully resolved in the core network stack
> upstream, we can drop this patch for the mainline driver. However, if
> there is ambiguity, do you think there is value in keeping this check
> to prevent the driver from crashing on invalid input?

We already have many costly checks, and netdev_core_pick_tx() should
already prevent such panic.

>
> Thanks,
> Ankit Garg

