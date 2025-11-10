Return-Path: <stable+bounces-192909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C8C4506B
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 06:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7ED188E10F
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 05:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C1E2777FC;
	Mon, 10 Nov 2025 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6/GyxCt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB5883F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752812; cv=none; b=aGx5LSG3RJyRIlpnw5xvFTJ69R1nCG3LVBZu+i1kD3ftp2KD/Mf7e5Xt99XEQ3y4M1OKL/XQ7+HWYzNOpzJg/IROfQsduWLvSKypv+nfLSywgt2N9Pj93wKaR33b7quaXMvFb94kFc6RWtNUAHGxwgYkKi6vIG+bVqZ4qKaib28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752812; c=relaxed/simple;
	bh=y6LEgdgdd9v8Z7GZe+XO/MCaNmA1ideLxm9iboioNS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFbSXPY1NaRWcuXUpLUehi38iLaT5NPJfUInNzD+lncLpAwauXah2CNqFhwv6xrCA9LNenGUEaUrrVqFS2okVZVQO5pYpc6+zxmi3L5I6abv79asgNqkOn5axAK00buP52teQgg5IRzfBSqtFBExM5DljIIw4frSSUXsbAiTXYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6/GyxCt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so495504a12.2
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 21:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762752809; x=1763357609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR/MbGcnUq0EBQz4ehwdMha/tCfwYBiuvbwmX0gSrQU=;
        b=U6/GyxCth/p6wjpu9TwJziMGHlCB5Pv4pRjdmZZZ4J280KITfK7iNQKtKeT8+cbEzq
         wMG+2tbRoEFy+1W6dCx9czZKv9zpgQUsm3hqhbyLGjSaKRRJm98H6ntTa7VcDkPZSq0G
         w3xHJCroyXymSxlnkJlI+LLsgT3N+J53CAoPFtQiDf7BIYoB/KgKUEIRsaD2rHQXfcMK
         4t5NeNHCngHCa5/I9oUU4eWOfIEHOh1aqDk5rS9QjeWse3+R9rbNd6t/WBS+tKcR/NV2
         RF0RF9B6V4oxmDu44KgDSAGOcL4sIuvT4fW2fZbzpQ+cw/FX6WH4nMC7arjEiZXExAfP
         aCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762752809; x=1763357609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qR/MbGcnUq0EBQz4ehwdMha/tCfwYBiuvbwmX0gSrQU=;
        b=kku/TK8RFeEkTvnY1KhfVoxm1FNILZnTutZalI8Q5moGftjCPu86FAa32W0E2Mhpf2
         pDE23XBy7J9cRazsh9D86LZ6tw1aoAlbp7mSiDbAMzbX/3AJ3HfqbrkwYxJnGbv/dlvA
         qbviEhv6t6WFjwT8aP/CeuX5R5pYmpZOwlgsNgy2OIniASbY1H2x4w4HAremhL27FI3e
         +XcSv4tyc0304bW8czd2k3aYid9CPmPnkACFmjU3bbrsxBCskl+7SMDhL/wEfoG81fTp
         rViFw5I6SA6EPBdoIatTgd3dtX4kmH3Rd0v1EeY7h8pDyyFy1lGHWtxi0FGBgA0MCFzC
         fayA==
X-Forwarded-Encrypted: i=1; AJvYcCX78QtqcAj2zD+TtxOyjXvhciEgrM9oOkXd4XoDRfZhhQTcnSxEqzs6HtguiZ2m4CqvVMn9Rjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhfeJyFNtD2yDadammfDeRWDA+mXcb7AOkjXfsMKpZam1G/xCS
	9dUHGwAjBt7gMgi4bVM0b9PUUehkDrmi9qVDMwLkeFkh5gf5lsk995dj/REvpnDdin6fzS/zxWy
	4KxjG1IJtmZtkPZDYy5genoYw6px9T/c=
