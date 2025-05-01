Return-Path: <stable+bounces-139410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F6AA6569
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 23:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F9B3B6B8D
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603BB257450;
	Thu,  1 May 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h2AuF2Xw"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE024BC01;
	Thu,  1 May 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746134801; cv=none; b=h5lIqTUarwN9V7W27VHLsLASNdt9WA0cENyTS0xjnw7PXiTuXdlCUY3CUSUU0RSuBy3iCtKjpsu4tQ0eIZKLf5Wpnr9XcjUwJX0LJXF7EXQSul3qCQJm8bZvpjBu4+i0je4Gzhxvhx18Q98uPsU1GZx/4Z0HX0Gyl34fG+8bXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746134801; c=relaxed/simple;
	bh=irmpkIt6FpBZEesK9Gigy15TM5FLTLFvvAPmvm4ztXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9cKQBwpNWtzdiJE4vuC6MRzcjkVIXsUIXyBCW9AMZd6M5490ZRBupC1tCi+4JGSoCL5dMAwRmH3yzaTUn7sx28g6ytn4rUiCQHI3BfiVnM3CYe+g8vbv24daoDxwdZgd4mlZa8n6zF0ShaoOSThDtUaFcyN5ZePGeIz37ZD364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h2AuF2Xw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.247] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id E670A2115DA0;
	Thu,  1 May 2025 14:26:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E670A2115DA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746134793;
	bh=irmpkIt6FpBZEesK9Gigy15TM5FLTLFvvAPmvm4ztXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h2AuF2XwRqotbxNqsjugkESxfs0YGZOOdKglIPEDSZiXFGksBOrz7CqAEZaLOt1nW
	 bMIOiHkzvKXh9q43H/NpjtcP3lElRqHDnD84vJ0GGSiwZKhwJHcZFUWNf6ifvJsqYS
	 H/TP/sYK3kkoXktyBA97fLeE2MQT8mtW2TYY5oaw=
Message-ID: <ffc1e871-02a2-4977-9a4e-e3ee6b1a302d@linux.microsoft.com>
Date: Thu, 1 May 2025 14:26:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/368] 5.15.181-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250501081459.064070563@linuxfoundation.org>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <20250501081459.064070563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The kernel, bpf tool and perf tool builds fine for v5.15.181-rc2 on x86
and arm64 Azure VM.



Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,

Hardik

