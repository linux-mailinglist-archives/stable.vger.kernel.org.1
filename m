Return-Path: <stable+bounces-60623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB5937C80
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 20:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79D31F21BEA
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DEB147C76;
	Fri, 19 Jul 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hObPZZq6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CAB14601E
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414074; cv=none; b=lN7sMtZ8+SDtOpIRQ+OqiVpeLGRsP1VReTLCRbxCW+3501lVVtrydJrk3Isqz/EK+3bkS6Vzr3+8y/0a5eZTPv9DgPy1vS1PjelvY0TGltqjZtKo2ABQEDl3/KCc3qObk5Iva0CKlXmDDqhqy0d5mcqZBivaSzQ9eVptIZ/vBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414074; c=relaxed/simple;
	bh=Eoh6Aq1gvb9UVPn3lR/rBomqqw573VWDNiA8yB3phcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGnlsY+2Oxl79q2qe2QxYmOlppBPsA64xuLkNt9LjbyFImZCkqQ9Ow+BJNGqKMC24QGGWgZj8cmyyyjMCH6MPLNjEw6lUYUeUqMBykxi8YGSlyRRH7DUll++V+nosejhyf1qXuLU6j8SE0XmXs8nhDGIkqYdjbwsHqiC5kSogjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hObPZZq6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77e7a6cfa7so243872966b.1
        for <stable@vger.kernel.org>; Fri, 19 Jul 2024 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721414070; x=1722018870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hs0XOIz2by5Qi8Z6C39BHeWCTQEj8qFbH9F6RrOljtk=;
        b=hObPZZq6BgEHMlg6nweNtkMrWOKyaXb+7M7J1JR8vMItMdomecCzazqoeMsdQi5SX9
         Tji4nwqjL1AIphZzpxtPaPW4JIhTXm3F446HU0DBo5ah6yGFz8bJub8tQ33BSwlI+Ksp
         2oY36w9l1DXxZzIoeId74j+UlE+r6XCKJlFTAZunDzGZrswiOZmgmi8awv3uvQDrRchT
         UcXfehjPwWODWlg58wcIF43WA5zAVukYAVnxQwleuJy8SQKYIGK8ubbJ7pZoJ3nzPZ31
         zww4yk2k/cOCDj3JCSJ+CuFdRQAhcoBSs+qux7Tr8olxU6edC5FbXImRjA4ZojvPVO1P
         suYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414070; x=1722018870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs0XOIz2by5Qi8Z6C39BHeWCTQEj8qFbH9F6RrOljtk=;
        b=H/ACfEd2mT3X/k/ge0zKBRTkPKptMvrx/EgdBdXoJYuGsvyIaEDZoy3SC0UMiyUest
         CeQghZo6vK0jEG09svtShHGrKj/W1GK2OFTPDj+xPhazAkj8NYmMLiEW/W3pVH9jEHd1
         gWsMYRwc+Xz4TZJnnOw+2mGRtafstCSBT7lR8ugFcJKCy344RpUHGrt5Sqh4AgUPm6iF
         2Vd1nXxbsXQzyOcH2+RNkefAp93UK6+/kdOaGUTAs60oSbjUAcvlRm4POQkKnVG16RPG
         eHvRWfFe3mIZIfvl9/thl+Yz8U/JR+u4xcRJnqs/PXu1KOqerOL+KCWOwaUEIUkl6B/J
         t+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyTZ8Ii0exaSZ/rbm+C5OAgE+dodxp1VIjZA/j9m9nBvUW6mmfOtzSsMKves0U0IHML7DAfFaUeW2Hr248mjJwt3J8tr2v
X-Gm-Message-State: AOJu0Yy8QoRt2AKlK5QEPwxW2jb11CzmkDmb92fdrCKwPJqeBfGr4r4k
	TJsabCEjfsDPssP7gQMR3ft3vZdr41EWSf7Q+75bxIdYaN/0vESE7YQPJaWa9pY=
X-Google-Smtp-Source: AGHT+IGL/8xmEg4f78v9lpdI6TbTW3HfZ4KukHLxpgWri/nzzX48d6LEwWn2aA/S1gsK0/kdwB6+VA==
X-Received: by 2002:a17:906:4550:b0:a72:6375:5fc4 with SMTP id a640c23a62f3a-a7a011177b7mr522091066b.11.1721414070194;
        Fri, 19 Jul 2024 11:34:30 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7bde59sm63194166b.74.2024.07.19.11.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 11:34:29 -0700 (PDT)
Message-ID: <aa099580-c0d6-401e-9956-be4a6b595dcf@linaro.org>
Date: Fri, 19 Jul 2024 20:34:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: qcom: x1e80100-crd: fix PCIe4 PHY supply
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240719131722.8343-1-johan+linaro@kernel.org>
 <20240719131722.8343-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240719131722.8343-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.07.2024 3:17 PM, Johan Hovold wrote:
> The PCIe4 PHY is powered by vreg_l3i (not vreg_l3j).
> 
> Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
> Cc: stable@vger.kernel.org	# 6.9
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Mind fixing that up on all laptops?

Most of them are 80-85% CRD copypaste designs and regulators for
precise things like PHYs are generally predefined for a set of PMICs

Konrad

