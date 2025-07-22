Return-Path: <stable+bounces-164296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 075B2B0E560
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C23D6C5233
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7DC286409;
	Tue, 22 Jul 2025 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SF5vwxsw"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CD285C8B
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219448; cv=none; b=us23dK+4S2ytAcQflrofcvl+vyebqt/ET5qmawYN1agCIIwoVTPPESb5puXqS+HnAqv4z30K4RxtVUUmwIuo7dHsrXvf+Q6/+rf4q4hthM2rRsnnbBNOKGh0H0wAVvd6B0WkpW1K3abDVevjjyOiVWEhCEhlc4bVi1XDjihmVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219448; c=relaxed/simple;
	bh=eYL1o47Kleefpqy0F6S/ozw8zz+oDdKbrjvaR7zhri4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPAcdfh8I/l4HRnjz2onm1oL+U/SPV3lWlf0EuiAlmn+N6tOTwzfJhU/pMlbUil0sKazJZni7aJnMRUQBkdBK0zZdXRsETdMlnjIoNnPhfzR7CI1u8r1dFSZtqp2rIPFlLO+vBfL3za6MQNjR57Hg/6uXafla+/89CLyH3C17Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SF5vwxsw; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-87c32f46253so100931539f.1
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753219446; x=1753824246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHBg2rMZuWIVzQC6BiR69k3jKDmsa5yJmHZY1CaYlic=;
        b=SF5vwxswTUPiHsjwFsMpZnNu+k4BncEKgOYRGvuwI18vupPnYreG8dpB1fj97fEwSX
         9gv7xUP5tYoAP1ViNl7zowgh2yK38+QLVyS29lcHZxqBpaf/KiV/7BzYr5uXUKm6JdOm
         GYLZeQILhGGPqCQIHegIKTUpDOKrcXDfDFAQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219446; x=1753824246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHBg2rMZuWIVzQC6BiR69k3jKDmsa5yJmHZY1CaYlic=;
        b=JJ7kmuaaeZoPofPUk9IpKYMaGot6mPDsicTxSypHMBRABX25z8T289ThkpjxHto+tq
         0ydePDDG6FwS8sveFdCXU3UWSenrthRpIaY1wCVfJ9WbTIGfkcV/uPYB/vQ4E/QW6cT9
         ucUMu5KgcIbr481Kkr/cJHqIevE43Z35ht3eb6Q5HJeiJpZ0nqaD//kR3vi+eZZsMAGD
         aD9K9aJJLo7jNOpnW64TXcroXTE473up/cLDN+nG2EgSQjACkKKIrsezucIJ54QEcf8U
         oqpqtdpfv1RzFt6ZtqsNkyICQFyZCloeVMDcYONKGzcAWlnt44lASBMG02idE90/Lq+v
         u34Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh0RYh0Z6mBqIsNsTwbf2DKE9e+oNHjVQFm2BQuVLj2IX3HPvNhE7QTUgjtUoW2QVUDbw3Ad4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4uPxLDSBIHxf4w69Qc2DYDyGUf1YoSeUVQIlwO0vncnDOpSg
	9Wsc+qYVtn5VoppCOxcVMpvowUoIfgBk6CipcwfCu94S8jNzRVwQZP+ZrvMSYvGvXBs=
X-Gm-Gg: ASbGncv+tyTX/BY3HpIeQ2grE0v19YjQSKOW3zB37VoG+rrjxSRWf83kklhl54tN8Z1
	OXRXyjo26Jt8i7ltDqLs4NlAw0LpUMh90Zu5z4fo6tOD5i8MqMZzKV02S1pqOYIFqxGVT7Ppyhn
	K/1Y1HETMSLu++MlZyW3NXDevMNOYFplyncpf0JMWKbQzxD5lGT+51wuTScbni+NCOsThHxuUOd
	yXeGpmQX0CfbE2CRhknqwg2g/7GASp4s6B6G0dqvXMJNahCURaixZIn7zRC5emu+S469823h7en
	Ghhs3ceH94ztjt7PmKOOJx2Jj2xlvWdEXnDsDJkcO1O5RdGpPEq8zlpW3R+qcl6r9goSPTNy8I+
	e004DUdtPMrcIUtTzMviO9Nj8XKFHuEjQng==
X-Google-Smtp-Source: AGHT+IGf2Vg6LS2KrJKv9TjiWcHOJsVguQEuNaQuu7hVEhq6SSyxnQbG7sJ1OKFBgaprLgEFn+Tfnw==
X-Received: by 2002:a05:6e02:4404:10b0:3e3:843c:9d16 with SMTP id e9e14a558f8ab-3e3843ca037mr2668115ab.12.1753219446313;
        Tue, 22 Jul 2025 14:24:06 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca03da6sm2781182173.100.2025.07.22.14.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:24:05 -0700 (PDT)
Message-ID: <c1c09085-afdb-4b1b-971d-8428993a6364@linuxfoundation.org>
Date: Tue, 22 Jul 2025 15:24:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/111] 6.6.100-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 07:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.100 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.100-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

