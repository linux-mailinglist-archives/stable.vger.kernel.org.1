Return-Path: <stable+bounces-195158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97649C6D61C
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 09:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 866F12D3DF
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFED320CA7;
	Wed, 19 Nov 2025 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PB3CBKb/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827C314A6F
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540526; cv=none; b=bUGgRfwyS9k78f+c6PXsi243ibxBj9hHHqMMbkQd3uOBqBdU15kLLdQvWpobuyGm6V+wrExL3vl7rswygzWjg2A1zXBiiGP9N6FYN4Z9IttO5/8wzifFT4njE7ZmRNKPjOqiUuFx3kisrAzWGHhfVkKJadkj8hNku3+pivA0Uuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540526; c=relaxed/simple;
	bh=XmQKQMt4wHrjO/28Gu11FuM6OaOs0LzzT2cJNi0JrP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7Qt50m5RryBp0i7nCPv08OiyBQMLS1JFS5xPOPxm2FI4hgKcALokz+dLdorshX3TNY3xcZlBmCDNhqJPUoh2HqYDbyN4foKf2X7D2mRVCf1PDFNUOqnc5mVYiYZO8Ly3GrniVWykryEjhieh3G9Bxy6UqLVH5sLWgVN3J4sabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PB3CBKb/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3c965df5so3726848f8f.1
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 00:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763540522; x=1764145322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prHnOWL3KZTfGMcuYs6Gvqk+F387R0tzV57ZZJJ4m2w=;
        b=PB3CBKb/fsNQmtd606CzGl0TRxYBnz6gVGoAOYcKUkXF/D5a4dIo7e7r23dvOeYoGN
         YbT7E1LOn7JCLYxV5F4LbCx4zVDW8EXms+HOdKk/29CCp+M0Wtv/yz7M/QzRGTLK+Xva
         mzEywQsJDqNqAOTCXoh85RUMSbazbKuVlE67FMmHFBdTZeRVyrthILOrsxj2U7rPdaO+
         tF0J/H5R3goVu9gffnR8u5zsJ9m42XoHeauQ/sfhD01vizYBEJYYyQ+m+//6p+eQCLqZ
         cBq+V1Du6hJBoXMSpatqHT0ps8Vwm97dlW+N/skHgR1Ff59yK47/Mug3UeUqHDI0IO66
         QEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763540522; x=1764145322;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prHnOWL3KZTfGMcuYs6Gvqk+F387R0tzV57ZZJJ4m2w=;
        b=YFAo0blcpIDKKgt7Hkf2be1VeVu4h2wxKYdFlaepe0DIFxN//4Ocw5Q2IYVX0yQhJq
         qP9dxpEguTHQpIdI55PF54yjxZvGrk55sZzlFH4Ieef6Ia6CsW0E5ZKXc/9l+04XsUsO
         g7H08yAgqE9g98XQkCvxt2bvrVGwoMo7zmySUuSHPHOast21RMEUZgpHGuplX1EXxUw2
         xxPTx4MqcP0NaIYuHf/IO2b/qFRTyd4xFOw3mkVG/zoL/HKL0BVgIQyo4cAZCOX3gjf6
         phwefgmisHOMRZGkO1Kd7s+oMsvlZcPCQFsHVp6gbA2QOt73BCuv9MEDKu9D+m4PxSju
         cRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5dMz2uhmL2W9yLrliDAENcqTqWB88aQto72t9MU84lxJWufyWJdsPIVdRsdWDhkzSAriUsv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhVORQEbga/w5qI5CJkwX4rcKcOAMnZyJnwHSOoukJ0rsQCSx
	VuIDdXQlTIFIp4k7ebOdz5ky2XOkzdtL3hWI3Bp5cRcCTDtJr2U7Tg+PUFUObzeMsgo=
