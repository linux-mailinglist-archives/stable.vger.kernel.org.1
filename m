Return-Path: <stable+bounces-65530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CE94A61A
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 12:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E0B1C22947
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6881B9B2F;
	Wed,  7 Aug 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQEG66Vw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420661E2891
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027460; cv=none; b=jYn8bO44YUKLl7v21+JLOGs/qpTih5AwHRbQS5jbUQIiWTix5viXCVPOEtV4ClfEcCsY/IkQTfhShm2bsU7AXWSmlsHzvIqEMX/71AiZmBHBqIVnpu+COoUMuowyzH4tftkZ69F4XbfpGn61juowVC7RLIL5SadoW4vdcCOAri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027460; c=relaxed/simple;
	bh=7F2dgW4FuJsClw6RwBczzLtLul8AUYM2EWM8QMsAPjU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Fc7aW0+iAh2lr5ectNqq/IHSJhGodc05R4ech56Ikw2u8eBj2Kor09k43OXIjw13sD8qrHhTGACFHggGJ2rfNMwoEaSjpc+lznsxMvkakbnvGcntFWlbJjE0Zc0aBgjJQ+RzfgOmr1m+u9Z9e7b44Dm72yjZMBJPLzij4SRKQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQEG66Vw; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1fc56fd4de1so5646425ad.0
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723027457; x=1723632257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F3o02Xw7ezzA14Pd+Lgc2BLB9SvalP82R9YVWF/sDxk=;
        b=eQEG66Vwf4gwAYtdaF9HPk1L4L+dBqzCKMONQnz8rR1WzM1b8ZZ85xLIh1QuEwRU+l
         uQ8U+SsAsydm3JgxcPZIshMx1mJa02gO4eZ2GMzHDhHS0ksZxIyDQO7QDWirGi3dGhHb
         7mTgICeuaHy75sqEGS35/Xa3yQYIyvR8I+cyjSMmDsPJM2OV1aL7wIbzf78RzMevTyls
         uqOaNNAJBQquMIg0zr1plyUb5UxseIjUeebIsUtEM76TTQ3Fvc37sgWuMEnyIPy+HhDI
         /YL216wDGRsn6zoIs+XBY2Aq6/EwzJ7wD1zf9c+vGcTEi+eqGa256Dk7QAtpR15WxXkx
         Ifxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027457; x=1723632257;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3o02Xw7ezzA14Pd+Lgc2BLB9SvalP82R9YVWF/sDxk=;
        b=Iyc3METnphKm5bS4Tu1rXVfZybkPKJq8tIXqD6szU4L5FVq5H7IwbkEMYEY1cfanNq
         Pcq70smdXVcZkpG7pIwIMoItO+BpOgFLZ5ZKCk1JtFcLZtRdjIAvZhDx4L7UUtS65fQi
         wm+ky2iqG4Ho0aX5MayZIRRPYJAYEWcDM79/1iWsIkM9RzKLG2x81JkKG9iniWolk5h4
         0hxyKwSzvT+kQEebgaBEdI32HWB8/01zycGLBQU0GYef6plHsq1dOgG9yOIjOQx0okAI
         AtqX9b/aWgmyHTDIqM0V3rrWR8dNGQutB915fGwOmtyb4QY3Wpqp2N1LUlj99PpbiW4X
         dV+g==
X-Forwarded-Encrypted: i=1; AJvYcCXLl4x+gSWBUMG+z3v2TEYB2qNRzk/+MiMx7ICQC3/Nsh1BEkDM1ThVAaRugtUxdrGg3YxoXK9nbsUYtPQFmBe3pD3EDnc4
X-Gm-Message-State: AOJu0YyUmpqHxMtMGCQmI/yOuIn77jXVjrd7bEX9I5/FRy/pRkBdERv7
	sJLYDcO9U5lyA+NrEujqFgRGOwBRZI9AYAMSAE11ZFUhB0cf3jRourVtiN/BPE0=
