Return-Path: <stable+bounces-96171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B79E0DD4
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 22:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77BE16586C
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 21:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA71DF727;
	Mon,  2 Dec 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uir5zYCt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA61DF735;
	Mon,  2 Dec 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174775; cv=none; b=nl2jCAsxULJbRo4eIbxRl/OMo3idU76TksQgHSPO3toTEfCu2CuZSM5pj0mJ00DToYlIKvmcEE0DtQquZ1UvuF/z6u/CM9qxCPo6U1ri0obwqXCUYBjEXChq3z0FNq7qKUReCj+LrzYQ9atMp7xs8id3C5NJcpBSrIvn4cr8iQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174775; c=relaxed/simple;
	bh=vUl+TUNQn8BRz2vomXn/Chbc78pyH2FuMlmF1Jcd/A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngMDzpOnFdwYeoLT8OIOMRlkK/URKZVfTzWLOfB+7bm7C3LDfptB0AHu8qk2Ph5kmzsFTgYISRz1dp6qWSQIhQIhI7OvQ2WlsnLqHrmi4363Zhj9/kvaf6rB3B/kmrQKv5fzxVArQXtxbdFR9PnhApLIjzEDti/5LFY54pMls8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uir5zYCt; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea93311724so557787a91.2;
        Mon, 02 Dec 2024 13:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174772; x=1733779572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2XejICzXArLFcIiyqAnjcmXvCQg/37urb3NpURPZ9s=;
        b=Uir5zYCtGcsgv+0cCWX91GseMQwheVmHdmT6P+GjThsDZGQUWklN4Q89VVDMgVHPGN
         zQ/0dPxK4zaqLMS4PHOhRegqdAIUPCHZbcKNvgjg4bCu/k7LXrnX3QOyJbHBinLrQIu4
         URr3l1bfjqt01RptV+UoYgbUaZerSqu42koucataC9pYLP4nQeKXbIFut9PLdeE3dMlo
         PoHiajwZgLM744qMLPxI5ldpazHdTxLSViKylSIXPCU53vNN61MGLah9WVsqSuuJRM9F
         Ymm+DfgA6O467OEkgSdv5y6GXHxV2arj4YIR6qMdvINzXm14btgDYS3D/bUupwflCdf0
         M8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174772; x=1733779572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2XejICzXArLFcIiyqAnjcmXvCQg/37urb3NpURPZ9s=;
        b=kjS+/cQZX6XITV+bjmV8MF9tqTTeorRDjTG3anEBVDyiogHhA+j/uTrj/M0zQjJbsY
         91Ybcd/jBc3+737/qINdMk2HXmJMs+8I3OC4zvSXaKuEPkVzxvQkrz8eGXBc0QMTqXtf
         AT9hwThEax9FJPubBCFj68l9LxTpblW2TpXpPPX3Q0Hxe2RsoumuyJLuSVlBRECL3e1v
         mVaYCj7lRZwsEZRnvz6fYQFd2feF2EHD4b+LP31QKkfRgrWIu7rK/uOHEtmgFEw/NtPy
         tvPnaD0rvpNA+20COzppdGPE1o/RmjMfuCvENC8H4WvUcSE4sReFJ7v5xPfEr8ipvTp5
         Z/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU/7lUD9+E3wttJgxkCwx49zYEylHd/DNyK1FTnQCiQkG0pWEUSJCn+navdMa0no2Wp1/1dPMJQ@vger.kernel.org, AJvYcCXe51Ve3Is/cI1T67kN7p8fLKqWagIAlD2FTrvjnmFfU2veES/VRUCdusRYFXNkWKf64hJ2CxggaYWSSH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNmpbtWAnmfwMXgslFWGJGudd1HXolRUTDnznlajBeuU6eQIU
	FEIWu5SfdZAQb5N182IFPvt2bKc17MjIQp6jTmG83cPyVRnRXCqaA/rwwWnKb7UEHY6fKGXsb9j
	5uUhdlJvi6r+CRt2M1YYydJrJkvI=
X-Gm-Gg: ASbGncvpPedgyeq03O0+9sd8jHXYC6NVl5fONXz62XtYF20pF36jGux8D0psEsk5Sua
	Jz3oIlQ9kIhC4ynHlLsFY4lECN2PGU1U=
X-Google-Smtp-Source: AGHT+IEXlg13b3ifBskkGZwkW8PNP/lLn1940BLZpT4v8S4oGQtGrOYide0iHSNd5F3UBGsaESmbS8Zb3m9xuMOOjqk=
X-Received: by 2002:a17:90b:4c10:b0:2ee:3fa7:ef23 with SMTP id
 98e67ed59e1d1-2ef01288ba7mr20504a91.8.1733174772464; Mon, 02 Dec 2024
 13:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202080043.5343-1-sid@itb.spb.ru>
In-Reply-To: <20241202080043.5343-1-sid@itb.spb.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Dec 2024 16:26:01 -0500
Message-ID: <CADnq5_PTvhr=Wz2OBPthKwM3nsshfq0679VoN-pqPk1H+dZtJQ@mail.gmail.com>
Subject: Re: [PATCH] drm: amd: Fix potential NULL pointer dereference in atomctrl_get_smc_sclk_range_table
To: Ivan Stepchenko <sid@itb.spb.ru>
Cc: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tim Huang <Tim.Huang@amd.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Alexander Richards <electrodeyt@gmail.com>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Jesse Zhang <jesse.zhang@amd.com>, 
	Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, lvc-project@linuxtesting.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 3:27=E2=80=AFAM Ivan Stepchenko <sid@itb.spb.ru> wro=
te:
>
> The function atomctrl_get_smc_sclk_range_table() does not check the retur=
n
> value of smu_atom_get_data_table(). If smu_atom_get_data_table() fails to
> retrieve SMU_Info table, it returns NULL which is later dereferenced.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>

In practice this should never happen as this code only gets called on
polaris chips and the vbios data table will always be present on those
chips.  That said, I've applied it to align with the logic for other
functions in this file.

Thanks,

Alex

> Fixes: a23eefa2f461 ("drm/amd/powerplay: enable dpm for baffin.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ivan Stepchenko <sid@itb.spb.ru>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index fe24219c3bf4..4bd92fd782be 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -992,6 +992,8 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwmgr=
 *hwmgr, struct pp_atom_ctr
>                         GetIndexIntoMasterTable(DATA, SMU_Info),
>                         &size, &frev, &crev);
>
> +       if (!psmu_info)
> +               return -EINVAL;
>
>         for (i =3D 0; i < psmu_info->ucSclkEntryNum; i++) {
>                 table->entry[i].ucVco_setting =3D psmu_info->asSclkFcwRan=
geEntry[i].ucVco_setting;
> --
> 2.34.1
>

