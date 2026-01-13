Return-Path: <stable+bounces-208260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 166F4D17E33
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 11:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F41993014117
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 10:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D93876C4;
	Tue, 13 Jan 2026 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBTvMcXM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4838A2A7
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299068; cv=none; b=kIY/rp4ZX+GKJBHuWKmEITm7sxsdq9ftENtvMNx/RKWrmi6DCn8LwkaDPB6TgadUOZV28w8HZmj+t245YiQq1RncFY65vaSN9vdrWk/8SCgsyNaZlASmMl0ACzTIkLBwR+APUMiOHsrftd7J6fMHL9np6ijejDXuBj52OLHbdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299068; c=relaxed/simple;
	bh=NkX37h2YMDNXkIH9xZy+UnxbGDXR+NsBOmrOH33TfLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2zkrHHE6uzFb5LKzwWABMCH8djW++yXgW0LFjbg6nGkAfA3HFj38RczDf5etufTWU/Er+gRM8F+3lmpCwFuMQNHacJx9X8o1GTvkUPRVmpsoCVv2wSVhm4YcK/CFJ6bOcOVEEkCkBWjRgsqBcSn8NptRCZQoHfkByadjTTXNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBTvMcXM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8707005183so363021166b.0
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 02:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768299066; x=1768903866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhwdsNSIXIbaUSh+z+YEwKaaf4OYjc6xkjJXOa/xwrc=;
        b=KBTvMcXMal6zfax+RzqVDF6xkXU7BXGDVz+t0vMEv13EdPehGDVm2Y3X9Hdn766ykJ
         uTRyum+MAXIeNAevpx77RkEvK5oiIEsDc2qogYVjRrzubXGuR/GzgO+4F6M3KblAzSAs
         r7tOPK6dqMYDKuYWb9l/9/IvXrCQWTawxOyjA7xrQr/PYPvfBLhMy2rq0ukzMObVRpvu
         7YiHkASuKpivWwJIEwK9SDWTGyog7oAsdR98/f5jgsnzkS4C4ygzAum3zS4RJ2NrykPJ
         lqzcMNqESMMOtz5MEF0x9cIdy9eCcVwNXgmD/FuIpeQnRHLwcU4wShHumi4Wj/x5dH7X
         IUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768299066; x=1768903866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhwdsNSIXIbaUSh+z+YEwKaaf4OYjc6xkjJXOa/xwrc=;
        b=oR8+7kZ4yQsBa8m8STWFq5FsdGNjGWm+R06FfYgqX3W37VxnMQB0PZVEHygCpA2f3U
         JwhDObiX1VdtybqT5pla+d2mNo97y7TvO8kFJMPXcic/EANyErgrw66AhLTyTkJ3vxzU
         FsAWQSnsrgEVqz3qSy+K5uIw89+3kYjHYGeVpX4SZvatDNMXrkTPnar1M7gO5mB2v1P4
         weG77N1xsaJ2Qk0woqozhcvqUauFK7eV6nLliL3teGIp4es5uP3cp/4gw/P6/0KlBk9k
         0N71PKXSwFAscJyzKq5K7R0Rjr+3wcRiE9jrwoRlSF7xQxF8zbQRVylyxTs6jeMeUro+
         5EgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGaO3DMtG7XmBJm9in92IEDorRvG3jKyZan9DRdnRFLxgejHKGRQWae0YYFAkUGPf4TIwJBSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoxOEFOZjLyQ4luOLlCK1DTRCO6HsMNHAbl1gdfXHRk2WmNVzB
	GmVI34770+B1SWhgRVgEKazdvf8VEzGt1wlWyUo/NwtMWmVhassw9c8CT0A306wM6VUSXjlswa7
	BxsJwYuqWJu9MEkUJfupOSzwEFtuXT6U=
X-Gm-Gg: AY/fxX47ivaH8Yi9rXZ+2PGhiXw/8Lq2zMAnxSgvIkrTvDcHdz1QytYQyXV4IXxGrjU
	2IRRU/CqD6b63XxGud8dG8FLoecqinxFSOD3U/9ynbvsN61qfLSUxPnDwWTmXpvcGdR/RePZbno
	7zmdzBbAv09tJ4MuK60f4Bh4RWqXR5LmCYNLMjNgxFrkzsWz4PTwy7U2tIB7BwbGid5Hpxci2AO
	foNpzMzy9oib2cGOhYILb/0AWX7V0f8IhkkF9nb4pHZYlvln3A4MaXyx9lnVzp/5pqL7me6qivJ
	SB95PWkG3i/5hgDegCJL8BXUDYBQ
