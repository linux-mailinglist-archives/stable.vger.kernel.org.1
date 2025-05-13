Return-Path: <stable+bounces-144202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599EAB5B56
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC8A16778C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8442BFC7D;
	Tue, 13 May 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VsGe6OfE"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE221E51E1
	for <stable@vger.kernel.org>; Tue, 13 May 2025 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157439; cv=none; b=WdBiYbeeiihxivtxxF++KsdOz5mHkQq2cPRS/Ub4s5EweFgsvo8zy4K0kxRr3za9Qn0wdnkZHYaS4MLlv3QPiaiKClajSsaz3/QPMJf98KffAMvt6CekkJL4IOJEhTqMTUUi9s5+9SxdzGKXW39x+eShCK3z/98T1lfXI2fmo3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157439; c=relaxed/simple;
	bh=1iKDHQ7jXvke4sxSCXjYm0GynBjrTYyOGP275PTOFfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5YA8KP1zXm0x2q0EEidrXHisLFdtXz2dtkKg5rEP/CiL80NL6g7bT0qOGY0gExkLqOr96BlUgN8C7loKT6C5Q/skssoPiBLVEnnH1Ux7sOokhYkj42/m5zTkEhET3F5Uy0StfBqg99lSUliD4r+AjrSR6shEXYUfYQFyQTAjmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VsGe6OfE; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-867355d9c4eso147005039f.0
        for <stable@vger.kernel.org>; Tue, 13 May 2025 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747157436; x=1747762236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tW6PygMdjeagRmJ6icjOyCgBVvMDYmBZ2dFiMgydeM=;
        b=VsGe6OfEoYw/3FDhDqPWJa4jARAC7F2gNSTfsiuvDBTqFcwAeJuNYo+Sb6dLsF6mOP
         7e+SSyw7v+r+EkxlxGbbjvc/zk93FSHGWATuSwfRIr02132oX+1cNdQB3L75RhCxxaW1
         4w8rsYXSmlicwpJG7Q6vmAOaYxJmMMEipt9RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747157436; x=1747762236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tW6PygMdjeagRmJ6icjOyCgBVvMDYmBZ2dFiMgydeM=;
        b=iUYoNGI5WyJBD2zsv5SNuxhvSP6u/FqpO8nl8gRepKGJMaQtR3M2mCd3W6W9QHXFW3
         aX5HZnUqEd7T9CTkApiTb83cdW9D6iUc3bYONjRl8IYZuUOX4cDUIUkiAF2YrkTeCFU7
         9AyYThiMan8x/aK4W7MMtW50DG8hR4WwbSxlGbcfqfj2q+DXEQMZUPv+W6/2w5nLmGn1
         tUzW1MX0nM86qTwrKXE6BaGHecT90QnT03BqFVTJYTGNcHb2vFBLrUImRpkyN2KLoIap
         y8avoceupLM/h7X6jxXvUJPo+6rBxQVpqF5JGdWWC1cmYnduhxx3UKAfgGhRn0BiGGTw
         OGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4BCUy28Y7uJfUFrkaufCXR0mzk0U7eHk9Oi50NEpSQo8sWFfPiANeiqChfdY2FRKZSp+eQIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvwQK14Sg8O+DqiWa09TcctyYovXqgPUsAu1SnXyh1lnsivQ8N
	kBreeEi/62wMw1sjCCxb+YYN1CPf8IekecBfkTOWGf+ifdxQ6bcRsoABEiFrWTc=
X-Gm-Gg: ASbGncvojvYSFDykLfMLA2o7Z5n9x6w7/M2gr1EIVEzUPFLEcPbv0sNNkn7AUeqDAUZ
	fhN24xY77UoGa3ucDIpwK6orir8UNjFJsYd82XkQvxS0r+u2Hau4ccFaJDyouw+PYEJYq/crYx1
	6HB8JWbMLMDWIqwL1Bq5dpKa9f58Ck5ZE1Irc+OF7ITmOcD47qRtAgz9kA/uX7Pt+YXYt4yVqbn
	ia36lTfaeFTwIiq6x49amdzoDkK1Q+JOJv62DHk6QmceYULOd7E/2hJjfQZAgJGSKWkYKqPagMN
	7JZagWzNjcuxIIXtgdUMZlzA4FN0rqp17zlAlJCbQPYJ34MCDm8j5fxFTzysIA==
X-Google-Smtp-Source: AGHT+IF33HkKIK0AZPxW0+9c8b+moPUF3LhmDZ8Yvqpj+8WXLkf1qZtasqM1OUW5b7g99xgQbCY/hA==
X-Received: by 2002:a05:6e02:178d:b0:3d3:fdcc:8fb8 with SMTP id e9e14a558f8ab-3db6f7a04c9mr3577145ab.10.1747157436272;
        Tue, 13 May 2025 10:30:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa224a1415sm2209822173.14.2025.05.13.10.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 10:30:35 -0700 (PDT)
Message-ID: <79f86562-af5d-474d-a971-7ae20c5cf011@linuxfoundation.org>
Date: Tue, 13 May 2025 11:30:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 11:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

