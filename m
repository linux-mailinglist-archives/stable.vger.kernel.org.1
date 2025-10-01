Return-Path: <stable+bounces-182903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF53ABAF9E2
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 10:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F4B3C41B8
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 08:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2093F28000B;
	Wed,  1 Oct 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV4CTV0X"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF327A465
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307334; cv=none; b=AryhoXOa+w2LafcZY2OTWEeuy2ZTJa8dgSzvz1Ks1VMnQKcQBHv2JQ6GQWSZdeSKHn7qprcPwonCTR3MxaMG4ojNPWY4kVtWmcpa/yW0Kqsv7meaYKp32f1mftsjrGUxrKkIL/BBTIC3CLMcThGadEaBt7V0tpfG2OFTrC+tc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307334; c=relaxed/simple;
	bh=mAs5jC88keGuTS1kfSau2lPlyfOYPIVe4bEKVDeisl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWpblH+yQ/PdvDVr3xcX81NyvWX29ISzhvz6Dslo7A05WguROlu5/UsSKI6KJJMXArhmklqtPEb/ua1FmxN/gxuBc7nGuUKpnoMbjGxq9GdMaYclJKXHOrJj58hVoNbBP6lJV7ajh8aG6MCTiFxh7pIwo+PIMpbr5tZ73gEm5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV4CTV0X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759307332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH59Sw29O2jzr1UeKiMhScDg0sFiTxNL4gz8DMwSkfs=;
	b=CV4CTV0X58bYu9fP/YaC+3zEZj6a058H985Prml/CoXCp6vojHQ0je7NOXFdROFJniQLsR
	WKTfKXdFAZldsNSOUfhixhUAkq9k6W2aNy1wm9TKx+Z3C80QeSuVByOMz/2pl7gmwrXj2S
	QlpG/RhbKr2D+v5qRsvaC5LLLm/vFCI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-tA3IrJVEMe2CwFkm33EpUw-1; Wed, 01 Oct 2025 04:28:51 -0400
X-MC-Unique: tA3IrJVEMe2CwFkm33EpUw-1
X-Mimecast-MFC-AGG-ID: tA3IrJVEMe2CwFkm33EpUw_1759307330
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-633009e440aso763454a12.1
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 01:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307330; x=1759912130;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH59Sw29O2jzr1UeKiMhScDg0sFiTxNL4gz8DMwSkfs=;
        b=w//Z8lbzXwTELvghfiy9c+3FcEydn7fEWwJXVquh2C75l4avPXBJGCl6cZskKKLx6k
         ugugiTzoaNTUwwGNHRL8GN6HTo1w6aiMoK7s6cS4AyA0GvdKAZSq5ZLFWT/ygtPB002l
         neeDBP4yCXcFpfRs8/yj/auoFS27Jr48XYDLDl9taMJRY39ICS2xuIDO23DF2gHiRGJ/
         JRZHq2bG78iyFCYOvoDE6mgE/ol7iVt6vbXCITVw3rIGu3fGxRb5LCuzy8nToWEdjs6P
         YGTN+4UzJkGzdwGIqF+p3M++s0oOeIjSD3cymE6U8ShAB8KhqMw8gF8JtGbDF5N8pau7
         tC3g==
X-Gm-Message-State: AOJu0YyP9UWeXe57Q13ecULJuuh+CRVCexNvVHzHoWEhzV0gmYnJ60K+
	aQJlopKFaHGQfloDGuZZiz6BYGB0XY5V+Jz1Tjg+cbUtCC+kcJWSRtf1G1Ogt7Ss8Sjux2vtT9a
	vWJTssXsFvrWeoRIvqZ4ip/3NEYBwZtrgpiH1ARjaaffjUOo2+F31TaEk5w==
