Return-Path: <stable+bounces-49920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A531D8FF541
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04BF9B23084
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F5D4AED4;
	Thu,  6 Jun 2024 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfN8T56U"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F215446DB
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702020; cv=none; b=DcBpP1VN4rG+xPTcnQ1WMRO3iswst9SuXk+BNirE+pSQv/B/C4keMhHS8de1UmgoxZTuyee0klrf8cD2BNxGcd9mzJhrdy2ZoQyckYyRMraDoIFbm3DrcFJFQvO7xl7QF3AAOt8A69RxHFI/2Zb775A6fRdl2bhKdtPPHFFdSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702020; c=relaxed/simple;
	bh=dVuS1q5/4ti7TRNqvBw2uyr26mic85V/iOdyK4bX8eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeVwfF6yPJJebq65ZTvIOjw061RPfBKfO500P1ktxXc6jSmvxgj1q8389QLCMr520zs0iWA6YILqhnTK4WThZLq5+z35rZkebnXSDh8kDdZI31tfPS2+IWV+i0cj2CHRJCsTezGKau4zM0yINc9caSVsofXgSilAMKxpWfrtSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfN8T56U; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b962c4bb6so1997107e87.3
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717702015; x=1718306815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55/bLsMNm30oQurGMw7I3lX3MCMyuxr0ITVCYbHOYfI=;
        b=VfN8T56US+dGtEWh4yD1t7cjsVJafwY7jrPTLiDBulx3PlylYMU/NMBRDa9GWcu8gg
         6YMAPdQ2pUu5lf2L3Wkl35pEbA5QirSMx2GQDbakjk2uXyoz9jiXU84RFpjrTBVrhK6w
         KdpnF1+6TDHRMLvp80HSmVRys22uIoL1X4D8qSg8nKgews8pFEahAE3G3FncTWgSy3SS
         ds8GwDlG4MgMljqTQTG4+lR5GFp7RECVQdFNFaQ/ulr8rjaku9MSD7fhnhcEvNEX+i8S
         r06LtPbxeCUs43TCL5f9uNP1vkYTW94z1oPAiWRmRLqfn2FDegwu0/bF7PzCuk0mMvCG
         pD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717702015; x=1718306815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55/bLsMNm30oQurGMw7I3lX3MCMyuxr0ITVCYbHOYfI=;
        b=X6hfGWpqZwzipOBEyAKdOVUCqNnNvPmO5jr/Z/lYkt6ngdAO6ewrxnoKCAQDmqsIpv
         bKEnLC5UphQFFhwKiWGvuv/LGLWZgdOmtj6R4lUBbapZfGJeDX/QTZl2HMbl2v98F2Y1
         klkD24KXJv/UonCqm+tmw5mvUUo3zlz5R9JNisR/TA8TGHuieV/9+vDXDa5OTrckVaN2
         PlB3nziFitoTNku4aW0xZSc1x49yZsTc555nSJpw0oI9DaVSTrqLE+ERDioThZ6Zc5fC
         KVcclk037tHW7WwIS4QnNiQWIA2EYqO4IAWFQsApz5Vx5JM2yS7+Dz0nyTuXD4YqVpUE
         4JXQ==
X-Gm-Message-State: AOJu0YzwcskwsHGLqOvufjCCccH/fIF7DmKTdIAV6fC29A+P/2htania
	O2CTiJ551U6i4WjEPehYJXRh0EpfeYQKyFYEajq197ffFFWhbPNgPZcmdwdFMKH+HM+LOyA/k+u
	W65n6CwHz+9t+sIe0+bjlEMBpHRaneEm1
X-Google-Smtp-Source: AGHT+IGp6KuLE4Vb2JANeb9mqZayOj5Kud47tzVKppZjuSzB0j9DE9Xr5O3L2zSryd3Wk/HmPMV95+Dbh++gTOuLJOw=
X-Received: by 2002:a05:6512:3d9e:b0:52a:f0e7:65ae with SMTP id
 2adb3069b0e04-52bb9fc5dc3mr515278e87.46.1717702015129; Thu, 06 Jun 2024
 12:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org> <20240606131752.295435490@linuxfoundation.org>
In-Reply-To: <20240606131752.295435490@linuxfoundation.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 7 Jun 2024 04:26:38 +0900
Message-ID: <CAKFNMo=+e+tOPQ4r3ZvyO_wCoCoQw9=OErnKFwkQ9qqovDKSMg@mail.gmail.com>
Subject: Re: [PATCH 6.6 617/744] nilfs2: make superblock data array index
 computation sparse friendly
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, kernel test robot <lkp@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 11:22=E2=80=AFPM Greg Kroah-Hartman wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>
> [ Upstream commit 91d743a9c8299de1fc1b47428d8bb4c85face00f ]
>