X-Google-Smtp-Source: AGHT+IFoNLrt1GaF+yeaFvmCHadWYdmm/RDr/6D/Md5qSi81mcUQk94i8uHGUfoK6lIe9cztu7TiAg==
X-Received: by 2002:a17:903:a88:b0:1f9:ad91:f8d0 with SMTP id d9443c01a7336-200853de85cmr23075065ad.8.1723027457532;
        Wed, 07 Aug 2024 03:44:17 -0700 (PDT)
Received: from [127.0.0.1] ([182.232.168.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905e58fsm103268695ad.177.2024.08.07.03.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:44:17 -0700 (PDT)
Date: Wed, 07 Aug 2024 17:44:12 +0700
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Leonard Lausen <leonard@lausen.nl>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_drm/msm/dpu1=3A_don=27t_c?=
 =?US-ASCII?Q?hoke_on_disabling_the_writeback_connector?=
User-Agent: K-9 Mail for Android
In-Reply-To: <57cdac1a-1c4d-4299-8fde-92ae054fc6c0@lausen.nl>
References: <20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org> <20240802-dpu-fix-wb-v2-1-7eac9eb8e895@linaro.org> <57cdac1a-1c4d-4299-8fde-92ae054fc6c0@lausen.nl>
Message-ID: <61D52432-DD30-4C43-BD5E-1CC9F84DF5B9@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 5, 2024 9:27:39 AM GMT+07:00, Leonard Lausen <leonard@lausen=2Enl=
> wrote:
>Dear Dmitry,
>
>Thank you for the patch=2E Unfortunately, the patch triggers a regression=
 with
>respect to DRM CRTC state handling=2E With the patch applied, suspending =
and
>resuming a lazor sc7180 with external display connected, looses CRTC stat=
e on
>resume and prevents applying a new CRTC state=2E Without the patch, CRTC =
state is
>preserved across suspend and resume and it remains possible to change CRT=
C
>settings after resume=2E This means the patch regresses the user experien=
ce,
>preventing "Night Light" mode to work as expected=2E I've validated this =
on
>v6=2E10=2E2 vs=2E v6=2E10=2E2 with this patch applied=2E
>

Could you please clarify, I was under the impression that currently whole =
suspend/resume is broken, so it's more than a dmesg message=2E

>While the cause for the bug uncovered by this change is likely separate, =
given
>it's impact, would it be prudent to delay the application of this patch u=
ntil
>the related bug is identified and fixed? Otherwise we would be fixing a d=
mesg
>error message "[dpu error]connector not connected 3" that appears to do n=
o harm
>but thereby break more critical user visible behavior=2E
>
>Best regards
>Leonard
>
>On 8/2/24 15:47, Dmitry Baryshkov wrote:
>> During suspend/resume process all connectors are explicitly disabled an=
d
>> then reenabled=2E However resume fails because of the connector_status =
check:
>>=20
>> [ 1185=2E831970] [dpu error]connector not connected 3
>>=20
>> It doesn't make sense to check for the Writeback connected status (and
>> other drivers don't perform such check), so drop the check=2E
>>=20
>> Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu=
_writeback=2Ec")
>> Cc: stable@vger=2Ekernel=2Eorg
>> Reported-by: Leonard Lausen <leonard@lausen=2Enl>
>> Closes: https://gitlab=2Efreedesktop=2Eorg/drm/msm/-/issues/57
>> Signed-off-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>> ---
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec | 3 ---
>>  1 file changed, 3 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec b/drivers/=
gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec
>> index 16f144cbc0c9=2E=2E8ff496082902 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec
>> @@ -42,9 +42,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connec=
tor *connector,
>>  	if (!conn_state || !conn_state->connector) {
>>  		DPU_ERROR("invalid connector state\n");
>>  		return -EINVAL;
>> -	} else if (conn_state->connector->status !=3D connector_status_connec=
ted) {
>> -		DPU_ERROR("connector not connected %d\n", conn_state->connector->sta=
tus);
>> -		return -EINVAL;
>>  	}
>> =20
>>  	crtc =3D conn_state->crtc;
>>=20
>


--=20
With best wishes
Dmitry

