Return-Path: <stable+bounces-179481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC7B560F3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0380583F8F
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8DB2ECE9D;
	Sat, 13 Sep 2025 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4r9yMcT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DD2E8B6D
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757768239; cv=none; b=QxpBzwbewHgB0A6s9JXoBRna/2RHTjTUZiwChdMR1ZwmchKRTzZGz8vk6Tsw858S3InQldGVGn7hLLJKd2wNuCYh+emj9uiUojYnMhL7+qNYCGoxwgwMBZ06f5MjRkVrLn8TCfaPa9djeOjuZ+/baML8bdMvPT6PpoWO1KqywF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757768239; c=relaxed/simple;
	bh=tUiYl0q8nzJqURhBlH50zoLRaS/z9qcITQokKmLz2p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMWv86k4FhEZWqa9V98Y2DjZdtjnYGVWVdgkHuZYfNTlUaOgv2/QInqp4Yc892uBqK2UZhsHRx/ruHTL/hwEz3IWQ6xPy1pTK4KpIx9YP6mvwg9iaxtwwUj6jlpEY0pxeefr+YN4zmPPelzi0e4bYqFS2zamaCtbFQyi/G+ma0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N4r9yMcT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e93c6c4b20so23382f8f.0
        for <stable@vger.kernel.org>; Sat, 13 Sep 2025 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757768235; x=1758373035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ajlX5M9D9raPkoDC7DsJaAjqkrSXNAPNl1i9qyNoGCQ=;
        b=N4r9yMcTiT923AivOuOCM817JOx+o1P7JP5CiW2QiASdtJisi42/0ogxnA9EjRlhIl
         jmwraHq38BRr1uWL7elN5gv5Ro74atRIUZtf7rKArDgedYF8xxgTRe4Cx6FY1gmdXjvg
         KkizoZiKm7IczgC7TSl4b/C9Te9r9A4ZyDjGPs33Y+qDpzwPuPJxqt0eDU7IXw9J7quk
         PJFjJ0b1FXM9abTW4W5VxBhS+hGPFVpcxeVZVXs0fQ/qZyP1NSP4K3RrE/n/xXM4cxTD
         qq+3svhUQr8L5q7LKR8bVUqutIvTVDQhiSvp2JmyezhVALkSFQGZwLOgrNJQ0ku+90Ef
         FRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757768235; x=1758373035;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajlX5M9D9raPkoDC7DsJaAjqkrSXNAPNl1i9qyNoGCQ=;
        b=wDQ3IB5HCiOwA+7NW+j5XBrpH+Jqqx8V74n5EuG3FKKQIKjfR4/UepCwGglAJKDJBi
         Uce0uVb7G7d/QY9gnq8eQXGKJifD0mUkQMRjeS8/6ObirRDfw6wuP2T1FKZ8w7/nvBqF
         aLVEK1+XjJA1TqwsbFSQyEP1lqnNn8bqp4Z7/3xCx5mcoz1Gw0dHaygtpAZ6eseF52Um
         UTFtm7rOrCAc7f04R8dosh3CETPtZV2/yTHpj2zBLU2v+nPNfL8n+8UAa0a/EUeISGMG
         /uyDcW/lPDfLfr+4GOEtd2YI8blQ+w9Pkp12mWVBIHGRxggPD7hcBVKqlfMXPhK+S/5y
         p3bg==
X-Forwarded-Encrypted: i=1; AJvYcCXb09DD7NVP58HO2R31MlCMDpgD2FoU73Q3S5GPsU4amE/eHHrIwRXTIaF/j2fwDMCClvSD1Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnb/aUCZDTPUWD4l3K1gCByC4mnl6FYpYZnyrfRpulP+huS8R1
	szdV51yKt8Uc42a+xpQPWp4UFMr9U5EJnnF/Cyf021YcKIbAP9HQVTkwwWrOXB6jutw=
X-Gm-Gg: ASbGncsqy1Hx5chkGGlJfrjMmUPWDm6hqQYGxT6MndMeYdSftREF44f7mSCOyNgamVY
	8OclNx+bsTtXYdDE5mUURHw5cqUdnrd/Nk8GiGaa9QhyjQO4mZJ69XHa6QYdiIGrLQpUKquWm6N
	/4RpHXfORWBYOMX56liAY4aC6YrAhHyWojWVXyr8DkklNZM1fntqa8Hy60lm8K2kGIduWAdO8lP
	4Atjq6b7Ua33SV9Iwv2DSRmfBeWOvGdm59+3+6RW/kl9fUuTrBGgBaBD7NtYllMk9GyYhKUy7TG
	f2AE/5GuKwE3iPItzM6xhHbFzYFp+S/2Jx7kqnMgWnaHOjahWibNAbtSOG+5ZlSIegEpTKcxJnT
	45xbgavd+aQMil9AG6lS1jleV6oQ2pQay3sXsckL/6to=
X-Google-Smtp-Source: AGHT+IGn5sCzsoqc2MaMoViDVBdvECXXkAco+Eu+Io81V2kX6oTtmJINauxexWPqK3aRnlW4W1Kmug==
X-Received: by 2002:a05:600c:6090:b0:45d:d289:f505 with SMTP id 5b1f17b1804b1-45f211f859dmr32547895e9.4.1757768235253;
        Sat, 13 Sep 2025 05:57:15 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7e645d1fcsm4235977f8f.48.2025.09.13.05.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 05:57:14 -0700 (PDT)
Message-ID: <0ac9fe53-8f0c-4729-82a9-3358eec19892@linaro.org>
Date: Sat, 13 Sep 2025 14:57:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: sdm845-shift-axolotl: Fix typo of
 compatible
To: Tamura Dai <kirinode0@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <Message-ID: <2d41c617-b7c7-43ae-aa90-7368e960e8a5@kernel.org>
 <20250913063958.149-1-kirinode0@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250913063958.149-1-kirinode0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2025 08:39, Tamura Dai wrote:
> Fix typo in the compatible string for the touchscreen node. According to
> Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml,
> the correct compatible is "focaltech,ft8719", but the device tree used
> "focaltech,fts8719".

I am sorry, but why are you sending this? You were told this is wrong.

> 
> Fixes: 45882459159d ("arm64: dts: qcom: sdm845: add device tree for SHIFT6mq")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tamura Dai <kirinode0@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Missing changelog. What is the reason of this v3? Why are you sending it?


Best regards,
Krzysztof

