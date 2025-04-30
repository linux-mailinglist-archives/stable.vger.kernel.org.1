Return-Path: <stable+bounces-139105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6D3AA4453
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 09:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220504E10C7
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22120C489;
	Wed, 30 Apr 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rCTqcBZC"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9092A1D88D0;
	Wed, 30 Apr 2025 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999319; cv=none; b=MhXxpjWmVXO1AJAn98fpwY7gOE7lwUngvngECuTZAAWVhfvuj6aDQJDFXA3VxvQKIeu7hNWjX3Gp7u+BQVUtkNSsgDdayD6PZqRFZeKb0NZCtHDjMuu10HUkca5GBWZUw/c/quZ3rYWvVxdeOfthxe4GdplHH2I3QU0Fi7+ta5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999319; c=relaxed/simple;
	bh=C7ZFKCsoLPWLbqw0rXNqdYUoJ/z9gq/6Npv3NfLINRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCRctlf9VwMimhj/bvKzCD4y8HxHOFG7n41qABKeCka1BeUhXwBIpVVKEEaHsmNLgNaa2SwdeHAwBHHbpQjBUltt2T/Qx2INs9wWEBdFOFRHq23VJSWnZgKIrfjcoL1RJGk5uHOKzSF00H7vMXNXRLreoHadAxdRHKEEbheRXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rCTqcBZC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.32.103] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id A0E8A204E7D7;
	Wed, 30 Apr 2025 00:48:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0E8A204E7D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745999318;
	bh=9CvSgBiVpPr6KzMXfUTXg9eT9FAu4uEWIBGNAYDNRQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rCTqcBZCNPQt3ZWtjbpA2ItG3DYxUpQqxaXhjvOZxtrz3jKCzmriLb/iMHMIrk64y
	 IadXxHnvWx5MqqALi67oKVlQSK6uNffNyFCWJ4KwTpFX/rW49NRSJcP8vjQ5cqI6al
	 yjx5yGER4PiVRmwHTykkQ5hd5rLfLCZD/8FzLgSc=
Message-ID: <f2ac192c-a64c-4558-aaea-fc79313dd892@linux.microsoft.com>
Date: Wed, 30 Apr 2025 00:48:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/373] 5.15.181-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161123.119104857@linuxfoundation.org>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The kernel, bpf tool and perf tool builds fine for v5.15.181-rc1 on x86 
and arm64 Azure VM.



Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,

Hardik

