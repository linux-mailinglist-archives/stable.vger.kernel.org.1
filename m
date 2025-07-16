Return-Path: <stable+bounces-163191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3224B07D1A
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 20:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399A67A73C4
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC184A3E;
	Wed, 16 Jul 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKquZlLo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753D136347;
	Wed, 16 Jul 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691523; cv=none; b=LZcrA228ex558pcxn9ujAM9RnE0xi2MT+jFD0fRJWbFWbbvQBYXiEfq2MU1hr5yulPw4NijWmy+CHzWyUpiJAYs3j053OSYoCT2YVcqdVnc+79f3qmVaICFUzB11X24sMYkaj7QSXzkJX0zwKGZqFGia0e6KHE8mdI7w311Qv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691523; c=relaxed/simple;
	bh=byOw/hpxqtKlXpx7TvAFWsTV4fu6i3XD8UHZK1Mblxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tm7z+VsDW5awnSNmewcCjRvQRS2HSOC7BvrqIphpUukpKDmWrBR346BDhQrWeS9FrfqWJ+RsIpX5SqodFe1Ut+2T3X+Wvbm3n9aOlBBZ5wJNnmO9QqIbPuFFYy9nQ/B9BETZP/Gj/Z5dwsoYX4/gYiv6MVePydZIvLadmsuPvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKquZlLo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e34399cdb2so12667885a.3;
        Wed, 16 Jul 2025 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752691521; x=1753296321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T7Mtx/XdHMXjk5yktialtduM8swoAvbwJzzp+EvAyrQ=;
        b=lKquZlLoJYqlVtx0gueUIpKyVdGtZYSdB8cLpvEL0UpKOoGiqYhbQ/q+XmBgmuYbj0
         5nY11Cp5yNA3cHcvcx3IAo7lf26AKqiGDN3Xa6wK3dRLT9uGkVAnoH2UK7KA7egPVMMt
         EMSDeX34YVXNWKOm+JJrzjwDvnCXxnhuBTAk99ieYaniegzgFueY7/xQ3g9ajzi+t/fz
         tazKde0LI4FgpPhYZhXsIm5rIDzjttyMc28ua7fYYHHfIxHp7MhRcNzqRpHAhKbRjRKz
         /6EQdnegwVkvRKW49D+QZWUgdnfTPHmRKn6SdLZPqoqAB0ygmG3Jp8negMFSOPvFagwo
         5uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752691521; x=1753296321;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7Mtx/XdHMXjk5yktialtduM8swoAvbwJzzp+EvAyrQ=;
        b=N53LQDrkichb3+fhZnGsaifcg6+WmOPMQKqrVDzWnqHNNGkVQ7bW7Hox95Njj+rzcS
         hwC0TT6oAvCMQoPcrzdmGgmK1KXlS4yWkP1o9J77hIED+jUrIA+9G4UcX7VXxpu32+pH
         l0NHn5Wi8iZbKqqWbGzzfNp8zH8RsueqT7xzDoJS/HvgwHR5DUSRajkMLbToxCmaTeTz
         2SPKAK3Bqr45qU7zsDR7k1TLhk4TtjhdSP8OlrX20dnIWqE9cYpqN6zutpJT0/wtup6z
         BEOwIVX/4qFt9gcxqmv4npJJMZN0NX8hLXOIYBZEZ/mml1KficV9I0mDk+P97oXdmCmD
         VomA==
X-Forwarded-Encrypted: i=1; AJvYcCWLKt7h1jPe0aekGI9b8pg6gHPhXhm8XI6VU+npel0ExXOX7xmOdRGfEFa67mcB/jTBF6LuTlWiXqZSxJ0=@vger.kernel.org, AJvYcCWyE91t0judiYq1M3ur3k4ZzvG3Kc2VCEbLN+DOVO6bXmlEEM6QYUzGfrYdOhIVvXayJUfLW2Mg@vger.kernel.org
X-Gm-Message-State: AOJu0YzZluPMOvELXhM93Fsh45r+lT1V9HNJo+M7p9NNr8Flc++2rWyy
	LImtpTRFOGlFTO01xSZw/tl2oZfJUHaVYIaX4M4AmgG1mYhSFPFY/Lm7
X-Gm-Gg: ASbGncuvBif0jlVRX2RWd/kAqXLFbgqhlexIaMjD+YwJtxliblm1Z47JR/1YjDOUL6/
	wpwpzYCqk0xPbCtA32DM+O39o1IfoziWQbL29Q4FMOVuMXUVCRVI/cIDlnuIb5eMXEDbs3YH65h
	VaGGd+9t5fpPTBBLTvk4cscFoXjsvDZppjzT79WyUXv6ocUDyoSQEcqbgHYBhxfRbL1m8mBT1Dl
	nHQanNgeDeCOIa+XZ/O7J+cNKgcbSWA2eN6WVANHAYjfJhRhbsb44phzzaMW+sHxKu7gtarhZlT
	Dn5Ow9pASO2iMMHaQA4pKHzfebUmFby4imE3g1LQZL41r3hyfwMbtFL0qYegHqrIZxv9/EBGxdY
	v3k+zXALulYsZiimSdP/bgK38roeC0QDAoubLGfnSCE1vXfRdxQ==
X-Google-Smtp-Source: AGHT+IFzSQ33OR3O3WHSIuVDvF2qc/J0H63sY67vb2W9Q7U2pQLCbk76JuDDLMKYhTG7U3oziAZvxw==
X-Received: by 2002:a05:620a:468f:b0:7e3:2c22:6d33 with SMTP id af79cd13be357-7e342a604a7mr531113985a.11.1752691520910;
        Wed, 16 Jul 2025 11:45:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e1bd9c895fsm472612985a.34.2025.07.16.11.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 11:45:20 -0700 (PDT)
Message-ID: <eaa5a3b6-00a2-4c92-a02c-059577e16588@gmail.com>
Date: Wed, 16 Jul 2025 11:45:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/111] 6.6.99-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20250715163542.059429276@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250715163542.059429276@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 09:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.99 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 16:35:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.99-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

