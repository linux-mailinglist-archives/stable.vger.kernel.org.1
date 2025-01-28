Return-Path: <stable+bounces-110991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A10A20F61
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 18:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5458A165F8A
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF751DE2D4;
	Tue, 28 Jan 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iPKaHRR3"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F4E18A6DF
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083970; cv=none; b=DH5sML8iiwoRXE/H6eOxbfuLTP9fM+Bg9VGEk/CE0FMxoG9ScJ1K/lEhh/dI+fILHi8AqahZVy0hxzbRiQoTVl2jLX10g5XFubd8wfqrQomvsZWVdx43sL2xBO+sMvBTvJ2T8H4udpL2TUsDIOR9W+PKQ2g3wbHKsj6Hvj10VKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083970; c=relaxed/simple;
	bh=NgOZM2DdWeCrQIPAeYLkxXa1+Cs76y0uhGILyMY2MYs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N1LqQt/D8wG4m4x/Gh8iDk49p66dCOsVCgqiyewpsoJBBekwckf9lkA8ClXjsIyPHCy0ZIiOpz4nM+PNFlHD3gd3+sI+VuQBKuU0Hs87ZQxWvcV+45FGGHEVEtTuG8EaVPzAkyz7I1KpEeIlL0COc/7ur10fDiBORdSO+cW3Ztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iPKaHRR3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.234.35] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 751C62037173;
	Tue, 28 Jan 2025 09:06:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 751C62037173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738083962;
	bh=0tn+6kdU7zenxDiQ4fbdOnukKmqAtv6KvgKxj5y7pIU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iPKaHRR3sZhxQOxnYNW8/EhTRbPEXZiUMZiQ3xSzCPgiFxtLWtMLIa8x37PvwCqum
	 i00Gny8Uom7d2nmsrWDmFAez1AK8JqWIVktTOx6pnHzsheYe7Fq5Du//pjPdBlIWc9
	 5tR2u1KOCIzTZMGNZslEAPdpgzCo51OKk5F7KTmA=
Message-ID: <abc9281b-a8bf-47e9-a3f4-19ed19776516@linux.microsoft.com>
Date: Tue, 28 Jan 2025 09:06:02 -0800
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
Subject: Re: [PATCH 6.6.y] scsi: storvsc: Ratelimit warning logs to prevent VM
 denial of service
To: Greg KH <gregkh@linuxfoundation.org>
References: <20250127182908.66971-1-eahariha@linux.microsoft.com>
 <2d31d777-6732-4075-aedc-a832c9713bdb@linux.microsoft.com>
 <2025012827-ripcord-dismantle-4091@gregkh>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <2025012827-ripcord-dismantle-4091@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/2025 9:34 PM, Greg KH wrote:
> On Mon, Jan 27, 2025 at 11:25:17AM -0800, Easwar Hariharan wrote:
>> On 1/27/2025 10:29 AM, Easwar Hariharan wrote:
>>> commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream
>>>
>>> If there's a persistent error in the hypervisor, the SCSI warning for
>>> failed I/O can flood the kernel log and max out CPU utilization,
>>> preventing troubleshooting from the VM side. Ratelimit the warning so
>>> it doesn't DoS the VM.
>>>
>>> Closes: https://github.com/microsoft/WSL/issues/9173
>>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>>> Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
>>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>>> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>>> ---
>>>  drivers/scsi/storvsc_drv.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>
>> I just remembered that we should wait for Linus to tag the rc before
>> sending backports, so apologies for sending this (and its 6.1 and 6.12
>> friends) out before rc1 was tagged.
> 
> Why was this not tagged for stable in the first place?
> 
> thanks,
> 
> greg k-h

An oversight when I sent the original patch.

- Easwar (he/him)

