Return-Path: <stable+bounces-144195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C600CAB5A7D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C2A18894EF
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE682BEC3E;
	Tue, 13 May 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyiC1lDA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48C1D5CC4
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154710; cv=none; b=sqGyltw+q8XCJlz612oN+xtCmomQ1TmEX0Zs/mtHTDV5jjsHdFxTmrFxRvI5PJnN9s/o+VtUPV1ms3sNa0STUIXAJGBju1QBmtKj3LDimSlzNbvtCjeEuiFktQq81tSvE45tSGkSgBdTnUZCIhsa8qpcHTtCwmkz28asAKzmn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154710; c=relaxed/simple;
	bh=uJ16UFS8Onm/1pmcbzqCBA97VUJql7Yobxk9hj4nKzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DL6ov/zjBqe5Ged8/bx/A9DCrN9I9PR8i18DC3CyHzfdZuX1Na4kc+BGdlGFFsSJIW86suweDvk30MeUVVHBXpTsKiaxYbWdrLjGaoLaIhc/BlVc/mkZM6JKVSk+8H73DFSDKFPoH+rXVG1w2sEfMM9Ednkf//iNMJyiOMx2M2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyiC1lDA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23179999d4aso1784585ad.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747154708; x=1747759508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iQw3rPC4MMDwF6PVhxgITs0Pt2hQtRby37OqxvKFq0=;
        b=OyiC1lDATRxJfTv3JpDyqKpeuB6/y/95PtSHQIXsan2OLKGce5HDbBdF5EWv47wulT
         1spPVGRLooPQZMO9a3EnYHQCJ+UOdgNwvqw5P7KT91I+mkhNqxaALa0bI2Gc2vVFEBH7
         dRqXgh1gdZZOeDh0E2C/qUcZwkZ3ilhfWWoWHsv++0FQWLaO604WN2TawZKCTOK9q4ov
         3SBxdBSPI4/WkAOsWQdi6zcNpanQ0G/Jj9RnvIxrdUNq0CAeRZiCKsxDLe8Egj2A5Qn7
         Dhvk18Y4JS/DviMaax3hyEXolCnCoHK3Lvwc4EZNh+hyfzGtgjVO8VAuqU32RerMskUk
         c8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747154708; x=1747759508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iQw3rPC4MMDwF6PVhxgITs0Pt2hQtRby37OqxvKFq0=;
        b=Z54aRXQaTlN+BM/HR9xCvp2MNWhM9NIs14lDCdA6GEH9fhMluXQhLuFp0K/cboD+6N
         0YSRGEILireKZ724enXg0S2gfChPW+Cz1Mzbz6xEJQ/SlzSqRgYvodZwb5vDuv8Zog5M
         04wPgIsHB1DCJvc4lN1+pzEdOlzwhvOgLa1bq27D48LxdZE+Jjf6zCz4iFNyMkRa01oZ
         pKGFXiPqIPbf9R6GNKzXGKxYdDFV08E2YAnuMYgmvcytBGcIyF13JE6FJKyHWWvnSqBw
         Cagmc778qn+td5eso1U+4BbI3OOcFcPvrYS+9p12IvZTx2/CLoEScSO/L8r27BYS3+/K
         HmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4a6zM/pP/hM/uyd2WxfL7VT2nvrQv/U85YuLVRAKbcPw0LCaeNUmnzBjfHGaedAt6F029n/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYMj0XfAyu9ocERXx5RFGKykhV9zjatonERT5C+5GJEF5DEsi
	mKpStvs5ycfveWeDw7JkLGl2JaDMVz/HnlQjpn5vl3oiHGr3YQMC08f+dMeHuPdWr837FsW5Dkk
	p490BSVivc+y5BuznVq3lP1gH5wg=
X-Gm-Gg: ASbGnctJh/oc2ASSB4i+IlOnrI5+Rbk5s6ZtGIuPaEsgRHAyTVEH5ksyK10o3sW/Kcb
	TwDSX3UR0gp2s+bOUyjPoCATbcLD7XYEv/Udbvv0ccmQyyHlmYP7RLRkB5GJDMheT3xB6y6YS6O
	w8SNFGXsbXnGzmtZtw8zYNVEl/iD4BiitqNAm4qs1wMjA=
X-Google-Smtp-Source: AGHT+IGCLGVpb7jGjHSHvQsiFCfy3beYXJoE0tWVrDAAN/NSOKrjM86Dp8gLDoK/hgEV834D+BYzby5c4DvUVPfF8Rw=
X-Received: by 2002:a17:903:1984:b0:231:7fbc:19c9 with SMTP id
 d9443c01a7336-2319810ea4cmr807135ad.1.1747154708158; Tue, 13 May 2025
 09:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513162912.634716-1-David.Wu3@amd.com>
In-Reply-To: <20250513162912.634716-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 12:44:56 -0400
X-Gm-Features: AX0GCFt_zpQ0P1YWbQqYyOo2zKyDqL46kqlXipx1zxscZ6ePplgD-FIR8Ulo7us
Message-ID: <CADnq5_P5QrYhLEzkwPUMvgYSmk8NkTOusa1dmBFD=veNfshBAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after written
 for VCN v4.0.5
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
	alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com, 
	ruijing.dong@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 12:38=E2=80=AFPM David (Ming Qiang) Wu
<David.Wu3@amd.com> wrote:
>
> On VCN v4.0.5 there is a race condition where the WPTR is not
> updated after starting from idle when doorbell is used. The read-back
> of regVCN_RB1_DB_CTRL register after written is to ensure the
> doorbell_index is updated before it can work properly.
>
> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index ed00d35039c1..d6be8b05d7a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1033,6 +1033,8 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_=
vcn_inst *vinst,
>         WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>                         ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__=
SHIFT |
>                         VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>
>         return 0;
>  }
> @@ -1195,6 +1197,8 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst =
*vinst)
>         WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>                      ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHI=
FT |
>                      VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);

You might want to move this one down to the end of the function to
post the other subsequent writes.  Arguably all of the VCNs should do
something similar.  If you want to make sure a PCIe write goes
through, you need to issue a subsequent read.  Doing this at the end
of each function should post all previous writes.

Alex

>
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_a=
ddr));
> --
> 2.49.0
>

