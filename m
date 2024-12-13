Return-Path: <stable+bounces-103956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635F9F02A3
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 03:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C02A280A93
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 02:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921E502B1;
	Fri, 13 Dec 2024 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hCDjghzL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D012F2F;
	Fri, 13 Dec 2024 02:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057066; cv=none; b=R8OfFeK5Kc0kReCOFwWBznw1w68cvwolJqForP7Oq7rc+pg3AmlIvqLuq8y2FqDWK+hnvccN4NSoP/BRezKUzh9W52j2VQPo5dL90HjOOWet9cBD92l0BTKCLoPEq5/rjRw7Rjq9JF19hDJjkXn15nQDxAKZF0H5sRKdVWJ+zpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057066; c=relaxed/simple;
	bh=hPzhQWhJg34Kpqf4MVZHYhzs+MIEPTPQBi5m5xnYDiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGNBA78PUDISLe6jSmi1gFamFfQqCdlBmuLUJArEmAkX1L710s2S3rGM+jXvYA75/jrMNL4MGLPDJQbYdnS9dJ+WG89vBtBWPRDKlLZKNqc+odN2WnlHBui3CiO/gTm0z0r/GQYT1wY9dNlyal3xmC9xSr0JNWeWcS/JGl4Srps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hCDjghzL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso1300769f8f.2;
        Thu, 12 Dec 2024 18:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1734057063; x=1734661863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/NT9jBFNeWij/Bo2czeFzLUqSgyf1VNBFVJ4b6esT8=;
        b=hCDjghzLJwEGSGmVEhhhGbIh9lX8O4RkW4hcvS5fUBmXR1TWborhp1DUOP7DmcpvN4
         iWBme870SdnzusI30Tmbdk0T4k9LSZefQYqbEX4ajkBVE+BeCw4tf09nIh7iNp4is1sw
         08lmn1awXcLq+YF/icL0Am0dbpSe864BPxuB0/TKbmsJKK+y7ju0Jcoskr4tt/CKT3i8
         XHc+LD0IBFQtHzYxZoMzkvSG4qrArX5prq3vm992+SV+VqJK/oEaRbYXNY7cC/M1Mg+y
         tQqq1PoSEOcguXA1E2/nhiwPXCDDjNlr21ecIexJs3IzRMYlRfnKVRjAybwLQCBDy2ta
         NH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734057063; x=1734661863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/NT9jBFNeWij/Bo2czeFzLUqSgyf1VNBFVJ4b6esT8=;
        b=efqHOXO3LrS/LJM3pFz18xHOZN3C2VKjhSDFZW/ooE4YMq0zMn4me3qZwtdBOfDBF/
         Ima9ikF9XVwGCx2Hz1vYlT20ciKumtW1Ug9GrNeZDUWBmBTW1zfojm0OtKazVVUpPcK1
         e+hwJm8txn+Hd+gb6U8dN9dZtQf5qVtVyR9hfvYkt32IMG1K+0xj2fAp/sLn4tw9LnJB
         sGkIA7pl4IK7SkUid8a+erScEV/ncfhvjk+qR7GbzZCwWjgR7BU4P1XQY/jREfXjodhI
         9ipiRjTedk8LZIgl9+tEM3eOKbjb/ZXzGfo3oGQp60J0oQbbOsaeQLeu7Z8mr6uSW9cR
         1v7g==
X-Forwarded-Encrypted: i=1; AJvYcCVP2ZKgNQBkNfi4JU24vTe3MwaKolO2IH8gJR7yqz9pFYvq0nmw4MEhOlo2GG2QCDBCGwv+2e/i@vger.kernel.org, AJvYcCWRDh0/GRpXCqheFE4oVINL7yXiiHjJbdpLG+bRhqV0YaK3NmvKBtk6Texg/6/svXeE96Hnfbg1Jl9U8yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5u9txmqGCuGTu7iQw4DQJ3R0AmwWAgmHkAb7PTGoILAyiSPNA
	KyN3pHdVPpMy+ZBbhuFAOIYaC3KCCl0cFV2rWCJXQjLn2XUjvgI=
X-Gm-Gg: ASbGncsA3u7DmB+lckwLKzJSp/9aOYq+KpMBXRJJtTdLMJ9pqv5C12oiX9q3HyFVcPV
	bDHVwtFmXghFmf6RjcplOaYiK/vA0XvZWSrDL1iC3avmM1bI5gmY7OMC1UWtYPNmp8UC/IUBXk2
	sXy9CGO06iwguoMfA8eSv/yR7BhfSMOEZMGeZ51yRH4fZhSfICAsbYTkcrz+W8chYFWfXZUyI8E
	ztkvrCPBMFRkNHDuVK/0zB+/CKF6+eUXKED2zPF//fEYcwPevB/NHzUKxlIEK/qi0w+iC9yRp0H
	JqFWtwTlsOXP58nZRnIqsRTKhqG/ZDdh
X-Google-Smtp-Source: AGHT+IEUL/uIQsLe/pbBTa962sqyzAgZ2ypA106g6+52xux6R80PwyBsPhVia81M0tXDqB7JjEqU2w==
X-Received: by 2002:a5d:5f50:0:b0:382:3959:f429 with SMTP id ffacd0b85a97d-38880ac5f31mr532370f8f.5.1734057062555;
        Thu, 12 Dec 2024 18:31:02 -0800 (PST)
Received: from [192.168.1.3] (p5b057a27.dip0.t-ipconnect.de. [91.5.122.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387825296desm5580998f8f.111.2024.12.12.18.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 18:31:01 -0800 (PST)
Message-ID: <b2913864-50b1-4f6a-b20b-3a93aeec204a@googlemail.com>
Date: Fri, 13 Dec 2024 03:30:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241212144349.797589255@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.12.2024 um 15:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
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

