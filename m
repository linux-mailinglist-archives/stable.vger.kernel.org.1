Return-Path: <stable+bounces-105328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A941A9F8217
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E68618969F3
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1F419F11B;
	Thu, 19 Dec 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClcFI77e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5EA1953A2
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629700; cv=none; b=g0pB9PAM2ry3d6w31ZyH1CwxVO25+KN1Qs7xEAbHwlP5nchTsA+DNZl6mXWpxw46ppI/LT9X95UpTzVbrZGkdMrq18i5v83Wh7E1zPZ7kUnGeEcZxVn6gc/+xCUkezTT+yPuhqKME5YnZ73QSb5gNYrxMfFn8bzIaq05s36QktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629700; c=relaxed/simple;
	bh=upaVH8CLYYv5z4h8CBpnuBM9SZ3dkhWzzawnvDVzr4I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BnUV0ySC7F2TV+m2/MBISWxR3jSZ5cGd0V041iRJ7GHoPqo/IWaZGas5E/AhdUzYDvy6Yn5huXxpYkFPR2XDX030NVh9Rqm6xFdB6f502NxR0qf3wECLtDM3Vnp0EULdKcGYpn4XEAfzo4LxTkiErBr/uLkS5LIb842hC57jrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ClcFI77e; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso7085775e9.1
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734629697; x=1735234497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9Q4C68e9yW8gyyBPkqZLZg7ZZOGLbvSB7afrJbR9o8=;
        b=ClcFI77eJHJIJ4ntntICVJfUXcBdoIgRdiWjEjwfiG8UckD9yY5xfb7DwyS18ILjjm
         pZVpYZw3/7UJDtvCQD5m8zPpZzy6JM1dBtWxQp4hxSScKDElWtZ2K99awVEvWrV5ujDS
         EWYUHXAwq2g2FVCcnkMjtWEllbpJkUzV5U9YFcDvzGBzPBvCBWS7ypp6hfuGPWASMr51
         cK2jtqlxw8ywrkb3KG2PIPu98yshFqQbtMhRPI2qe3JC4iYZDh74beizZERFbfib3l+J
         o4lyNGpjWY98MRTbRGsjSxysPQMw+SWUCrr4VT2nE3+Fxybx4IJXKa7Lq17ElHGqcY21
         iStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734629697; x=1735234497;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F9Q4C68e9yW8gyyBPkqZLZg7ZZOGLbvSB7afrJbR9o8=;
        b=Pvdsp3OhnZ8qu+JN7DRMosfsj4yLgM8JtqQVKCCfx/PgM2CH6HJFE3QG72ZPlP3vET
         3/iDhVpe5o8WdhTm23gO72EDn8IoqzA1zDKKxoPJ+vXR00ShRazV8Iv9TAf2ZftzRvRR
         55mOb2Ee1BqxDEApRUd73wl6vD7eouqePwcZBdDN8J8sMNqQOzZqVJfOR4fk5UWIHNzg
         7B6CJWO1jp3MNg+YZkZi4n5tkYRHESrA5s70vrk9fMv4MGkUB5XOX77tVfqNb+KaQlNi
         IiGDz4R0yYRZpkmgWaTIj4TqvarVjDGR8UCtwlgkhBrFefug8HnvG2EOiBEakqoXlTRo
         dpxg==
X-Forwarded-Encrypted: i=1; AJvYcCXrrsHPYOtu1MmPh/nhXHK3TUjbC7er91qhIDSDLeh04ls0bN1XzT0ddVVYvY21YSNYDtbz2Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXHyobcs6RgVZgvUD6ysGJf4eljcFvNa8ZJ3+pg0ZhdosNeKU
	Q3c/ZcWRyRbKw7+N3PhzgFYACy9zjr38LFyaJDBihz2brWhC1nxoXQBdEVaGxsE=
X-Gm-Gg: ASbGnctymsEf6pPAkLiPW1uL6YCd/bpNBrZvsZP4X2CLY9cgWo7JanBXPriIjtyrQJS
	YGBfAkyXPxzpvFVpzyAFHxdxpsGJbhfcHwMbWjAncYdUXwgKFsVcfniHnHEU9bBJzWiszdeGRJJ
	s+2f+Ss74iYzCdHmn0NX/OtdLsBqjz+OTJCOWACjFgzUx66Gh5CKWpwOnNyWTvLxyXicdQ+N8fQ
	WRVb8O6Ds4NGyQb089/gZ7TlfCGm9yTB6DwMHqlXHy2hzgzrlZ0UaGgCZZUwXer8PECzRwkQRK+
	wOp8rysQ9eQIBe0nL9j9Gv66BMMeHemXCg==
