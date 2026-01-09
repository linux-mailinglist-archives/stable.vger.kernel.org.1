Return-Path: <stable+bounces-206421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F035D06E76
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 04:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51B2E301A73A
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 03:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A329ACD1;
	Fri,  9 Jan 2026 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPmPvxUB"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A31E1DFC
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927750; cv=none; b=l2Ka891YCVloLnim0L2+egqLHoS/mYRO9bH78vO051NM5113T4Ohxoux1z0gLFo12PVxlgem7TsPjxRJe3zeS1FKOIZa2Vx9392pROi8f0q0+QLL+FS4nKkxF2OPPxgSfRjiwfY6zdm+AlbF/8Deq9UTElwZngbSQMpD2nb+NDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927750; c=relaxed/simple;
	bh=Xz4ZM2I5n6Y9GRsPA0tIedMQuRVDASwlvZES2ZTUjns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onga+oRY5Olr6R6JDs1wBQYVofz3wjmFsChiCJ5m4WAT4E62rWYWbRJEpGSmPww0ELTLIr58GtvyiBQ5e+AxfWustL5AhXb7w7JwfbMqql2snBJBSYrxOELe6SkFsdjBiuOcLN3DP2GqJmRzoZ0CR9jBw57RrjpUeG7HYANbpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPmPvxUB; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11b992954d4so3826081c88.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767927748; x=1768532548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6+t4agQLU4acDLbggczTWiXTVc/FJwjo4CU9QuXnfQ=;
        b=aPmPvxUBv3FluE/3wTgBMFQBj5FC3z2+p+aODwiIQjVwWEDljKPZk2IZ67C+MW6fih
         xzPrU+gG/slJ80ScPQpIYnVruCEm5a2UNryBkmMesQ1RQzX2wrxP/U9aoIDZVy06sRvB
         Qp1K2g16SsPQtPRMB/rFk1EyzwTGdBfBjQ/QtuPEYH5GlGbXRVZqcAQDfu48ps5G+bcu
         CiLwtYXgO1CjilcoRRAINWJyQYcFiX37mg8RJIdl9VJuUFiMukMZfJZkxlKVURVN87g3
         fNlWzWhoVO6gW2AtUt7cJ9hidgtKK5BzN5VKUCPrue9nRmEVQWk64VaI2l8eZc2kGSgY
         hViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767927748; x=1768532548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6+t4agQLU4acDLbggczTWiXTVc/FJwjo4CU9QuXnfQ=;
        b=v318HCFbe5xJPttrzCw03Y4KGvagh+Y5SvCjyw594W99BGcM8q0IWqTcrDkNqWW+XW
         XOZxLqzpmrZ3e49q4qQNBAuWfNahrQnYtT+b14LAaHRD83mGo/g3WpBG5Fu/jgXYVVKS
         aHc9BXK71aisdklNXNwUI+azgli3kzZDb8tOFgdRuIujZStQ7dLNTq5e5TQs7Uy+1yTw
         TMYgdilfTFX2OUHXd5xv+GSvWEqYUqVQFufRP2xhQbT/A7xYRPCthldIcOLpRnp5946N
         bI2j3tZOPoOtuGRTtYqZe9GDweRjtOI57i+7acbYqdLNSD3QR0kvuM8tFLkvk0qafP8M
         CgMw==
X-Forwarded-Encrypted: i=1; AJvYcCWqso9ip9zLQhjLmBWtR8Lvr6qPeLLNrRKn4+7++jbNvKsvamCOsdYYKiahxwtUJtQUSWGjrUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKdFgJWLkOo+Qq6FWNpaDdzZXsHTrM8HPKRbCE477LzggwcJA
	7qaf8nIMqbXdO6ccYe78oeVDzNFVHCW0aP4/53O/zsEU/FHRYHf5t++Kw7dGXupi8lJ8PGJUkaB
	RtV/NgI1xYER6h6oHP457On/IWfXcAms=
X-Gm-Gg: AY/fxX7vINcFuzbcmq/Jfbm5U/fvJyFS79SSMBeFZ6iuqG5kEhlBIrw/f+KLqI+6cgZ
	gpDVtdBT6Aw1rYvLV/HvA3Zvzx1nmNDlQR0kL3MLjaK/kgitvoV3jkajDN+PzoDeEyksG+HJ49V
	C41JNhGo7On1LF+KaGQeqyRJtmcwMC7UbP2vZUM+GKyHSlWg2vR2JjC+Z+wMMhPOcMJrrpSA4ht
	A7inrx+GYCosgDRDosR/lrnqSIQgLLMeCUSnzuuaRDqBE4BOUwZ4KBlToTg5zVXSac9eaG8tTWH
	/spu0eUMxv40W+0XJndjoSLAcA==
X-Google-Smtp-Source: AGHT+IF3rp0TIdvpfSI/j8EZ/b9J74MdEz7nkEo2vIUjsPy/84ARozHwlHEIz3Gfasb+VucKkHVyorWLilWigJOp840=
X-Received: by 2002:a05:7022:112:b0:11b:9386:a37b with SMTP id
 a92af1059eb24-121f8b929c9mr7895281c88.42.1767927747742; Thu, 08 Jan 2026
 19:02:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218025947.36115-1-danisjiang@gmail.com>
