Return-Path: <stable+bounces-99943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B87F9E74BC
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1C116A5E8
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86920B219;
	Fri,  6 Dec 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6yPEfYb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2D20E021
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499794; cv=none; b=hjXfnY4ioAcwUXbwMwCC+ftwXzCfWQsPzs+K5ehZivPjS2OsNOHl9zcsjKqPQF6WX22i+9gCAZSKHBBtDiPXdYk1QWAHCZpwcNCzFkGn2qW3wA1AAV/V21x0qmZCbF0i/fbTl4+Uppwdzi9e/iDXYko1+FusWEO968FW/y3rjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499794; c=relaxed/simple;
	bh=3P9Re4i5OetH50KMbpHgNl1Mz2sO8eUJ84qtwUpCAMQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WMn4n36aqCuU7kUcAy9qLxkAG+ahzSEFuK+11Hsd0pou+yIXn6jKCf/3WYdHHTWzvLJ5p0YBHS9Pj9Gv2xTyvXMjcGXKW6ZyfKYQDZnULGEVnnY68r7EV9E4vBfdgwpzk1Qa4gJJhlg2n89KTpKDmDN/f8Khy3+ldkH3r652iBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e6yPEfYb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434aabd688fso14781565e9.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499790; x=1734104590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l+8hgcOTP5OFgWjraHM7FKjybQxrDym2khU0s5Y4U8=;
        b=e6yPEfYbfoPHCrzOhCybnjvnxvQhmTt/bOFZdvgge5EDS5o+iB8s5istbbSY7/Nk49
         Nu17fB525TwxCU0bIRhGsP+961Hao01+9f5xRSD9TAjqmh0336OhZ5JF0zgwS3DEYNdQ
         THAtuFBzCMprA6F+Rppn7W8J9LFgnpJn4I+vkyiTJWnEktToomKqMnyDkIPK5XCJiNkG
         fgt7/2S9KAcW54CRG7Qgz9EYwWCs12OsmF1cj0KphoLsaQJQwXySPAfGz6XxUGCPnvbE
         RvfzH1pOf5irKP1wIx/UzIAC3s2BZC4pIx/KarDhGXgoku4WmwfVwQPA5rbHRSgQjZyO
         mDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499790; x=1734104590;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9l+8hgcOTP5OFgWjraHM7FKjybQxrDym2khU0s5Y4U8=;
        b=uxw2eeqA1RMBQlCRLIU/zh7ciz/PzAMqg73UW8/lnuXyX2gMz02EVLCnudvp4JjQXU
         xpCjRiTRVq1Wsf58AjLkWFKFsQ92JGg6uRHndSmJgh7pHb8tj3gT4ch1RaFjbP4ozPYr
         UBVyLqLrqA+5Ob2I+l6c5lMPbQG6B6Nub2rZGYjDhpUB8qgHQm0CEHAkDQGKvLX/Thmy
         68RNzpmJcotC8Xq/60UPa0qTsLEtdQ4+JZLl0Yapzqumn4bt/JTRgfwOEkqn3dgAXwBX
         yl3nGdpKLeahnxJfPNxAZjrZndmjUOeQyW1QNf7KBpqPvY6qU58wQAAsiDHzXvCKcu9a
         /KGA==
X-Forwarded-Encrypted: i=1; AJvYcCV/GwXUwNlTYoAMrbnLdPxMRgWXrQavGJhN5+3Lepk3RDIn03TBZG6UhaTGFp8hV3e5YyetRAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfUFsgreg5fYMyH5haN4j/uB2wL/46gR6P0OTYhO6Lzu8YtmO
	iJGx13/pU1xnAiLwcr6WoS4wwperb07YYI+fuBnRcH5U8VdPhvDSVgteBzv4V7k=
X-Gm-Gg: ASbGncu1PU9gtvuuUwYHESyX7h2cz+rbapGVkCuoShQ/4jLF5DoZl+WSi7QQYsH1Nth
	5hbaY4kgKSvSqk7Bzqgl6Jl9q1u2MV6q3EQG0PIpiVpaXz479y2Yo5HU9+zwC3+sddMRebQKLSI
	6p2gS598YE5JJoRW2muP25fvgqn1SZ4VewyyQoLLMO1k/HRONJEDkLsyo7AWgUr+jH63wsgXUfy
	mg/yDY36P8d377CFWaxgWBJZJhB8OT+U+RKAd/ZqYVorNWlBXvz1+3kZOfkJU5VkCk6AxYcrBaX
	EAx++p3ADfQM9GgYOf7GjExH5DA=
