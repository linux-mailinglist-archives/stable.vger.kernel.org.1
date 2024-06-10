Return-Path: <stable+bounces-50091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423709023E7
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 16:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7921F24675
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA4684DE7;
	Mon, 10 Jun 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C179FBu8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86656452
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029176; cv=none; b=b2AUUZBC70h1IJe3keTHlOH6w4MDTOhWxMoluKU0qstJtxfcJ7koZa5O0NciyIqLRZrY27eRZ9PdtZCRb1mrQGzP5iJ6z2nAMI6u8QyiR04OaSc6T2hJ/NZaMgkvd7r5PDEScfm/qdU9R/iCzilcqdB9/FJn9B5HVyo82tUlOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029176; c=relaxed/simple;
	bh=4QNNwmrYS1hoGpukYtjY4o8FR1Cjzh9Dsb/xKb3v0Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjweT9HqvtjUA/etFiOPnPK6seujsjeR078qViPwuBPtY0aLSBSk+FzVQmkQMTf2kJGCQiHzD0212gyK8ziOQYkXd7923uYj955ssekxB/us+KnY1QmVnPHv1REGN3ryBEPbwU/7bo8x8hGR4DvrmdQvNs2UkCp9ktGxxQTuauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C179FBu8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so21586535e9.0
        for <stable@vger.kernel.org>; Mon, 10 Jun 2024 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718029173; x=1718633973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7CyBtd5B83ygD6GbkOpwE4mpTzqZVwTF1rJgNbid/14=;
        b=C179FBu85GoKzy4Vmn8H1xF7WEYxpoUyZfBeKdkJutJDYJbiNlMZhcW6hdR3I3gRqs
         jL4CDv5IIk2AgeFkwu0sIGGIOpAxIUjUxn+uKDTFeZSnHZwSKx7b3sr5COj95OTjMfnI
         9ktJ2qFAsOiMzoqtgvwZ4HV3OANWT6I+2JYlrgscb1KkvPtm1wXhF015hfeGvAtmlKZJ
         DuAjVzKZV9/MzcN/wGi9sCAKu+IDNXD+gjFgjSkJwaI5xOa3qfvY2mPBdXkzqCPJ3dfM
         KzWOoh+q8h5Tu6AXzk9GkrSeu6IgSKdi2G8Hdvv/xTPeSZUQSVuJDaPnpWgBtGWADsAG
         dXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029173; x=1718633973;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CyBtd5B83ygD6GbkOpwE4mpTzqZVwTF1rJgNbid/14=;
        b=F6lYS8S8AsfBObyHQXyOhA0J5e6X5tRlAnH7CNCjqH/hka4eHIMvFatvXZPsUn4DDJ
         rn5sj2qHgjT3jihc4n0kBDTRdkt9ekWy8pAE5y1Gb57p09QO1knIXhERPNQVXuCILaLS
         6H28u5Su3bWN6H2wLYv1nwaHBnX3UfllaQdhXe+MBBLGbASL9EkPqpOpmeUQVOw71O/H
         LIbfiI8AH+4yoF9WBSqa+NIfngtczzdpXsgIQQG5ZT7tnWxVqj0ghUlzc9Kxd9kgzX6/
         JiI30dWs00Ctl6k7niisVQAZ1jzZBgiJj8U5ZsNNb3pvgQA/l2T4Yn/sqRgIRM46MFKz
         FgBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqn+pcXxkBchP/lgtJnNhos1oEqxUOTyKv7ABz9vdZ/yTFqFjc3m53ih2uJEYtDVI7WAnLOOJ0JjyUAktqnt1Y7onYsm6P
X-Gm-Message-State: AOJu0Yx95H5lnjpug/y4L59IF/Ztc+HqImi47qWPMyRYkFr1lhm0CDBc
	qgr9A7N8lqLKYXdnFGHNg7N5EOLvCL4ifRR3Y+f+wDK+f/KON3NWpegaqeI0NG4=
X-Google-Smtp-Source: AGHT+IEx6wsSafpyFfRNQ3AQwe3T6JBrembToAkJGFNVgSFYx0ydy1h2DK/X+G08h5Dr4RVBiFepng==
X-Received: by 2002:a05:600c:a45:b0:421:5605:8c92 with SMTP id 5b1f17b1804b1-42164a030b0mr79617075e9.20.1718029172734;
        Mon, 10 Jun 2024 07:19:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa1desm144900145e9.11.2024.06.10.07.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 07:19:32 -0700 (PDT)
Message-ID: <e11fabde-9aec-4699-a7b7-15cf667657ad@linaro.org>
Date: Mon, 10 Jun 2024 16:19:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Lk Sii <lk_sii@163.com>, Zijun Hu <quic_zijuhu@quicinc.com>,
 luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 regressions@lists.linux.dev, pmenzel@molgen.mpg.de, stable@vger.kernel.org
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <7927abbe-3395-4a53-9eed-7b4204d57df5@linaro.org>
 <29333872-4ff2-4f4e-8166-4c847c7605c1@163.com>
 <5df56d58-309a-4ff1-9a41-818a3f114bbb@linaro.org>
 <0618805b-2f7a-473d-b9fb-aea39a1ef659@163.com>
 <3d27add1-782c-4c19-9d84-d0074113c7a2@linaro.org>
 <fc035bd7-c9e3-458f-b419-f4ac50322d02@163.com>
 <caa701f8-0d2d-4052-9e55-2b755b172c56@163.com>
 <eca0655a-260e-45d3-bb4d-7de6519ac148@linaro.org>
 <CABBYNZKx15mrTgvE6bSvxn6YVv=jJKj7jHu1UXVFrtvffHQa9Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CABBYNZKx15mrTgvE6bSvxn6YVv=jJKj7jHu1UXVFrtvffHQa9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/06/2024 16:02, Luiz Augusto von Dentz wrote:
> Hi Krzysztof,
> 
> On Mon, Jun 10, 2024 at 9:24 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 10/06/2024 15:17, Lk Sii wrote:
>>>>>>> Why Zijun cannot provide answer on which kernel was it tested? Why the
>>>>>>> hardware cannot be mentioned?
>>>>>>>
>>>>>> i believe zijun never perform any tests for these two issues as
>>>>>> explained above.
>>>>>
>>>>> yeah, and that was worrying me.
>>>>>
>>>> Only RB5 has QCA6390 *embedded* among DTS of mainline kernel, but we
>>>> can't have a RB5 to test.
>>>>
>>>> Don't worry about due to below points:
>>>> 1) Reporter have tested it with her machine
>>>> 2) issue B and relevant fix is obvious after discussion.
>>>>
>>> I believe we have had too much discussion for this simple change.
>>> @Krzysztof
>>> do you have any other concerns?
>>
>> No, nothing from me.
> 
> Ok, but I guess since you didn't sign off that means you are still
> unconvinced that this should be applied? I could try pushing it to
> bluetooth-next to check if it blows up on the next merge window, but
> it is not that nice to have things completely untested, as far
> upstream goes, being pushed that way.

The patch is fixing at least one case, so at least one group of users
would be happy with it.

Best regards,
Krzysztof


