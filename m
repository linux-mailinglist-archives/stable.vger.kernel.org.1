Return-Path: <stable+bounces-139104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEC2AA444A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 09:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A981189F30A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE420E334;
	Wed, 30 Apr 2025 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B/RhTTtZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43AF20D4F2;
	Wed, 30 Apr 2025 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999200; cv=none; b=NunVhe5J5LMGuLFqNnH4WbJYglZWvz1xKpH+pNUUF9Z68UTlc8YqVI0fQXUHwaYw1elgveNQDfskM2BJw/dmMKW24/f4HDpRBq0KHtX4+Km4e0utiQHhRWzS/8l4yxIOjN1n85Lk+sn40N6E5uLhxbzpSvbkyW3VIHpTq24XSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999200; c=relaxed/simple;
	bh=V0vN86J8Amhp5uSVCUtJ9QA2CyeKLoo79zpLTPffBxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DP7FYn2U0FjULY+zh3sHN9SBngtywRtouvR3sfg+ffcDhq6xaPMFDaQ26t3m3lDma67Xf4UUPBRygvGOqohFHxn9lQVqqujjyd+ZCvKxTaYg+WBq8M1MCLBnAmmljZuMNMq8Qb0IoRf0XTt6E1perr44y9WdB6eqFdbJnI+zyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B/RhTTtZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.32.103] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D098204E7D7;
	Wed, 30 Apr 2025 00:46:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D098204E7D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745999198;
	bh=1sYnBvs5uUw9MJcn+lnMcfIkdXkdcRWW5QdwFTK2gRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B/RhTTtZ5noovMdUGXb882ZzLD1lEmnbW9IVGtM+1s0ymbsV21gcZgyAUUZ6mVF4p
	 Dv28uWItPcBo+UT7v68pj6lFdM4dddy6oL4ATrV197EmjsZZTAWTvTf5PR4YWZtlrk
	 H7ziBduaINqWzpLzK+rihe8apExia+tQWv5vlxgw=
Message-ID: <d5bea5ef-770e-4b99-82c3-95f26e29e018@linux.microsoft.com>
Date: Wed, 30 Apr 2025 00:46:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/167] 6.1.136-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161051.743239894@linuxfoundation.org>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The kernel, bpf tool and perf tool builds fine for v6.1.136-rc1 on x86 
and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,

Hardik

