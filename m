Return-Path: <stable+bounces-87650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5759A9379
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 00:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC5B22014
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7681FEFC0;
	Mon, 21 Oct 2024 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GakT1KdU"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6CB137750
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550491; cv=none; b=PPU+zWRvfn5T0pgNO7i85akPvgrGqexZXm802ufjlOLYgUlchNZwdyThaxQE8LrL/6kzkymi91mVr8Mktbh41w4jC06Mf7tRUvhX0q77eAxmlEZ4l7L4yFBk3+cvXXlsNJGk2qM+rwRti5gMXundtKd+2O+7FH2XpEHpdFBULq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550491; c=relaxed/simple;
	bh=PsPPiiDCrhoSB3wsRMZs3K+SlDE82UI3Dva8qJIqSHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rS5MU69k7r+EOpzBgvhpSoEjwvj2LgukRDASm4ivU9w+qNXkfDLJyqoOoTKPMcNpHLm+C6WTXSLPDXTacg1yYTsHTTvKAFSpVZOzxOFhVSq704sCgmiyJfAv6jfNd8QXBhlELC6IMew4gg0/GmjJG8JQvtV17LsdNeEuNKt5xbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GakT1KdU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83abe7fc77eso123554839f.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729550488; x=1730155288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8AuINN/VlI7pACZM3YzjmWIoSWBhMxFLVtFg1hkHIQ=;
        b=GakT1KdUnpNvVBsVFJkN7Ub9tCI3NTmXzju3SRh4PWjFU2kE2INyJ87uyKpW1Qnojy
         h/dHdPsj+JBm/wbivW+zICQoXaVljoINCp6uFAlrD7L2Pse+aY27ezZ7DA812szeK9Ts
         uN8lvw7NyvSwcJF82hOw5TbdGny3f0ItSaqVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729550488; x=1730155288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8AuINN/VlI7pACZM3YzjmWIoSWBhMxFLVtFg1hkHIQ=;
        b=tIOeTVWjYVTTSDgbVEuH5B9tz/SV5NUTpmVfeBsSDCzp9j1GVSKrqcARBWQggVpIzq
         njdVPzTygIJFnIePrmTywH4lyzZ9X3D4T+yVVVAq+h0+YeALEPWw91bhz8ZR9ieDk0Z6
         yj5uCTcju2IbDMThpnaArvb3XaAlP9bDv3pc1CeNyIn3hdfv//z5K4MraS5qPdf6O0gC
         zZbjv3hH345/XLYOJ8QvwClsz+1ZFr5bwAfsgJZUVDEcZ7cngHQPcgfj9cDElcqJzO/x
         KiwouqTb98VX/OrW9H+dGZelHgETtLTVOZU7/osru6uPDUwKL445PMKZ6vfcsHzOk1Kr
         KzUw==
X-Forwarded-Encrypted: i=1; AJvYcCWLEeBiI8EF67HpqKNRyzK1g9nIfeh6AZ65gye5UeX/zlyj1abmY1VJQxkCpEkWGadRzIaY1ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAbJZk5sin+vxbMdtV0PQpf4fYCoaoCjdbkn5YJRfH2oNV3NY
	yudpyB1R/rME3FyXm5etHFzZ3PjigNQ9lPtz0brDwpBy4MqIPc6KMKmdKvlpra0=
X-Google-Smtp-Source: AGHT+IEaAuGxE8Q/sUhf8BHr/cqOHvML05PH0iljxkC4PH34quq5p+P+YnDVd+6lHd10q3fIaxMq+Q==
X-Received: by 2002:a05:6e02:1a81:b0:3a0:abec:da95 with SMTP id e9e14a558f8ab-3a3f40ad623mr111865565ab.22.1729550488238;
        Mon, 21 Oct 2024 15:41:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a6090b5sm1260296173.89.2024.10.21.15.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:41:27 -0700 (PDT)
Message-ID: <f1218a73-76db-4f8a-b3c9-19bdd3c026fc@linuxfoundation.org>
Date: Mon, 21 Oct 2024 16:41:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/82] 5.15.169-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241021102247.209765070@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241021102247.209765070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 04:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.169 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.169-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

