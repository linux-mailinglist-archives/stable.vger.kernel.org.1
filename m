Return-Path: <stable+bounces-110992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C2EA20F72
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 18:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF19188A976
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157C199E94;
	Tue, 28 Jan 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dzWHcA/J"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4AA27452
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084123; cv=none; b=o7sfUKWCZKNy/wwJL6ESpx39Pog0UA2vLlXQj49eItYsfuX4CZUYhxANa496qGawiJPWrjd6uDe27YX5ypRVjF81AucdOI9l4cPHcw7E54OYpTqev6w0CNh21SO02/Qsbjek0u1+2Y837V09IFcToWrS20JBhEiRtHNQ8bsCOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084123; c=relaxed/simple;
	bh=uFT0q2IcxgTUel7Y/EPOxw/p6tRlkeCQH9hVm0dxIPU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=utLxEitlKOj5O1m4zXHRbO2WB59itIJ+hXMFNU9IMoWkevnHjh4ZdFPUkTOIXZh+T+LQrV/a1Y46/wWzRpXDK8AH55b7aQ04JtinRAZPeFFM9jU3ZFrQnTQlSfXD5ezr6v2iUXDpD3snA27jdL+Pwx2kvsa9DMatfJVXcSG/4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dzWHcA/J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.234.35] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 144B32037173;
	Tue, 28 Jan 2025 09:08:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 144B32037173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738084122;
	bh=+8FOFHPWCxXRo0Vdo6o4ZhzriYAeRQZgLFu6ashJsQE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dzWHcA/Jo4aw8JT30ewsQzrRkODdEiowhTIozn6HbLjc9oAbFCaR1056R7AsuH+Xf
	 JIMrV4+apcG0gAhzejFpUHX+xaG7oLIL8V8mBy+BEgdLvdvT4ptC/BP8sngF3VMIyD
	 nYcT+KJEifIVjh1yeJg1IvoLVP3O5lMGVRmjiFpI=
Message-ID: <185173f5-5f46-4c24-b4fb-86dab478ea02@linux.microsoft.com>
Date: Tue, 28 Jan 2025 09:08:42 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, stable@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 6.12.y] scsi: storvsc: Ratelimit warning logs to prevent
 VM denial of service
To: Greg KH <gregkh@linuxfoundation.org>
References: <20250127182955.67606-1-eahariha@linux.microsoft.com>
 <2025012856-written-jarring-4843@gregkh>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <2025012856-written-jarring-4843@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/2025 9:35 PM, Greg KH wrote:
> On Mon, Jan 27, 2025 at 06:29:54PM +0000, Easwar Hariharan wrote:
>> commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream
>>
>> If there's a persistent error in the hypervisor, the SCSI warning for
>> failed I/O can flood the kernel log and max out CPU utilization,
>> preventing troubleshooting from the VM side. Ratelimit the warning so
>> it doesn't DoS the VM.
>>
>> Closes: https://github.com/microsoft/WSL/issues/9173
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>  drivers/scsi/storvsc_drv.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> What about 6.13.y?
> 

Yes, needs a backport to that too, another miss on my part. :(

Would you rather I send it after rc1 is tagged, or now for completeness?

- Easwar (he/him)



