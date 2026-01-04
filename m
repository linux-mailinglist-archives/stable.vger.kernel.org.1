Return-Path: <stable+bounces-204558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20513CF0C39
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 09:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2701D30109B2
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326BE263F5F;
	Sun,  4 Jan 2026 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNxBz2qd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576331B6CE9
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767516091; cv=none; b=GbpgcnVQpT3HfoLRbRFniXYkJsTTVYflYavawmSnTUgQlMBrTrPD7hmSTN7akYWa5Ekl3A60I1QelSZEeZ9W+AnrkpEwCtQrCMJR0jQCV9+geXHEd3A2y3RSYow7PWMAtIvpH5NQyzeqW1FkCRdIaKBJapIRSvNRnmG5wJob3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767516091; c=relaxed/simple;
	bh=ZL3QagTQ9jAE3jZf2UYj5e9nSx7Hnf/m9dZ54tQmU6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWXixjG3CjYLKmpCpMdoTOGbiZdwI0o6FC5023+9mYXlkD+e8bK3JWUAP9QzeeO+Agm0rosBJo/n4jIBzA6KN3qw3ztFDuiimZgd8PW4Dtawtclw1WMsA3Oglz29Q59xzNVO65khv47OLaAilZ6y2nQM7caeI9yaQZiPRh/UiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNxBz2qd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso5629688f8f.3
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 00:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767516088; x=1768120888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL3QagTQ9jAE3jZf2UYj5e9nSx7Hnf/m9dZ54tQmU6Y=;
        b=WNxBz2qdnlS9wawfThHT641HNm1La0MWVYtAhF958pfKBwsYJLT6ODWoW2q9kONoij
         6T2ERz2a84lvjbZaNesrH6rKXE6gZGSne6sQiHZdowqS/JPcL6JR702Nknl3GqFAGmIA
         bUbSzodHQLTAy+CjGf5kYbNWlJRF9RELVEk3AA/jXxzyfsN2YdmthuOtuYtgv9mChXAd
         Ru4QJ6GUUEZUk7bQvC4cQv9kF1/dX5/WgKZw467lwGOAHrvHcBIeumD5x8tat/kcBNWR
         c7OXZfoY4mYPoV8cXTqh8j3XZchRbn7krQg84fIVVc9oQ9FfJEDsv8lZreB7B4AXNnSC
         XKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767516088; x=1768120888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZL3QagTQ9jAE3jZf2UYj5e9nSx7Hnf/m9dZ54tQmU6Y=;
        b=pHVetwVJG0aBGjJ5YUOgbbSIExXA7AgoDOc1ml8U2tH0TNJpwCDRmkOGL5n4sAmEWu
         UnjZb9Lu/OaFCFk+r1u/FvMmP0z5kU3n7HZZCcwt0cxUJ7veLiRkre2PcAR7HumOC+l8
         9qe+96jMmBptYIJ5vXBBF455jF9oJOxTDMcShty/P1RLx8pRv/GajWNHBih46Q4lgYu/
         yiCHqyLFPuhbkzaKsvzD17qHLQW6KLc9R9nuKwCxntKzXMtHhn23BgbVRf6eq0XeiHEa
         VbSuONiZEBR9MDbKQUDyd0O3H9GPaK75auyYBvTjHPuEfFNuShqUFWovbh2E5IL56QHe
         ir2A==
X-Forwarded-Encrypted: i=1; AJvYcCVahMX4IINOfI5BQvbYNuO2NvjrNvILq3u974siImScysPOKWagWYBDuGNZ7vYQ6Y/8FdMZdHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9x9mBZUxTDJ7ACmmApLz2IxN3Ajlosemw8LGi+q2/pOhGoguk
	9yzwO9o9A9uF83QBnWG+eN9ilOk7u9AsxNBr7RKkLEXyxny8JXG3SmU+W2VmNWMb5tRKdzLI9v/
	DcuyVa1Y3b4UW3zBz8p0+bCjInSPUYHY=
X-Gm-Gg: AY/fxX4//0ZLQntcjduylyUxMpfqHqIPX8eZuQCrnmhJ4wfqZQx8RHU1TjVGqG1vTFg
	frFNC+6Mx2/44nsJjdKwZGmUEIqrtgSwedeCd3Vm38igpkvGu0+5eE1AOlhmjMMJfhawsE1yvOA
	yBRI6rdNEPBKYMXvi6k725pYHrT4xx3NVkGI91oCPMk3iLwZMAqQpDChfNqLxhOAQp8s7oCdM24
	Q1lsKrnCbdnHWE7jY6t7VMBfWL4Gd6FmFo+kGmdVqPYbj64jK3Kuvm+UCoeq70T9NLTCxeEzkTv
	WDUfOoqbp6LGPDBF4YOlprC/tPe/ZDMtu2zueIs=
X-Google-Smtp-Source: AGHT+IHQzFq+i/woR5r1u+aL5iID+9t9gIdl6JNWh5ubS4UyoIIR7NC4C6gkz8cAVcHEVBoMLfdk3Nox4f1w+MwWpLY=
X-Received: by 2002:a05:6000:220b:b0:430:fbce:f382 with SMTP id
 ffacd0b85a97d-4324e4d04d4mr55366470f8f.25.1767516087495; Sun, 04 Jan 2026
 00:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231074638.2564302-1-pbutsykin@cloudlinux.com>
In-Reply-To: <20251231074638.2564302-1-pbutsykin@cloudlinux.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 4 Jan 2026 00:41:15 -0800
X-Gm-Features: AQt7F2ppXwyMl6fyQEBfhw1UkIR0oohdH_p0Oyp-hkq6e8XFwU446CRH76b3fXk
Message-ID: <CAKEwX=PVZJZHJ9JyubqH4C63RLRiHvMaVYGc-TtY2jt9vGWzbQ@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: fix error pointer free in zswap_cpu_comp_prepare()
To: Pavel Butsykin <pbutsykin@cloudlinux.com>
Cc: hannes@cmpxchg.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 11:46=E2=80=AFPM Pavel Butsykin
<pbutsykin@cloudlinux.com> wrote:
>
> crypto_alloc_acomp_node() may return ERR_PTR(), but the fail path checks
> only for NULL and can pass an error pointer to crypto_free_acomp().
> Use IS_ERR_OR_NULL() to only free valid acomp instances.
>
> Fixes: 779b9955f643 ("mm: zswap: move allocations during CPU init outside=
 the lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Butsykin <pbutsykin@cloudlinux.com>

Acked-by: Nhat Pham <nphamcs@gmail.com>

