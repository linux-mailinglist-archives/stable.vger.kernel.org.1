Return-Path: <stable+bounces-204498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6ADCEF157
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 18:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E70300ACD0
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A932ECE97;
	Fri,  2 Jan 2026 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAnNrqvp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B662E9EAE
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767375768; cv=none; b=t/iz4SkuFFFogJcxaKtR2ImHzyYMwnhIMjX/IY9ezX6Lcur+9kSDH7mq7K4Rdt/Rosa1tmWwPDTBemgxSv+5mrf8m06u3LjpCeWLaekO9BrseiTuyHG0SsPFRTck2FPOBsrjuFxXp86tfM0fz9QX/m04Dttb9EzHDnl9lSA2O70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767375768; c=relaxed/simple;
	bh=rsxFLkkh44pkPJZT73BcC9nhTJZbYI3ToU2uQHHHqJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPtLawCEdhCqBZLkueaCsWgXTBSKru8yK3ugkiLAncwzXFTWItgPNCwg1VST1erXsFoAtaCCDriNuAyspCKdIhhs3a5g0ZkpCYpftEG460MByVrB80HZOnpVJia+axT1j9LYLlc+B5xsRnzhwqNMJPOElkEP2qwR5LPuc1hgnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAnNrqvp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso141775951cf.0
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 09:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767375766; x=1767980566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0X43tzsEjAIkMG5nHwHs/LKFKaM5iOATeWa21x7UkM=;
        b=iAnNrqvpRMUnHZHf8F68+vd7F7uSJvJykVdk8Rw+1ad+T/8xiXcuhBTny1pNACBKUm
         +DsTWWCbvHcxJNeq4QRKMQWEgYThnHjyl4hti3s2EGZbS3DHCcPWJ7un4gF0QQ3w4nyl
         pK0KXwGyipoCPq3gHmOKUSDnZmhNqPiMZ9V4YZMwEU4UnYQZ6756VaJu0LO7L42KUl45
         rGW/uH667QnLgc0MIXEPN1KSv6F2MXOXZja/nHoPbXf2Xe5vBQpJ76Zq4sWtXkQgEQt+
         Izi6Y8eiykPw3T3Y0MvG/M1naR9ACFt7516C3Vpjj8dqDAjOmz0w8qPN/5d/Y6R4lTrE
         bRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767375766; x=1767980566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0X43tzsEjAIkMG5nHwHs/LKFKaM5iOATeWa21x7UkM=;
        b=XyoXJ/HVJGQksLsXCArbu5RaIo2hpSiFnZ6v2aAPEN3cmyP5/EZ9Kdj10CN1QMT7qg
         3ymv+EL+Vejgo5qvXPHFLmTUBTIFomfIl/yzN3OhTFQpd3Nicd2ZrTNfilcsDBaNhnwm
         +jr8HGApZavSejbjMhDU/zstiij5tJGoCf+Jc5xzXQM+OjOcc9ShG31P2wl92JzadOYS
         q7sXEeOUCCNTrRb2uqKSVkqJRMTmibDm+/mFtBMYtmj9HeW0LkT3ByCjyXGy2FcZiISo
         9yEnZ5BL1B54jKdH53eL8QBb4mEN007/rPhs4YzkQSHCoNETztomclcWml5/StGImWf1
         fOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUigd99N0dK4/6nAi1hrtsslwvPgK/nj0KfQax+B7jiwanyrEaFXlOREBPpE2NpiU3kcvmx0W4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hQ41BLifTl15Gc/dyYYoCbwUp08e5ok2y3fxeDCpSLLWOr0p
	jt0p8gRYIAb2pkYv5ziyKZNLdx3mZ8Ocvk9n8VI4bM6XLOR1VXUKzI+fAXxVlBk2vhzwMrXT/9b
	l+1EN+gjSL5L+5+CLWTDycy310l0O15E=
X-Gm-Gg: AY/fxX7eyCF9+j9dPAm1R7N3/V8J6+Y9o05FtUY6dyt66x60Ou54391+TSy+5wvhOVs
	WL45JjGkWveDSNUmaVYGpBsc8Iq2lfco9QWrX35s8iHZ02A3tXBlOoPhX7GVWy8xka4KYr7kwMC
	xMgaoHZ6qoMYwRZeIGREHV1OX9M32Ul86SZjy5cwsL/caQ6HVPhB6SmRjoB6jT1yrvyGlDdrpIa
	ZpTn5gSP/3EV3cgloNX53osHii+T+y1/I5qWEUUng5PVMwtFrLBOpGwPA8nsBIFvfSKYw==