X-Google-Smtp-Source: AGHT+IE5koNuNvxPmbBViCOCRoO80TeAOdiVnlHy3nwK1dS8c910DR8sA2rJ08WXFiinB416K1zXyw==
X-Received: by 2002:a05:600c:1f8c:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-434ddeb5379mr29307995e9.11.1733499790060;
        Fri, 06 Dec 2024 07:43:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889? ([2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38631f73237sm448908f8f.62.2024.12.06.07.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:43:09 -0800 (PST)
Message-ID: <c6aaef38-b400-47de-bcb8-6eb9e12aebb3@linaro.org>
Date: Fri, 6 Dec 2024 16:43:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 07/19] arm64: dts: qcom: sm8550: Fix ADSP memory base and
 length
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
 <20241206-dts-qcom-cdsp-mpss-base-address-v1-7-2f349e4d5a63@linaro.org>
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
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-7-2f349e4d5a63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/12/2024 16:32, Krzysztof Kozlowski wrote:
> The address space in ADSP PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB): 0x0680_0000 with length of 0x10000.
> 
> 0x3000_0000, value used so far, is the main region of CDSP.  Downstream
> DTS uses 0x0300_0000, which is oddly similar to 0x3000_0000, yet quite
> different and points to unused area.
> 
> Correct the base address and length, which also moves the node to
> different place to keep things sorted by unit address.  The diff looks
> big, but only the unit address and "reg" property were changed.  This
> should have no functional impact on Linux users, because PAS loader does
> not use this address space at all.
> 
> Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 262 +++++++++++++++++------------------
>   1 file changed, 131 insertions(+), 131 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index e7774d32fb6d2288748ecec00bf525b2b3c40fbb..f454015c5b90c7d792c01bf85256812857d79c64 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2354,6 +2354,137 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>   			};
>   		};
>   
> +		remoteproc_adsp: remoteproc@6800000 {
> +			compatible = "qcom,sm8550-adsp-pas";
> +			reg = <0x0 0x06800000 0x0 0x10000>;
> +
> +			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&rpmhpd RPMHPD_LCX>,
> +					<&rpmhpd RPMHPD_LMX>;
> +			power-domain-names = "lcx", "lmx";
> +
> +			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC 0 &mc_virt SLAVE_EBI1 0>;
> +
> +			memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			qcom,smem-states = <&smp2p_adsp_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			remoteproc_adsp_glink: glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_LPASS
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "lpass";
> +				qcom,remote-pid = <2>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "adsp";
> +					qcom,non-secure-domain;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x1003 0x80>,
> +							 <&apps_smmu 0x1063 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@4 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <4>;
> +						iommus = <&apps_smmu 0x1004 0x80>,
> +							 <&apps_smmu 0x1064 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@5 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <5>;
> +						iommus = <&apps_smmu 0x1005 0x80>,
> +							 <&apps_smmu 0x1065 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@6 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <6>;
> +						iommus = <&apps_smmu 0x1006 0x80>,
> +							 <&apps_smmu 0x1066 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@7 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <7>;
> +						iommus = <&apps_smmu 0x1007 0x80>,
> +							 <&apps_smmu 0x1067 0x0>;
> +						dma-coherent;
> +					};
> +				};
> +
> +				gpr {
> +					compatible = "qcom,gpr";
> +					qcom,glink-channels = "adsp_apps";
> +					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +					qcom,intents = <512 20>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					q6apm: service@1 {
> +						compatible = "qcom,q6apm";
> +						reg = <GPR_APM_MODULE_IID>;
> +						#sound-dai-cells = <0>;
> +						qcom,protection-domain = "avs/audio",
> +									 "msm/adsp/audio_pd";
> +
> +						q6apmdai: dais {
> +							compatible = "qcom,q6apm-dais";
> +							iommus = <&apps_smmu 0x1001 0x80>,
> +								 <&apps_smmu 0x1061 0x0>;
> +						};
> +
> +						q6apmbedai: bedais {
> +							compatible = "qcom,q6apm-lpass-dais";
> +							#sound-dai-cells = <1>;
> +						};
> +					};
> +
> +					q6prm: service@2 {
> +						compatible = "qcom,q6prm";
> +						reg = <GPR_PRM_MODULE_IID>;
> +						qcom,protection-domain = "avs/audio",
> +									 "msm/adsp/audio_pd";
> +
> +						q6prmcc: clock-controller {
> +							compatible = "qcom,q6prm-lpass-clocks";
> +							#clock-cells = <2>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +
>   		lpass_wsa2macro: codec@6aa0000 {
>   			compatible = "qcom,sm8550-lpass-wsa-macro";
>   			reg = <0 0x06aa0000 0 0x1000>;
> @@ -4576,137 +4707,6 @@ system-cache-controller@25000000 {
>   			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> -		remoteproc_adsp: remoteproc@30000000 {
> -			compatible = "qcom,sm8550-adsp-pas";
> -			reg = <0x0 0x30000000 0x0 0x100>;
> -
> -			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
> -					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> -					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> -					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> -					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> -			interrupt-names = "wdog", "fatal", "ready",
> -					  "handover", "stop-ack";
> -
> -			clocks = <&rpmhcc RPMH_CXO_CLK>;
> -			clock-names = "xo";
> -
> -			power-domains = <&rpmhpd RPMHPD_LCX>,
> -					<&rpmhpd RPMHPD_LMX>;
> -			power-domain-names = "lcx", "lmx";
> -
> -			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC 0 &mc_virt SLAVE_EBI1 0>;
> -
> -			memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
> -
> -			qcom,qmp = <&aoss_qmp>;
> -
> -			qcom,smem-states = <&smp2p_adsp_out 0>;
> -			qcom,smem-state-names = "stop";
> -
> -			status = "disabled";
> -
> -			remoteproc_adsp_glink: glink-edge {
> -				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> -							     IPCC_MPROC_SIGNAL_GLINK_QMP
> -							     IRQ_TYPE_EDGE_RISING>;
> -				mboxes = <&ipcc IPCC_CLIENT_LPASS
> -						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> -
> -				label = "lpass";
> -				qcom,remote-pid = <2>;
> -
> -				fastrpc {
> -					compatible = "qcom,fastrpc";
> -					qcom,glink-channels = "fastrpcglink-apps-dsp";
> -					label = "adsp";
> -					qcom,non-secure-domain;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					compute-cb@3 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <3>;
> -						iommus = <&apps_smmu 0x1003 0x80>,
> -							 <&apps_smmu 0x1063 0x0>;
> -						dma-coherent;
> -					};
> -
> -					compute-cb@4 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <4>;
> -						iommus = <&apps_smmu 0x1004 0x80>,
> -							 <&apps_smmu 0x1064 0x0>;
> -						dma-coherent;
> -					};
> -
> -					compute-cb@5 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <5>;
> -						iommus = <&apps_smmu 0x1005 0x80>,
> -							 <&apps_smmu 0x1065 0x0>;
> -						dma-coherent;
> -					};
> -
> -					compute-cb@6 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <6>;
> -						iommus = <&apps_smmu 0x1006 0x80>,
> -							 <&apps_smmu 0x1066 0x0>;
> -						dma-coherent;
> -					};
> -
> -					compute-cb@7 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <7>;
> -						iommus = <&apps_smmu 0x1007 0x80>,
> -							 <&apps_smmu 0x1067 0x0>;
> -						dma-coherent;
> -					};
> -				};
> -
> -				gpr {
> -					compatible = "qcom,gpr";
> -					qcom,glink-channels = "adsp_apps";
> -					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> -					qcom,intents = <512 20>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					q6apm: service@1 {
> -						compatible = "qcom,q6apm";
> -						reg = <GPR_APM_MODULE_IID>;
> -						#sound-dai-cells = <0>;
> -						qcom,protection-domain = "avs/audio",
> -									 "msm/adsp/audio_pd";
> -
> -						q6apmdai: dais {
> -							compatible = "qcom,q6apm-dais";
> -							iommus = <&apps_smmu 0x1001 0x80>,
> -								 <&apps_smmu 0x1061 0x0>;
> -						};
> -
> -						q6apmbedai: bedais {
> -							compatible = "qcom,q6apm-lpass-dais";
> -							#sound-dai-cells = <1>;
> -						};
> -					};
> -
> -					q6prm: service@2 {
> -						compatible = "qcom,q6prm";
> -						reg = <GPR_PRM_MODULE_IID>;
> -						qcom,protection-domain = "avs/audio",
> -									 "msm/adsp/audio_pd";
> -
> -						q6prmcc: clock-controller {
> -							compatible = "qcom,q6prm-lpass-clocks";
> -							#clock-cells = <2>;
> -						};
> -					};
> -				};
> -			};
> -		};
> -
>   		nsp_noc: interconnect@320c0000 {
>   			compatible = "qcom,sm8550-nsp-noc";
>   			reg = <0 0x320c0000 0 0xe080>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

