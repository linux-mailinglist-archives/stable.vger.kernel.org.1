Return-Path: <stable+bounces-139411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DCCAA657A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 23:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75EA1BC1549
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A572609EE;
	Thu,  1 May 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IKi/d7M5"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A558920C01C;
	Thu,  1 May 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746134976; cv=none; b=oHHuJZOeyV6hYtlWeSj9WZ3CPNDAItlaRbfi3hgmWf5mcmikPfoEIZkGUboMJ/p0NKfVHxBB+1kLtKG7uuB+GamdJyClwusGdw02MFXKDVnPMSlUIiUG6GwVi5yOeKY5gDT42RBSfCdbBW0h4ehFH1L6wL4R/E5S2yl7IYyOhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746134976; c=relaxed/simple;
	bh=TtQHlSs9mCuOvq/Od5atiUs3rhQI1FOYWBUI1lzVHu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5F/gOwJh6UAgQt/1mkLqAkVMDYiTtwYJBgj8SMTSWs5aZKZKjmR4keQ5Ykgrqkc8g93RiID8zGK3H3MuHKVx9pnFkQRA6lfFIg0iPAv89hRllerTISrR2+oL63xDnec3xZXjIMa2oQzGepoqvx0nyE6sc4MRZMbrpwSkrTB+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IKi/d7M5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.247] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id BC9402115DA7;
	Thu,  1 May 2025 14:29:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC9402115DA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746134975;
	bh=TtQHlSs9mCuOvq/Od5atiUs3rhQI1FOYWBUI1lzVHu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IKi/d7M55gekyAZwpAb7sFwysgYxmHR8ULVzeMxgJYNjnG6DTGzhLKzkhmTp8f5+/
	 sV16/KC75XFe3ISEoWkWu4OHNiVgOVHr78s+XuJvwvwUaytRNDy8VPYQj3OhWoGjTJ
	 ptqnJ74GAAcKMzHwTLk9KmQysDS55D3MEhFfv3uc=
Message-ID: <0455be5b-f93b-44c2-82ec-68717aae2038@linux.microsoft.com>
Date: Thu, 1 May 2025 14:29:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/157] 6.1.136-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250501080849.930068482@linuxfoundation.org>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <20250501080849.930068482@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The kernel, bpf tool and perf tool builds fine for v6.1.136-rc2 on x86
and arm64 Azure VM.



Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,

Hardik

