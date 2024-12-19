Return-Path: <stable+bounces-105308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3765C9F7E0D
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 16:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0427716ECBE
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E968226549;
	Thu, 19 Dec 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgvlmS/X"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9922653E
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621990; cv=none; b=IOKu/cBMbCFWxOn6IPfQSLvaCDZJFY+7yBucZzzmoLo/pGTUWySxDGKhnX/oHHjKWx9i3EktnLNEByT0F7230oGu4R5Bu4oyImSnrHe59x5PKywD8DIObHqGKXSriEKvtmeumSEb5ijme6W4197bh7mTHP2iURDt4sm0OeincDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621990; c=relaxed/simple;
	bh=15RrTWKQpHCq/hvcLugkHfHdil5oe73YrQ2pQ1CJlL0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fGoDc0MGyfnHBLxvZIa85WQt9P3WySbAxDiEsRqhPYroAqasWgRzHSGU5J0sHyIbh7uJtJuFQfkXQmWxrhPy8kWZQ+kK46qEtfek1Y+rzaX+vOkFQfWi9l+jKfh0kssfdrnINCR9HJVA0toXlHX9DPNpIH416vsTGykNZ4zrAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LgvlmS/X; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43618283d48so7078825e9.1
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 07:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734621987; x=1735226787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ7HZmEeCGMgy0e+vPaSllNgD7jxFlhgiuqO+Gf6oic=;
        b=LgvlmS/Xe1DbBaOh2EqvwcEOO6YusRBXskAlnyEyADAINemZ4uoxyNdQRgHQtKqsNT
         MV6oZniWv4Kq9XUVQ8YwoGWrtsswxPn6+MOTDj44owNPi9LB/B/tVBjxmKDvyLmAWXtb
         obtY7syLHbEiJoZOjODqNq/ULJ4Jpb69CcQaTCCHGCVFusiAU5aeJnvaijslrJk3+9k0
         PltVSi3U3mAUkoOgfT6OaDlzviRbcpLf782u36qxGjdr6UDU4IeECcmkRh03Yx1lwVqn
         JG9ZSu2hT2yOM8Gnft0y4aC/3fLu7iejd+ymrtxNefdVegnZ1gBzRZTXv0zlACkpBI8A
         +Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734621987; x=1735226787;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VQ7HZmEeCGMgy0e+vPaSllNgD7jxFlhgiuqO+Gf6oic=;
        b=b5//Ljui6+Wca5yZjKISNxKP6/RGzduZCR4p8T63S06JPZkpUEvK4l95WaWZSEnAb0
         ErZtZFn+9trnKqXRbS1xhAA9syhMffzpATtzkt4xZg2Q0X4xRp6h30hLrB/WFg3IGcjC
         NXV7aO0BQTCNDc/e9po5n7no2wYUfW/DL409RoTdJAl7KRMR6i4pJ1mXi60ETI5rLVZw
         BlXjK2EOv79D79wZZa5LwMsP8x8z/rldqSiikS0Zl4zI1i1tg8JWB4/BmCRka7X+5nqz
         xBp8NSaG8L7NwKu5DTWwFGPOI8XQxGzZMgt19XXI/5OhFjaHl0dQYGM9b50wqa7hwNqd
         wu1A==
X-Forwarded-Encrypted: i=1; AJvYcCU8AP05AWdLgdZ6Uh+Z6ekMd49zKodQB5pMG1S/bfUnN7P3nRiT13aCCk4EpHPGBU4XFUOAqc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZfeZRVjSqFzg7nQXPwX+zcAvMr6HL5YnnEJ1w/ulXfLhr2w6
	TCpGXROYbbEcz2i7DtzFXlG5VJlq3AJ6wfcFUHOFNl+0nj5re0PImDXqR3gKZ2Q=
