Return-Path: <stable+bounces-100499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842189EBFBD
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 01:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF4D28318F
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E310433CA;
	Wed, 11 Dec 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YpLjZILz"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09B800
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875480; cv=none; b=S8LHERFL7nieSYgXk3YVUg95M+7BsS5xjNrAbhJH7m3ZfC3fRrgGmNm7/d4T0WYCBjJzkNu3ekD3P/FAih2VIji0uJLSV9qcJCADAn95QvXuuEiSpfkG1pRspIWHunzs4m2boMwHfJ2jwwKjdyyqmoWjrSDzYDQXbdSYXjHKDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875480; c=relaxed/simple;
	bh=OCHV6HmvuE1qzKNAPSoYhRL/7FV4ReXNkxuSygUjwFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GA2RVHIC18GB6Ud73FqgN6PzwBy+d6uTxr5D1X39PM74JY/nCcNPihn4yslap4GRFswfJI8STs0vq4I4aD6mgS26YXbLU8Og2XyEMq2rkRyiU3lAjGLDTxMTjHB36FPo0cxCoiP0JaT60VFamh5p9Gq5q6z8QlX8yI9p+7C2CFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=YpLjZILz; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3a0d2d15adso4176211276.0
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 16:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1733875477; x=1734480277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCHV6HmvuE1qzKNAPSoYhRL/7FV4ReXNkxuSygUjwFc=;
        b=YpLjZILzLMYgXC7X3hw3H3EPw5j4ApF7GiexGBB+lCJcoVysqfJDNhgGbn3MTUGS11
         vt+LQTNUBG2/RV6wYQUAcf4Yl/tMbLy58Fj5WAacs1QD0H7VMR4ZR4g3TwScRCEMN+vp
         ML4mzeT6dy5kpGBM0I1acJnIeEQof47hQ85Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733875477; x=1734480277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCHV6HmvuE1qzKNAPSoYhRL/7FV4ReXNkxuSygUjwFc=;
        b=E2QMpovA2Khw5cx85x8hbsR9i+7VnXUwNNZDQb/tVsG8XEYRFSpD2PPEz1aQkavHMy
         UFwY1xZZ4LkA7CMMF5cVnAlEYSOyS3GFsFXkxcxanhE6HtMB32aFDzxZmD0J6VXEnDdR
         hqQ1gLuC/etEtl5dedqnDBvEejW0UhjHr2dt7PpfTykBT+TVcaoy7kQSqGoty6j/UNWa
         PpIb0lux4VoTGfhXfyu/zt/tyhr/pjjCzy1eTlLcy9pHs9ud1uSn7GrvDA+UsCahtlWB
         tkJ49r4jHGUtBxIUGauToNXYQeEVywR/bj9Kdo+MrzvwNV6aI8QHZVJkvHXRGXZHVtUW
         FfAw==
X-Forwarded-Encrypted: i=1; AJvYcCW2pgp4kZZBrOcc2NrsXHBPjMomxrG3TYM/N5qikw4BkLE1xopSOgj255ddItg7rAuSCnkvID4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSvmJvpxljr20/3yeIadCOt88JHB9Kqj86A4KMADwcUJwcRBz
	/946+8XyASakzPkXltE3OtC9hjo5cqSfuuqPJfpYbBMN9TAknjusOxKFv0EjjBirNFiPSkeRTYt
	IgDNur5L0ZZ4dzXm9QEs8VAGHr8Gil3OzbcLAyw==
X-Gm-Gg: ASbGncuUULT0LDxollBpNrAWxCbNGM9T/xGjXNIzm0fZQzfpnuicqas+eokX/aLOQox
	8/x9hJ1XD9o3Ri2cCtqgEFh3wywNwoB3Z01k3
X-Google-Smtp-Source: AGHT+IHAdKnSSZvTjoIr7mwXDQmX65FsKpemA7psolWqer3VHIGe/o3rpMktPHVLVXQ+RdM6hXLdwcEW5U5tsp0AJDI=
X-Received: by 2002:a05:6902:120c:b0:e2b:e0ba:d50 with SMTP id
 3f1490d57ef6-e3c8e42e3a6mr1140093276.5.1733875477096; Tue, 10 Dec 2024
 16:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-udmabuf-fixes-v2-0-23887289de1c@google.com>
 <20241204-udmabuf-fixes-v2-1-23887289de1c@google.com> <CAEXW_YRb4PsFgEvHW2QBDY5dxJ+aoMTn3qtj5v9eboxO3SxPLg@mail.gmail.com>
 <CAG48ez2cTrD2_4iKo3+zrPH=e29znYOKLBkC4OLA3yhsu5oMNA@mail.gmail.com>
In-Reply-To: <CAG48ez2cTrD2_4iKo3+zrPH=e29znYOKLBkC4OLA3yhsu5oMNA@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 10 Dec 2024 19:04:26 -0500
Message-ID: <CAEXW_YRUVwWxuoWs1fU8OCsOf+vAWc__csX2Ed0W+yVr0Y49aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] udmabuf: fix racy memfd sealing check
To: Jann Horn <jannh@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, John Stultz <jstultz@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Julian Orth <ju.orth@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:12=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Dec 10, 2024 at 11:51=E2=80=AFPM Joel Fernandes <joel@joelfernand=
es.org> wrote:
> > On Wed, Dec 4, 2024 at 11:27=E2=80=AFAM Jann Horn <jannh@google.com> wr=
ote:
> > > The current check_memfd_seals() is racy: Since we first do
> > > check_memfd_seals() and then udmabuf_pin_folios() without holding any
> > > relevant lock across both, F_SEAL_WRITE can be set in between.
> > > This is problematic because we can end up holding pins to pages in a
> > > write-sealed memfd.
> > >
> > > Fix it using the inode lock, that's probably the easiest way.
> > > In the future, we might want to consider moving this logic into memfd=
,
> > > especially if anyone else wants to use memfd_pin_folios().
> >
> > I am curious, why is it not possible to have a reproducer for this
> > issue, is it not reproducible and is theoretical?
>
> Sorry, I think I must have forgotten about this part when I wrote the
> cover letter: The original bug reporter (Julian) linked to a
> reproducer that is linked in the bugzilla bug report, at
> <https://github.com/mahkoh/udmabuf-seal>. I haven't tried running it
> myself though.

Thanks, I appreciate the pointer to the reproducer.

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

