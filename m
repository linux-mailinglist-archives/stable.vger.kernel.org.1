Return-Path: <stable+bounces-245956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBQkAntnA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:46:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ADA526150
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61C98300E4B6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B1E3E075C;
	Tue, 12 May 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Iwo0uzcF"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48A3E0754
	for <stable@vger.kernel.org>; Tue, 12 May 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607986; cv=pass; b=Km/4mb92sgQe8xPcNpjwCn83f7NKslOEuhWg8uvayNrcZrgIvS0eoFvHQfJ8aw1HsQ4LjyDITefht2czCHu2T2prG4UE4KZVaCedIzcskY+aph+4eU90wQTz/K6hwoFIwJ7WUqH/aVd/7b50I4nek/9btXFDwWdF+3r1J7Rz1Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607986; c=relaxed/simple;
	bh=Mrgr6G0kHwIbc8j4jUJh1eocVZ1V3eXYBjlfyutvb4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2zKnjGYBC0mYmQY4bfxyICvUBoAcDYZewLZ0dq4e1OqDMzgDswrfEJudaYqeMZ3V3+PYPhFLg7ISjrGiDJVAM78AhE3FWHbtBX1vOAGcWVZOJa81TSu99PyeDD52sg7f4BQ8Oyyf0gLRjVoEnZSXxUjgbUmxMDDM1989LRLMmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Iwo0uzcF; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-694907f7967so376879eaf.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 10:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778607984; cv=none;
        d=google.com; s=arc-20240605;
        b=OCRpBhe36kEmiO7wE5X5nOHSCWNIE96h1JW5g1DNPeL0vreQ9UUrz6YMB2Ex+FWmg9
         UXwsj1O9ffwect9b5HO59KWH0BqxTuzrxZdtVUQsNxo8QR74aKwmt9vmA1bho+b7a5B/
         ZOTviD101LmfKOgNhN3S/Tf3ySNfrQhZS93qjLGbwJDmyC8RyephTcf5vYHnENdjIZ12
         xiwkAQTtVrzYC8YkjXj6yjVOpWvhj7EHKHqP8W0yWcvqi0v8dIOmojCv0sv+dGZLIOzE
         1UYHI3JM2eIpexHD4qkPuc27ZGYeFl3znytRedVvD+Pvb+SZa0w8Wf0ROQAnECBXEuFF
         kqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DQqZ8jWA6UtiE0JieZxssjde34NvWN5pSABKzZp5lDE=;
        fh=BH/91FvRcQxSX2zB2G0Y8rrjmWM+O8uuEuETCpulcx0=;
        b=Y2l0T62QwybN6wXaWqD/0yLgMtS5PhA6DLzqvwWK7NKDLtI1xAm0NB0D6Xed/J+Km7
         PmUOa829PqbsbBYbyJTtkwbok8vj32mXvPKhvoX0u/O5nLWDU1BpPhU8LeNOJEKBtijC
         U/5K7gjnyoap443TUt84Sl7/iVB84N5MY400LYW6KxlNx82cbOXXAVKRoyuYg6YpwO9z
         GMwOkjAhJAQnWO17Hhzx7tR9Xhe7gspQ2zTNBS8JIbdzXRi4fEl5HTg/nVBlJH7C6Lco
         9x3HNC3dveospyYayP9S0JCkzVj+buwu+xoCus+cIv2a8Wo8+4RTWBbQwp73uKBu0TPM
         wCOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778607984; x=1779212784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQqZ8jWA6UtiE0JieZxssjde34NvWN5pSABKzZp5lDE=;
        b=Iwo0uzcFki397oJwDPOoTKXwX1nbJ21i+0UA23U/HMR1954yhI51NNMAwSbN4+VuAY
         JCXwclucYyC6+XY6eamugvaLMwtAe73F/1ZKE0FMYgABDLRlJmcmbtDv6f8kAsnNyP0B
         GHAQpFkyVIdLRQMF/ttQ/E82YQKEEtPKUGqASLbdD4SlXL6bnDHUOLV4cHdPY5sPegC2
         w5k0PJkKe9L4bz1VFL2llk0m/UghXimx+DsxXv1Woqhqj8X4BL60MgWGjZDp24zc24Tw
         Ydvr5JBrTbMfECbIJnwlkhFqI0o8ZPsq0nKoQekxU1kiixc9vhXp5CKrvxJTJkSzTPHt
         ECmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778607984; x=1779212784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQqZ8jWA6UtiE0JieZxssjde34NvWN5pSABKzZp5lDE=;
        b=gcjd1AWLzL+R+9ABVnXhWVNGxBtn1joI2tBcS2CTTTzryAMK4hvCFZ1BWbIrpeeiX5
         ye8Jyt+VCHnzB6kyJTAt3JhhenK5fleGFsMSlWE/uUtlpgsozFf0NkaVmrwAQHfX8hJB
         mVS8DQiRmVMzvZpjoOPSPRDI4Rjo3ly4qEmMcs5o9zhtxc1KhOz4uFTrxt5HKf6O8jeo
         l1/bzzC2hBmOqBKVVGpaU0yGIS2B2yaH9koDB1QSKU53WUXzskyKVw2bX/W43V7XhBHq
         T5t3rDL1omSt0++CJ5jdikqQ+vqCkljIP9Sp8mZYO1ArWiFNoKzG4Ige4KimyqmGBy1V
         dzFg==
