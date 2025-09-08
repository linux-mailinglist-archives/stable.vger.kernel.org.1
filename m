Return-Path: <stable+bounces-178834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F9B48278
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 04:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B680518837BB
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50FF1DC985;
	Mon,  8 Sep 2025 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un35fxMQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C002199385;
	Mon,  8 Sep 2025 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297147; cv=none; b=Kq1oK2OT06QWdYWKECRkHfv4HYDNy0sOL3CeY3K7/vKxSKt9pcDNtdSXJDvcDrzfHKKcu3PRS5L7EpOQb3B/IyvxbuA1K1cGy0pB/tF8+0JZTcX2OrGU8MB9JB1QVnHpt/FX7Aqth9tjuVY7/6cXPiwHSr0/iCrFGLI8rnBS2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297147; c=relaxed/simple;
	bh=htwW1xfmVzPRRVkaJnN+izgyhESSK69PwxwsdZqPpdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUriOgKhxt6KrrkmzbLrMAo8p/id2vlnx9xE7yo2Vtz2DOR7Zk9uHALdZFq6gZkO3OqGGfKY5AfbjDhsIusDhc10b3km/2m9eTm52EbXOroFKB5p7rasq86uF1jgtdA9nlV++tg/ggrYpikzcqpheMN2xVwuIgSKTDKbLPZZ/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un35fxMQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24c784130e6so43507865ad.3;
        Sun, 07 Sep 2025 19:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757297145; x=1757901945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMux8eKktzYrGyHNJj+h74891VBOnd8NG5NmCraJ1jY=;
        b=Un35fxMQj5STSMcd3OzVi8OK2WRCD3w9Y1zC5ArR04qYoSz3MRmeC/bQoDBPomEMRY
         S1dkT0wL2l4RtID+dpG+Lmq5F0PivIqM2HBbP7B79MV83FYgwp6IIbANFXXIgxK5/goa
         60Uzk3fNgfot3VZkJb6nGLmKP2+Dxzv9XWPBFVtHYJO/1OJ+OR8xmng9yKN3CVBNTgNW
         +sWYn9zALQmXlQVqCJViVh8fMbttMysbDwxZ7ER67BaD4WaL9oxsDMXhfmRpe9dcA9PZ
         6LlG4KzLTJX4HoLCmiFnWh6xWJP7FcBoLPtA2F+OfHeU019VyPtb+1pdfhGRE84la3GE
         qunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757297145; x=1757901945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMux8eKktzYrGyHNJj+h74891VBOnd8NG5NmCraJ1jY=;
        b=gpEnMEPuwZbMM2s7pbJwI8+vVl4l62OGT4sYe7aglrsXEF9KhGzGYTERuKUygVzyE5
         IF7ETHE1qOgB0aYRtcmcYQ3hdhnt4imPmpMhlv4Es0DUWgt8sWRC2z5Vo3wYp3hrDbMz
         GsogGpl/h48YIMk4mV9iZ2M8SB83pPu4c7mP1CHkg+sIxLQLgMhKJnK+veoxkGhhk2I+
         0ObCfnqKPNQ6LdoY5QSR9/k1Ae5j1Jh+q/AV77pvL1/cvniCq6cz8Bl2430AyLS0XsO/
         LUNbi1W6stH7cSXdH7E7fm10J+VQ03hzfBj5MBZCfqtAr9AUVE9UxSRnm3pwMOXkx06Z
         W8qw==
X-Forwarded-Encrypted: i=1; AJvYcCUroeDxslrAegPlyvCDJHuT0kPGf6DGACWaHIE9Ik/KoIuXXBqMnGvWimHKalfHNST1s+TlR1E/ofnPF5c=@vger.kernel.org, AJvYcCXcAdA4ie/9qLoipi0D/rQIXjwuZ9cmhQfQBMCoz2ySJelufqvIDaNcWZUzmTYMk+ZLDY/kEsWW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/ALODUTfCv+im+TobMb6RNUugpUGjbuFOswbV5USnbBCiChR
	oENrFwYmW+Ja86K7oQBrStgzlEJjEHji1Apb1SyC+4AH4xK1VwT570qs
X-Gm-Gg: ASbGnctUBLTzTRVR/0R4KOCabZ6WhTWXbfUG1Mr5HKFIQA9Ruh01TR3YtHggEhixY4e
	k6lYMJxYbRorvpJorxtRgXJ6KCFTqIs3P75pS6KEit07DLhFJPmOZY1U4/lqJ4xxpKamXgJc2dz
	+Ztp8jXZ++4cyaic9vHtzAvzKeCPowThpT6Kg46UrZMFaazwabk9YOmAiatSjktsU0rXwwpNqow
	UBCyBZqjI2/BQsdCh51EwAw1JnwYJ1Oi0bd4+dRMr8ibSnNNqZUHf9jnQ7AwK4JWaPpqbwPkDcb
	VuQOuzkkfDZKCw3bg6rRXY3dcZBki0Wevr6O2PdJPW06f+1/o/7CkSBRcx+qoUgNJJ1BZa9oKye
	0TnJbkMM+d6SOcrFV3lVspJbB7wbvCSPco0f/l9Bc6Hobhq7B21k3csLfgfLmEMt5
X-Google-Smtp-Source: AGHT+IFlWTF5WOzkIXIZY70TiMkV+dwbPWzTmWOpp6OHRIk4MOu/rKmvFMqIXWjKtv+kofwGYOnsnA==
X-Received: by 2002:a17:903:22c7:b0:24b:e55:334 with SMTP id d9443c01a7336-2516d8187fcmr66151985ad.8.1757297145305;
        Sun, 07 Sep 2025 19:05:45 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cd5092951sm94757905ad.18.2025.09.07.19.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 19:05:44 -0700 (PDT)
Message-ID: <2a1e081b-22d3-4f96-a0c5-2427de8a44c5@gmail.com>
Date: Sun, 7 Sep 2025 19:05:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/52] 5.10.243-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250907195601.957051083@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250907195601.957051083@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/2025 12:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.243 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.243-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