X-Gm-Gg: ASbGncsLMkXM1VaLfBkCyViafHGbZ3o5gCVaG2w3TumtJwNnxkpsOsLOBWq5s6lHwfm
	uICqUJFOhMsKSJYHhJMPusIZ0f9IdyBpRoMyCRdjSIIQ+I+d0Hur9StbrmjDR0xYgWy4okmL+Ui
	DOmym8Npm9KPw+EjYS2eC8YnFz3++LWFPT1PHfXi5lWxJWzmnHK7jCZNFn4Iqr3n0YUicWZbXqT
	iUuMjMBMRuLLKf3xVGr4uE5fkC68B9f2SpNL3K4AwjvgXnIc+jyalv+aZIib+cFGdGkq+tNEh6M
	7ym4N4alVTWMkcbTWJIVD3lbdL7/WKcb4ydy6A7T9HVSQ8mbxX0t7Q02401D/ECo2vvikkqX
X-Received: by 2002:a05:6402:1e8e:b0:636:6e11:2fd1 with SMTP id 4fb4d7f45d1cf-63678ba63f9mr3429922a12.4.1759307329898;
        Wed, 01 Oct 2025 01:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj+PdPhsJi8Z+hoZrTRC6U/N/PUjMCvkDv55wnRbOMIuFkZ+Ix/bmpUxPMb7w+6Ds4kpGBRQ==
X-Received: by 2002:a05:6402:1e8e:b0:636:6e11:2fd1 with SMTP id 4fb4d7f45d1cf-63678ba63f9mr3429889a12.4.1759307329463;
        Wed, 01 Oct 2025 01:28:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63662dc0a3csm2990346a12.48.2025.10.01.01.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 01:28:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AF4DF2779AF; Wed, 01 Oct 2025 10:28:47 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Helge Deller <deller@gmx.de>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, Mina
 Almasry <almasrymina@google.com>, linux-parisc
 <linux-parisc@vger.kernel.org>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] page_pool: Fix PP_MAGIC_MASK to avoid crashing
 on some 32-bit arches
In-Reply-To: <03029eb0-921a-4e45-ab23-3cb958199085@gmx.de>
References: <20250930114331.675412-1-toke@redhat.com>
 <03029eb0-921a-4e45-ab23-3cb958199085@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 01 Oct 2025 10:28:47 +0200
Message-ID: <873483m3eo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Helge Deller <deller@gmx.de> writes:

> On 9/30/25 13:43, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Helge reported that the introduction of PP_MAGIC_MASK let to crashes on
>> boot on his 32-bit parisc machine. The cause of this is the mask is set
>> too wide, so the page_pool_page_is_pp() incurs false positives which
>> crashes the machine.
>>=20
>> Just disabling the check in page_pool_is_pp() will lead to the page_pool
>> code itself malfunctioning; so instead of doing this, this patch changes
>> the define for PP_DMA_INDEX_BITS to avoid mistaking arbitrary kernel
>> pointers for page_pool-tagged pages.
>>=20
>> The fix relies on the kernel pointers that alias with the pp_magic field
>> always being above PAGE_OFFSET. With this assumption, we can use the
>> lowest bit of the value of PAGE_OFFSET as the upper bound of the
>> PP_DMA_INDEX_MASK, which should avoid the false positives.
>>=20
>> Because we cannot rely on PAGE_OFFSET always being a compile-time
>> constant, nor on it always being >0, we fall back to disabling the
>> dma_index storage when there are not enough bits available. This leaves
>> us in the situation we were in before the patch in the Fixes tag, but
>> only on a subset of architecture configurations. This seems to be the
>> best we can do until the transition to page types in complete for
>> page_pool pages.
>>=20
>> v2:
>> - Make sure there's at least 8 bits available and that the PAGE_OFFSET
>>    bit calculation doesn't wrap
>>=20
>> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them w=
hen destroying the pool")
>> Cc: stable@vger.kernel.org # 6.15+
>> Tested-by: Helge Deller <deller@gmx.de>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>   include/linux/mm.h   | 22 +++++++------
>>   net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
>>   2 files changed, 66 insertions(+), 32 deletions(-)
>
> I tested this v2 patch (the former tested-by was for v1), and v2
> works too:
>
> Tested-by: Helge Deller <deller@gmx.de>

Great, thank you for re-testing! :)

-Toke