X-Gm-Gg: ASbGncszCsrVQmrChIzDj0pD9dQqNPBHQA+3p6SfLr+cPL60U/GuUxT75cGFaS+Koi6
	rORicIJw/MglIlf31Eg9PxFfuVFIxn5r+dn7yAXW6RizfqfgPab/h8w+T18e/LGx7kpJtMU5+EN
	1uTv6J6/TFIaKbC4yeOKSPoTYICesccYLS7lnwUm4ih9DlVWo7EYNI6idIc26ymGa7H+OkvlkeW
	7e1vPolEQ+eeswydKwINo7VizA8L2lVt+QWPGhBERJNM1bqjoYk6zINw/mQ
X-Google-Smtp-Source: AGHT+IEQaTF+1TfzvP4FKyKjl0iE5Fs96BjILlbZ5Ppxh1pUUmMmsbNSxF6n9/ltcRRgD+ILMiYpD6RIg1jm5j9TO5c=
X-Received: by 2002:a17:907:3fa4:b0:b57:2c65:116e with SMTP id
 a640c23a62f3a-b72e02b3515mr749481466b.12.1762752808595; Sun, 09 Nov 2025
 21:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com> <875xbiodl2.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <875xbiodl2.fsf@DESKTOP-5N7EMDA>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 10 Nov 2025 13:32:52 +0800
X-Gm-Features: AWmQ_bk0J22Vk5bVsirS-BlCYuVlPSn2kEJtIWp5JuDlLDq9qg3-goJo61eNTfo
Message-ID: <CAMgjq7CTdtjMUUk2YvanL_PMZxS_7+pQhHDP-DjkhDaUhDRjDw@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm, swap: avoid redundant swap device pinning"
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 9:56=E2=80=AFAM Huang, Ying
<ying.huang@linux.alibaba.com> wrote:
>
> Hi, Kairui,
>
> Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > This reverts commit 78524b05f1a3e16a5d00cc9c6259c41a9d6003ce.
> >
> > While reviewing recent leaf entry changes, I noticed that commit
> > 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning") isn't
> > correct. It's true that most all callers of __read_swap_cache_async are
> > already holding a swap entry reference, so the repeated swap device
> > pinning isn't needed on the same swap device, but it is possible that
> > VMA readahead (swap_vma_readahead()) may encounter swap entries from a
> > different swap device when there are multiple swap devices, and call
> > __read_swap_cache_async without holding a reference to that swap device=
.
> >
> > So it is possible to cause a UAF if swapoff of device A raced with
> > swapin on device B, and VMA readahead tries to read swap entries from
> > device A. It's not easy to trigger but in theory possible to cause real
> > issues. And besides, that commit made swap more vulnerable to issues
> > like corrupted page tables.
> >
> > Just revert it. __read_swap_cache_async isn't that sensitive to
> > performance after all, as it's mostly used for SSD/HDD swap devices wit=
h
> > readahead. SYNCHRONOUS_IO devices may fallback onto it for swap count >
> > 1 entries, but very soon we will have a new helper and routine for
> > such devices, so they will never touch this helper or have redundant
> > swap device reference overhead.
>
> Is it better to add get_swap_device() in swap_vma_readahead()?  Whenever
> we get a swap entry, the first thing we need to do is call
> get_swap_device() to check the validity of the swap entry and prevent
> the backing swap device from going under us.  This helps us to avoid
> checking the validity of the swap entry in every swap function.  Does
> this sound reasonable?

Hi Ying, thanks for the suggestion!

Yes, that's also a feasible approach.

What I was thinking is that, currently except the readahead path, all
swapin entry goes through the get_swap_device() helper, that helper
also helps to mitigate swap entry corruption that may causes OOB or
NULL deref. Although I think it's really not that helpful at all to
mitigate page table corruption from the kernel side, but seems not a
really bad idea to have.

And the code is simpler this way, and seems more suitable for a stable
& mainline fix. If we want  to add get_swap_device() in
swap_vma_readahead(), we need to do that for every entry that doesn't
match the target entry's swap device. The reference overhead is
trivial compared to readhead and bio layer, and only non
SYNCHRONOUS_IO devices use this helper (madvise is a special case, we
may optimize that later). ZRAM may fallback to the readahead path but
this fallback will be eliminated very soon in swap table p2.

Another approach I thought about is that we might want readahead to
stop when it sees entries from a different swap device. That swap
device might be ZRAM where VMA readahead is not helpful.

How do you think?

