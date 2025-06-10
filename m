Return-Path: <stable+bounces-152299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48BAD3AE8
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948983A33F9
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32597296152;
	Tue, 10 Jun 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Tk1Le9pq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D60295DB2
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564920; cv=none; b=F/IrN1cq78BEtLDW5GJBP2qvWeBluAZ/qX+LlIzZRRF9yvficdSVbR9exHDhl0QWW/2jbl9dSvTrcRHJS1Wdu2HcooFrsztrOar1Fsx8swGY8RggwJ3Qzt4+lyL+LpdbKCX2TgFkMHXy4w9o3tu1VetvqD6l/BhAHWaQGd+9Snc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564920; c=relaxed/simple;
	bh=NjF56yrieOMdsOe79bJFPgf6L3bFFKcGJx22BHCY6ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BdMYy+fQLxCIkXyKxh16MuzWP6lZyzGNmtbg2J/OGvkBo3fDoDAFsEDTyS+ATrg/+yySLQ0mYU9M2Bjo6iGiIGohBW78F0LK+DBYCEN/V8iwCggRqxpj6HOp3oO2B9e9SxKv0+VNycAPxYWNSiIybCAznc7dpOnU3Pww2DJPqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Tk1Le9pq; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-735b9d558f9so1431918a34.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749564917; x=1750169717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nPBVzecp2Cia52gZ18wBozuUbCPP69cm8rGB++G5SI8=;
        b=Tk1Le9pqroapsAsZ4BaWL5WYX8UOxQdSFK6496FAj5XrroQVm6Rj0LHhpzeVnnlF7R
         sOuUxrnQMDJ6CEPTZJzWD4Ty2lFqFz9468p6qaE/CNA80wvR7zgeiQFZUiBKYXxtF9g/
         oymbu1EF363uS74k00X7WX/8/R34ZpTro8qb52KnrS83B0CRs/PxE9y/TGS6A9e0NAGT
         Uujs0L61RhhZn7iOaXVjwYWc+mOPn2Eh8RHB3iw/IqBVcBZiu4ulrK3H3WCD1pesP7aX
         0zIS4U8Ih+ZGb3gfMNHCwZe23GN3DyiBpsl9Vevw2eP8Gb9NkAlRnluDoi2RPROHFcwz
         O/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564917; x=1750169717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPBVzecp2Cia52gZ18wBozuUbCPP69cm8rGB++G5SI8=;
        b=PJU8dM075VG6Tyh2ueVIlkZj59SNzRusnn5iR9W+CwWQNBKXIpkeaHVg0HlyWFgPcL
         2wnFNu62FXoCTEevuuymBLR6T4maDFOozJVP6nDkNxQfEX8A1Pe+No6LiV4Csv0paFnv
         RqY8jmhSashtlOLtFAsuqL4KZBvCEMACXkHLfpHpxG9LGwJINqzOD/vzsj5MGf2sTMnx
         RMulIyd+w6DvNZEk7FFmB9xHMgKVTqz86pU/vEkPG5DEJceWSTXXFsFzOBveNb6wZIwC
         RKe/4SMZAD8qhgizyDh09HGZouxiYYwtynobpwyczfLX2524Nc1LylYUnc5cZtU6Y3sf
         uBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpU2zr3i5VGlnmzUTtWbczLHXI4INRcCWzoA8TpF47+0/LaRLDioAbxGMgQrrra7L0THecmMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxF7RXp/tARbCVSAOagLNgtfcm0wSbc1J75xb7bdz6Mp3KwxrA
	IAM11oBtiQQyXvcr3O7vj9xKNfIZ5NshgNaHU9PF1WJk74bOESB7eg4sMqRp52aDrAk=
X-Gm-Gg: ASbGncu/omTJPNTPPveEmr5h5kzVWUD7QqNqNtaRQJhgq3g/DbX6eq4nSSDl9KGNRFD
	m+i8p5GxIF2gQeVF5tkbFFaI88UmyvolHJalLiRE3JTBfyPC/rFJUi5ndxjKxaWbQ0acmdH7Zhp
	xmqxJTs0kA0MDxUO+JRwlL1jh3YmstnPdjsgGMrcOkIFtkYQrXbKKc7ZtVsiawDBm7AKwiLhdig
	1dlxfZCaJPNWFc/flR2AhglwaT+pJkXxdavS19dLUy5CcB+faKsvuZBmNplYIlcxfs//lb4ZCju
	lzaBzrSpJFkxZjl/V8F1NG0sbJCdm6hZ5kIdgbWSfeaFlFrynA1B6Xh2QboIrz0KlEysYyG9GIt
	RvDOhX4JeUwaiH+h3ptsib2mTGs0SvHwcfId17hBW53Eydvw=
X-Google-Smtp-Source: AGHT+IFepuISaXRsFeVR+Tc/snQTNIg/TRzv/N5RJrjyTVf8BK2Z4WPQkQbwPy+CVhmSUd9nHEBycw==
X-Received: by 2002:a05:6808:211a:b0:403:3660:4130 with SMTP id 5614622812f47-40a56b4b632mr1505150b6e.27.1749564917330;
        Tue, 10 Jun 2025 07:15:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a49:6255:d8db:1aea? ([2600:8803:e7e4:1d00:a49:6255:d8db:1aea])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40906a0e520sm2294244b6e.33.2025.06.10.07.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 07:15:16 -0700 (PDT)
Message-ID: <57d6cffb-644b-42ab-a494-80fba51b476c@baylibre.com>
Date: Tue, 10 Jun 2025 09:15:15 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] dt-bindings: pwm: adi,axi-pwmgen: Fix clocks
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250608172432-60813911671e4e29@stable.kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250608172432-60813911671e4e29@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/8/25 9:34 PM, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found matching upstream commit but patch is missing proper reference to it
> 
> Found matching upstream commit: e683131e64f71e957ca77743cb3d313646157329
> 
> Status in newer kernel trees:
> 6.15.y | Not found
> 6.14.y | Not found
> 
This patch landed in these two trees today, so issue no longer exists.

