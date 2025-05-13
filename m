Return-Path: <stable+bounces-144209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4292AB5BEB
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A613188304D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A687A1C8632;
	Tue, 13 May 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUSaaSU1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A31A23AD
	for <stable@vger.kernel.org>; Tue, 13 May 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158933; cv=none; b=Hopm8cg7dflBmd1ZRflOIPwzbAuGIDv95WpDgiPKl81S+Mo3RpZvK4yLp1waKlwWdMqU2nc1V0EJnNYNqkFdUnm88eW438HjMCLtBVO6e8dvFsdVAHW7ygiO4PLq56LyJXY7zOHRe88w6IUnRr+48G9dsIB6o2LiSENJicD3omE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158933; c=relaxed/simple;
	bh=PGuhZK0/JSFsPkraVQ1kjEkhy/+TO+a6NFTFbFh/K5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBL6AXhYUVHUGM/wYng7qfj76j4yD/f1zLSx2gcIS74RRB91hy73m4mcbbbIHT2wP+aMIfB75llUNvJsdDGcbZ1NshjTBQtggMyySYwzVCgRCdem5PC7h/k7/dXTZYos6Kkr5C637DFI4aItbmmT8+pJxtstrfsS+6UVBz0vhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUSaaSU1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30a892f82b3so1053315a91.0
        for <stable@vger.kernel.org>; Tue, 13 May 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747158931; x=1747763731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wzkZCXyXd9rqf1l3QUizvgGLyX2iFgmixpDBZODhVY=;
        b=iUSaaSU1cqjjGpqj7FTZ0TVnOra519pBWVs7LuOd8Z6IfOgYUee2dwbGDf4LyjXYzd
         UhjPYrNREXDevJegJtfWLQUNOlnp3OmJyfmN5W5++62CewMi/lS4QGZxYJYxrrTLmGtL
         rMr1fqUVxidKiCVw7UkuSZ6aR8ijr0/p8Wm9uNeop0Wm3Gj32L+BL1xvhfDq77iwBa/G
         LQ1dhl1qGi5YW9vfXiA1tbb+1Def6bJs5ieeL15JgMdUQLsG+Sp9oJL7e4qK84vWiCEw
         Jb5zYzV7d5JcqqrpVAPTvGfzSLp6NFzrQ+CtLY8rJmq0g/83KgOjlyj8j0oFPP4opSOB
         9z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747158931; x=1747763731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wzkZCXyXd9rqf1l3QUizvgGLyX2iFgmixpDBZODhVY=;
        b=g8ggqhZyIMhteNQhIo5icditO6pTL/KQd3rF5Gb4WrOJkJKP7dtfPYWJWfSB8iMo0x
         Or8vHcB0eAcl5o1kmV4YTrKiQYljlVkn8jh+6DqqFKIOBwh5DGhy19xa7ZcmJgFb33A0
         LD4ifOJwZxnvWAq4IGVRqJsH003Q/VoSPZ1KLvPXWMsPmoZEq855FUQq7iFeSQuSzS/b
         f6s2+twif8uhmEXemsvlj8iejlQd/qaWVV/QAQJVxYYODcAUVHmaHhs6mzvw1QLRf4qr
         gmtMtgvFKfZgOcq0J4JW0wFQxeWeJeqO7z681cqDkaFukAfBj8BjTufqrGm5CFoUTu0i
         aoQw==
X-Forwarded-Encrypted: i=1; AJvYcCVzNJnqg+e570rLtoZaXrxS8yO91JI55w6d0EZ+ejh2wFs6f+N7vX/+84iLoepB+B2Hwd/gTj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWcy2CwGUV8KLix2dUCzB0M57fPgrSJGb7Mfe9E1GwIwCzh/B
	C3M0ibiPQV1A3xjGer3UBwsBvJyC8Uh8e6YUkiFVL8MYIdvMW26KCz3WPTFZOHAQ781Ca71wxtx
	0A/MLd7DssN9EdKcDQWUtGI2Hp98=