Hi Greg,

I have twice raised the suspicion that this patch should not be
eligible for stable backport because it is not a bugfix (it just fixes
a false positive sparse warning).  And you dropped it the first time
[1][2].

[1] https://lkml.kernel.org/r/CAKFNMo=3DkyzbvfLrTv8JhuY=3De7-fkjtpL3DvcQ1r+=
RUPPeC4S9A@mail.gmail.com
[2] https://lkml.kernel.org/r/CAKFNMontZ54JxOyK0_xy8P_SfpE0swgq9wiPUErnZ-yr=
O7wOJA@mail.gmail.com

On Tue, May 28, 2024 at 3:28=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
> > This commit fixes the sparse warning output by build "make C=3D1" with
> > the sparse check, but does not fix any operational bugs.
> >
> > Therefore, if fixing a harmless sparse warning does not meet the
> > requirements for backporting to stable trees (I assume it does),
> > please drop it as it is a false positive pickup.  Sorry if the
> > "Fixes:" tag is confusing.
> >
> > The same goes for the same patch queued to other stable-trees.
>
> Now dropped, thanks!
>
> greg k-h

Perhaps due to the confusing Fixes tag, this patch appears to have
been picked up again.
Unless the criteria for its inclusion or exclusion have changed, I
think this was selected by mistake.  Please check.

Thanks,
Ryusuke Konishi


> Upon running sparse, "warning: dubious: x & !y" is output at an array
> index calculation within nilfs_load_super_block().
>
> The calculation is not wrong, but to eliminate the sparse warning, replac=
e
> it with an equivalent calculation.
>
> Also, add a comment to make it easier to understand what the unintuitive
> array index calculation is doing and whether it's correct.
>
> Link: https://lkml.kernel.org/r/20240430080019.4242-3-konishi.ryusuke@gma=
il.com
> Fixes: e339ad31f599 ("nilfs2: introduce secondary super block")
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/nilfs2/the_nilfs.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
> index 71400496ed365..3e3c1d32da180 100644
> --- a/fs/nilfs2/the_nilfs.c
> +++ b/fs/nilfs2/the_nilfs.c
> @@ -592,7 +592,7 @@ static int nilfs_load_super_block(struct the_nilfs *n=
ilfs,
>         struct nilfs_super_block **sbp =3D nilfs->ns_sbp;
>         struct buffer_head **sbh =3D nilfs->ns_sbh;
>         u64 sb2off, devsize =3D bdev_nr_bytes(nilfs->ns_bdev);
> -       int valid[2], swp =3D 0;
> +       int valid[2], swp =3D 0, older;
>
>         if (devsize < NILFS_SEG_MIN_BLOCKS * NILFS_MIN_BLOCK_SIZE + 4096)=
 {
>                 nilfs_err(sb, "device size too small");
> @@ -648,9 +648,25 @@ static int nilfs_load_super_block(struct the_nilfs *=
nilfs,
>         if (swp)
>                 nilfs_swap_super_block(nilfs);
>
> +       /*
> +        * Calculate the array index of the older superblock data.
> +        * If one has been dropped, set index 0 pointing to the remaining=
 one,
> +        * otherwise set index 1 pointing to the old one (including if bo=
th
> +        * are the same).
> +        *
> +        *  Divided case             valid[0]  valid[1]  swp  ->  older
> +        *  -------------------------------------------------------------
> +        *  Both SBs are invalid        0         0       N/A (Error)
> +        *  SB1 is invalid              0         1       1         0
> +        *  SB2 is invalid              1         0       0         0
> +        *  SB2 is newer                1         1       1         0
> +        *  SB2 is older or the same    1         1       0         1
> +        */
> +       older =3D valid[1] ^ swp;
> +
>         nilfs->ns_sbwcount =3D 0;
>         nilfs->ns_sbwtime =3D le64_to_cpu(sbp[0]->s_wtime);
> -       nilfs->ns_prot_seq =3D le64_to_cpu(sbp[valid[1] & !swp]->s_last_s=
eq);
> +       nilfs->ns_prot_seq =3D le64_to_cpu(sbp[older]->s_last_seq);
>         *sbpp =3D sbp[0];
>         return 0;
>  }
> --
> 2.43.0
>
>
>

