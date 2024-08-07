Return-Path: <stable+bounces-65531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0530694A621
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 12:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788E31F24E24
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5011CCB37;
	Wed,  7 Aug 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5Sb08Lg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C661B8EB1
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027572; cv=none; b=LQQaf6AjZNLzuE2Djt3Mw/EDFX5VyfQz2JMbpXlujDLW6uJK2WmhTpPjD8ELdWxDUpI31u9QvItYlEO2yIps5l7wCjri4z3dl/HbAyi2itpEiO//eyOTvmCWZPgicJvF5cZMvJkz/NxQUmQZPDUxvhAbxxYBuZO4amPG6uTzPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027572; c=relaxed/simple;
	bh=l1HgOodX/TVtOD0wCtcn/qd6n8AkKBtuNLop/rtKpnY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L8f3enFsxGBZvzAOIiVXp0lmLLsk+CZnUrUdniuuxQG18VqNewGPrDI5Td6IfzoQmmoBjC27f6Sx12nPjDBnNlyObFMOXE02Ft0WbeqGCSVMHjU3yq02qI2UCdE//pFA4/vKyuMWbmwzYYCvAiYKS5UWw4cycoWe/5/A5owl/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j5Sb08Lg; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1fd65aaac27so5384355ad.1
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723027570; x=1723632370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DcfdKUXeiI0RflsU03nEHJTFXU6hNWDJiSM79+Zbsjk=;
        b=j5Sb08LgqeyeAF2epoDsHyW7uLdUZDjl94bOkIaQhjynMTNHoxfkCgSdBnAUc+fRKy
         IrTtXaa4Szz4DzELImCxRf54sEZK49aRVdgNRz8yX5kBaSqdX+IDSSURSt+OpppPJXCI
         1FmfQU36vhgyTSB0ABwslU3d1JpMTkAET6qiaQg7JT/nuSC08zqv1CgmManKw0hR7eMV
         BlxMDoNgFMi3FHsPuItjozFC29z0y3GsaYbApVhRn4VjI76PjJG/tUawkFAvWxk8uKfw
         MAZP7ly3cCSaOgVExFrGI1opjkX4rQViOzYSNejCeMTmZPNh7UcIExZAd2jdB2x8UK1I
         786A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027570; x=1723632370;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcfdKUXeiI0RflsU03nEHJTFXU6hNWDJiSM79+Zbsjk=;
        b=FL/YMBgR38QjV/4q66kbntXPR2HGYzBebRHEIibPDchlWnZUGqgSXnVetoBToP6xzN
         gILDmZdT6C/5eATxUheStPy0Mp5ohFqY/bevBHKCbJuUgR+qu9mROT1u5y3d70Pgj6Me
         /KofnX1DutpSQQUbSNbZZlZms3JLI3WCwr2UJ4Xg9i0fRzZTIsulD7WWIMhhksNGY3Hb
         2uQ2LCoEqwJiLlFcHHkEYplTeF0BCAgQsBsAXnQfaomQf1IIumxWav81MhNJxvet4jVZ
         7cQgu6C7J9le7w/6YXZ7i9YyaeMR+omn7he54vxdy7QhaDXcxz9b7GqtBdj7JY8mrx3K
         liZw==
X-Forwarded-Encrypted: i=1; AJvYcCUWMideS1MbW2g5er+6lKaK+aDi3ReTD7UZKNFAvt04dH6u0YXVmo0H9uXskV2BfF406+J6iuNTJtuRC/IuEYtiaWmaXz2G
X-Gm-Message-State: AOJu0YyD6JzfjSdjmJgUzmLWdOhbZ6J+14ioTgNINUSlfKPyxiBWrvhZ
	j/WWYbUYlKjgb8+VYyEWTBXnHb14x9WfdQmCg4EnUkCgpl13uO5ZKQquVjoioFY=
X-Google-Smtp-Source: AGHT+IHj1q9mnqROH1Frx3vYDFQ/RJEPn1e6A0NiqFVGzeKu1qvj297UTqh1jOAY4F0eH5Xa+lNJlg==
X-Received: by 2002:a17:902:e5c6:b0:1fa:1be4:1e48 with SMTP id d9443c01a7336-20085418b8cmr23058915ad.11.1723027570477;
        Wed, 07 Aug 2024 03:46:10 -0700 (PDT)
Received: from [127.0.0.1] ([182.232.168.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b3fa6sm102793885ad.304.2024.08.07.03.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:46:10 -0700 (PDT)
Date: Wed, 07 Aug 2024 17:46:03 +0700
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org,
 Leonard Lausen <leonard@lausen.nl>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_drm/msm/dpu1=3A_don=27t_c?=
 =?US-ASCII?Q?hoke_on_disabling_the_writeback_connector?=
User-Agent: K-9 Mail for Android
In-Reply-To: <800e03d2-01b0-4bde-816a-e45e1acdd039@quicinc.com>
References: <20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org> <20240802-dpu-fix-wb-v2-1-7eac9eb8e895@linaro.org> <800e03d2-01b0-4bde-816a-e45e1acdd039@quicinc.com>
Message-ID: <42B219B7-01DE-47CC-9D31-E27E40C04428@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 6, 2024 2:19:46 AM GMT+07:00, Abhinav Kumar <quic_abhinavk@quicin=
c=2Ecom> wrote:
>
>
>On 8/2/2024 12:47 PM, Dmitry Baryshkov wrote:
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
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec | 3 ---
>>   1 file changed, 3 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec b/drivers/=
gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec
>> index 16f144cbc0c9=2E=2E8ff496082902 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback=2Ec
>> @@ -42,9 +42,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connec=
tor *connector,
>>   	if (!conn_state || !conn_state->connector) {
>>   		DPU_ERROR("invalid connector state\n");
>>   		return -EINVAL;
>> -	} else if (conn_state->connector->status !=3D connector_status_connec=
ted) {
>> -		DPU_ERROR("connector not connected %d\n", conn_state->connector->sta=
tus);
>> -		return -EINVAL;
>>   	}
>
>For this issue, do we hit the connector->force =3D DRM_FORCE_OFF path?

It was hit during the suspend/resume, so yes, it is a forced off, but by t=
he different means=2E

>
>Because otherwise, writeback does not implement =2Edetect() callback toda=
y so its always connected=2E

It is undefined/unkown (3), not connected (1)

>
>But if that was the case how come this error is only for writeback=2E Eve=
n DP has the same connected check in atomic_check()
>
>Change seems fine with me because ideally this seems like a no-op to me b=
ecause writeback connector is assumed to be always connected but the issue =
is missing some details here=2E
>
>>     	crtc =3D conn_state->crtc;
>>=20


--=20
With best wishes
Dmitry