X-Gm-Gg: ASbGncsx+CgL/6YXe8pypkt3EPrb30/RIFYRUZDivOdJMbpMjd9re8+rMdNGGZPwcW3
	w6IbmNtxpJ/jLRs/WAbKdKgyKEQ47nmHjrsgefRCtCCyJU/+cwSlGpTTLfF3q1H5QosqqHo5oas
	7BZn4JsmUKY0ehAjxh4zju0RHnSDs1HHCe5RX8rbzdLus=
X-Google-Smtp-Source: AGHT+IEFKNCctKQt9AOmcZ2kDPxtQlOzjyUROCylpXH1Xo4N103v3vfaXrk7GNnvBNOazLrZo8uCvchY+6QZl5vqpU4=
X-Received: by 2002:a17:902:d482:b0:220:e1e6:446e with SMTP id
 d9443c01a7336-231980befe4mr2035585ad.1.1747158931128; Tue, 13 May 2025
 10:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513162912.634716-1-David.Wu3@amd.com> <CADnq5_P5QrYhLEzkwPUMvgYSmk8NkTOusa1dmBFD=veNfshBAA@mail.gmail.com>
 <23d465ec-a15c-43ae-ba1e-052cf342ba43@amd.com> <SJ1PR12MB6194CA9BCEAB6A35205822449596A@SJ1PR12MB6194.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB6194CA9BCEAB6A35205822449596A@SJ1PR12MB6194.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 13:55:17 -0400
X-Gm-Features: AX0GCFsMXBqDJPw6Qjep7DZXwNB3U-a660PrQidhpwFu18lR68gBGzFYdoFDb4k
Message-ID: <CADnq5_OZqv_2NAEPqX9RB3OSY0S6F7zny6hhVErw2j-vSR9TBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after written
 for VCN v4.0.5
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>
Cc: "Wu, David" <David.Wu3@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 1:54=E2=80=AFPM Dong, Ruijing <Ruijing.Dong@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Then dummy read should not be limited to this register regVCN_RB1_DB_CTRL=
, it can be any valid readable register just for posting the previous write=
 operations.

Right.  Any register will do.

Alex

>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Tuesday, May 13, 2025 12:48 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Wu, David <David.Wu3@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@a=
md.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@am=
d.com>; stable@vger.kernel.org
> Subject: Re: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after wri=
tten for VCN v4.0.5
>
> sounds great! will adjust accordingly.
>
> David
>
> On 2025-05-13 12:44, Alex Deucher wrote:
> > On Tue, May 13, 2025 at 12:38=E2=80=AFPM David (Ming Qiang) Wu
> > <David.Wu3@amd.com> wrote:
> >> On VCN v4.0.5 there is a race condition where the WPTR is not updated
> >> after starting from idle when doorbell is used. The read-back of
> >> regVCN_RB1_DB_CTRL register after written is to ensure the
> >> doorbell_index is updated before it can work properly.
> >>
> >> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
> >> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >> index ed00d35039c1..d6be8b05d7a2 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >> @@ -1033,6 +1033,8 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdg=
pu_vcn_inst *vinst,
> >>          WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
> >>                          ring->doorbell_index << VCN_RB1_DB_CTRL__OFFS=
ET__SHIFT |
> >>                          VCN_RB1_DB_CTRL__EN_MASK);
> >> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> >> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
> >>
> >>          return 0;
> >>   }
> >> @@ -1195,6 +1197,8 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_in=
st *vinst)
> >>          WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> >>                       ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET_=
_SHIFT |
> >>                       VCN_RB1_DB_CTRL__EN_MASK);
> >> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> >> +       RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
> > You might want to move this one down to the end of the function to
> > post the other subsequent writes.  Arguably all of the VCNs should do
> > something similar.  If you want to make sure a PCIe write goes
> > through, you need to issue a subsequent read.  Doing this at the end
> > of each function should post all previous writes.
> >
> > Alex
> >
> >>          WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> >>          WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI,
> >> upper_32_bits(ring->gpu_addr));
> >> --
> >> 2.49.0
> >>

