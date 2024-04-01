Return-Path: <stable+bounces-33883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE289394D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF46BB21956
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E865101DE;
	Mon,  1 Apr 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DLHWMNWN"
X-Original-To: stable@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37928101C5;
	Mon,  1 Apr 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962910; cv=none; b=RQDLFTil9ij8VznedTePgzze9whjMZI4p8VJNyd6OdiCuGyQxykOQiaTiOTTxpRm5i8MI3qr/0K5j0xgrH+zV7Ea+UXxXjrS+R8/0LQt/L+DJY/tP1+aM1vixpJ+QeHY6TPppLHrjNv2wLn6w9aLEbtc31S+NYNhtz89Fu5zR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962910; c=relaxed/simple;
	bh=7BbthviDQ0Ra47LSGIAYHzV26/8roeWxwzBYVgJLFiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+yjo2KWuwWShqVTpNmbuEf+dYy4KVn1XP24SLkP6tm49bnev73Dc3Mp2bMkDLriA/gLMYGk5eIN8tbgJek6WxAyzLC780fa79Y0ZdoBMZxsOWQCVwtPFmFmoWaIhY0RsS+zrer7eL//UdO2hobQl4IOiS6M0f5z96k7fTK0Sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DLHWMNWN; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711962906; x=1743498906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7BbthviDQ0Ra47LSGIAYHzV26/8roeWxwzBYVgJLFiM=;
  b=DLHWMNWNAqlN6QyrbEgjEIVdX4fgw/lyrHuVt/R7HDzGupV57bzekq9+
   xfUmmU2BeY6bRc6sbvu0vMEwDd9ChY/TReCbwsjN59qAQsdn4aApeTAq/
   ST4epl0j7XpQvf9AF9dqQTzbC3bhRV/bfp1L7SROd+oKxrgRXZykKtlrW
   Gz5qTel4WAmUbt2sjnyuPuudMoKx8U+8L5Txk4blN3pFDePmWcFYmXcmF
   XLpEw6+yrgi7XKDHxUmexUqyxFcK/WUeUOQ1oGTSiB2m9YOEUmz+HoRrJ
   WgJuJbi+lbXNSOMtw60m0PF7cjdB/YmCGQdu+p0ZCbzMFn1IHjlPD7ZmE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="142702081"
X-IronPort-AV: E=Sophos;i="6.07,171,1708354800"; 
   d="scan'208";a="142702081"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 18:14:56 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A5F06E95D6;
	Mon,  1 Apr 2024 18:14:54 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D9011CF7C2;
	Mon,  1 Apr 2024 18:14:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A2D821D02B;
	Mon,  1 Apr 2024 18:14:53 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8C1E41A000A;
	Mon,  1 Apr 2024 17:14:52 +0800 (CST)
Message-ID: <545f7629-2937-42ff-809e-02fdff5f4571@fujitsu.com>
Date: Mon, 1 Apr 2024 17:14:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/6] cxl/core: correct length of DPA field masks
To: Dan Williams <dan.j.williams@intel.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 stable@vger.kernel.org
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-2-ruansy.fnst@fujitsu.com>
 <66076ce2ddec7_19e02946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <66076ce2ddec7_19e02946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28290.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28290.006
X-TMASE-Result: 10--5.278600-10.000000
X-TMASE-MatchedRID: U43YD7H1LvyPvrMjLFD6eCkMR2LAnMRp2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1baz4aoYHfj+mh3bqxZ6gk+QqU4tmmg3HIi3TrOhAURKEbbhhV65kaY2O0yVK/5Lmc5GA
	Qy8LG5mci+t+0AiFaYvL3NxFKQpq17ZpdgJkP1WLcgUVP3Cp+vXFd5+Cf9M1DCK16zrE94nmkQu
	0/M/TLDg9Mn3iItNtKhgDksK+IVyzHO8eAxCOj9o61Z+HJnvsOfS0Ip2eEHnzUHQeTVDUrIg6wQ
	I72z4YedB0ntd9Tzp7GVuWouVipcobZcWeGK7nSbWo/bGcDJ4NC0x/dJHqjC/pbmb3XVEvJZDeF
	sBl1p6QJJfBDBk+SFcEYB+iaMCoc579tse/QOaV+erPL3QFt0vMMpBf3ZLno9xc4blKmPsG++4/
	U0fKJimxVnQcP2HDau2+pJwc75bs=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/3/30 9:37, Dan Williams 写道:
> Shiyang Ruan wrote:
>> The length of Physical Address in General Media Event Record/DRAM Event
>> Record is 64-bit, so the field mask should be defined as such length.
>> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
>> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
>> unaffected.
>>
>> If userspace was doing its own DPA-to-HPA translation this could lead to
>> incorrect page retirement decisions, but there is no known consumer
>> (like rasdaemon) of this event today.
>>
>> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
>> Cc: <stable@vger.kernel.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/cxl/core/trace.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index e5f13260fc52..e2d1f296df97 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
>>    * DRAM Event Record
>>    * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>>    */
>> -#define CXL_DPA_FLAGS_MASK			0x3F
>> +#define CXL_DPA_FLAGS_MASK			0x3FULL
> 
> This change makes sense...
> 
>>   #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>>   
>> -#define CXL_DPA_VOLATILE			BIT(0)
>> -#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
>> +#define CXL_DPA_VOLATILE			BIT_ULL(0)
>> +#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)
> 
> ...these do not. The argument to __print_flags() is an unsigned long, so
> they will be cast down to (unsigned long), and they are never used as a
> mask so the generated code should not change.

They will only used to check if such flag is set, not used as mask.  So, 
yes, I'll remove these changes.


--
Thanks,
Ruan.

