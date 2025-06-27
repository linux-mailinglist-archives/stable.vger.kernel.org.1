Return-Path: <stable+bounces-158735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35200AEAF3B
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 08:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A94E56550E
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF372215F42;
	Fri, 27 Jun 2025 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtDOTIcq"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CF18E750;
	Fri, 27 Jun 2025 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007177; cv=none; b=HhXej+WrRp9COv4AfDJgg8g2osIUW1icaoHTIYuyk461uBS/4G7DxWlhwmT+sjx2oiA5Op1QfaixA4FvEKOfei1snTeDYjSvzLHUY1HB2GmarO232NhTUxgG0k0bRfDhP5/h/jUWnenGXB4tl77YeivqRxJbLDcVT8jfEbzBUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007177; c=relaxed/simple;
	bh=EaFMQmISe8mwMKslzDhJXe2N9mtx8GidIaMXPAK04mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJRmMuTsQLBg+wukL/AdUUgANXt4LOM//etqViel4bNkIKMEQd0v8BJ+GN9RCQoPxdcQdtUj7KPZ+b/tpTJLI24MsE2gDjPaq/iNJ1GDFM9UGJ0is7yHkeS+HWJfdUXfPT+JcpFFipVhvt76tGTG2YLY3cpbYtrpdQJx0JSPPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtDOTIcq; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e80d19c7ebso1043759137.3;
        Thu, 26 Jun 2025 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751007175; x=1751611975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaFMQmISe8mwMKslzDhJXe2N9mtx8GidIaMXPAK04mQ=;
        b=jtDOTIcqHlIkhkMGD29J8MHuHgohtSncLG5R+FPSh+UT5YwLsEIyNQu4OMEWz4H21k
         63Mmj7HzWr7W5pOCzgUIoaGvaGFCzF3U4PdvZuvacphmPelEj1UncH5gwF9WK/7DO98K
         CPocvSAfjVlf8oCjQGN71O1eXPFY4Od4UKxDJpLGVgitY3tVuaPgg8XLplNLlZtj2E3i
         svZlYzjPiYp6qPQOGlHR3wMU9cCWzvEeIIo6M/6DYWInztFsF9JjqmjgfMLqBDPKMLIJ
         xF1baQfKX+xowEEsNl9Bie/5SEcHCRsZhZdiBdhV2ImRw0DAjmo8v5LQCwOq21f624Iq
         mCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751007175; x=1751611975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaFMQmISe8mwMKslzDhJXe2N9mtx8GidIaMXPAK04mQ=;
        b=UzywMXznJ726i2qp+imKsRPPTAUndjKWfhU9J1GGHvY4RvZwH8LrKoGM7G2EGVKdqa
         HGZnsxo7r+9uwJmcLDMbZ4u4zGkbGAOJ8WhHFJqj0rc2oTdrL3Dme7DdUGkMXQ9TYitM
         tc5GNzdYRu+9nUj1rzmga+qq5vunzHVNoOYwdMceYICEzsAh0KgomJA/hMJdJWuFcHS4
         YukNd3nNQpj2MqzfebMqtdEXfqg8tm6pJMTcbUtQYDsisHV1yAwjDTxza28rHhG8+j6X
         vPvZFVlbVniATGG4G2quBsjhBp08WxzRTjZXSVaN8TrpEn48wrVQjNnsxY/+MEiC5I4W
         V42A==
X-Forwarded-Encrypted: i=1; AJvYcCUptbW+aY252DIAlDHfFhzqYQZ7lTdf96sK4tf5qLOnqto90u36dZranKVVs/Cl/VXeyESqlH5aGd8Ckvs=@vger.kernel.org, AJvYcCWJ3u3tUfwVraXZAwsESjvVH3fTsdsNOXqDN618I8fCW1beM6hijJs1RWuqTi/03nyF92LqXyby@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93AOpQ7xLLDP7Pe34hRhr3JRCU20Ge8sdPZxHNKzgiMtVq9Ky
	oOqpjdRmAYKk4BKo8bT5OEghrIhtpNzbAOupD87zFdxTR7MiNtIUX1yMybk+6EyYeyBmaIvZVwx
	kF60DvkObc7eUlizCUa9pQ7h16OoswMM=
X-Gm-Gg: ASbGncsCkwBg4Xbanb3GEvp6M6s3T99RH77PWsrXJR8JPAFr2hmAY0NauMwhA8mB3cP
	64EsYXSeujSz0kGWacOcrcthQdyWN+6tpegnKq8cmD0dmeTYFlbZmAUagzeX5KnGemCIsyn5H53
	PVJp3BtHmBUelt+khXnBs3Qto5C2gbkFaKBnXivbESchE=
X-Google-Smtp-Source: AGHT+IH6bDiCYOYL1uwyhCR37thkVbMFzWqTF1MJ7TonqI/9c72618WAPYRenRHgD5d7gIqLvS+7c3Y3eFAsHo5tk2Q=
X-Received: by 2002:a05:6102:50a8:b0:4e5:9138:29ab with SMTP id
 ada2fe7eead31-4ee4f6f7c8fmr1635839137.15.1751007174693; Thu, 26 Jun 2025
 23:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627062319.84936-1-lance.yang@linux.dev>
In-Reply-To: <20250627062319.84936-1-lance.yang@linux.dev>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 27 Jun 2025 18:52:43 +1200
X-Gm-Features: Ac12FXzKrRSpHCQX4R2-HXu3dI84IogjSfBJMN0ktRq8apwqIcoJ13xTkDhUr9k
Message-ID: <CAGsJ_4xQW3O=-VoC7aTCiwU4NZnK0tNsG1faAUgLvf4aZSm8Eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, v-songbaohua@oppo.com, x86@kernel.org, 
	huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, riel@surriel.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com, 
	mingzhe.yang@ly.com, stable@vger.kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 6:23=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> From: Lance Yang <lance.yang@linux.dev>
>
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> can read past the end of a PTE table if a large folio is mapped starting =
at
> the last entry of that table. It would be quite rare in practice, as
> MADV_FREE typically splits the large folio ;)
>
> So let's fix the potential out-of-bounds read by refactoring the logic in=
to
> a new helper, folio_unmap_pte_batch().
>
> The new helper now correctly calculates the safe number of pages to scan =
by
> limiting the operation to the boundaries of the current VMA and the PTE
> table.
>
> In addition, the "all-or-nothing" batching restriction is removed to
> support partial batches. The reference counting is also cleaned up to use
> folio_put_refs().
>
> [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe=
@redhat.com
>

What about ?

As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
may read past the end of a PTE table when a large folio spans across two PM=
Ds,
particularly after being remapped with mremap(). This patch fixes the
potential out-of-bounds access by capping the batch at vm_end and the PMD
boundary.

It also refactors the logic into a new helper, folio_unmap_pte_batch(),
which supports batching between 1 and folio_nr_pages. This improves code
clarity. Note that such cases are rare in practice, as MADV_FREE typically
splits large folios.

Thanks
Barry

