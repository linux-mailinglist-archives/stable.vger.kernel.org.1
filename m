Return-Path: <stable+bounces-178943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A9EB4969B
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 19:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D56166530
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AAA3126C0;
	Mon,  8 Sep 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsTeU0Pm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA430F812
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351485; cv=none; b=bI1jqnU72sz9nrY9U12pTI6H8hGKj0AAnYWwUhjCVsADCHZs80hb8599vBHZZ7Ve2K2pfjodzDy4oV4bysJDdzvqDsGIRem2U0n5/ZrJnO4SR8xcJ9G+K1zgH+gVsw88NJaIA/Llt8PDWHUZ/x5Gj9wkxbXkAgTvsI8TPE6Ebu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351485; c=relaxed/simple;
	bh=DavoxOhjLPcLDMahL3Y9U/VbM03JitHAgDMsWBFVdO0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tZB2iFzWAYFmtMPMv2ygO8Yi/ZYo7sfW4O116O9uccybMWcNu49cMID5wK1IKvOchcxt3e+/ITzMInfDb55vF/laY0MZSVueuU5mbE8UfkC8a1V/j+BHnYIVpfMcuGi6OVgj2u9A1C7hAbGl5mPIfSYipzPMMMPoGljyTMKyQtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IsTeU0Pm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso4102476f8f.3
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757351482; x=1757956282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXRt87N5KcbZYpVffvCLbSJic16B7wGhz6E/yGN+Uxg=;
        b=IsTeU0PmzwSYDbg3EIr3zQLnnf0NAyu84FP2kNyCbJvnuGT0pWQN0tYhfZesdCK+jJ
         owCDBZ5MrzTyU7GtP65hf7XsbgZD5bzLZAJTDl4OYpCAWyPHy027Uo9hEL644atQMG46
         JjOYuYgVBhvBh86fcyS80xnKbQsAdr5K+hLiZQr7Uw4rdVBXiLdnHlo2KAINc14viD60
         1gAxsy15XxGLJy4HB5apgJR/CpJU6DG5ss4to+aPE/YZFeMEURMJvQAWbTBYLX9ACk0J
         JqLHOv3a7G0WRBYJrHPgaQYwYoAkEzBItr5H+MZ+Th6AodrwBBq47TsZhFg7LnJ4G3Pj
         FaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351482; x=1757956282;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JXRt87N5KcbZYpVffvCLbSJic16B7wGhz6E/yGN+Uxg=;
        b=OZETTZ6tvd29eqq5Os83yl5Q3y3YSNTnC8NKQ75I1w5deQEP2YNjJoovNhQX8y9DBI
         Xs9RRIjL814cV7XVO5OX+CrYNi1eNWIKnvYI7u+57MpZQgSvs4XISH270ka+IiVROKnJ
         W+YIw4Z27VQmY5tNU8h1MrOytgW6yIF1UQR1bgMciwqsxUqgiykHc86ma4U44O1hfJlS
         /wMMf8r0cj/sVXm7sUuvh7dtYIQ2E9Wl65CLQYFUEKEsTfJXqsb2aQ+qnLfR7KxFXbfU
         a+pnuAMudTY6l3ypaEXAPrRG7pmgWb8vbon6QTkjPLix8AkbdB52ocTd/fz0eY1WOAYR
         NLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmi+fyTdB2gTrVm8KDx6renbMiTBjy8t4J7EmqWe8d77syfTYObLEtScshqv/OtdAn8j4eAAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGabUSyRSqYjwgYks5F4HsbD4yauKFvj4ZSmYMkgB3pU5u3lt1
	ibiGTfXRvuALq7B5XqhtbuWlhPp8t9nM71JEBvicNc/hJtr8fC9Kqcrpxlr2tbcSiCY=
X-Gm-Gg: ASbGncufLe0DzC9Cmbj/n9eHgPvmj2UYF2CbJGsQYk1s3kxrkTS9T6zRBA5qs8LCLcZ
	dtc3XqnwWBZhL69Do8IGqLHlcSOMCUEH3LtBNd3oZlDP0l2SstSlZ8ZzL3C4hW6QP8b0Q14hgE0
	4vzf8zooB0PWPohBWsqdFtDyvSO6wUbMkwUPtl5TPStDWKgCyXeyWa0MbaJMVjY4PG6WeXlMomc
	mrhvTSfKEGvuLdY/xcdxmD3KibSnZt38ckOHk7856nh49ge+ps2972XgqW3GE0jWPs8UL+GezFy
	9y1en3imCw22SwK3Hohy5AFosFTYXFXKxNBZcwPq6ZM2i23GdyjSSAMgpcTHvns7UeK9kMmYvQU
	G4QJTiUxjOZJ2y38k/rbMwGu4YLFanfgtkR2lHs+y2rP0MGXR+FApizWk7P+IqBdWkVrI65GqVb
	0=
