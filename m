Return-Path: <stable+bounces-99938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2FE9E7493
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBF5284054
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39A20C03B;
	Fri,  6 Dec 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqYv2ZtI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA83206F05
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499658; cv=none; b=e1ICf+Wlf3g5fGVN+ua/rgDd7WdKJJBkK4QOEQ2POfRJ7Ak/2ogrKrJvpknuSJgO4eeRsvSPIqqkfNmgR1PabzquEp780Y4uHuWy0CSGATvs2uLlODwgRf9UJZ8OYt22qfQi4BYkNEYZWzr9xbcIDuhvf8lnG7qiPwVg9JOEzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499658; c=relaxed/simple;
	bh=Cw7CIvhRRm6GoAkNUjnKOvsN5t5uxXgXeMcanvc6Hlk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mqBYpG1/8QjZSBkw3XfgwkVXJ6STZ+0FkXdwoUKj3hDQMlBVNjVbNMEWBJuOa+y0Pu7cEcioU9HjCZYmhBRlpRVSg/yT7kt6RB8k9OMbKohge4E5T6hI5jqc7PhDhyuwBHFLKrw8tOhts4q5NAJrnf+YZ6LA4Or01pY/hgaGtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqYv2ZtI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e2880606so1913775f8f.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499654; x=1734104454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWqntg0RFUhzv+UNp2DltQ7Wlk+GGCS3rqR/Q1P1cLQ=;
        b=LqYv2ZtIqhnLhIM+Z1m3Suzw94IS2lrzvgjPazyuiutVyRGCCoQSsDuOWAN9d11by3
         PriirlrGYYT4AM0Ct4B14EBa3HxZxsysroyxOEd9g+F77M78cCqYLgrP+xAsS6AV9k9Z
         CzAtKrtLIT/c8R2vm/nnI7c85Ca9jYiHLbr1kcQksxxiUPjUAHd35xaCOaXvYVlcxf8C
         gyJ4O9kHhztWmLbW5pyyewEUqDo+taMJ2dwcISJvb/kpOj9U+zl1V1VViScqoJ41qwiv
         r3J1zpnyVGR2uEBFw3HwJ2onWedaitKJlGOF+ZORzGpAkVTesjh/iSZF1Sc3JvOam3+/
         SCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499654; x=1734104454;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WWqntg0RFUhzv+UNp2DltQ7Wlk+GGCS3rqR/Q1P1cLQ=;
        b=hBP8rS8BZvfSN/R52RQg/2Jgge1USY4E9F5VTEI4VsdkugxtKypMNQRPnMgQv1wQQj
         Xa1XXPKJMw2Onn1XND9cYrRMSUUWoNqRahGM2uck3PAKb0NyjSDyO1YW+mXRcFzsU3Av
         ktVzHdkYKC9SDCaBdqc2wFS1/2rJgIcm3OCOYGH/19VRb90xdgfttzjZ5ZdhG80zD/mi
         gL8Zaftz8mksY8Bp+r0NK4YdWXaDwBh6G04KFRhE4TVff/XvP/+j0eC8Ifeiqqh1C7lh
         QXJh4yblcJBOqJ8df2G9bQaeTg5x8LsSL87tN9V+PniOUfSLW7aMhjfCwnsEdQ3bF9e4
         JgSA==
X-Forwarded-Encrypted: i=1; AJvYcCWItq1rpmgTEGjXChfK/cShmqF0tbL/+cZaeSpU2E87Sz3D0DOo3a1QsKOp1YwOG16TwvP7qhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZN1buP2ixndP6IslofrptSlfx9PjLghDpOI8212zTmg6bkfTZ
	vKYYGFVfudXVYAcAdIgWQolAqo4m67w5jvDctfjFxl/nLxBDqpn+ADq99vFu0Ms=
X-Gm-Gg: ASbGncuvzRRuxnA+a9m8HvdFM3XqpceSFXbWYsWZBzs4JWHikyHVeA3ywkwvC2ejCxC
	BiRhnkMw/4/sPuTvKabjhQjX88anFxY3NeoXaOBTwYaYgRPtrQahW8HaH7vZFIPOL+u6/1lt5Wh
	ywly/QuW6iTxyxcZasBY9Jw/zvMr9gj9AuuD7j7BXOyMGubcsGCHRbl1pMTdU+Un+1FWNWKbyA+
	UaaqAsy43kEed43PX1ABAYEaiYg8aQjPMpJle2jZ7oxTIFUBR9ou8mudXoIOB4hK8I96Ans33l0
	wI1KpiH741NVVyxvNyfkNx4kqxI=
X-Google-Smtp-Source: AGHT+IFlnyH/jD2nynjtvBEVw+BpXOfbJPqFVYOHmk3gJ6IJYEa/fTutfXA9AkC9pxx8mH0Yoekw5g==
X-Received: by 2002:a05:6000:705:b0:385:ebaf:3824 with SMTP id ffacd0b85a97d-3862b36b7f5mr2969117f8f.27.1733499654199;
        Fri, 06 Dec 2024 07:40:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889? ([2a01:e0a:982:cbb0:bf3a:f04c:5b99:c889])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862eb06e00sm1235152f8f.99.2024.12.06.07.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:40:53 -0800 (PST)
