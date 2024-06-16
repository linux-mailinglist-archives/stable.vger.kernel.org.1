Return-Path: <stable+bounces-52324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E8909D90
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6813E1C217C6
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A119C188CC0;
	Sun, 16 Jun 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5oph5e/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360216C6AF;
	Sun, 16 Jun 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718542583; cv=none; b=TWGrzjx0JuHnmU7obof5FmLPHstQKUfaGKbDdCHq9y/3XpzuHXQo7kSOa3ydRjU1EOqoxegxda12DPU7kwBAtdU1d6Ni/VI/mNchqc9N4Pb5PIrWXDu87vrT6zv7zYx4bPukxGEJl7r+ybqQ7ywG3869PkeO6nMIPaflNxy3/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718542583; c=relaxed/simple;
	bh=atMPEPRk86gUsmXv9xq1J/L5pz64zy58CAtEEIE6QBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRNEulFm6k2ZIeZF1N+69U8rh7F43yFOrjvgPmHJdOWIHUmsPdcQy50IrqP0TAurtjL7LlzBvl0KDu6j0t8g2PtfiEx+WSiMjtZcJPiSCUdiYHUc+i9yrihsWwRCtSF8CxxYmqHxjRb7JFc9ShA+FWatmdKtSa3AI0XtObLy/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5oph5e/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f47f07acd3so31931145ad.0;
        Sun, 16 Jun 2024 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718542581; x=1719147381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WbWp3Np3avgU6PWax0kO6yO/cXc5IQMH6Pm9H/WIftM=;
        b=W5oph5e/D+NyN+V7Dh5lW8thWP9+dqBkNHw1NsY7ieZwCpaBOyXIg33lCdZXyni6qy
         EKZ1oIn/0QO5MHBkITPjoTSjAVPFg+kBUxwbFBgpHOQaLQpT4adLGJ6m+w0M3mYTByE+
         tCMYQmCqiQ0+3BSf3NmwC1dQM2eRFt5Hwd9EkUn3Du63d+bTCnm5LTz9+W+jyrOckDOA
         DZ/MaZlpBQpd9n36lwAFPVvKtIfvW+6jmKRE03CqPXJLglgte8vQ2cKUpExLUevveljT
         KZ/LUUrwbt3He1tQR17UFnFv17X7HBVIz56SBYDv0cFQdDy+mOCDTz1fpdixlMoJlkcw
         2peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718542581; x=1719147381;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbWp3Np3avgU6PWax0kO6yO/cXc5IQMH6Pm9H/WIftM=;
        b=XVNBJiXJKdz8lg6OLSmiMFa/AYNRtcAPE/J+KSpT7y5YT1rC7mjNvADW2UOWN4UEmt
         LM3f/VgnLy4OhWZG6VGeU8L3HKP8DBh5RVuf1kPZQz7FSuzx2p/iSdIGUDNvqP2nhxrq
         yrGafAZmd23EkXNG3nxd5nhFp6LQOd3LPGGhtZBlxDc3/k1SxYXWAvKqphmSfGcLYQnK
         PTgtGrw8s/AkcUBmG54VohTUI1Uq9c9nHwosmPWGRcSVmqj5F8OL3HOkY5IF1XXCoXeJ
         S4tZQT8ON7Q1lVzRv0y4BDwc08PFlMkmu9wtLsG0H71LnKAAsNCe6Yzck249dUqrw4ft
         gREQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdvlqgjzQZ7rCbUuMgIrh20BAQ1NjiJJ7rA+KTiINJ2n8QXCyCG+jBvo9j+eUpGz35iUAFMvVjlu01L18hpua6K4ICVt1dpTrFXzec
X-Gm-Message-State: AOJu0YzeWKSpZdOx2omJfDTxxbIcVoTj6Uh118VP9y56tnN8pRjLGKmh
	G8H1cwFmlilUHW9ABGz/TCgRPn505B7CIzEyr/ix0n5WyTshCqL+
X-Google-Smtp-Source: AGHT+IGemF/eRFUpRVvAbhfJdy/+lCJl/uRgG6ud/vEgKuD7UqmAKw/zKAMkbctZHFc+s5dWUjvo8Q==
X-Received: by 2002:a17:902:ce02:b0:1f7:2293:1886 with SMTP id d9443c01a7336-1f8625c0c4emr103497445ad.12.1718542581337;
        Sun, 16 Jun 2024 05:56:21 -0700 (PDT)
Received: from [192.168.1.114] ([196.64.245.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee83cesm63267105ad.133.2024.06.16.05.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 05:56:20 -0700 (PDT)
Message-ID: <ec2304d7-62e8-4d4f-a838-e4decd78d147@gmail.com>
Date: Sun, 16 Jun 2024 13:55:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/402] 5.15.161-rc1 review
To: Vegard Nossum <vegard.nossum@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>, pavel@denx.de,
 jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 acme@redhat.com, namhyung@kernel.org, gpavithrasha@gmail.com,
 irogers@google.com, Darren Kenny <darren.kenny@oracle.com>
References: <20240613113302.116811394@linuxfoundation.org>
 <b6548098-de01-4ee1-87c8-6036cb1e3073@oracle.com>
 <2024061530-dress-powdery-c464@gregkh>
 <596a3b8e-0d36-47bd-b3ac-68812506b307@oracle.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <596a3b8e-0d36-47bd-b3ac-68812506b307@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/15/2024 7:09 PM, Vegard Nossum wrote:
> 
> On 15/06/2024 13:05, Greg Kroah-Hartman wrote:
>> On Fri, Jun 14, 2024 at 02:10:26PM +0530, Harshit Mogalapalli wrote:
>>> I think building perf while adding perf patches would help us prevent 
>>> from
>>> running into this issue. cd tools/perf/ ; make -j$(nproc) all
>>
>> Maybe, but I can't seem to build perf at all for quite a while, so I
>> doubt that anyone really cares here, right?
> 
> We're building perf and it worked before these patches. It's part of our
> kernel build and we do ship the result to customers. So we care :-)

Likewise here, we care about making sure that perf builds and works for 
any given stable release stream.

--
Florian

