Return-Path: <stable+bounces-50187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5759904803
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B66B285944
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 00:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9046CEA4;
	Wed, 12 Jun 2024 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7qgS421"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFDD10E6
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718152298; cv=none; b=m/ujhIECetO99EKBTS4//CPdY5JszIYcR+bN7+MW9uVOthSB8fKLtDJuxG7aeoH7XzXMqKZQx8kj+ie/t4oKZqQIpTE798P/zD4Fi5Xt8hxzNjzfMLfGlOlCe3JiAeAJU36Ue3CNWvJ0UUIMp/+E+j91AGoMoKFAYzxO7vCwxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718152298; c=relaxed/simple;
	bh=X0iRHgSHadERH7skav6XYECcquIoIcn/GVmhRptUGTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jPCnzMkgBfGAgSXLEtFJWNxmCZUpLE9CBOeOtEzPpFLTbwLhUhhCDHYK7rIEQABhKkRPtgF58aI4wFD9GuvDin/yhc2Aev5tuHLJMRz2yCDw9wh5iE9sH50E7TKxRal8bZGxC+so/fbu2o60w/H3N2zIIF7+PBqy5wcCNaiRR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7qgS421; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfb12fe6f96so3432442276.1
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 17:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718152296; x=1718757096; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dicUC8nVSwYgS++hKHdSQwP7k+YbySZtkkrHXyZZtWQ=;
        b=i7qgS4215B/JikZ7i0QBj+hGsrTP+wCBXb+MGBEFnsOy1LtzxZ+31NxM+lhEOuiHtB
         SIE92rulwMemCSf+YYD4kTLCOvED0LK1U1XKn8UiOYkgfDDvQmqWj5uCKZvCTpdSk5q0
         fFN+eR+BXO3UPWi1HvP4GeKyIM7HNFUKOJU5iDRjpy0kUA1hGtk9IefsflXB+boRcdiN
         ZweMxWTbJ1DQbed75BFIJPJXHZshWUz56Nd80XHkbTaK9sSzsysTToknOLrxhwdm2Icd
         7eMnjLnt/hrXD/25tP+61sF8S8wbEkF9jsgDcfx9H0D89xT15akkIJM5jvNHCpFQGDbK
         Iz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718152296; x=1718757096;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dicUC8nVSwYgS++hKHdSQwP7k+YbySZtkkrHXyZZtWQ=;
        b=Pty1E3nbCjt8IjZfVcgrx/zxYb1DjMX9NgMApw9/eCl8NSKLMRfJbgTtfcUMfFUqZM
         lUGHNUM4o8glc/f9Hr/E2TR6oI7IG1YYGXtNCM3Pnc7acD6z9U1AsmDkNag0YXiWDzWQ
         eGLS8G9Hjx1cqzf3NeODdDeEh5eC2dZtMjgCxcW5Un5YCrKrMsG0rabJ/KJIBbTqNxBK
         66b3thKGavcbhnqDPyOsApAKBGWRpVfeTEZVQSPCYzvFW4cwIFeVtkJkLCEZRAUNpXEk
         JqrQVRhqS/j74nSmR7CJoGEodGEtt4gaTOtFgzwW13V567zLl+C3J+FBVfqFBt0sT8OI
         tp9A==
X-Gm-Message-State: AOJu0Yw+jFiPySg3FOGCKC0aHcyPZPsDzGcEHhbqL2xoNoqEFGjY8p47
	Ko0ChbOVzrBj0+QXIIcn+hnFf+CYCV5G6H87HHsffQi3ZWpffYbQMf2kOAPk9ERe7Pa87pShXXf
	X8O33GRG+JRxGAupGkwqGYarNlytsjkbB
X-Google-Smtp-Source: AGHT+IEPjMOph9Xhai/xRRErDOQwOR+ogKeelt831HgluaASntGmAdlAoRXHkfIBRUMUN0G1apWxhpycLEvZrNo+V+I=
X-Received: by 2002:a25:18a:0:b0:dfd:cc57:e043 with SMTP id
 3f1490d57ef6-dfe65f7543amr244608276.6.1718152295549; Tue, 11 Jun 2024
 17:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603232530.3801675-1-leah.rumancik@gmail.com>
In-Reply-To: <20240603232530.3801675-1-leah.rumancik@gmail.com>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Tue, 11 Jun 2024 17:31:25 -0700
Message-ID: <CACzhbgRjDNkpaQOYsUN+v+jn3E2DVxX0Q4WuQWNjfwEx4Fps6g@mail.gmail.com>
Subject: Re: [PATCH 6.6] backport: fix 6.6 backport of changes to fork
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Same for this one, incomplete so please hold off on this patch for now.

On Mon, Jun 3, 2024 at 4:25=E2=80=AFPM Leah Rumancik <leah.rumancik@gmail.c=
om> wrote:
>
> The original backport didn't move the code to link the vma into the MT
> and also the code to increment the map_count causing ~15 xfstests
> (including ext4/303 generic/051 generic/054 generic/069) to hard fail
> on some platforms. This patch resolves test failures.
>
> Fixes: cec11fa2eb51 ("fork: defer linking file vma until vma is fully ini=
tialized")
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  kernel/fork.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2eab916b504b..3bf0203c2195 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -733,6 +733,12 @@ static __latent_entropy int dup_mmap(struct mm_struc=
t *mm,
>                 if (is_vm_hugetlb_page(tmp))
>                         hugetlb_dup_vma_private(tmp);
>
> +               /* Link the vma into the MT */
> +               if (vma_iter_bulk_store(&vmi, tmp))
> +                       goto fail_nomem_vmi_store;
> +
> +               mm->map_count++;
> +
>                 if (tmp->vm_ops && tmp->vm_ops->open)
>                         tmp->vm_ops->open(tmp);
>
> @@ -752,11 +758,6 @@ static __latent_entropy int dup_mmap(struct mm_struc=
t *mm,
>                         i_mmap_unlock_write(mapping);
>                 }
>
> -               /* Link the vma into the MT */
> -               if (vma_iter_bulk_store(&vmi, tmp))
> -                       goto fail_nomem_vmi_store;
> -
> -               mm->map_count++;
>                 if (!(tmp->vm_flags & VM_WIPEONFORK))
>                         retval =3D copy_page_range(tmp, mpnt);
>
> --
> 2.45.1.288.g0e0cd299f1-goog
>

