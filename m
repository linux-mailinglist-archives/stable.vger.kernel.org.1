Return-Path: <stable+bounces-41423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287ED8B1ECB
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636CAB27721
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9928E86274;
	Thu, 25 Apr 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hYMTxVTy"
X-Original-To: stable@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD06EB51;
	Thu, 25 Apr 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039576; cv=none; b=mQy+KOq3/aUc8kgJ49rDL72GUZG+aqD5x2CVZzIJPus+2xDj6+tj3kwJdfgjfze/2IOBvU6Sukv77HZjyJ7AF5Vkk8uj/xoq16euS5vfaBN64Czcqe/X7j9Wd11AjAXD8h8SyUypgS3Dz56kx4v8lftNIZqw1J8zrysuQTDy+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039576; c=relaxed/simple;
	bh=9ui7yF4xCi0s7W9PYYbpmr3fDfYDVJD2/IAdjVVo60E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDiIU06B5ZHVA849k5nuPezkMNph8B0+PlelGAuttymAMVy4ScovEQ5n+dd+9LvzSUR2paTfCnoF7Zvq4jdJeeVSB6g+pUh65pRmedDICGOiWGwSp5ewIrXwYSrawA4Mvzuj1KYvgbsdbpEuwE7adDJIO40DQqX/Om9jJw1HvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hYMTxVTy; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1714039573; x=1745575573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9ui7yF4xCi0s7W9PYYbpmr3fDfYDVJD2/IAdjVVo60E=;
  b=hYMTxVTyYfqL7Z84/jo8Efk5PD9jxcE/HB5HiHCc89Wsp8npbvcUl1V7
   xvo/A33N5o29+924SztQhcVB2uZL1zszxI+0WthwV/4IsZ+yJsCTFEwy5
   XnaGb2E19lZKw+WRLmJ6ko2IaVo6CJbAvjw96ShCSfIDB19DlOPOHKPTZ
   HHPkRbNTIWSR6rQkdCAbGpiSLVLEpQEWzKVeqxza405bJPmEKnRemnWta
   JdP72WjKCWXhEkQHXiETktb7nxYbCNk0SmDnMRLtNDyGyMls+DRHLoC3V
   M9eNEF9YjxoHa8JTDPyc3oXCiYFkjSpyA57g2LUpmZKI1c0Hwvr5BTeE3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="157008414"
X-IronPort-AV: E=Sophos;i="6.07,229,1708354800"; 
   d="scan'208";a="157008414"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 19:06:03 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F704D9DC3;
	Thu, 25 Apr 2024 19:06:01 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id CA709D4BE3;
	Thu, 25 Apr 2024 19:06:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 57CE0202D20DF;
	Thu, 25 Apr 2024 19:06:00 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1AF301A000B;
	Thu, 25 Apr 2024 18:05:58 +0800 (CST)
Message-ID: <5563b68c-48ab-48e3-bbc9-b93236ea0543@fujitsu.com>
Date: Thu, 25 Apr 2024 18:05:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
To: Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 stable@vger.kernel.org
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
 <ZifzF8cXObFiDiIK@aschofie-mobl2>
 <66282269c8d4e_d2ce22941e@iweiny-mobl.notmuch>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <66282269c8d4e_d2ce22941e@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28342.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28342.006
X-TMASE-Result: 10--8.769000-10.000000
X-TMASE-MatchedRID: ehvrJQ9m4PCPvrMjLFD6eHchRkqzj/bEC/ExpXrHizxBqLOmHiM3w9vx
	x0ntQKyZIvrftAIhWmLy9zcRSkKatdgW4k6aveo4JmbrB1j4Xwqu2GmdldmiUFAoBBK61BhcDNg
	h8//LFqcY75YLBQacDDXZ4YiSvO26P0DBdQeKlX30hv/rD7WVZAGo1vhC/pWj1tmGB7JU9CMQGU
	caieHP20ky3+YDnnncWtxX1bZT1YKPaFHMfVTC4IMbH85DUZXyudR/NJw2JHcNYpvo9xW+mI6HM
	5rqDwqtdBt/JsWxNYMojJSc3dcGBinRbTgBFGIc+/ubgugAYE5DfpC/4XnsQAPA0m6VHcLNwMzJ
	Pwl8jS0FTjdoGJlwifD71DijxXcjgokLZRKLKVGdC4HNoe3rP7Iyum16+pyZ1elfyC1yu6+FK45
	C57CBPA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/4/24 5:04, Ira Weiny 写道:
> Alison Schofield wrote:
>> On Wed, Apr 17, 2024 at 03:50:52PM +0800, Shiyang Ruan wrote:
> 
> [snip]
> 
>>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>>> index e5f13260fc52..cdfce932d5b1 100644
>>> --- a/drivers/cxl/core/trace.h
>>> +++ b/drivers/cxl/core/trace.h
>>> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
>>>    * DRAM Event Record
>>>    * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>>>    */
>>> -#define CXL_DPA_FLAGS_MASK			0x3F
>>> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>>>   #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>>>   
>>>   #define CXL_DPA_VOLATILE			BIT(0)
>>
>> This works but I'm thinking this is the time to convene on one
>> CXL_EVENT_DPA_MASK for both all CXL events, rather than having
>> cxl_poison event be different.
>>
>> I prefer how poison defines it:
>>
>> cxlmem.h:#define CXL_POISON_START_MASK          GENMASK_ULL(63, 6)
>>
>> Can we rename that CXL_EVENT_DPA_MASK and use for all events?

cxlmem.h:CXL_POISON_START_MASK is defined for MBOX commands (poison 
record, the lower 3 bits indicate "Error Source"), but CXL_DPA_MASK here 
is for events.  They have different meaning though their values are 
same.  So, I don't think we should consolidate them.

> 
> Ah!  Great catch.  I dont' know why I only masked off the 2 used bits.

Per spec, the lowest 2 bits of CXL event's DPA are defined for "Volatile 
or not" and "not repairable".  So there is no mistake here.

> That was short sighted of me.
> 
> Yes we should consolidate these.
> Ira

--
Thanks,
Ruan.