In-Reply-To: <20251218025947.36115-1-danisjiang@gmail.com>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Thu, 8 Jan 2026 21:02:16 -0600
X-Gm-Features: AQt7F2qad3xmd4BMt7UysR8oqzLIXBJuNfJDs6KHL6FuxKlZXchgWxJcb_8Sxhk
Message-ID: <CAHYQsXQzAWhpwzqSTGxvWgNXq_=g4V_nsmRGnYeKPumGgAmyXw@mail.gmail.com>
Subject: Re: [PATCH] io_uring/rsrc: fix RLIMIT_MEMLOCK bypass via compound
 page accounting
To: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens, Pavel, and all,

Just a gentle follow-up on this patch below.
Please let me know if there are any concerns or if changes are needed.

Thanks for your time.

Best regards,
Yuhao Jiang

On Wed, Dec 17, 2025 at 9:00=E2=80=AFPM Yuhao Jiang <danisjiang@gmail.com> =
wrote:
>
> When multiple registered buffers share the same compound page, only the
> first buffer accounts for the memory via io_buffer_account_pin(). The
> subsequent buffers skip accounting since headpage_already_acct() returns
> true.
>
> When the first buffer is unregistered, the accounting is decremented,
> but the compound page remains pinned by the remaining buffers. This
> creates a state where pinned memory is not properly accounted against
> RLIMIT_MEMLOCK.
>
> On systems with HugeTLB pages pre-allocated, an unprivileged user can
> exploit this to pin memory beyond RLIMIT_MEMLOCK by cycling buffer
> registrations. The bypass amount is proportional to the number of
> available huge pages, potentially allowing gigabytes of memory to be
> pinned while the kernel accounting shows near-zero.
>
> Fix this by recalculating the actual pages to unaccount when unmapping
> a buffer. For regular pages, always unaccount. For compound pages, only
> unaccount if no other registered buffer references the same compound
> page. This ensures the accounting persists until the last buffer
> referencing the compound page is released.
>
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Fixes: 57bebf807e2a ("io_uring/rsrc: optimise registered huge pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
> ---
>  io_uring/rsrc.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 2 deletions(-)
>
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index a63474b331bf..dcf2340af5a2 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -139,15 +139,80 @@ static void io_free_imu(struct io_ring_ctx *ctx, st=
ruct io_mapped_ubuf *imu)
>                 kvfree(imu);
>  }
>
> +/*
> + * Calculate pages to unaccount when unmapping a buffer. Regular pages a=
re
> + * always counted. Compound pages are only counted if no other registere=
d
> + * buffer references them, ensuring accounting persists until the last u=
ser.
> + */
> +static unsigned long io_buffer_calc_unaccount(struct io_ring_ctx *ctx,
> +                                             struct io_mapped_ubuf *imu)
> +{
> +       struct page *last_hpage =3D NULL;
> +       unsigned long acct =3D 0;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < imu->nr_bvecs; i++) {
> +               struct page *page =3D imu->bvec[i].bv_page;
> +               struct page *hpage;
> +               unsigned int j;
> +
> +               if (!PageCompound(page)) {
> +                       acct++;
> +                       continue;
> +               }
> +
> +               hpage =3D compound_head(page);
> +               if (hpage =3D=3D last_hpage)
> +                       continue;
> +               last_hpage =3D hpage;
> +
> +               /* Check if we already processed this hpage earlier in th=
is buffer */
> +               for (j =3D 0; j < i; j++) {
> +                       if (PageCompound(imu->bvec[j].bv_page) &&
> +                           compound_head(imu->bvec[j].bv_page) =3D=3D hp=
age)
> +                               goto next_hpage;
> +               }
> +
> +               /* Only unaccount if no other buffer references this page=
 */
> +               for (j =3D 0; j < ctx->buf_table.nr; j++) {
> +                       struct io_rsrc_node *node =3D ctx->buf_table.node=
s[j];
> +                       struct io_mapped_ubuf *other;
> +                       unsigned int k;
> +
> +                       if (!node)
> +                               continue;
> +                       other =3D node->buf;
> +                       if (other =3D=3D imu)
> +                               continue;
> +
> +                       for (k =3D 0; k < other->nr_bvecs; k++) {
> +                               struct page *op =3D other->bvec[k].bv_pag=
e;
> +
> +                               if (!PageCompound(op))
> +                                       continue;
> +                               if (compound_head(op) =3D=3D hpage)
> +                                       goto next_hpage;
> +                       }
> +               }
> +               acct +=3D page_size(hpage) >> PAGE_SHIFT;
> +next_hpage:
> +               ;
> +       }
> +       return acct;
> +}
> +
>  static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ub=
uf *imu)
>  {
> +       unsigned long acct;
> +
>         if (unlikely(refcount_read(&imu->refs) > 1)) {
>                 if (!refcount_dec_and_test(&imu->refs))
>                         return;
>         }
>
> -       if (imu->acct_pages)
> -               io_unaccount_mem(ctx->user, ctx->mm_account, imu->acct_pa=
ges);
> +       acct =3D io_buffer_calc_unaccount(ctx, imu);
> +       if (acct)
> +               io_unaccount_mem(ctx->user, ctx->mm_account, acct);
>         imu->release(imu->priv);
>         io_free_imu(ctx, imu);
>  }
> --
> 2.34.1
>