X-Forwarded-Encrypted: i=1; AFNElJ8X5Gpq0tA9KMbypOCUkO6DtVDWWUFIm4/mB/MUARsghaTkXeR+IltGjkw6fqdnvsc1Ubqpn8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzFtGkYF2rDmP9US6vO/C4nIyvMhc9l07CSCP7SBeABBJhnXa
	u+2XVK6h5I79Y2GLibe/aMn/NAonVwGmERErNIRYySTJcECSsNh1FUliSL+Rp3Wg6xmtaAVr9he
	YIWdaQ53A+GrLYXGnL4BNJnw90PJplx9uX3MtY1Ww0w==
X-Gm-Gg: Acq92OGyew66j3K7hutUxjZlidT0IQUnF5C+LS2KdvCSRIclzYtH6uHqAw2Cams40YW
	ogrE7kUFbTkKsxp3Kv5sVXJLcNkCTPvzkBPS/Ox9cwuLKQMc1ajKfkxlJh6Dhhj9fUh5WolTpRz
	eYlCk6Y2BryYXWjwzrNEQ19kJmdZYwg8AhjBWO2emI2KXuhXOqLkuEPgKXJGwc4bRocOOU+Gi5h
	Qmp4ZsU3QC/BmfPobAbaJXF0darRmh6zpRqaNOvLYiw6prBr2y04bcvoZ0JlZsZXMyMKNmzy2VR
	+RmdZzWN
X-Received: by 2002:a4a:ba84:0:b0:696:1d76:9dc with SMTP id
 006d021491bc7-6999a3b813fmr6694789eaf.3.1778607983722; Tue, 12 May 2026
 10:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512170525.357573-1-dmantipov@yandex.ru>