X-Google-Smtp-Source: AGHT+IG8nDMuMXGfVeKqpMCZnsQOH/yz01ostDNqxQirjqiwcV4e0MoqHe3mJyooKErDq5lHg+urzMnrBlkG6KaxQWA=
X-Received: by 2002:a17:907:cd07:b0:b87:24e1:1a4c with SMTP id
 a640c23a62f3a-b8724e126cemr380790366b.35.1768299065444; Tue, 13 Jan 2026
 02:11:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com>
 <d20f536c-edc1-42a0-9978-13918d39ecba@linux.alibaba.com> <CAMgjq7ASxBdAakd_3J3O-nPysArLruGO-j4rCHg6OFvvNq7f0g@mail.gmail.com>
 <1dffe6b1-7a89-4468-8101-35922231f3a6@linux.alibaba.com> <CAMgjq7Biq9nB_waZeWW+iJUa9Pj+paSSrke-tmnB=-3uY8k2VA@mail.gmail.com>
 <d95f9ea4-aa47-4d85-9b76-11afd0fb3ee7@linux.alibaba.com>
In-Reply-To: <d95f9ea4-aa47-4d85-9b76-11afd0fb3ee7@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 13 Jan 2026 18:10:28 +0800
X-Gm-Features: AZwV_QiLPLQrDBWAFzoULxVjWOBFLZ4KBEQ7aukTazW3S2GoIToz6cLvTx3o_yU
Message-ID: <CAMgjq7DrrCx78K3uccsfpGeQfC-_+LuONSefJ+Vd+aCjyncwKw@mail.gmail.com>
Subject: Re: [PATCH] mm/shmem, swap: fix race of truncate and swap entry split
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 3:16=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Hi Kairui,
>
> Sorry for late reply.

No problem, I was also quite busy with other works :)

>
> Yes, so I just mentioned your swapoff case.
>
> >> Actually, the real question is how to handle the case where a large sw=
ap
> >> entry happens to cross the 'end' when calling shmem_truncate_range(). =
If
> >> the shmem mapping stores a folio, we would split that large folio by
> >> truncate_inode_partial_folio(). If the shmem mapping stores a large sw=
ap
> >> entry, then as you noted, the truncation range can indeed exceed the '=
end'.
> >>
> >> But with your change, that large swap entry would not be truncated, an=
d
> >> I=E2=80=99m not sure whether that might cause other issues. Perhaps th=
e best
> >> approach is to first split the large swap entry and only truncate the
> >> swap entries within the 'end' boundary like the
> >> truncate_inode_partial_folio() does.
> >
> > Right... I was thinking that the shmem_undo_range iterates the undo
> > range twice IIUC, in the second try it will retry if shmem_free_swap
> > returns 0:
> >
> > swaps_freed =3D shmem_free_swap(mapping, indices[i], end - indices[i], =
folio);
> > if (!swaps_freed) {
> >      /* Swap was replaced by page: retry */
> >      index =3D indices[i];
> >      break;
> > }
> >
> > So I thought shmem_free_swap returning 0 is good enough. Which is not,
> > it may cause the second loop to retry forever.
>
> After further investigation, I think your original fix seems to be the
> right direction, as the second loop=E2=80=99s find_lock_entries() will fi=
lter
> out large swap entries crossing the 'end' boundary. Sorry for noise.
>
> See the code in find_lock_entries() (Thanks to Hugh:))
>
>         } else {
>                 nr =3D 1 << xas_get_order(&xas);
>                 base =3D xas.xa_index & ~(nr - 1);
>                 /* Omit order>0 value which begins before the start */
>                 if (base < *start)
>                         continue;
>                 /* Omit order>0 value which extends beyond the end */
>                 if (base + nr - 1 > end)
>                         break;
>         }
>
> Then the shmem_get_partial_folio() will swap-in the large swap entry and
> split the large folio which crosses the 'end' boundary.

Right, thanks for the info.

But what about find_get_entries under whole_folios? Even though a
large entry is splitted before that, a new large entry that crosses
`end` could appear after that and before find_get_entries, and return
by find_get_entries.

I think we could just skip large entries that cross `end` in the
second loop, since if the entry exists before truncate, it must have
been split. We can ignore newly appeared entries.

If that's OK I can send two patches, one to ignore the large entries
in the second loop, one to fix shmem_free_swap following your
suggestion in this reply.