X-Gm-Gg: ASbGnctb8pQIXozg3C0iLOTQ4F/RY5NlbqpJ2e1HN3e+Rek185jHC8nnsI6rJbmEmRQ
	41I7S8APCXxseSGHlZRoEmzGV38eu8BxAB6hsOjR6rp16Io0a81t3B1mukLcIWYPBlznVJ0QgRJ
	+n6suZo8uiQzfhV2krCeJtjBOGlFlarSYsgZ+Ws1PUw5dadbQ4fEJBblFDDUHQRHMp9MbwA5XPt
	VfZBfcQ8Mhq8k1egLPKGmDSx4r6oSxQEL+0c4Li/kMozuWZXvvq8+E+eMrX56NkxFWZIFpjT3up
	4hd++Z9ihuwZwxbjRAbgZC/vNVJWSreGrw==
X-Google-Smtp-Source: AGHT+IEy1xHzK9K7OC7FPc2fyDm4x3L6AUfcIgdgbQdf1FCaNr7K1xPzw5OtAxsv5OKQ4c4RA4lwuA==
X-Received: by 2002:a05:600c:4fd3:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-4365536f6camr66630715e9.18.1734621985918;
        Thu, 19 Dec 2024 07:26:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a0fd:4342:76af:7533? ([2a01:e0a:982:cbb0:a0fd:4342:76af:7533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829235sm1779437f8f.15.2024.12.19.07.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 07:26:25 -0800 (PST)
Message-ID: <145dd6ae-be08-4f19-9e9d-abc238b35b8c@linaro.org>
Date: Thu, 19 Dec 2024 16:26:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/3] scsi: ufs: qcom: Suspend fixes
To: manivannan.sadhasivam@linaro.org, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
 Nitin Rawat <quic_nitirawa@quicinc.com>, stable@vger.kernel.org,
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20241213-ufs-qcom-suspend-fix-v2-0-1de6cd2d6146@linaro.org>
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
In-Reply-To: <20241213-ufs-qcom-suspend-fix-v2-0-1de6cd2d6146@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 14:53, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series fixes the several suspend issues on Qcom platforms. Patch 1 fixes
> the resume failure with spm_lvl=5 suspend on most of the Qcom platforms. For
> this patch, I couldn't figure out the exact commit that caused the issue. So I
> used the commit that introduced reinit support as a placeholder.
> 
> Patch 3 fixes the suspend issue on SM8550 and SM8650 platforms where UFS
> PHY retention is not supported. Hence the default spm_lvl=3 suspend fails. So
> this patch configures spm_lvl=5 as the default suspend level to force UFSHC/
> device powerdown during suspend. This supersedes the previous series [1] that
> tried to fix the issue in clock drivers.
> 
> This series is tested on Qcom SM8550 MTP and Qcom RB5 boards.
> 
> [1] https://lore.kernel.org/linux-arm-msm/20241107-ufs-clk-fix-v1-0-6032ff22a052@linaro.org
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Changes in v2:
> - Changed 'ufs_qcom_drvdata::quirks' type to 'enum ufshcd_quirks'
> - Collected tags
> - Link to v1: https://lore.kernel.org/r/20241211-ufs-qcom-suspend-fix-v1-0-83ebbde76b1c@linaro.org
> 
> ---
> Manivannan Sadhasivam (3):
>        scsi: ufs: qcom: Power off the PHY if it was already powered on in ufs_qcom_power_up_sequence()
>        scsi: ufs: qcom: Allow passing platform specific OF data
>        scsi: ufs: qcom: Power down the controller/device during system suspend for SM8550/SM8650 SoCs
> 
>   drivers/ufs/core/ufshcd-priv.h |  6 ------
>   drivers/ufs/core/ufshcd.c      |  1 -
>   drivers/ufs/host/ufs-qcom.c    | 31 +++++++++++++++++++------------
>   drivers/ufs/host/ufs-qcom.h    |  5 +++++
>   include/ufs/ufshcd.h           |  2 --
>   5 files changed, 24 insertions(+), 21 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241211-ufs-qcom-suspend-fix-5618e9c56d93
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

