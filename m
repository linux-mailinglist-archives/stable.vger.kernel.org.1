Return-Path: <stable+bounces-180385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39003B7F958
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50603A42E3
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D302332A45;
	Wed, 17 Sep 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtTJ71C2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6413333A93
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116732; cv=none; b=kulUdP55jrKJb/18FdPkbvpNCFvtbPjeF6OxmBKsqDpB/VqwykobYtRzgVRavBTTzy2jPxmkOtpjWT1n5yhYgYnek+KaL+6bJzhQ90dWF83k0P8OfECqMAeJud5ibj06AzOj/XjPXQS2SrNsLQ39S9wrBnfV/4ukkJzoMQrXTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116732; c=relaxed/simple;
	bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMY9ZkWU7q5U5ZHtgwZADpg6129I/yjdjROvGho//+QOS2vZSmEI/ZyQlUf1aOadXhJHxxAdQtDYud6RGU/Q3shRvAd4HskXa9t92Z2V3jsbTb3U9FxFdVnNGMGAQE8cnP0GZQ0laUAFgmOm8yvYDUD7qWtfmbo4iAKK18Sam+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtTJ71C2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso11304490a12.0
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758116729; x=1758721529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
        b=OtTJ71C2+f60SZTiEhIWHBQ4o7kLP6xIlRwXDOQmyb2tfI7Ixqe3jdodyDCZ6I/pci
         VrYugBtsM39gl26uU6q8zCgyF3duHSoLIBD9gl91+nd7Px5uTUgcH93KyfqjILZ45oob
         2hyQT1b5NVbgDk8Otqi+IB+ja1semJyZPKvQsfEAC7hIng7aXqM1XAr15ts6n9oJs0l/
         gNxXp4EOLAnzzRWO/qH2GU7yPe4BIjcYQBgQAwknAMvNqZL7IxAeaJvAQQmxzrM6U+58
         Kh1khv7J8EK+n1DRN18PQrohtPa6NfRFhGUeWL6KmBB8uCPW5EUPeAG+sA/Av8BLTks9
         vfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116729; x=1758721529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
        b=O/PyYT8vdiAB4rSXU5PX1LNOb9PqH2n7B+B01azsTUjCdiV3vLY0WNnYiibQF5qG8m
         Cib6sz+T+4YrNb2lKknby06/Ys4WK6XAgTPR0zJcKkkV0gLLcmaf7qnul06S4rhaJTYi
         Zr/BiRDNWf3SNYkFSk45DXNryDkvWcaTDS1xBrrCBLJij6C7FmMYexFpy8tOR0DGZl0d
         Dc+DN9C18CrVMZjnHFpDuh/HzsVx5zHBa2ZK2Y8a59+HpgBRAwouf/dppw52WZ9WP52M
         TscRRhnrIh9hM6um4c2m9R3cj6hRSqQ4Dm9pSv9hOCph4zQ02XN5C1+p2KS3UDB28cvf
         l6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhrIovn/czNXzXKt+0ldcfDdezPEGiewPFtwJfBZgx/L9h07jaHb5jIQZves9HPsGaauMUBaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xz6U8VyVdECIxlH1UhbsW0Ijud4llMZKnkCTbOM4EDiuQT7h
	S2iePdMnN0yTmpduVFKAH7DwljgcUyhWBWVrwKv8CTKmV8E3IoDG+skmlkM4fSKhk78sjmFdQHL
	ECr5Hp0wTqxHxBOP1sPG/Wk9KAy5GEME=
X-Gm-Gg: ASbGncu8lPGuXbP2HRUDIrM7Rm/m/nUGsgs26BjoV2qQkpsjNQhUMClvh83KxPX8rKw
	thiFwd1hNe2l9gwgrwrTVJWjK8e7gKh8z9SQn5/e8g8JPGlHEIlL1lwCkOdImHkwwnrPtg7ZEFb
	MRLliyNHxihifKaclPaYn426WB26+Zc/Lsy1kmO2WZK8L9EKzKtYICEymMMMjqSHMdOoNyHn3FE
	BLBxfob/lEoR2/dqL1hNQA2KyWyU5AoOGd2njyRKg/gAr/x8Q==
X-Google-Smtp-Source: AGHT+IHJjSAqFzQR7vsvzpBHIle/SM7pkbfcfwBMTr+P1896d+alN/SQihemXVKbkiSRCNaNWJtZu6qP46KZEuNFGWc=
X-Received: by 2002:a17:907:3c8b:b0:b04:aadd:b8d7 with SMTP id
 a640c23a62f3a-b1bb5e56d85mr276690166b.13.1758116728681; Wed, 17 Sep 2025
 06:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com> <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
In-Reply-To: <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 15:45:16 +0200
X-Gm-Features: AS18NWBMJGX1M7gmLnyGCZI8UTIw8c6hYUtKDGdB2cO4qtZ9mDWgO1MIhRf_XYA
Message-ID: <CAGudoHEhvNyQhHG516a6R+vz3b69d-5dCU=_8JpXdRdGnGsjew@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:39=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > Does the patch convert literally all iput calls within ceph into the
> > async variant? I would be worried that mandatory deferral of literally
> > all final iputs may be a regression from perf standpoint.
>

ok, in that case i have no further commentary

> I don't think this affects performance at all. It almost never happens
> that the last reference gets dropped by somebody other than dcache
> (which only happens under memory pressure).

Well only changing the problematic consumers as opposed *everyone*
should be the end of it.

> (Forgot to reply to this part)
> No, I changed just the ones that are called from Writeback+Messenger.
>
> I don't think this affects performance at all. It almost never happens
> that the last reference gets dropped by somebody other than dcache
> (which only happens under memory pressure).
> It was very difficult to reproduce this bug:
> - "echo 2 >drop_caches" in a loop
> - a kernel patch that adds msleep() to several functions
> - another kernel patch that allows me to disconnect the Ceph server via i=
octl
> The latter was to free inode references that are held by Ceph caps.
> For this deadlock to occur, all references other than
> writeback/messenger must be gone already.
> (It did happen on our production servers, crashing all of them a few
> days ago causing a major service outage, but apparently in all these
> years we're the first ones to observe this deadlock bug.)
>

This makes sense to me.

The VFS layer is hopefully going to get significantly better assert
coverage, so I expect this kind of trouble will be reported on without
having to actually run into it. Presumably including
yet-to-be-discovered deadlocks. ;)