X-Google-Smtp-Source: AGHT+IEg/f9S1DLAfQQk3JRLZENFZPwKbjav2YVjwZU30nhH+LDJfuSBQA045+uH1/8zST8dM70ckw==
X-Received: by 2002:a05:6000:230e:b0:3ca:3206:29f with SMTP id ffacd0b85a97d-3e642f91891mr7571829f8f.40.1757351482100;
        Mon, 08 Sep 2025 10:11:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b? ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add504sm41829503f8f.30.2025.09.08.10.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:11:21 -0700 (PDT)
Message-ID: <6fe68880-44a4-4b7e-a978-2c65d50f018c@linaro.org>
Date: Mon, 8 Sep 2025 19:11:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 00/16] drm/msm: Support for Inter Frame Power Collapse
 (IFPC) feature
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
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
In-Reply-To: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2025 10:26, Akhil P Oommen wrote:
> This patch series introduces the IFPC feature to the DRM-MSM driver for
> Adreno GPUs. IFPC enables GMU to quickly transition GPU into a low power
> state when idle and quickly resume gpu to active state upon workload
> submission, hence the name 'Inter Frame Power Collapse'. Since the KMD is
> unaware of these transitions, it must perform a handshake with the
> hardware (eg: fenced_write, OOB signaling etc) before accessing registers
> in the GX power domain.
> 
> Initial patches address a few existing issues that were not exposed in the
> absence of IFPC. Rest of the patches are additional changes required for
> IFPC. This series adds the necessary restore register list for X1-85/A750
> GPUs and enables IFPC support for them.
> 
> To: Rob Clark <robin.clark@oss.qualcomm.com>
> To: Sean Paul <sean@poorly.run>
> To: Konrad Dybcio <konradybcio@kernel.org>
> To: Dmitry Baryshkov <lumag@kernel.org>
> To: Abhinav Kumar <abhinav.kumar@linux.dev>
> To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> To: Marijn Suijten <marijn.suijten@somainline.org>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Antonino Maniscalco <antomani103@gmail.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Antonino Maniscalco <antomani103@gmail.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> Changes in v2:
> - Elaborate commit text and add Fixes tags (Dmitry/Konrad)
> - Document GMU_IDLE_STATE_RESERVED (Konrad)
> - Add a memory barrier in fenced_write
> - Move an error print in fenced_write to after polling
> - %s/set_keepalive_vote/a6xx[gpu|preempt]_keepalive_vote (Dmitry)
> - Add an "unlikely()" to read_gmu_ao_counter() (Konrad/Rob)
> - Define IFPC_LONG_HYST to document a magic number
> - Add a new patch to enable IFPC on A750 GPU (Neil/Antonino)
> - Drop patch 12 & 17 from v1 revision
> - Link to v1: https://lore.kernel.org/r/20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com
> 
> ---
> Akhil P Oommen (16):
>        drm/msm: Update GMU register xml
>        drm/msm: a6xx: Fix gx_is_on check for a7x family
>        drm/msm/a6xx: Poll additional DRV status
>        drm/msm/a6xx: Fix PDC sleep sequence
>        drm/msm: a6xx: Refactor a6xx_sptprac_enable()
>        drm/msm: Add an ftrace for gpu register access
>        drm/msm/adreno: Add fenced regwrite support
>        drm/msm/a6xx: Set Keep-alive votes to block IFPC
>        drm/msm/a6xx: Switch to GMU AO counter
>        drm/msm/a6xx: Poll AHB fence status in GPU IRQ handler
>        drm/msm: Add support for IFPC
>        drm/msm/a6xx: Fix hangcheck for IFPC
>        drm/msm/adreno: Disable IFPC when sysprof is active
>        drm/msm/a6xx: Make crashstate capture IFPC safe
>        drm/msm/a6xx: Enable IFPC on Adreno X1-85
>        drm/msm/a6xx: Enable IFPC on A750 GPU
> 
>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c         |  71 ++++++-
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 105 ++++++++--
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  14 ++
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 221 ++++++++++++++++++----
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |   3 +
>   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c       |  10 +-
>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c             |  34 +++-
>   drivers/gpu/drm/msm/adreno/a6xx_preempt.c         |  40 +++-
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h           |   1 +
>   drivers/gpu/drm/msm/msm_gpu.h                     |   9 +
>   drivers/gpu/drm/msm/msm_gpu_trace.h               |  12 ++
>   drivers/gpu/drm/msm/msm_submitqueue.c             |   4 +
>   drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  11 ++
>   13 files changed, 459 insertions(+), 76 deletions(-)
> ---
> base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
> change-id: 20241216-ifpc-support-3b80167b3532
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Thanks,
Neil

