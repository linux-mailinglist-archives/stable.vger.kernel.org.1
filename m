Return-Path: <stable+bounces-67618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC4E951843
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89282285B53
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 10:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8A13D502;
	Wed, 14 Aug 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0AxZ7mO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82C36134
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629809; cv=none; b=CgdUKorh3Za0acULBe9hORXErIsxzyeJjdD8Qzhk1VWt4ZkNYamAxYiU/A+YKpnQ22rfY6yvLnOatuDTrMGzf3XgqI1xE1kNi7fpviW6E4RJpm4hKCUOyKb/cbdt6RaoYe1hnyvCW4vktxQR1z47jeabAniyNOHsDbU5yKMhYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629809; c=relaxed/simple;
	bh=e8XyBB4yp1va/v+zfC3Kd+5kJrc3+5KmEpkmNaa5DPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d66XiKHjEwilFqRUOgDAJRPyj8QVTwJYgxucn8Fn9x3XFyKk+sStJcc0A9+EJQKjhrhzqnU1kZw2fvNbQeGyQq94C1g73w4yMr3X8gUZFXU42gxubXNNidx5DBaJeRbfJYF2mSXTeFaebWvkzACU4oD+KUkcp3wBaMfjPhZglyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e0AxZ7mO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ba43b433beso7035218a12.1
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723629806; x=1724234606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6AdZbX4AePgyvzpCvj5p2nD5PTKuc5dc/y4Q+eKt9M=;
        b=e0AxZ7mOEqlVOtejltu5XdqFvCne1D0x64LuX6oD5EDz+NfSp1uYWcN18S2PMPcDif
         ersQaKg3UmpJXNGqHMjBzUTXiWeqgPcWW81c+Kgt60f+hFUzW4eGC/vaToD++brVw88u
         ytLURHMSIQAoFIQeC9xecAGRO+1aVWc3jgbhX84GUz9qaxYEaVnOYpXGKB1JR5lIBviI
         W2s4Je9E8ZQU4c37dUpCOZjrvCSNwc5QgC+ZvgbNWIvRGFjzaMaGVU5DEbXHcBYU0udK
         gT5SFcs28LprdnUzx0AZaR5n74r1Z7pQPbiktAUKOuNm/wL+zVH1uLAKWzm2BwJyFjt7
         HSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723629806; x=1724234606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6AdZbX4AePgyvzpCvj5p2nD5PTKuc5dc/y4Q+eKt9M=;
        b=UJ+QsfOMr478nvvpQihRLJWtTdPC+R7NwbUJLK7/XjfG4cjma845EUS+M+54FuchAK
         o8NCusvnuidxgKO2wEnLePG4pNz1+vu44Vaxm/kbHRygCKBhA8dyl3xYazAd1W3i7Uxa
         f7aY7ohDPNWAYSrU3CI/mP8yj+bMnE1GSenANxilDAwuPMQGXthlqUnKkShHS6w12SP0
         p7RfPHIbnRqeB0ix6dHRFI003lJdgWGw+C8q7s+bhsNbIXmwyQBOzAN6F59KG08Yxkud
         8tS+SmYqc5s/sA50VnFaAOSn4Ls/SPmUB/QLQU5oDO3iHE3jgtRjhYu8aoX9IaUgqTFS
         MDYA==
X-Forwarded-Encrypted: i=1; AJvYcCUkxhRmfGV4UV18ubSnRYg1leDSbA926Un3irs1m7+EQy3Oly8pO/S8qjTfBZ3JLaRVHZBIe8WJ+y7KXUiw0cHwm6TUaS15
X-Gm-Message-State: AOJu0YyrhfnpXeLb39742TdisNFxpeCNZ0RReN3dk5/S9bw5M6YfPEFS
	y/qeOlv9qyJLt1sUsD1352sjgnYZ/JNbS9RK2MQywep9u6IW2vJn37xXTneSd+A=
X-Google-Smtp-Source: AGHT+IG3zu5ucEGQ87VA8smXNp3wJ21CmD2nr1F46xm876h9j+Ns+xJkXp5EW311IGIDO9CsfcC22g==
X-Received: by 2002:a17:907:97c3:b0:a7d:a080:bb1 with SMTP id a640c23a62f3a-a836702c7f0mr160179666b.43.1723629805596;
        Wed, 14 Aug 2024 03:03:25 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-161.dsl.sta.abo.bbox.fr. [176.184.32.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa5db7sm153381866b.58.2024.08.14.03.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:03:25 -0700 (PDT)
Message-ID: <a3673d8c-3ac4-4e7d-afda-85741d0f4d28@linaro.org>
Date: Wed, 14 Aug 2024 12:03:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] MIPS misc patches
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 stable@vger.kernel.org
References: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/6/24 15:11, Jiaxun Yang wrote:

> Jiaxun Yang (3):
>        hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineState
>        hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection
>        linux-user/mips64: Use MIPS64R2-generic as default CPU type

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



