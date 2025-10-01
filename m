Return-Path: <stable+bounces-182900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0AABAF621
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 09:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE237ACA41
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 07:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA1C22126D;
	Wed,  1 Oct 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="KNM5rWPw"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E41D61B7;
	Wed,  1 Oct 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303324; cv=none; b=Q9LDkBPKcImwl1cMpzDNCFqLmAdHVfuhiNr1wSXhU2pTlqsfiMHJgoq5txneseXZOvMtvGoVbUti7/vRlaIfjIdymFhlM6jsFgLPwXIdHlJSxKReuH6nUfjH95thng3X1yK/qOY9VfBzu0oeQigmlV105ZSs08bM70K/+r+oQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303324; c=relaxed/simple;
	bh=xdZvpTYWdQVmppxBYv8yN8Q5L+MMw8v9clByinNMbbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEnHc4D3lcWtvvYtp/pFeCxWBl+kNcl3KHoRDE+51Jye89RoSXhTXhclJ7YEKrbkbyigRfvUq/5VpjKv+UgfTE+tZDb5It9N4FP0vBspu3xqCVumcE+QURLHP27f9+i9thKjqnqtm7ykmM3kshQrMKTsTpLUEz+qUPs1MoADUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=KNM5rWPw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759303310; x=1759908110; i=deller@gmx.de;
	bh=hnZWcXMOWRq2bfdW9zZE3Y8mGZXHkc4Xt0CxUKxl5es=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KNM5rWPwJ9kFGuk7wBUp39om8Q+7cmNhdOlAlrGkAMFdB3Iv6AW6dOqg2LFXI749
	 vPOI/R+5DKLtW2jvww3YQfZroOaXL8pAXlLl584/Jzj1WksGSUWPqDVOuHxWSp9K9
	 CmAd24Mg2+nPMv5+vZ/GUQe4srMM4P4m3jVQnv5Tt9IeCVHxXV44cYWvW0fHCR2ra
	 tp9UiuxifigU/ySTygGNayekf83E+BLZTcfB9ale3RYaizlyByZb/khhTKYkS4r84
	 By1IQc8aU3A19Er5UmnyVxsoh2Z4hzxXvEjOkFc9820k4ItCQTNMmi9+/jKrJADst
	 +ll6XY+Go3XdDuBSVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.8]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1uKrJz2eHt-0157oy; Wed, 01
 Oct 2025 09:21:50 +0200
Message-ID: <03029eb0-921a-4e45-ab23-3cb958199085@gmx.de>
Date: Wed, 1 Oct 2025 09:21:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] page_pool: Fix PP_MAGIC_MASK to avoid crashing on
 some 32-bit arches
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
 linux-parisc <linux-parisc@vger.kernel.org>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250930114331.675412-1-toke@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250930114331.675412-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PBXPll7xM7u3uw4Q9cPL2zfse9YG3KsxFM7O4WpnM/wagZm9iod
 nR+2OAVpeNgnIZnUI3G5l4Tbx3cDiYYyd1U1jRZ8Pf/ulCj0eYn7Ithoygx8QqjUmFMzkbD
 ippirVXJX7srYQlhyDZmTGjHI0NIFYaDQVmsF8qY+dLKdCoGk0MrPiOxgNvANBgJujsZ4d3
 LQqIsSWU5l9DjkCo7L7FA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nP7369nU9w4=;CW20skZnlr6EqTc2kFizoWkyK9X
 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

On 9/30/25 13:43, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Helge reported that the introduction of PP_MAGIC_MASK let to crashes on
> boot on his 32-bit parisc machine. The cause of this is the mask is set
> too wide, so the page_pool_page_is_pp() incurs false positives which
> crashes the machine.
>=20
> Just disabling the check in page_pool_is_pp() will lead to the page_pool
> code itself malfunctioning; so instead of doing this, this patch changes
> the define for PP_DMA_INDEX_BITS to avoid mistaking arbitrary kernel
> pointers for page_pool-tagged pages.
>=20
> The fix relies on the kernel pointers that alias with the pp_magic field
> always being above PAGE_OFFSET. With this assumption, we can use the
> lowest bit of the value of PAGE_OFFSET as the upper bound of the
> PP_DMA_INDEX_MASK, which should avoid the false positives.
>=20
> Because we cannot rely on PAGE_OFFSET always being a compile-time
> constant, nor on it always being >0, we fall back to disabling the
> dma_index storage when there are not enough bits available. This leaves
> us in the situation we were in before the patch in the Fixes tag, but
> only on a subset of architecture configurations. This seems to be the
> best we can do until the transition to page types in complete for
> page_pool pages.
>=20
> v2:
> - Make sure there's at least 8 bits available and that the PAGE_OFFSET
>    bit calculation doesn't wrap
>=20
> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them w=
hen destroying the pool")
> Cc: stable@vger.kernel.org # 6.15+
> Tested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>   include/linux/mm.h   | 22 +++++++------
>   net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
>   2 files changed, 66 insertions(+), 32 deletions(-)

I tested this v2 patch (the former tested-by was for v1), and v2
works too:

Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

