Return-Path: <stable+bounces-98333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B234C9E402D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8007D167652
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F520CCCE;
	Wed,  4 Dec 2024 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YXfjL6Qf"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F520C474
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331421; cv=none; b=WM9jYUHMOUMLZQjD53oDPV/yCUv6msKXKm3OnvCM9A9Ij5K/vYtyKZIfgqf1/I72UQDUl4ojA9/CCz3RX3ZFEl/1VK0KXPJQd02d2rrCTWyVSWSJnRnWBrGM2YXns/AHcnWlOYvyqJ00lmIgUu0mIBVhNWAogiw6jzkcttJyNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331421; c=relaxed/simple;
	bh=XaoMXII8e6mfuATSLsXtjEWnRh3UwxsQH2bojJPG7NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLJsfb5LWKS799hNVvTs5lJcV0K03Q8mNH7K4C7o05wzXSBCpCHzw4uCIfStfumnbPZLmv7YxQ6nxru+umItlNv/XPqHg6pBJAqqGlllVYfpYt/xX6hy+VdIvGBBOMZonAMd6zWZ4uolBnBKE+IvZ4pz1pzwtJfgHI9vGQhuOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YXfjL6Qf; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a7a8195822so30865365ab.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 08:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733331419; x=1733936219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iTXrzkVbRdOn7ya7jAgMy2aC6OZ+AghQ3qdoT+WQZ8=;
        b=YXfjL6Qf7iqmC5EujnCqD4rd/5wY14LEHuMK8FfQfxCEbVDn3lObDh9PrpYoRtshh4
         hnd4lH8pIZxucE1n85k50NkzlXbBIzcNJw5We8xQiegZhRmcghhKsAIKPD/TZ5NYf+d2
         lX71pTROwjTskPsblJiRWtUOuMmry6pO/OkdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331419; x=1733936219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iTXrzkVbRdOn7ya7jAgMy2aC6OZ+AghQ3qdoT+WQZ8=;
        b=eFzpUYfsedX86he3VZ7BOmFITste2+Q6ydamy68XyDRCIxk6m1upNplWiJbL2L812W
         SymJ/zeYObTBjy5cXnb8zq3DWRua+8MV2qM/g7b1oOWSd89pnyVumzpLgQEq7Co8pWOE
         XMcMx+k5mSHQ8xincUIm06vbQXFcdOmtQS5lfYuoBEEavR5oSYGdfriHbTXVESSGvUk0
         QuJLCqoz1oIgsRYvTgWCNC8hv8bFDHNfVdfpcGEJQpqCMt0uL5K+ZeJSrrGJVEu1ApsN
         ga1TpeO2qPJmjJec8W0FVDAzbMN/Oe6ccWuwytAybFlK4XY6h+hZyAQeOHQ6IJ/Gc6N5
         tfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRf+rF4P6c67QwD+dG6rI7/604LCQtAVzuRGg0aMYf8GoE3EypCLGtsinXMcu7S3rYSef7rhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1IJ9NBKwKmgDCa/NLyhQfwrjXhGZCLDRZDJX3+1H7/WCNClS
	8wwKCownjU4ZV7cDyAxq/gQXtCttudK1mLVqgckXeBHkTzqYSuvkT2L3Vzup+kU=
X-Gm-Gg: ASbGncu7DGMLmGL2Yji9ut2rVeqdGJFUK7HNRbT4TqrdkUYdmTN8CwuBYMUWooCEbKM
	RPNAnUmYh3QAMmTUeBTMexYT5HFmWJrKFl3kT1b+BDe+o6jwiSPUfXD3Qn0GMtXzyMaZb3ndIFb
	t8y2mDaw9/Yy+8sBrKQG9xNdoD0cGftbO/KLoJzDMlHGnL3Im0RIoOWAI6iHcXRd0nK+BQgX8Q0
	3zdZXzDVeJVA/erAsHJm8pRhTeJ+o8hWrG9KMAgo565NYpxNCtNb8eMBM4cgA==
X-Google-Smtp-Source: AGHT+IHYHfBvUu0DZFh16zcxTkFpKxetrmBGHduH1Px3jq7+qvQd558v6EZlAarkWJRanQMBCA2qaQ==
X-Received: by 2002:a05:6e02:174c:b0:3a7:e0c0:5f25 with SMTP id e9e14a558f8ab-3a7f9a2952dmr79789725ab.4.1733331418893;
        Wed, 04 Dec 2024 08:56:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7dcc6146fsm26878105ab.74.2024.12.04.08.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:56:58 -0800 (PST)
Message-ID: <8e7b4812-bb10-4f5f-92f9-86aa33203c3a@linuxfoundation.org>
Date: Wed, 4 Dec 2024 09:56:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/138] 4.19.325-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241203141923.524658091@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241203141923.524658091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/24 07:30, Greg Kroah-Hartman wrote:
> ------------------
> Note, this is the LAST 4.19.y kernel to be released.  After this one, it
> is end-of-life.  It's been 6 years, everyone should have moved off of it
> by now.
> ------------------
> 
> This is the start of the stable review cycle for the 4.19.325 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2024 14:18:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.325-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