X-Gm-Gg: ASbGncsADdonSSXC+xnU3oAiHNX0cp/AOtwVeJfYvmiQPmULZDNreasDB+FAX+Ao88s
	NCtc2aj8RrP9ZoqSGTG9sPXMQ9Cn7RNRYXWZ8y1mw0q70x0+nBknsUNVO7nqq0y/e07CAsDddaZ
	X68TNw2Putypw0M6lHdBiAVInfQhO+vLGDbsQ5xhCcxW3Z0T4m4LaRLe856+KDhO0Vq84FokWFo
	nArKxmBfkKQ40d16SuAhPRdDwKMKDbbOte1WBdO0Z7t/CgbQYm8csu9GYgqrPwv4VDWuLcbcQWO
	+98hW/FQB2iyQ7n+I6X9YSwBtF9ehQ83JQPOaCXGNP55ypzswDcHQkgJ/ljM3zEEVh92Cpo2t1e
	/wEmafeyMYbUD79J8Rxv1YiMN7zUXU+CNpRPvgA81HFeGgmk7TQpB6IktadHaPhbkBChpKxEo3P
	r8M0BPTfd/GXsK01J5KYctOVt/uQk8yufUV1WWq9fLoOxVMG12aqW/wRLt+/A1x7pNK2uxaY130
	Q==
X-Google-Smtp-Source: AGHT+IESR3q8PRMdgehT41zzmTrRE4kFNljWLOSoMsF6eJXC2oWLRwLzbqk1zj89EkKHUL3P6S7vaw==
X-Received: by 2002:a05:6000:4210:b0:42b:40b5:e64c with SMTP id ffacd0b85a97d-42b5938ab12mr17657397f8f.30.1763540522201;
        Wed, 19 Nov 2025 00:22:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:94e4:fa88:414d:e1ad? ([2a01:e0a:3d9:2080:94e4:fa88:414d:e1ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm37294740f8f.39.2025.11.19.00.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 00:22:01 -0800 (PST)
Message-ID: <84e53d61-ef32-4f15-aa51-132acb83c52d@linaro.org>
Date: Wed, 19 Nov 2025 09:22:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/3] phy: qcom: edp: Make the number of clocks flexible
To: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org>
 <20250909-phy-qcom-edp-add-missing-refclk-v3-2-4ec55a0512ab@linaro.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20250909-phy-qcom-edp-add-missing-refclk-v3-2-4ec55a0512ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 09:33, Abel Vesa wrote:
> On X Elite, the DP PHY needs another clock called ref, while all other
> platforms do not.
> 
> The current X Elite devices supported upstream work fine without this
> clock, because the boot firmware leaves this clock enabled. But we should
> not rely on that. Also, even though this change breaks the ABI, it is
> needed in order to make the driver disables this clock along with the
> other ones, for a proper bring-down of the entire PHY.
> 
> So in order to handle these clocks on different platforms, make the driver
> get all the clocks regardless of how many there are provided.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-edp.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index f1b51018683d51df064f60440864c6031638670c..ca9bb9d70e29e1a132bd499fb9f74b5837acf45b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -103,7 +103,9 @@ struct qcom_edp {
>   
>   	struct phy_configure_opts_dp dp_opts;
>   
> -	struct clk_bulk_data clks[2];
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +
>   	struct regulator_bulk_data supplies[2];
>   
>   	bool is_edp;
> @@ -218,7 +220,7 @@ static int qcom_edp_phy_init(struct phy *phy)
>   	if (ret)
>   		return ret;
>   
> -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(edp->clks), edp->clks);
> +	ret = clk_bulk_prepare_enable(edp->num_clks, edp->clks);
>   	if (ret)
>   		goto out_disable_supplies;
>   
> @@ -885,7 +887,7 @@ static int qcom_edp_phy_exit(struct phy *phy)
>   {
>   	struct qcom_edp *edp = phy_get_drvdata(phy);
>   
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(edp->clks), edp->clks);
> +	clk_bulk_disable_unprepare(edp->num_clks, edp->clks);
>   	regulator_bulk_disable(ARRAY_SIZE(edp->supplies), edp->supplies);
>   
>   	return 0;
> @@ -1092,11 +1094,9 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>   	if (IS_ERR(edp->pll))
>   		return PTR_ERR(edp->pll);
>   
> -	edp->clks[0].id = "aux";
> -	edp->clks[1].id = "cfg_ahb";
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(edp->clks), edp->clks);
> -	if (ret)
> -		return ret;
> +	edp->num_clks = devm_clk_bulk_get_all(dev, &edp->clks);
> +	if (edp->num_clks < 0)
> +		return dev_err_probe(dev, edp->num_clks, "failed to parse clocks\n");
>   
>   	edp->supplies[0].supply = "vdda-phy";
>   	edp->supplies[1].supply = "vdda-pll";
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