Message-ID: <d9c0981b-f3b2-4079-bd0c-cfbd67ad1212@linaro.org>
Date: Fri, 6 Dec 2024 16:40:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH PATCH RFT 10/19] arm64: dts: qcom: sm8650: Fix ADSP memory
 base and length
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
 <20241206-dts-qcom-cdsp-mpss-base-address-v1-10-2f349e4d5a63@linaro.org>
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
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-10-2f349e4d5a63@linaro.org>
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
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 296 +++++++++++++++++------------------
>   1 file changed, 148 insertions(+), 148 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 25e47505adcb790d09f1d2726386438487255824..95ec82bce3162bce4a3da6122a41fee37118740e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2904,6 +2904,154 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>   			};
>   		};
>   
> +		remoteproc_adsp: remoteproc@6800000 {
> +			compatible = "qcom,sm8650-adsp-pas";
> +			reg = <0x0 0x06800000 0x0 0x10000>;
> +
> +			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog",
> +					  "fatal",
> +					  "ready",
> +					  "handover",
> +					  "stop-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +
> +			power-domains = <&rpmhpd RPMHPD_LCX>,
> +					<&rpmhpd RPMHPD_LMX>;
> +			power-domain-names = "lcx",
> +					     "lmx";
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
> +
> +				mboxes = <&ipcc IPCC_CLIENT_LPASS
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				qcom,remote-pid = <2>;
> +
> +				label = "lpass";
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +
> +					label = "adsp";
> +
> +					qcom,non-secure-domain;
> +
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +
> +						iommus = <&apps_smmu 0x1003 0x80>,
> +							 <&apps_smmu 0x1043 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@4 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <4>;
> +
> +						iommus = <&apps_smmu 0x1004 0x80>,
> +							 <&apps_smmu 0x1044 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@5 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <5>;
> +
> +						iommus = <&apps_smmu 0x1005 0x80>,
> +							 <&apps_smmu 0x1045 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@6 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <6>;
> +
> +						iommus = <&apps_smmu 0x1006 0x80>,
> +							 <&apps_smmu 0x1046 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@7 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <7>;
> +
> +						iommus = <&apps_smmu 0x1007 0x40>,
> +							 <&apps_smmu 0x1067 0x0>,
> +							 <&apps_smmu 0x1087 0x0>;
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
> +						q6apmbedai: bedais {
> +							compatible = "qcom,q6apm-lpass-dais";
> +							#sound-dai-cells = <1>;
> +						};
> +
> +						q6apmdai: dais {
> +							compatible = "qcom,q6apm-dais";
> +							iommus = <&apps_smmu 0x1001 0x80>,
> +								 <&apps_smmu 0x1061 0x0>;
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
>   			compatible = "qcom,sm8650-lpass-wsa-macro", "qcom,sm8550-lpass-wsa-macro";
>   			reg = <0 0x06aa0000 0 0x1000>;
> @@ -5322,154 +5470,6 @@ system-cache-controller@25000000 {
>   			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> -		remoteproc_adsp: remoteproc@30000000 {
> -			compatible = "qcom,sm8650-adsp-pas";
> -			reg = <0 0x30000000 0 0x100>;
> -
> -			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
> -					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> -					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> -					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> -					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> -			interrupt-names = "wdog",
> -					  "fatal",
> -					  "ready",
> -					  "handover",
> -					  "stop-ack";
> -
> -			clocks = <&rpmhcc RPMH_CXO_CLK>;
> -			clock-names = "xo";
> -
> -			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC QCOM_ICC_TAG_ALWAYS
> -					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> -
> -			power-domains = <&rpmhpd RPMHPD_LCX>,
> -					<&rpmhpd RPMHPD_LMX>;
> -			power-domain-names = "lcx",
> -					     "lmx";
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
> -
> -				mboxes = <&ipcc IPCC_CLIENT_LPASS
> -						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> -
> -				qcom,remote-pid = <2>;
> -
> -				label = "lpass";
> -
> -				fastrpc {
> -					compatible = "qcom,fastrpc";
> -
> -					qcom,glink-channels = "fastrpcglink-apps-dsp";
> -
> -					label = "adsp";
> -
> -					qcom,non-secure-domain;
> -
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					compute-cb@3 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <3>;
> -
> -						iommus = <&apps_smmu 0x1003 0x80>,
> -							 <&apps_smmu 0x1043 0x20>;
> -						dma-coherent;
> -					};
> -
> -					compute-cb@4 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <4>;
> -
> -						iommus = <&apps_smmu 0x1004 0x80>,
> -							 <&apps_smmu 0x1044 0x20>;
> -						dma-coherent;
> -					};
> -
> -					compute-cb@5 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <5>;
> -
> -						iommus = <&apps_smmu 0x1005 0x80>,
> -							 <&apps_smmu 0x1045 0x20>;
> -						dma-coherent;
> -					};
> -
> -					compute-cb@6 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <6>;
> -
> -						iommus = <&apps_smmu 0x1006 0x80>,
> -							 <&apps_smmu 0x1046 0x20>;
> -						dma-coherent;
> -					};
> -
> -					compute-cb@7 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <7>;
> -
> -						iommus = <&apps_smmu 0x1007 0x40>,
> -							 <&apps_smmu 0x1067 0x0>,
> -							 <&apps_smmu 0x1087 0x0>;
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
> -						q6apmbedai: bedais {
> -							compatible = "qcom,q6apm-lpass-dais";
> -							#sound-dai-cells = <1>;
> -						};
> -
> -						q6apmdai: dais {
> -							compatible = "qcom,q6apm-dais";
> -							iommus = <&apps_smmu 0x1001 0x80>,
> -								 <&apps_smmu 0x1061 0x0>;
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
>   			compatible = "qcom,sm8650-nsp-noc";
>   			reg = <0 0x320c0000 0 0xf080>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

