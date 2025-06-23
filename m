Return-Path: <stable+bounces-156163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED8DAE4DBD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8546F7A16F2
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA001D88D7;
	Mon, 23 Jun 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AiWmlF0V"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E161EEA3C;
	Mon, 23 Jun 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750707989; cv=none; b=U+UklQN84AXOpFUEEaUeRhJw7f+BPVC3FvEbaic4a/E+fBjQLNngu/TFg8420XmYmKigLG7oj2lFatUWy80zFG7DOKD4ltOkgxQayKeA1jlVdZYdEBxarLPzCpT1CkE6ecx5KprkhIALPXlU+/RrhfRoh5SaRkdRkxLHS05iJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750707989; c=relaxed/simple;
	bh=qNtX7HOtHPAZ37bzCwU2x94iYElxKJdWBv4q8izut5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJbmNTVE5VONr12bXOMtZdox1pQumgBtUAJJQ894NC5j3E/vTQkbSO1CyR5nCkB0wCC56b6qy/naNbmo3vSJYa7nkVcsT+PqUR0HzJgdrsam0lcXczNqsjyUbxYmPqhyHwAS54JE05N3TIm8IZ4bp0PQu0++o4yn8oYkifEr91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AiWmlF0V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so30312375e9.1;
        Mon, 23 Jun 2025 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750707986; x=1751312786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEGyrQzRFDGKEhq8E+Hk5aKFGbdt1Msuid5ULByX0HE=;
        b=AiWmlF0VsqiyvXXG4ed8RYgljmv+uMfjhH3HvLBaWoZm5DzZglSAMwFDL0OuVK5t4L
         M7bpBhxI3DcvQDI5K0odksqAUytSUoNOU90wkYQ3QlgLRUQjESVef9aviFm8rIYTE8HJ
         dHXsdkNLhKBaSl0RwcQzG6blNgGzbEvK/oihnnzDSkEIY/ah9/++QsW3+5zAKbpNmkif
         aM1xQTUg9BT1st2gaE76qJ7zmvd31xsCXDHCXW3T3pNrVge25mNzTTSzGT6yOaVZRBE2
         F9i34THRnjkjXVNJV2EwXjg+41WyIzJloQ3/4Rh0mk1Vq0z/8fLdQ/NTIxvWJGyG6Mbn
         cS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750707986; x=1751312786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEGyrQzRFDGKEhq8E+Hk5aKFGbdt1Msuid5ULByX0HE=;
        b=YQ43Cs2d4CdjhLYLMbblh6SRnoyUrDQ5rNwvXXEZuZtRBMmLeXyZ9MbLCd90mZf+Vn
         9N201M5Q3OLyCdBYNE/UhwXW9gn+xaHRzKOrOClDDrAayzYGVWN79P2Y/yxeyi/l/sk2
         ai5qsMOEPcDLJZUKJoBtavsmnOSWiFLVm1MSRT2A42/XxukwAgpMlSgsUAV+xGRW/Tyk
         TnlMoHizCQPjkZsfewSFZMk6T0FvOjUYfNvq9nHaazk5ICByf59AVEZXwVmas74mMxbr
         iL6yge9Ha5JsoAr2OKWPlqOmqRe0B/7bOVjvfT2f726L8sNF903gEmgligPDOZoqTvC0
         1lbg==
X-Forwarded-Encrypted: i=1; AJvYcCVneXpss6nH9TSs8FDL1+HJZYwDS3MKrhsYKEbu3JTEm8f/Bf0db8ZCTnLLytwAzkyBFD8vO72x@vger.kernel.org, AJvYcCW5mV0959TXg06iEdTf/ts8ecJYh33eJWwbvsz8byuxXlbZLehBBmFxTeZ3Zh28PheAa+HrX3I8O0B4YMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/zhjSb593na0es18gYlx4evykZcSFuv+cwhYUOxOnBgbuGqS
	LOyQS/oVBi+etQvfbfZt6IUXq/O6FHkFjXpkTzohDQgOLlmZmxaFnMQ=
X-Gm-Gg: ASbGncvrPp6sIf5ipC2IJyTrNxGzGn4gDaAyP6RTwH7y9UVESajn5rKqqh4SRh72f6F
	k3uKl9+rCkZXpjO8bLhh6eVyx+u81HvFlLL+krGZE8v7r8SP0d9Zt710cP8CBOx0k8hfpKM+HLb
	Dd6sn15ls7OD1MnLM6SjLlmNsfwWxrKZuIJc9Vk2M6Qlff2KA8jmRbFjT51DX2muEn68lplsjBu
	VdBGFg3d2rFQVHjLwaxRodODCJo5RHjLfeXFIrMK9fD3YniViFqaAAfy4ZuFxagCcdEokgigjdS
	j8j8MptVn+pMapeG5fdBUZbwZVBafuc1sA20Xe8Q80PF4OLm2YVjvytt1lji/WVKlpNBWfoU1tD
	E4VhggKt9l1onNJqQveOkz0kTwBGqn0d0UZmq4tTB
X-Google-Smtp-Source: AGHT+IEC3oCTdWFz7Fo7GvpLWVJrW+JtooF8zjBoWDJe0pgPBUTFLBci6fXO3NhGZrBGR3uLXCD0TQ==
X-Received: by 2002:a05:600c:4706:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-4537b79c3d0mr8441305e9.14.1750707986182;
        Mon, 23 Jun 2025 12:46:26 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac778.dip0.t-ipconnect.de. [91.42.199.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97b501sm151363115e9.2.2025.06.23.12.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 12:46:25 -0700 (PDT)
Message-ID: <9c093c7b-5b38-4865-ae01-8c97943db05f@googlemail.com>
Date: Mon, 23 Jun 2025 21:46:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/414] 6.12.35-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130642.015559452@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.06.2025 um 15:02 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.35 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

