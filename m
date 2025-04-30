Return-Path: <stable+bounces-139196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4DBAA50EF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6AB3AA834
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF6261585;
	Wed, 30 Apr 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TJH9iOWk"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141CE20FABC
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028559; cv=none; b=LDDH7fkWa267orwqpPSjaHq7SI+cV4E56VgMtnBrJPS0aibf9eUceYUMfjkwZil+KGr89Sd16UHXrU/sN4qgBOPWzMpiTamRRaqPfaUMnTthnvGAUFs8nevF80rttMGqfow1/labyXkxn7vq/xFy6oazxLLsSvv2EP92AxHGvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028559; c=relaxed/simple;
	bh=nvpbM6yPn80ejMIq2G5tOqowwPWvomfiV80DiRlQ3v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R53uDqd2/OMUtN/P4tk0N0UTAfdmSgJoTkP/sUZKLI1s4NSQEU89eI8URL2qtW37ETyUuWgXPxgZY5cOsSL+/By1D6XChq9OGmsUnr8H0Y6Zf9dTZ7ghliJuLhwNzDn/a2qBOX3FtuhCwZH3P+tHZ4IJ7TPxqZ/UNXZ0dkI+gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TJH9iOWk; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d90208e922so36869385ab.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746028556; x=1746633356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8hsdaBH5p1DQoSnQ5Ty53GpeYiStgKXkL8MESJIMtU=;
        b=TJH9iOWkHIa6pcJRowSHjxGy/VFL0NTO5C1FgZy3J48ylOERYzajJdrDP/JanbVZgF
         76QQiSLhK/y91lJz3KSwVXUiMprdLw6CR+eKk9DS8uNiky1W7Z5z6XtBEwY92GzkDbW8
         wPnoAcCD1JL+hMCiOjowwSV06Pl0tio2y3gAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028556; x=1746633356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8hsdaBH5p1DQoSnQ5Ty53GpeYiStgKXkL8MESJIMtU=;
        b=nGKdE/T0lHvXeBidm32mLzOM1eiHQk+3n/IRhGnCJFrpmJzDUkEhWWMIscK+lSzVLE
         lyY1sQa6OhnxPifEeex/VChpsg4AgLO//gt75xnEYEBGw5sQlaI0dnU1bZe09fWGFKfE
         u/3Jh8ReKWQkJCW4f1zX/JGBrmDMN/qq0IFKyhkDiB6W7/XAuNG6wzg+fhJA4zIp4lcq
         2brUNeeMb5+EkRybz8LBimalf8NNERwpwvXUfgaqzmMGPpzDDi8LRZxWWxNd3hkIVDX3
         A3YxtLVqKHv61LVMhS+uXefVtaMxQ7/kDE8Q6kzrGkK1CR22cY0VeUV8Li+zKCO9HDMd
         /exQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoxDzp+Gl9OuIOzqSsz+cr9gHAguFPfwv4VwNs8NkX/lyZvSqVjgIWKly+yqusA2cYRoDBHZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9nZT0ZbDIzpE4di7IxZe6/ZvCI6JK8JlMPaW76TupWHlxyi2
	ilGEHKXP+PjoP4q66OW5S50xq34u0ZxeZ3MvQCVsUp/D9b2Pr+oyi38NUfiT2xM=
X-Gm-Gg: ASbGnctoyJ4sQB773qFQ7oxc7ral7FJUOANAeqKPYn1MxUYDTXRJjbCYOqoX59ernLw
	0wBZmVpEUInPj1PbCG/99ia2Q5PLin4w3yzhuHTm/eSMa4pqAhRSxHydFUYVpg63QfV0JtJsVzT
	uTOPAgrRpTANJhjHdA3TDUShoM/Q/VZ24jVYb69htgWq2H6thm/nmql2be/wWfXNjYvlCimHFbS
	xIpJFtd5Zni/nUSMdiPkoJ3sEtnILKT1cJg3gsY/mEHqBxLjJVtUw+ZBECxRmMuyLH6goVJaI9H
	Srsl+qRCKrBFJ7beF9X4PixRXDK+voBLevS21MBLI+WBXu8DWeU=
X-Google-Smtp-Source: AGHT+IHDd6IrZ/vYNCzEQn0266E0pxx26NMuGqdeEc0TxxwFoyQmZMAPG78d5AHhYanl4op4L0EMaQ==
X-Received: by 2002:a05:6e02:1f0e:b0:3d8:211c:9891 with SMTP id e9e14a558f8ab-3d967fa3bd8mr33031125ab.2.1746028556114;
        Wed, 30 Apr 2025 08:55:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f86314a291sm803211173.124.2025.04.30.08.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 08:55:55 -0700 (PDT)
Message-ID: <25a5c132-6686-429c-93ea-1a0944203af0@linuxfoundation.org>
Date: Wed, 30 Apr 2025 09:55:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/179] 5.4.293-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 10:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.293 release.
> There are 179 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.293-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

