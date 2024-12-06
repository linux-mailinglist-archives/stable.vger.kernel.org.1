Return-Path: <stable+bounces-99949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E45B9E74F7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D5F1604B4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE61207E1A;
	Fri,  6 Dec 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="42fbc/5q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05632066F0
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500576; cv=none; b=GaGmBzT8EjbTW05yM1DbLaURP38X7eEIHktpfdbLP77htl3wwdGbHfa4XEM59qJLbRd3rUng4olrVM/n3q9LQi6bx10Vrcih1TH/3FzPc060ucbIC9o9/uPqjJmbEcK11TJiOoHzxwFp26iKJDXX2P6crgGIH1NzwWFhvVGxT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500576; c=relaxed/simple;
	bh=HiRM9JCXoPNEMuQmDgPmwpM+IFO+Ml8AHljm1CLjQw0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TGy0wQvjktjg3xoonFETUa1WNHqyg6QAa2WTcqocUle7yHvY+V7bi2jr4TLEAC+04+lk5B2dmdvM5MKqOXFnnY7uiq9LDE/98TkHqGSCwVz8BVGD2BoLwJNsKFk+C2BHSvDPwTbBMKhG0WKa+yPu1czq77Vv0xR4GHDAPrGbaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=42fbc/5q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so923387a12.0
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1733500572; x=1734105372; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhXG7usYN1Ndp7KrExGMRuLhz9e4x8sMn6Z7NQ1u10E=;
        b=42fbc/5qlLGJUg79O+blBo/u341Y48NLRBrg2VHTutSGPbhN4OcFx8W18R1Mfj8wJg
         AM1BhGMwgqeeM4Ft3XMC0mqmeIq+2WkhgZjyjZkPSI+b8/RRzijjpoQs5DbwI9nc9j1p
         n0e3dzV/QXFY/YcziU15pnrUVMJcf3kM8h9zYuG/R/VYLoCGYL4MLtgby+NhIoQEVKQG
         KoknmcC7OljJsRTuZqPf0nPmTnQq9kxlnVKaTRI68TdFUTm4sUfuCvEVVzUTB5E1NFZ+
         6TfqnI5x1MJiN1IZE4SruVr69HcoTwzw9531cvd/nh65ay75f1HJ5THPhWR8xzfhzoJL
         e3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733500572; x=1734105372;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fhXG7usYN1Ndp7KrExGMRuLhz9e4x8sMn6Z7NQ1u10E=;
        b=gpgCuLzXL2hwxK70HDSVw7ISHIziEW3dmYQx/dmL5UKgeskUokBuTk1kPZFFGdlt2e
         ZOSJFgS3o8dnQK6QfkJmqbXcUiHvzaAa0u5KeAFdY0hpaBY/APdzW35um7vAb9YDJrDs
         KpPPpHnNPxzI/tCxzzPE3DVV5vfMDAb0D2Tx/3BXYpVMosoLUoTbV2AipjIxdolYQw+7
         /7nQ4uqfh1QX/saqisUYRilC/4RkACnFiLUPt43Ype2PUliaSPEiZNMQ3Btn0bbAtZsg
         /A8gO67GDLEuoKzl1NBpS9eXFvtwqmRCYt2KLMjASNHahBPwoowl5n0k1SJHLnP+slbU
         iJDg==
X-Forwarded-Encrypted: i=1; AJvYcCUWjdxwYgxLeS0PJMbcIAQbhhSlYOOZTtHLIsU/EGBv3YHV4KOS45Yw+RNukLbFN6ZT3Pvy/7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vCQWQnM9ALn7rEMFnXnMi+PK1EZeN24KiiZ1x8PRa9IY6vG9
	SC2YlvBhj4smvQIIKunDKgdSH3KHppiVfQG+BokYcr40dM8FEaapU1GFuxPEFuc=
X-Gm-Gg: ASbGncujB7/yKnJybCSyp6VzmOrQsouaDMbIxWTg2smFCC8kjpO7Up/KUM5TeCgk0tv
	iexxAVt4PWGS8/bULER+sc/n0xIvZV8tqRUsjmwIhf1yF2xpwK72+FFMu9IiXdkjhrrsFDWbvgD
	W5XgaOUPbOfcp5TUqTNhc5KcNB6wO9g4qry+CjOuRtkJC5fCBZCzPeymqtzGiiFQIuKf0magNcd
	b1drek6szmPOBYrFI3lJqBDT6RTYaAQUAYwmE4c3pOYMPVjQQqdnkIMzKXqmaDeh6SAR5s7X+Rc
	p7lu5FDi+OF2EfVDJGKYo6SYm4fNgJRp2+hJ2xi6q4BMMetcHab853wjZIuqhw==
X-Google-Smtp-Source: AGHT+IH3JbFPMFTV/3kFiyKdRIaHb2mLz54BeVoJjzVAmHboemNCWABvF8tJd2pSZsnQF9LYk/+aug==
X-Received: by 2002:a05:6402:51cb:b0:5d0:8359:7a49 with SMTP id 4fb4d7f45d1cf-5d3be46563amr4160654a12.0.1733500572121;
        Fri, 06 Dec 2024 07:56:12 -0800 (PST)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5d2sm260347966b.93.2024.12.06.07.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:56:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Dec 2024 16:56:11 +0100
Message-Id: <D64QO0GGTG1H.1XNALA48Y0LX4@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH PATCH RFT 16/19] arm64: dts: qcom: sm6350: Fix MPSS
 memory length
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Vinod Koul" <vkoul@kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Abel Vesa" <abel.vesa@linaro.org>, "Sibi
 Sankar" <quic_sibis@quicinc.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org> <20241206-dts-qcom-cdsp-mpss-base-address-v1-16-2f349e4d5a63@linaro.org>
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-16-2f349e4d5a63@linaro.org>

On Fri Dec 6, 2024 at 4:32 PM CET, Krzysztof Kozlowski wrote:
> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
> remoteproc node should point to the QDSP PUB address space
> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
> copied from older DTS, but it grew since then.
>
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.

Like with adsp, I can't verify this information, but with this change
modem is still starting up as expected:

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/q=
com/sm6350.dtsi
> index 3df506c2745ea27f956ef7d7a4b5fbaf6285c428..64b9602c912c970b49f57e7f2=
b3d557c44717d38 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1503,7 +1503,7 @@ gpucc: clock-controller@3d90000 {
> =20
>  		mpss: remoteproc@4080000 {
>  			compatible =3D "qcom,sm6350-mpss-pas";
> -			reg =3D <0x0 0x04080000 0x0 0x4040>;
> +			reg =3D <0x0 0x04080000 0x0 0x10000>;
> =20
>  			interrupts-extended =3D <&intc GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
>  					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,


