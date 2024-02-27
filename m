Return-Path: <stable+bounces-23856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46690868B76
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6C3B26C34
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CBB131734;
	Tue, 27 Feb 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKGC2Tc0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFE54BCF
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024348; cv=none; b=X+ivGCPl1cuiE06yyh/NMUvhl/UEDt2qxTw5Oh5XCQaQdPxpEws0QMfsPzQZFlUQokxkn8awoQJhiUomwAIQxV2FK3zQ6PhMESRsJ2nJ2H5pga3Gw8g7PnCuo3UpAf4Hx5qjZEvz/uC7VVpA5NQDfmk2MR3DhA13AaNFGyYi/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024348; c=relaxed/simple;
	bh=0OznEP51hZXznvUGBng25CLjSiKVMpfQR27NIycej3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyOQgH75XjIXqeQuybirG90HOodU7U7nAFEO9A7PsPnGP2PdHiaL1d0NAB9kGmOsoouHkrvOG5YB7bR6Gb9lwTYsPrb1vUigWhjK932V3LbpkPXw3QrOYDg1dwussoQ1PTM+sJUqUJSTiefKu878LidgHtBqfjouU6C91pHUaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKGC2Tc0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e550ef31cso447578566b.3
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 00:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709024345; x=1709629145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbIA5jLAW/O+7tEhMJSC/awwah9PgpbT7DSPeEKH9LY=;
        b=VKGC2Tc0jKrtDuaGSaw1YX7RkTU9OFbwbfRic8lRk5Gd6GyeEtKz8KKGuMg2F9Tpdm
         7FmWhWzNJot34V3T1yGI03MBY81Alr6zJsuWGJHK/2P9Tp5VbaTJ+zUIDAqwenQf3lXU
         Xbe+NApf6pEsJwnrsDFf4U/jXR7j8gqSFXHXSRl5ZnfX5wnrI/yR7PByb4nRfK+U/hBN
         y4U1iB2tcFzFTpySNquHZOlkucT9jd3aGQAbAlfvT37eUsXhePl0N/7jDIbS5OSiex6T
         gW0Yx/0yGAIpM1MNQALv/YjMVuheSerVpr5aprHXN0JEL3OCduP76jpNBg5TdJ1a1tzN
         jhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024345; x=1709629145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbIA5jLAW/O+7tEhMJSC/awwah9PgpbT7DSPeEKH9LY=;
        b=wc4dGvMrWBujY1moJmPLFWmnQ2xcF5S3kEL9EPA8LgtKEKh54q/kT9C3wUqefPIVzX
         4Vq0ildMilsp8R2PIZyf6x3Mr5gGpZ+028aaQEzDezQ+2q+AqOg5UcHgynTWZuOyinfk
         4CeEw49Y8nruiH14Uk3Qjb8IlnA1GkqkLeF54GPH0mY0zQjQ+8Akm/nKpKLqhXFAIjdE
         lWxan4KdxQpp+eivu2oUcEkUaPrB8sFCisImLtsUGP07yoqgUyQ7mCdePOVHzhhd7kyN
         2L05WNeGu/Rlr82Xf85vtxz1JhepTZAV/y999BMR3aiYKHfuDA8vxeOHFnBDv6nsTPqd
         0UAA==
X-Gm-Message-State: AOJu0Yz+tK7ibvNb5s6YkCm/74UBU1PyhYLtg1ihK0uCm2Q4qlRi359z
	T3R587etSoOzAl0B37lG6YsW/z75qZ+eGEpm3nM+x1v36QcjoEvwGP8gmBFrE0khxNIhc0FrBYc
	s9SYT4lQzuWVFzTp99vkSoWPOJTiL7R156PlB
X-Google-Smtp-Source: AGHT+IEU71qh9pSDAOfby8HvkSDS6k48tNuB+W5jnpCuulaJwBngEIvEiMhYSnBijDdOXPqL95beDO+y3yRu6l855H8=
X-Received: by 2002:a17:906:48c9:b0:a43:3f37:4d88 with SMTP id
 d9-20020a17090648c900b00a433f374d88mr4069391ejt.71.1709024345054; Tue, 27 Feb
 2024 00:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024022611-tropics-deferred-2483@gregkh> <20240226221017.1332778-1-yosryahmed@google.com>
 <2024022755-amplify-vocation-854e@gregkh>
In-Reply-To: <2024022755-amplify-vocation-854e@gregkh>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 27 Feb 2024 00:58:27 -0800
Message-ID: <CAJD7tkYYWPWA-3fGAjMOqVy+8Mcwq++6yw0R6odeOsByugre+Q@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix missing folio cleanup in writeback race path
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:55=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Feb 26, 2024 at 10:10:17PM +0000, Yosry Ahmed wrote:
> > In zswap_writeback_entry(), after we get a folio from
> > __read_swap_cache_async(), we grab the tree lock again to check that th=
e
> > swap entry was not invalidated and recycled.  If it was, we delete the
> > folio we just added to the swap cache and exit.
> >
> > However, __read_swap_cache_async() returns the folio locked when it is
> > newly allocated, which is always true for this path, and the folio is
> > ref'd.  Make sure to unlock and put the folio before returning.
> >
> > This was discovered by code inspection, probably because this path hand=
les
> > a race condition that should not happen often, and the bug would not cr=
ash
> > the system, it will only strand the folio indefinitely.
> >
> > Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@goo=
gle.com
> > Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > (cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> What tree is this for?

This is for 6.6.y, sorry I messed up the subject prefix. Do I need to resen=
d?