In-Reply-To: <20260512170525.357573-1-dmantipov@yandex.ru>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 12 May 2026 10:46:11 -0700
X-Gm-Features: AVHnY4KWcjBva7nw0Ibsy4xgzTd5kc75h1GtStF_42Kjh1hgALO9DNt1vTHxy7Y
Message-ID: <CADUfDZqnV5BRwZq3c3Atu8w3gOm87AbmtexL=MenWcSbTVOgvw@mail.gmail.com>
Subject: Re: [PATCH v2] lib: free pagelist on error in iov_iter_extract_pages()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org, 
	Fedor Pchelkin <pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 29ADA526150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245956-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[purestorage.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[csander@purestorage.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 10:05=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> Users of 'iov_iter_extract_pages()' may provide small, likely
> stack-allocated, array of pages by itself and then reject to
> use it if it's considered too small. In such a case, passing
> NULL pointer means that 'iov_iter_extract_pages()' should
> allocate array of pages internally (via 'want_pages_array()').
> An overall scenario may be:
>
> ...
> struct page *stack_pages[SMALL];
> struct page **pages =3D stack_pages;
> ...
> if (not_enough_pages(SMALL))
>         pages =3D NULL;

The example is a bit over-complicated, this can just be:
struct page **pages =3D NULL;

> ...
> if (iov_iter_extract_pages(..., &pages, ...) <=3D 0) {
>         /* Even in case of error, new array of pages may be allocated */
>         if (pages !=3D stack_pages)

And these checks could be simplified to just if (pages)

>                 kvfree(pages);                                  [1]
>         /* The rest of error handling and return */
> }
> /* Regular flow */
> ...
> if (pages !=3D stack_pages)
>         kvfree(pages);
> ...
>
> That is, if you're unlucky so SMALL amount of pages wasn't enough and
> new array of pages was allocated, missing [1] causes the memory leak.
>
> Currently 'bio_integrity_map_user()' seems the only place where such
> a leak looks possible. Older kernels may have more. In particular,
> 6.12.x has this type of leak in 'bio_map_user_iov()', and it was
> found with syzkaller and reproduced experimentally.
>
> So adjust 'iov_iter_extract_pages()' to make cleanup [1] itself rather
> than rely on caller's handling on error paths.
>
> Fixes: 7d58fe731028 ("iov_iter: Add a function to extract a page list fro=
m an iterator")
> Cc: stable@vger.kernel.org
> Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: fix commit message and issues observed by Sashiko
> ---
>  lib/iov_iter.c | 54 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 21 deletions(-)
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af7..30c5baccc6a9 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1807,7 +1807,8 @@ static ssize_t iov_iter_extract_user_pages(struct i=
ov_iter *i,
>   *  (*) Use with ITER_DISCARD is not supported as that has no content.
>   *
>   * On success, the function sets *@pages to the new pagelist, if allocat=
ed, and
> - * sets *offset0 to the offset into the first page.
> + * sets *offset0 to the offset into the first page. On error, new pageli=
st
> + * is freed if was allocated, and *@pages sets back to its original valu=
e.

Clarify that "error" includes a length of 0 but not a positive length?

Also not sure it's necessary to say "freed if allocated"; from the
caller's perspective, it just looks like it was never allocated.

>   *
>   * It may also return -ENOMEM and -EFAULT.
>   */
> @@ -1818,31 +1819,42 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i=
,
>                                iov_iter_extraction_t extraction_flags,
>                                size_t *offset0)
>  {
> +       struct page **oldpages =3D *pages;

I think a bool would suffice, as pages will only be allocated if the
initial *pages was NULL.

> +       ssize_t ret;
> +
>         maxsize =3D min_t(size_t, min_t(size_t, maxsize, i->count), MAX_R=
W_COUNT);
>         if (!maxsize)
>                 return 0;
>
>         if (likely(user_backed_iter(i)))
> -               return iov_iter_extract_user_pages(i, pages, maxsize,
> -                                                  maxpages, extraction_f=
lags,
> -                                                  offset0);
> -       if (iov_iter_is_kvec(i))
> -               return iov_iter_extract_kvec_pages(i, pages, maxsize,
> -                                                  maxpages, extraction_f=
lags,
> -                                                  offset0);
> -       if (iov_iter_is_bvec(i))
> -               return iov_iter_extract_bvec_pages(i, pages, maxsize,
> -                                                  maxpages, extraction_f=
lags,
> -                                                  offset0);
> -       if (iov_iter_is_folioq(i))
> -               return iov_iter_extract_folioq_pages(i, pages, maxsize,
> -                                                    maxpages, extraction=
_flags,
> -                                                    offset0);
> -       if (iov_iter_is_xarray(i))
> -               return iov_iter_extract_xarray_pages(i, pages, maxsize,
> -                                                    maxpages, extraction=
_flags,
> -                                                    offset0);
> -       return -EFAULT;
> +               ret =3D iov_iter_extract_user_pages(i, pages, maxsize,
> +                                                 maxpages, extraction_fl=
ags,
> +                                                 offset0);
> +       else if (iov_iter_is_kvec(i))
> +               ret =3D iov_iter_extract_kvec_pages(i, pages, maxsize,
> +                                                 maxpages, extraction_fl=
ags,
> +                                                 offset0);
> +       else if (iov_iter_is_bvec(i))
> +               ret =3D iov_iter_extract_bvec_pages(i, pages, maxsize,
> +                                                 maxpages, extraction_fl=
ags,
> +                                                 offset0);
> +       else if (iov_iter_is_folioq(i))
> +               ret =3D iov_iter_extract_folioq_pages(i, pages, maxsize,
> +                                                   maxpages, extraction_=
flags,
> +                                                   offset0);
> +       else if (iov_iter_is_xarray(i))
> +               ret =3D iov_iter_extract_xarray_pages(i, pages, maxsize,
> +                                                   maxpages, extraction_=
flags,
> +                                                   offset0);
> +       else
> +               ret =3D -EFAULT;
> +
> +       if (unlikely(ret <=3D 0) && *pages && *pages !=3D oldpages) {

The mismatch between ret <=3D 0 here and ret < 0 in
bio_integrity_map_user() would result in a use-after-free in the ret
=3D=3D 0 case, no? I guess this should be fixed by the "block:
bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()" patch
that landed today.

Best,
Caleb

> +               kvfree(*pages);
> +               *pages =3D oldpages;
> +       }
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
>
> --
> 2.54.0
>