X-Google-Smtp-Source: AGHT+IFbbqiRcM8kQ1G5cGnyM6An6nfZaiZ5DQIelNPVbDA8s6GSu8GoB7LW1ceTAqEtfl+GEFoXpw==
X-Received: by 2002:a05:600c:4f85:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-436630c620emr23031305e9.8.1734629697071;
        Thu, 19 Dec 2024 09:34:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a0fd:4342:76af:7533? ([2a01:e0a:982:cbb0:a0fd:4342:76af:7533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c833280sm2039057f8f.40.2024.12.19.09.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 09:34:56 -0800 (PST)
Message-ID: <af005778-0309-4c38-885b-a5b7ee2d0128@linaro.org>
Date: Thu, 19 Dec 2024 18:34:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4] drm/msm/dpu1: don't choke on disabling the writeback
 connector
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Leonard Lausen <leonard@lausen.nl>,
 =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
 Johan Hovold <johan+linaro@kernel.org>
References: <20241209-dpu-fix-wb-v4-1-7fe93059f9e0@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20241209-dpu-fix-wb-v4-1-7fe93059f9e0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/12/2024 11:04, Dmitry Baryshkov wrote:
> During suspend/resume process all connectors are explicitly disabled and
> then reenabled. However resume fails because of the connector_status check:
> 
> [dpu error]connector not connected 3
> [drm:drm_mode_config_helper_resume [drm_kms_helper]] *ERROR* Failed to resume (-22)
> 
> It doesn't make sense to check for the Writeback connected status (and
> other drivers don't perform such check), so drop the check.
> 
> It wasn't a problem before the commit 71174f362d67 ("drm/msm/dpu: move
> writeback's atomic_check to dpu_writeback.c"), since encoder's
> atomic_check() is called under a different conditions that the
> connector's atomic_check() (e.g. it is not called if there is no
> connected CRTC or if the corresponding connector is not a part of the
> new state).
> 
> Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu_writeback.c")
> Cc: stable@vger.kernel.org
> Reported-by: Leonard Lausen <leonard@lausen.nl>
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/57
> Tested-by: Leonard Lausen <leonard@lausen.nl> # on sc7180 lazor
> Reported-by: György Kurucz <me@kuruczgy.com>
> Link: https://lore.kernel.org/all/b70a4d1d-f98f-4169-942c-cb9006a42b40@kuruczgy.com/
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Link: https://lore.kernel.org/all/ZzyYI8KkWK36FfXf@hovoldconsulting.com/
> Tested-by: György Kurucz <me@kuruczgy.com>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Leonard Lausen reported an issue with suspend/resume of the sc7180
> devices. Fix the WB atomic check, which caused the issue.
> ---
> Changes in v4:
> - Epanded commit message (Johan)
> - Link to v3: https://lore.kernel.org/r/20241208-dpu-fix-wb-v3-1-a1de69ce4a1b@linaro.org
> 
> Changes in v3:
> - Rebased on top of msm-fixes
> - Link to v2: https://lore.kernel.org/r/20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org
> 
> Changes in v2:
> - Reworked the writeback to just drop the connector->status check.
> - Expanded commit message for the debugging patch.
> - Link to v1: https://lore.kernel.org/r/20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> index 16f144cbc0c986ee266412223d9e605b01f9fb8c..8ff496082902b1ee713e806140f39b4730ed256a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -42,9 +42,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
>   	if (!conn_state || !conn_state->connector) {
>   		DPU_ERROR("invalid connector state\n");
>   		return -EINVAL;
> -	} else if (conn_state->connector->status != connector_status_connected) {
> -		DPU_ERROR("connector not connected %d\n", conn_state->connector->status);
> -		return -EINVAL;
>   	}
>   
>   	crtc = conn_state->crtc;
> 
> ---
> base-commit: 86313a9cd152330c634b25d826a281c6a002eb77
> change-id: 20240709-dpu-fix-wb-6cd57e3eb182
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

