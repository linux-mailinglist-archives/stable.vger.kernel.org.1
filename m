Return-Path: <stable+bounces-50186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE2904802
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EC4285939
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA8EA4;
	Wed, 12 Jun 2024 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktHC0z2U"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39FEBB
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718152271; cv=none; b=S9lpBlqu4+ueLLdgRbLEXndYWjOA0zt5bQPhrryxlm287EdcQ5wBu1sY/8FPRw9xsHty0Q1IbgUWp0ML4Ct9uqx4mt2Zl+5ntz5UeWwEY6MDxQAizGJ+2XvPHeZqmVMF0mI0hVpRIKh4AuKEewUWBci5WxRYAVZIr+ofv/SUxG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718152271; c=relaxed/simple;
	bh=vGwQi4xh/dE+YXH5OsF/CjbYDz+vdO21Ziy4706Xav0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DwCYE6YYPIibZMJ17cLg1YnPh8r8uLmTtX4jZCBLhMEmy/pxo+yCiFGJqq4JVr+JqpJu1BzGNW7YBbDaoJMgItYyQL1VayVIMI2edLIFXt1ahgme24VgbJfwSVUOKvrBscRLNIbbbwxp3zA5kvXUhGofLa337LJTlXY/+RJn/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktHC0z2U; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a08091c2bso22105077b3.0
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718152268; x=1718757068; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPM5AKKIqzAZMyJyEDbqG2yh4rfSsdBbpGBXHlWAjB8=;
        b=ktHC0z2UC4Tt3NO6h5CFyAJQD9vXSieTWFTCrfuCapL+lzvmEAbwDBJKtJjUTJZEJm
         BSJU2UN/l6TLDEhXT6Vr8KZHeuLQHPBPzOHPmFGQtOFKb9jMvlheCioiQw4YXGAlgZHv
         PGjmTv28+GFLbfHtahWw7vZX7V9hyAitiUQtQN+QEWUs4PasI2lcXzNfrG0p0LoOgp4Z
         FzvKxrUbli4JwifsfqqYWIXceT5+I1usB3zZeR0U+Dfxyl+FDymNeifjfx4uWwDnbLu2
         2Cz0cEhXDLlW3NBCK1CwyAK8+cV1QfWTgLEOhAipFijpI5+pLI6f8QN8F8aRE9r4yfdC
         uOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718152268; x=1718757068;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPM5AKKIqzAZMyJyEDbqG2yh4rfSsdBbpGBXHlWAjB8=;
        b=bix39t8Wft3BWay5eRwZegmR86rC9LF0eYAKAdbQ8KhDGYLfyfTdNbZf1O2DnAt4hj
         MWQmqVoJF3mZ3L5IFzCFamnQM19+0eFmDV5RDlum7rEEzXvLVZCXq04ybc4JvqyHdyCw
         a1I8cfxSZBDbG9lmpHQiOhrb/g+qyj02uuQWMwGhXfeZKgFShVXymNWaCQtgF2w2hNXi
         kyXYRi6acGea89KCLiqNUqYXHUHFcDoDRzmhK/OiAvsDyNsNyk0JNzpQ9sm+KFSSpabe
         jNMDNbUtOz2cDblKowKpKajRlsxu9LgNbFX765JqCY7hnG7vxHaUhtVsidTrkNK4aMx4
         EJhw==
X-Gm-Message-State: AOJu0Yzo83aCpSNmTQJmMqJV6W+Sy29gYZUSYkLNSBGMHGaTLVprzGRR
	ZJwo296iaeFYaD4PsJLGbC/8TyPl87NRA5hafdu1kres64oaoguqiE3PW485aZY6VhtwBRRyE00
	E8vykH8EpQ8GaaZ1/0GrRvHjJgufPtw==
X-Google-Smtp-Source: AGHT+IHv4nL8OTNWAI32NK7eMlQWBUFVhDcy6EBuJOVqj22hpTPIPIUFzCqDAJKqEb8BGC6Wh7E84fLniG8ytiqoI5Q=
X-Received: by 2002:a0d:e6cf:0:b0:62c:e62d:561d with SMTP id
 00721157ae682-62fbb7f5e6fmr2958607b3.1.1718152268015; Tue, 11 Jun 2024
 17:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604004751.3883227-1-leah.rumancik@gmail.com>
In-Reply-To: <20240604004751.3883227-1-leah.rumancik@gmail.com>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Tue, 11 Jun 2024 17:30:57 -0700
Message-ID: <CACzhbgT1VKd6MoYbv6Ep_idbKa-Lcmm_+bJfqKOG05B5xyTWUQ@mail.gmail.com>
Subject: Re: [PATCH 6.1] backport: fix 6.1 backport of changes to fork
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is incomplete so please hold off on this patch for now.

On Mon, Jun 3, 2024 at 5:47=E2=80=AFPM Leah Rumancik <leah.rumancik@gmail.c=
om> wrote:
>
> The original backport didn't move the code to link the vma into the MT
> and also the code to increment the map_count causing ~15 xfstests
> (including ext4/303 generic/051 generic/054 generic/069) to hard fail
> on some platforms. This patch resolves test failures.
>
> Fixes: 0c42f7e039ab ("fork: defer linking file vma until vma is fully ini=
tialized")
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  kernel/fork.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 7e9a5919299b..3b44960b1385 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -668,6 +668,15 @@ static __latent_entropy int dup_mmap(struct mm_struc=
t *mm,
>                 if (is_vm_hugetlb_page(tmp))
>                         hugetlb_dup_vma_private(tmp);
>
> +               /* Link the vma into the MT */
> +               mas.index =3D tmp->vm_start;
> +               mas.last =3D tmp->vm_end - 1;
> +               mas_store(&mas, tmp);
> +               if (mas_is_err(&mas))
> +                       goto fail_nomem_mas_store;
> +
> +               mm->map_count++;
> +
>                 if (tmp->vm_ops && tmp->vm_ops->open)
>                         tmp->vm_ops->open(tmp);
>
> @@ -687,14 +696,6 @@ static __latent_entropy int dup_mmap(struct mm_struc=
t *mm,
>                         i_mmap_unlock_write(mapping);
>                 }
>
> -               /* Link the vma into the MT */
> -               mas.index =3D tmp->vm_start;
> -               mas.last =3D tmp->vm_end - 1;
> -               mas_store(&mas, tmp);
> -               if (mas_is_err(&mas))
> -                       goto fail_nomem_mas_store;
> -
> -               mm->map_count++;
>                 if (!(tmp->vm_flags & VM_WIPEONFORK))
>                         retval =3D copy_page_range(tmp, mpnt);
>
> --
> 2.45.1.288.g0e0cd299f1-goog
>

