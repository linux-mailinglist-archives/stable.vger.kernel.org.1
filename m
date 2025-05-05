Return-Path: <stable+bounces-140940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED324AAAC89
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F2F7ACAB4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1973A4364;
	Mon,  5 May 2025 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DTN+iyjK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B42F4F44
	for <stable@vger.kernel.org>; Mon,  5 May 2025 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486962; cv=none; b=gnv0wnBHVEBaA+fu3CFXLdlRJ+0kuarANuiKWnJYPl76uQaeNJexmS6ZeqWwC7IlbS4pHacJCwuZARI9bCZZAbAjm5sPwZMHCzZGpNpaZYWi9b3E7ijDyoSNMNIOox+qH96jZnIS+QZIuHKoDo9/EjHxGZcTTY5SmjMEk257+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486962; c=relaxed/simple;
	bh=krYNUMsEhGAKkDAx01YP/uXWwWJEANf6SSdqIrKdoA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWTkQSuFItuQFUkuyj+OCmAaoKY/ciZS74MGsvfMSJIP88Ecbt+b+96Q3lckfGkiKP2ECtoQFu7szm58ZnD2QFEC2ht594qHf9OVXQmbbiKSirjke0TFD084KDLlpMKQP4n4tznOVIXqJmZrp7q+vlJ9gAaoFuBseVOfa9gXQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DTN+iyjK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30a892f82b3so8263a91.0
        for <stable@vger.kernel.org>; Mon, 05 May 2025 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746486959; x=1747091759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBtLiqsQAZNornH5wgD7b3jJYD105S/GiDk49aEDwGg=;
        b=DTN+iyjKej+zspc8uEMmAzxPt3aoXPTgJKSpIQrsMZ2UfMM+KT/o3I04ETTfGb8jmH
         p3ATOsVKOs146zsOk6NwY9gdymDV7sDXzPLmwNTJGxJQJXOJRftrvj20ajCr3MCjSda+
         J049BfrKJtPBgpdwOdO3dQtL9zovX7bKQlsok+tMqf03JKU93AM8e+zNt8ENnKWnHE7l
         2IR3NRAmZcbbSzC+uiEHuWxDtRNuLGGnLoxB5BWb8AWerThLE7iPTLov4HjLVGFC/EqP
         e6fMSrKXkLLCR/GK/kEPYpnSuEM68VzqolkofbnFCBA9/IGSN+mjswOAzeWFQbMbVvMC
         h1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746486959; x=1747091759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBtLiqsQAZNornH5wgD7b3jJYD105S/GiDk49aEDwGg=;
        b=AE/35ThAhrhMdi5hkU5ykAjfYzhWZ0B72EsrPwe6pOAcixIEH3KS0es+Socs982V0S
         ooT25kxCfwEqlVmg+encRR7fbluXIAfKUQKjwcTLHHfWrZ87mvyamoCBf/q9EtKxyQK4
         2M3hbYFKt+cpk+dbHVb18HWzwFm5ll+cKwxqW/gm9XTS4a9sUmD38NdQ63lcTzVS2pUX
         J1CNp1cnC4u8sx3AFszVwC77YX4nt/GBhqosQeAYbRTyBI1YvXDs/UWUZugFzJ5XGP4W
         vu1OwT0sLNFI+V9MYTieyqNw07E7xdYhGx1H9WYOz2coUdhB02EOqLnc2u7ACNcNPwbv
         z4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrrDd9dMMMIDaZTbpiJyGYJoCU6X7vQZkhkhZotD21Q+kZ8SqP1zZu+ccwCSqmVwwkF4Di8R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQXhWOwbdxv1/fbo/O/SxIOAiE30C3YMLLgXlb+YzbdxWFwAn
	e8IPTMAiW8jAHaYzB0BczgsTI/qJy0CrVNTUy4+ggOK+qG+cEcAgW3l6LOnpfATmXWk1+STyJB9
	MA/rAbOUss+hFfAFshgmnoMcu2GRFHKs3zlsaOg==
X-Gm-Gg: ASbGncvC4zCGwyFlo0E4Jw9JE7ZClj0428tJebzQaP3gw6M3MDQt/fZO4Ph3f9xbB5x
	OM5IprLIWlMyiTThQL7aPCYdJrgKFtYpOSigOzANH7QCpHWDuBA/SLt3aN7q5/T1CA3mKYmSmC8
	xtkLNTEbI9EazLfOU9cC9B
X-Google-Smtp-Source: AGHT+IGagPTPgVx/zK3NsPeBBD10ssAbHcDl4TLAybNA5eLO8eptE6YlSL4cJMULg3pPnx1zFjy8HZWl4F2Kr8E+HKM=
X-Received: by 2002:a17:90b:3842:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-30a4e6aff6bmr7959705a91.7.1746486958763; Mon, 05 May 2025
 16:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505221419.2672473-1-sashal@kernel.org> <20250505221419.2672473-295-sashal@kernel.org>
In-Reply-To: <20250505221419.2672473-295-sashal@kernel.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 5 May 2025 16:15:47 -0700
X-Gm-Features: ATxdqUGHxmzJ-iTUgsy67bI6uusSMYHzrvElI7q_8rFZmVYMhnN19Tk8UkIP6Bo
Message-ID: <CADUfDZqvwhL3Hz7_u+TsO5XrpeWX9dHtbehXUtwbJdyi_GXT_A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 295/642] nvme: map uring_cmd data even if
 address is 0
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Xinyu Zhang <xizhang@purestorage.com>, Jens Axboe <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I wouldn't backport this change to any releases. It's a potential
behavior change if a userspace application was submitting NVMe
passthru commands with a NULL data pointer but nonzero data length and
expecting the data buffer to be ignored. And supporting the data field
set to 0 is only necessary for ublk zero-copy, which is introduced in
6.15.

Best,
Caleb

On Mon, May 5, 2025 at 3:26=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Xinyu Zhang <xizhang@purestorage.com>
>
> [ Upstream commit 99fde895ff56ac2241e7b7b4566731d72f2fdaa7 ]
>
> When using kernel registered bvec fixed buffers, the "address" is
> actually the offset into the bvec rather than userspace address.
> Therefore it can be 0.
>
> We can skip checking whether the address is NULL before mapping
> uring_cmd data. Bad userspace address will be handled properly later when
> the user buffer is imported.
>
> With this patch, we will be able to use the kernel registered bvec fixed
> buffers in io_uring NVMe passthru with ublk zero-copy support.
>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Link: https://lore.kernel.org/r/20250227223916.143006-4-kbusch@meta.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/nvme/host/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index fed6b29098ad3..11509ffd28fb5 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -514,7 +514,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
>                 return PTR_ERR(req);
>         req->timeout =3D d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : =
0;
>
> -       if (d.addr && d.data_len) {
> +       if (d.data_len) {
>                 ret =3D nvme_map_user_request(req, d.addr,
>                         d.data_len, nvme_to_user_ptr(d.metadata),
>                         d.metadata_len, ioucmd, vec);
> --
> 2.39.5
>

