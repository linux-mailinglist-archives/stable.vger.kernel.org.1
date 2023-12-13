Return-Path: <stable+bounces-6640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A80811DD5
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 20:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7105D1F21742
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD467B5B;
	Wed, 13 Dec 2023 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECfmI8sU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DFEB2
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 11:00:30 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf32c0140so8299587e87.1
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 11:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702494028; x=1703098828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qK7Oyh72XFSFSL4xPkFqcCR8+DGBFGrbcMmMNxvkKPw=;
        b=ECfmI8sUg78xe6FINCnL/QtG2lG6omV10LmYW2AOdb01km5aL+xebUanY2y5xzjI56
         bRaX4LL8L/xGfobK+iZ96GwAodYZ++l5APN4+4JMHGmQLJJA1Fc/dpUl220CUnjvogRa
         mdjDzx5r3ltvrRju/GhW9l9+rEOl8xlicUOHPkoL/0+cuZk+zKm9TIMjsRk7PACBFxVq
         fnA1MSpaElJYs1MmOagrzs6oPizj2r7BJzoitUMS4dHb1GJTPALlNlxaeTHO6e+5Aizj
         po3T+QLiq5kIYkL7vWHgpRwlv8TswqK3vc2wBBbr8vZIE3d4OSfuB6i08aPozw/YCG3h
         affw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494028; x=1703098828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qK7Oyh72XFSFSL4xPkFqcCR8+DGBFGrbcMmMNxvkKPw=;
        b=ogsbAsh2rMxtjaKlUe/1UaJL4Jp+zwc5Tg4d7GKN0nSTBj6Z91lgThZ4nH8EjFjgFD
         O+BYzG5Mp3yio6oC4Zp3QB+lkpCr7zfmi0I8xiqJU2BNg2L8DgpMWHAflld7cOkP8Rvb
         EdTFMSn+35oeuVO08zSiQy5QBIlkXlTPT1kUj55kGDsz1vOleN29X8CHJE9U3Yu/6QgQ
         RpT14sklFIJqPvrNaj4g03UDvcfVEoSaCJLN7rKLEoKOlBe5xodzxjQKt0auoUqZrW7A
         lM5ulOXPWE4hZqUJCSzPnntkkKoHy7E4SIG5Q7KTBgTqebTIAc64o02kSEinbVM9LsPS
         zLsw==
X-Gm-Message-State: AOJu0YyZSxZcHefjuiC+o+/HviRPQ56Bw6DGVG+oD7+ig1o2TXILsD5G
	OQblE0gZCjnFR7/ocGeogQCjpQ==
X-Google-Smtp-Source: AGHT+IEjXurmiqb7G4f2AEjbM9CKTFKc2qPOfSmJeViFUwTe2NCpCJa8AveSRgjNSxmd4lBdmfAQEg==
X-Received: by 2002:ac2:597a:0:b0:50c:125:c6c3 with SMTP id h26-20020ac2597a000000b0050c0125c6c3mr3803080lfp.128.1702494028402;
        Wed, 13 Dec 2023 11:00:28 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651206c400b005009c4ba3f0sm1680336lff.72.2023.12.13.11.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 11:00:28 -0800 (PST)
Message-ID: <4ee3e8eb-de4f-4dba-8e66-966ba7692d83@linaro.org>
Date: Wed, 13 Dec 2023 20:00:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8150: fix USB SS wakeup
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jack Pham <quic_jackp@quicinc.com>, Jonathan Marek <jonathan@marek.ca>
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <20231213173403.29544-6-johan+linaro@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173403.29544-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/23 18:34, Johan Hovold wrote:
> The USB SS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
> 
> Fixes: 0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
> Fixes: b33d2868e8d3 ("arm64: dts: qcom: sm8150: Add USB and PHY device nodes")
> Cc: stable@vger.kernel.org      # 5.10
> Cc: Jack Pham <quic_jackp@quicinc.com>
> Cc: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches ds

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