X-Google-Smtp-Source: AGHT+IHTCGFABNwPrRSP04C0uqspZoW3b8+qyuNDvY7nmDU36AGNpQ6R94yX7G4K3JG83u9w3TG9d+djwu3dA02k8LU=
X-Received: by 2002:a05:622a:1c0b:b0:4e7:2dac:95b7 with SMTP id
 d75a77b69052e-4f4abd2b668mr721175471cf.37.1767375766098; Fri, 02 Jan 2026
 09:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com> <20251215030043.1431306-2-joannelkoong@gmail.com>
In-Reply-To: <20251215030043.1431306-2-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 2 Jan 2026 09:42:34 -0800
X-Gm-Features: AQt7F2ohaHF2UIzgTLkq0qp5Sg4UKfGxsYKPSUC_Kd08WY71gAokum3IjvOCHyE
Message-ID: <CAJnrk1ajqa4+GNgXNNyZ4sfpsyr3fcO15FH2CiTipyeMoVyT1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: akpm@linux-foundation.org
Cc: david@redhat.com, miklos@szeredi.hu, linux-mm@kvack.org, 
	athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, carnil@debian.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 7:05=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Skip waiting on writeback for inodes that belong to mappings that do not
> have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
> mapping flag).
>
> This restores fuse back to prior behavior where syncs are no-ops. This
> is needed because otherwise, if a system is running a faulty fuse
> server that does not reply to issued write requests, this will cause
> wait_sb_inodes() to wait forever.
>
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal =
rb tree")
> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> Reported-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Hi Andrew,

This patch fixes a user regression that's been reported a few times
upstream [1][2]. Bernd (who works on fuse) has given his Reviewed-by
for the changes and J. has verified that it fixes the issues he saw.
Is there anything else needed to move this patch forward?

Thanks,
Joanne

[1] https://lore.kernel.org/regressions/mwBOip3XK77dn-UJtlk-uQ1N6i3nwsKticZ=
yQdPYzQcsk0dsjXl4oOAh-Neoxv-0TlpKnt_FEJwx8ses5VJglGLJUW-bIG8KWchtoDwCnnA=3D=
@protonmail.com/
[2] https://lore.kernel.org/linux-fsdevel/aT7JRqhUvZvfUQlV@eldamar.lan/




> ---
>  fs/fs-writeback.c       |  3 ++-
>  fs/fuse/file.c          |  4 +++-
>  include/linux/pagemap.h | 11 +++++++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6800886c4d10..ab2e279ed3c2 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb)
>                  * do not have the mapping lock. Skip it here, wb complet=
ion
>                  * will remove it.
>                  */
> -               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> +               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> +                   mapping_no_data_integrity(mapping))
>                         continue;
>
>                 spin_unlock_irq(&sb->s_inode_wblist_lock);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..3b2a171e652f 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3200,8 +3200,10 @@ void fuse_init_file_inode(struct inode *inode, uns=
igned int flags)
>
>         inode->i_fop =3D &fuse_file_operations;
>         inode->i_data.a_ops =3D &fuse_file_aops;
> -       if (fc->writeback_cache)
> +       if (fc->writeback_cache) {
>                 mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_d=
ata);
> +               mapping_set_no_data_integrity(&inode->i_data);
> +       }
>
>         INIT_LIST_HEAD(&fi->write_files);
>         INIT_LIST_HEAD(&fi->queued_writes);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 31a848485ad9..ec442af3f886 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>         AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
>         AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file that =
shouldn't
>                                    account usage to user cgroups */
> +       AS_NO_DATA_INTEGRITY =3D 11, /* no data integrity guarantees */
>         /* Bits 16-25 are used for FOLIO_ORDER */
>         AS_FOLIO_ORDER_BITS =3D 5,
>         AS_FOLIO_ORDER_MIN =3D 16,
> @@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_on=
_reclaim(const struct addres
>         return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->f=
lags);
>  }
>
> +static inline void mapping_set_no_data_integrity(struct address_space *m=
apping)
> +{
> +       set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> +}
> +
> +static inline bool mapping_no_data_integrity(const struct address_space =
*mapping)
> +{
> +       return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(const struct address_space *mapping=
)
>  {
>         return mapping->gfp_mask;
> --
> 2.47.3
>

