Return-Path: <stable+bounces-50088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B67F9022A0
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 15:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A461F23809
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275A84DF8;
	Mon, 10 Jun 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0LCZwGN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88474048
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025848; cv=none; b=KMg6RYNqO9bxT4xdbV1GFPXwvOXgMh1LuR/TCWmrBwpxvY6dY4ftap0ssNQwe6k2iABg1g/CZJhaJSq56JXgs9YGRZlWFWqIhBjLk142PnL8TaAfB8cFTZhsF++21f2XgQ9guRV8yW7TMON77XR/esZZlP8qYZzKXyO6tf3UMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025848; c=relaxed/simple;
	bh=cv21a25imgzIQyzA2Q03tYU95MuYdhWUZXDOTajmmvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4yqpby5sv7qIQE/LGQsnlO6Z2bAwdp9XBanEe9ViJ0xlDpMCKh2aEm39UON0mUJqlcf9u79gNClbFtmYIkfD8+GJpHS6CxVvps4U0z3NwKLd4s/8lzj/u8OaUZk7B6tXjd+af1K9xsL2wjHSOKsz/wZ7LEdoqOEowbM+4QgBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k0LCZwGN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35ef3a037a0so2724801f8f.0
        for <stable@vger.kernel.org>; Mon, 10 Jun 2024 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718025845; x=1718630645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cv21a25imgzIQyzA2Q03tYU95MuYdhWUZXDOTajmmvw=;
        b=k0LCZwGNXUi/WhGyln2mBqXgXv9RnqU8iM4FTGiRQPP9JUC1rIdvqnAGwFV/tysxib
         W6DaYELNfma5ftfyKw57kz2Rg57q7JAu+Gfu/0xeDMB0x8M6N2SBe/WUYg+2cfH1NDAY
         QYR221zyPXiKh2VSqjc7hpcRJv7HNppN8XvaPtVOOIFMWNZw9o20GMkfeyrRxy6t0EE1
         AxJn0dQUaoILdbvu3phIX0DkeYNAoDb38+cXqE7oUY+kjHrz1LUJjAwySDLw7KT8EP5S
         8pp56yL2d1FMUw/sjNQ4pJYQhxlhrte0rOzgRJEe5ERRBn2x08g4Z3UMd7SHSOZlZ1qo
         P+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718025845; x=1718630645;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cv21a25imgzIQyzA2Q03tYU95MuYdhWUZXDOTajmmvw=;
        b=VLDtkbEXmEURslMZnbBtKkO2JQMQ6b+twfgX0dwFpKBvdIi7KZPvRHmH+xSHoczA3B
         RFQy1S/FHzuoVzS8wPr/T7XDmwfpDiTJFeku6cCaAiwLrG1ETF3ArLKFxRkNHedribSd
         oWSSEeeik6sjR44mDGhg2Hg4GDVYOejEpZ/JCxGvRUCAd/3MQhe2Eks0vp5oEPy+nBbr
         8J3Jzk/RVljOTpjBhOnIxrIEFfM8tRADfO1Ie94tiI1ASbpPwmVexl+cdhz2F7WkRkrM
         sZLYORcCYyTGKcZTlLkzQ02JfoiWqFbWb6ioBEm1DA+WHKkbr0Iyc34PQHOsbPCKTGMJ
         ThJA==
X-Forwarded-Encrypted: i=1; AJvYcCVjHx45mVYWUfavoAaICsRenUmIJv321jRPH5T+GhLJYqERVJt7qc7XcSuzzCY1A4VuWQFog/7daKCRqhgJ67XqdQpYbIL4
X-Gm-Message-State: AOJu0YxapADb9nIXz1cUXlWF/hxvrzBLI5J1cakx0I4KUn9L7NI2mMEL
	MqWyF1otYB5qZrflljrNjXCjkuVArjeqFoBzdxiwifNAqdo7Z7o3Z9rQO9kmK88=
X-Google-Smtp-Source: AGHT+IELeDdUHRR6TRaU6TpFZEZBK6Xj754Ty2RAKhoNehyoy5XlhvC8rHMwKFIfAgQ7ltP/WqgBZg==
X-Received: by 2002:adf:cd0c:0:b0:35f:1f66:d708 with SMTP id ffacd0b85a97d-35f1f66d867mr4582947f8f.22.1718025845081;
        Mon, 10 Jun 2024 06:24:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c57bac8sm5121659f8f.83.2024.06.10.06.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:24:04 -0700 (PDT)
Message-ID: <eca0655a-260e-45d3-bb4d-7de6519ac148@linaro.org>
Date: Mon, 10 Jun 2024 15:24:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Lk Sii <lk_sii@163.com>, Zijun Hu <quic_zijuhu@quicinc.com>,
 luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 regressions@lists.linux.dev, pmenzel@molgen.mpg.de, stable@vger.kernel.org
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <7927abbe-3395-4a53-9eed-7b4204d57df5@linaro.org>
 <29333872-4ff2-4f4e-8166-4c847c7605c1@163.com>
 <5df56d58-309a-4ff1-9a41-818a3f114bbb@linaro.org>
 <0618805b-2f7a-473d-b9fb-aea39a1ef659@163.com>
 <3d27add1-782c-4c19-9d84-d0074113c7a2@linaro.org>
 <fc035bd7-c9e3-458f-b419-f4ac50322d02@163.com>
 <caa701f8-0d2d-4052-9e55-2b755b172c56@163.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <caa701f8-0d2d-4052-9e55-2b755b172c56@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2024 15:17, Lk Sii wrote:
>>>>> Why Zijun cannot provide answer on which kernel was it tested? Why the
>>>>> hardware cannot be mentioned?
>>>>>
>>>> i believe zijun never perform any tests for these two issues as
>>>> explained above.
>>>
>>> yeah, and that was worrying me.
>>>
>> Only RB5 has QCA6390 *embedded* among DTS of mainline kernel, but we
>> can't have a RB5 to test.
>>
>> Don't worry about due to below points:
>> 1) Reporter have tested it with her machine
>> 2) issue B and relevant fix is obvious after discussion.
>>
> I believe we have had too much discussion for this simple change.
> @Krzysztof
> do you have any other concerns?

No, nothing from me.

Best regards,
Krzysztof


