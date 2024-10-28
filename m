Return-Path: <stable+bounces-89124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D532F9B3C28
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 21:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761B01F22E09
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0541D1E0B6E;
	Mon, 28 Oct 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpPtMH1Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706718D649;
	Mon, 28 Oct 2024 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148364; cv=none; b=A/LVqJ745oOe/PVTqnQGy0OpsbhIPAQ3Ie3GZHxlHkuG2UWRsNMOV32M97pljZdrYXuTsWHu82CycTmVMRc0n+Z8CIOX7xrWJGytr8hIo3vqAkw68BK5+0FkzMJ9DTDKjx00+L8KWcqltvYHkXmWfaBV3DRPasJoV24vCdU7sTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148364; c=relaxed/simple;
	bh=itesG2RvWuf28etNXsbQmQFizk4AbMZdb9m4C5OrjG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsYflXytIG/wEYoRB8VZ6pjBaDU/ov8I3E16qCeDeTwYv8Xd1Xrods47gowkaz6JSHhDZKSX7+9+0mIJNpCajwtxQfeLmSC92Thh6uG5cbz83EmYsC2lT03t7rYXfmeFbsJLeLumuVS0RJHUCPBZDBieObzxhRHEh8k/TbBWxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpPtMH1Y; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0cee600aso618204366b.1;
        Mon, 28 Oct 2024 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730148361; x=1730753161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJWfDKwlLmshZFu5aw8CBvAgMnKUr0ALhBZ22yCGjZ4=;
        b=BpPtMH1Y+6jiUnkpnZ5yDjETWag3BvXpWxkfkgrEbzQFa9eee15WLwSv3g8u25qhLi
         dNc01+vYNzYYptwbL9aNyfRwNmE/GLnax4TwrwxCZZfCT44I5oXosED0IPV/EmVEbYm+
         WzSnePPM6jkLwfyObNHZv3Y71mjMCoDPRR9EzfitLYeNF8GBAwb/RpyenWF/N+pDrDgG
         ovAUtTiT5Md5DSFttB2Ulhp39IH9ZPd5CtWDPLx2SkWihP1HJ0TCWIsGB/Pgs6eM1QAh
         AS2X6goxRZGpbS5VEI9H1TWUPBSi3Aenb7fqQkBiLshw23d+zmDacmlhVwxvm2AA3vc+
         dVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148361; x=1730753161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJWfDKwlLmshZFu5aw8CBvAgMnKUr0ALhBZ22yCGjZ4=;
        b=K1Tkla3DZ0CXq7kt4M8OnTSCEpQ6MtqjNpnMbP8wW//u8qkWdLBKP+17PjBhR1zpPD
         6iR8uP9hRp5N1syHJAtLw2WgPhZPTbAabbDpKFWlCOZLkZZeQtpAv10NLpXNvhUE1BW3
         ZMyRxazp5qqylSOBw/K2LOtzsEcvTnP9cD5qM4DuSngX0uHLcI+jAmoWGnwpI3ogv5es
         k6YMqMGwkI9HOB+LPVPF7N4AALdpmi7kQmApIPfm7eWv1Qla2ODRyUOm1zDH+m4FrB0Y
         QZYAQ0UsvuuDiyaCvfOMz7QkX1NlxFY1pdmSAVL6x2S84iNNm2yPmpcZS4D8SHC3ihCF
         ZtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMvJNr4EtWHDGnYt5QZabXYTVQxJRvOiDTu0RF4VCguLUqja2YV2bwo8yBigV4yLcLosMYTuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQQLue6L3e1WJi4BC5OOX/QO0jIGDzgVru/l5Fsp+kId+zjKGx
	/CLpKpBGOInfLS/ebgafxY+omsQq99Y3VjI/oaijZAt3gi8eB1+0ZLJIFtYXuJHGVVTqqrEODJo
	IuMfrcgoUkzrIWvZm75YUt+ga3Ww=
X-Google-Smtp-Source: AGHT+IFu0/SIJ4+nMuHnai7SSpAJVfjT6SCBj2snSYIIgS3/PpybgZuBVB3RtoBV2tmSRortugcY/M8XDJ1prS7XgRU=
X-Received: by 2002:a17:906:6a1c:b0:a9a:81a3:59bf with SMTP id
 a640c23a62f3a-a9de5f656e6mr1057978466b.35.1730148360606; Mon, 28 Oct 2024
 13:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025141724.17927-1-gourry@gourry.net>
In-Reply-To: <20241025141724.17927-1-gourry@gourry.net>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 28 Oct 2024 13:45:48 -0700
Message-ID: <CAHbLzkqYoHTQz6ifZHuVkWL449EVt9H1v2ukXhS+ExDC2JZMHA@mail.gmail.com>
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, ying.huang@intel.com, weixugc@google.com, 
	dave.hansen@linux.intel.com, osalvador@suse.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 7:17=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> When numa balancing is enabled with demotion, vmscan will call
> migrate_pages when shrinking LRUs.  Successful demotions will
> cause node vmstat numbers to double-decrement, leading to an
> imbalanced page count.  The result is dmesg output like such:
>
> $ cat /proc/sys/vm/stat_refresh
>
> [77383.088417] vmstat_refresh: nr_isolated_anon -103212
> [77383.088417] vmstat_refresh: nr_isolated_file -899642
>
> This negative value may impact compaction and reclaim throttling.
>
> The double-decrement occurs in the migrate_pages path:
>
> caller to shrink_folio_list decrements the count
>   shrink_folio_list
>     demote_folio_list
>       migrate_pages
>         migrate_pages_batch
>           migrate_folio_move
>             migrate_folio_done
>               mod_node_page_state(-ve) <- second decrement
>
> This path happens for SUCCESSFUL migrations, not failures. Typically
> callers to migrate_pages are required to handle putback/accounting for
> failures, but this is already handled in the shrink code.

AFAIK, MGLRU doesn't dec/inc this counter, so it is not
double-decrement for MGLRU. Maybe "imbalance update" is better?
Anyway, it is just a nit. I'd suggest capturing the MGLRU case in the
commit log too.

>
> When accounting for migrations, instead do not decrement the count
> when the migration reason is MR_DEMOTION. As of v6.11, this demotion
> logic is the only source of MR_DEMOTION.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
> Cc: stable@vger.kernel.org

Thanks for catching this. Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 923ea80ba744..e3aac274cf16 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1099,7 +1099,7 @@ static void migrate_folio_done(struct folio *src,
>          * not accounted to NR_ISOLATED_*. They can be recognized
>          * as __folio_test_movable
>          */
> -       if (likely(!__folio_test_movable(src)))
> +       if (likely(!__folio_test_movable(src)) && reason !=3D MR_DEMOTION=
)
>                 mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
>                                     folio_is_file_lru(src), -folio_nr_pag=
es(src));
>
> --
> 2.43.0
>

