Return-Path: <stable+bounces-188867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB12BF9C2D
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 04:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581E519C18D6
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 02:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FD2212FB3;
	Wed, 22 Oct 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNHvrVWV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C81D5CF2
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101211; cv=none; b=aIJFtRwV3b6PHT6IUHSAk06C1iDmKYdTN8mYBioca8qUO7swk8ZYK1YXIxXeOhVIEdJMueBh8d3zyCTanoYduU7hs77GPc1AxDeO2kraRnnKNIJRq3MHa99fZy2QF/1GqPegJQ1+chA2Dfl5Uxwm78yejuOQ9Cl0SFCmqzpL4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101211; c=relaxed/simple;
	bh=a3CCCdrTWUxuRUJBdeeFVwrJgfSwekbmeg/24eUtngo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs/XwIyplCJYrHgjAN13nsofvuFtya4bLhWh/viYUF47o6yAUuDbTnOlZLWgkQMB8l2Id2MZG3n80SUVmvWWumkFEgSRCMuDoFZNa2AlE+URvmi0DZw1BhP67SmXYlLJcawa3dVDjK4L2HQ+kwuS9Kng/pKA0X2+C73POPadbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNHvrVWV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7835321bc98so5675346b3a.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101209; x=1761706009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYNRDrO3CybgYbzGCrw9HtMshXI77N9IrEDAL18hksY=;
        b=VNHvrVWVCV5RfrahILjFm3ADTKr57l5GSCeXAOupQgxEgrfDYwH5iPe9xNlz6FU7SY
         gVgIu2/DbRk9Ue1roCpdeuT1ehZoiapNtOAtJPVLO3fvPfH2beQ7Og4JcB62LQfTYz8g
         al/zpncVIRh96frwh8OYAZYdmvvBEXGdYiGM+Cu2at2wjnTSiJyC4Cd57J1yvdoM3AJZ
         vN3GeaDyUivRPRfXDkFWyP0Gm6Ga8AvqLtExfEu+bZ0LN0zxBfQLLrWnuMwDeHiB0O17
         DOgaPBSNOrzgXJV82znacwmLK5eG/sh/bsNqDUMv/tJJTDIZOz87kSId9KnABkiF4ITM
         hSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101209; x=1761706009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYNRDrO3CybgYbzGCrw9HtMshXI77N9IrEDAL18hksY=;
        b=S8opGVxEthXdAkk/jtVPDL22nQLZcAJ4Bj7iW2LZWGQBKidm5Ec0N/1A1JJULpGxaO
         xTBDLkCGlGCUrgj1SQT/Q0aEe/YGIauSGhEkl8l0R34M/FDSZp6zFKTJLjiDKf9LrrIz
         8NYtu4rhDiUmjEf6MaY3UU1bPUGunTdgm4rEwmq8mxjt/yQG/5XR+7HbLuxu0DHv2I0p
         xvC+QeCU+zppSBXeAbUpMMcpj/EweTN/F82e+o664PNeoFloaHuaOo0uCUTDFrQyU44C
         t8jFviUhzaKtcTS1KVoW5NjlE5WyFsgChgPpK1opXScl1f4IVBvgvLqgGRcJo/FbxAAN
         CjDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF23qz21/4wVBxM80ItMWmVxlLoU69UOQHVg99jOcOr9Gk82Qexd8hhmjNiKEXuqRbFLvbW48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1XkrOFH9HaaLsW8PbYew9F3fwjrun90mpdWIUQOT/5F3rfFQG
	ztXz1pKqNQJUN1gsRrajwUnTaC7SjAfToq2YBPhkcHfboyGi05FSpENa
X-Gm-Gg: ASbGncvb1NSQrMgwgJfvn7kLSI5ySqlXKYSp6nTfmIiE1eVnjjOLXb1bCtEnlT48ZJm
	1Q/54x4TngXuGYVv5KCfbBKhxtrQ7w3U7Ub1JPuxTBJbHsNia2fVpRFO0Fnap0l+hIiY6qHr6WH
	lpT1AA+y9mJs9pJiL+pKAM5X68gr25brkL07oEed9+TddR0r0ABE4mMngU8MtQ1s/HYPJM3bnkn
	GkIunTADwx7DogHJ2J6t2TwETV6f0sz9HuhZqb8P5t/Hqisy7Qnl2s+4TFJ5kd5RKULYqNyru78
	+DPaaZtbnSsJL6y64duCuerlzKw+XIKpXXQFSAXGFhzWOXLTqCpoD8hKeqOMXS8MQt4Q/PwejMz
	/NxH7/9609tfBCNvbhQ+ZzhAaH4HY1AsJpJnY9FrrwbIZCzZ1xAyX8x8PEr3aPUtQxfxpmm23Xw
	ClmdgRLaU9ADlAS1yxeSN0bWCWEHPfrYorb0g31ak/eA==
X-Google-Smtp-Source: AGHT+IHmTFutYfiBPfh6pKIFfa8WG/r+Q1etaUgtanp0pzTongAxTZzvK9UpNwlCGbPLH2M8H69kng==
X-Received: by 2002:a05:6a00:4614:b0:78c:984b:7a92 with SMTP id d2e1a72fcca58-7a220a859eemr23541047b3a.12.1761101209199;
        Tue, 21 Oct 2025 19:46:49 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15c89sm13232037b3a.1.2025.10.21.19.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 19:46:48 -0700 (PDT)
Message-ID: <0f508e49-f916-4219-8743-0ee7ed12fc23@gmail.com>
Date: Tue, 21 Oct 2025 19:46:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251021195021.492915002@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/2025 12:50 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.114 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.114-rc1.gz
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


