Return-Path: <stable+bounces-99948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C056F9E74EF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A1728153E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC0C206F05;
	Fri,  6 Dec 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="QhOry9qg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675CE62171
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500547; cv=none; b=cxZmsk4F7vJadD751oSWKe2pjihk4y79c+70BTYu0DZHh+QdOPL5T4nS3XbnynzaQR7SdEVVM5o9VUXC5lbrnjG2No2SEjufhAGAWoXs45siN1iRrx4MxISREGW9X56c9W2OVo6bLbv3oFxp+uLfOZy3eOU1f2sDGrlRzp7T9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500547; c=relaxed/simple;
	bh=1yO6WKMg7Reae+Xm/8d6dxOzkvnym7CeZdHFGZWhpNY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mTt8w9SPMd67wppKnqac5YYaHtQwzDgYzoyWYlTP3cjpgB0E2P6wZxrRDUi1jakHmlwQOXevEmDc9bqchlvMBuVbmf3nM1UmH85tI6t3ejHm9fvxa8DBTw49+6aKBuanDkeUdlMtaLLod8Lnx4l+cydihVaLBfutbJHW+Kg0M28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=QhOry9qg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862a921123so709101f8f.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1733500544; x=1734105344; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfETEog9kNwm+ZEaU4iUILsAuYULWf3mToje1NA0XUs=;
        b=QhOry9qgOlNRdlW+MykgpdjdeSYk4BTQ9q4iXxQ5lcycMTITZ0T7ATYJ2UL91aLfah
         4k9Kis0MOD9lBgviO/sUbsp9zjhQsc/Z9qxScLpEDFpPJqanIWvi75iEKlT4w2S3faig
         /MbSo1ne1WrBxTFL3IaZ+SaLg3ujNAt/DQ3QJprmCVMIUGQnuwJhO0sYxMyCvnYbXALZ
         AxTBmJy0jhj/5O4jHeW/SkyQPmWeM+sfsl9i5LP20z+qMR+dLOeJKoKCZvSUI2iYu8if
         ZpsD1xJmhuBKi8foWaPcOwlRBtc7d2TxcbyHZaM2co6C989iLF8vxdv0iDuYJXQYF3Pm
         uAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733500544; x=1734105344;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CfETEog9kNwm+ZEaU4iUILsAuYULWf3mToje1NA0XUs=;
        b=qQpwLUxiiTqK/4nK1TQ8/eLSGfEHjvnGS3+cAnrlkmbNcPVKjkdDdwoNlKYU6cdeGc
         SAQtYWq79UquiY5er3hSTjiKRi4NGGf3C5y3KxnknHlVUD8F7jGB4sRMqzVFrLraIGGj
         fE1x46wIqs59IlarTquW6ltcXjlt8JvUDDWhmDvHif78yT+uoqIi8RT4HChTnFWjihxD
         AXhD/M2hFPKQ3XYmyacBu3N6yfJOTkAfy7SJ6yKdr3tifxJA0by/jTAHJoDGs/TjquMi
         x7328CxElHvcwi6fyVZprri9a0R6J2TfjiKXFvRpnvadXa45EtykQn0aFIxqX8cjgcwd
         yUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMqHuTZq55v2d6NaN96MIbcKN7FyjgP04pAfXQDyy1twVoFgG6KYfQBp3JEtlI2PmuDh3QOjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypiShPUZAqGoRyE+sGo1DMM0nyTgFKpZfLxtAZkLuw2ZnLOuuT
	hZSMkmJ74JAJxY4xRjs7JR2YVzPAK7815p/OXwdc0TOmMLQSF1ArI5pzRvrMzxo=
X-Gm-Gg: ASbGncvxcvCZMpCQj+6Emi3FOB5ArBA/w7ItyIqEdxUjiSQxkfrDk0Wtc3VX6GFzKv5
	nIEaThJ7avUNfr4HbfItFvoEJ4sPJ9TITRm4KlUeXDfVWKZKH4W+/UNicya1I+KtN+F53EoevEY
	BP8Y8cfAJxBqqauvAoUgPbaoSR+bUWOcy25TfeySNZWDtK8lmzgpVluwBXV6BNv1bDe4Z8o8nlt
	boe7/+o8COFJeR/mhUOjwczshPdeAF0JRee8h0wKoEEmEXyek+sKCoRlgtPDmw7119BHqQ0OUrD
	d6RCyErTvsgdilXKkQx3MILu5Ja9WtQOhaRzQc/Xcf7u3m1JjZZMEx9lCftL7A==
X-Google-Smtp-Source: AGHT+IGju/HpCMcyMpb2m3aBcogWdUR4ZrgWhZBrYlBGJa0J4A5vDrFJeCwRWq9jcVih3UR26XBMqg==
X-Received: by 2002:a05:6000:1f85:b0:385:ec8d:8ca9 with SMTP id ffacd0b85a97d-3862b3d09eamr2648760f8f.42.1733500543773;
        Fri, 06 Dec 2024 07:55:43 -0800 (PST)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d7158c4sm1698774f8f.54.2024.12.06.07.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Dec 2024 16:55:42 +0100
Message-Id: <D64QNNAMVMJM.3NDC6J100E8ME@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Vinod Koul" <vkoul@kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Abel Vesa" <abel.vesa@linaro.org>, "Sibi
 Sankar" <quic_sibis@quicinc.com>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH PATCH RFT 15/19] arm64: dts: qcom: sm6350: Fix ADSP
 memory length
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org> <20241206-dts-qcom-cdsp-mpss-base-address-v1-15-2f349e4d5a63@linaro.org>
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-15-2f349e4d5a63@linaro.org>

On Fri Dec 6, 2024 at 4:32 PM CET, Krzysztof Kozlowski wrote:
> The address space in ADSP (Peripheral Authentication Service) remoteproc
> node should point to the QDSP PUB address space (QDSP6...SS_PUB) which
> has a length of 0x10000.
>
> This should have no functional impact on Linux users, because PAS loader
> does not use this address space at all.

I can't verify this information, but with this change ADSP is still
starting up as expected:

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

>
> Fixes: efc33c969f23 ("arm64: dts: qcom: sm6350: Add ADSP nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/q=
com/sm6350.dtsi
> index 8d697280249fefcc62ab0848e949b5509deb32a6..3df506c2745ea27f956ef7d7a=
4b5fbaf6285c428 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1283,7 +1283,7 @@ tcsr_mutex: hwlock@1f40000 {
> =20
>  		adsp: remoteproc@3000000 {
>  			compatible =3D "qcom,sm6350-adsp-pas";
> -			reg =3D <0 0x03000000 0 0x100>;
> +			reg =3D <0x0 0x03000000 0x0 0x10000>;
> =20
>  			interrupts-extended =3D <&pdc 6 IRQ_TYPE_EDGE_RISING>,
>  					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,


