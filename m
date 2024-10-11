Return-Path: <stable+bounces-83507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B7F99AF77
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 01:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504C61F23007
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800D1E3786;
	Fri, 11 Oct 2024 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gznUbumH"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E81D27A9
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728690025; cv=none; b=OFJuyVXniYvZzFWCbPL7r3UkB+/h9eTcXIlK66xuQPd4QeVDLD+qKGiDB6L9EIKpBNai/cWDsiEdYsDncJDhTXT/Agp51GPMCt7OPMO6nYcE+OnYjp6soBaJSqcqQyq4Q99Q6aZJA3GvX0TR4jFYAfhRfAXmwOgvUyYdnWrOxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728690025; c=relaxed/simple;
	bh=hzmriMm1SlBGJ794Cddrkfm/jHhZdGdWaKuc0Hj0ZFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atKCrvAnrsUbh5EhEjwKAgdjLbUkpDQ2dN6QspjsAo2RZlVneAoCs2l6IICcdPs+iT7dfBWUvrdtBjIoFkCvPpb519Z1Uhxz3KPw5b56mcik38NTxeNYhXd2mbOdnRko2zaxYwZ3yQQpv4+h3LzqrZkBUa3GDQkQFNkKVqgoiug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gznUbumH; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728690023;
	bh=rC/dMbnugMRawoRxS2uRVhimv+ms1/XM7Yr5Pb3hCoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=gznUbumHUDA1uaHgKsfzgAnxv+kG5j6ikHE//fBa9stmsXh41VWRVv2Dpic4ieQfV
	 iWh78db4bpMCJ01AOjsV/8pZvrCwrX6RP4X44Qecnat3PIqVb6sotaU3ODqFNhVogs
	 BZh6Xrtmv6yAwYsA+7e5wXAXlsqzYzsAePtxt1d8Z8sce8rWYq/mqUyTou0LfQ9Kzi
	 FF4HJ/tcmnjKLQxewzTzULyK62OOzebnxb1vUWQ71WaDpdwdjMEjPePQnNWDkY4Qjw
	 yrnrfsLugPdXbSK94SL6V51NHoPdDwm7e4PidbpYLDgN6oMJiVSq9bQWi4LVrPnIqY
	 Vpt7iO8q7xUZA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id B5D903A02D6;
	Fri, 11 Oct 2024 23:40:17 +0000 (UTC)
Message-ID: <060193f9-5de1-422b-abfb-6328a1c7b806@icloud.com>
Date: Sat, 12 Oct 2024 07:40:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] cxl/port: Fix use-after-free, permit out-of-order
 decoder shutdown
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 ira.weiny@intel.com
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>, vishal.l.verma@intel.com,
 linux-cxl@vger.kernel.org
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
 <a7b8a007-907a-4fda-9a35-68faed109ed3@icloud.com>
 <6709647f66d94_964f2294ae@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <6709647f66d94_964f2294ae@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SdAq2sLRtK5itv8SkkUuMB5ydBc9zxot
X-Proofpoint-GUID: SdAq2sLRtK5itv8SkkUuMB5ydBc9zxot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_21,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410110164

On 2024/10/12 01:46, Dan Williams wrote:
> Zijun Hu wrote:
>> On 2024/10/11 13:34, Dan Williams wrote:
>>> In support of investigating an initialization failure report [1],
>>> cxl_test was updated to register mock memory-devices after the mock
>>> root-port/bus device had been registered. That led to cxl_test crashing
>>> with a use-after-free bug with the following signature:
>>>
>>>     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem0:decoder7.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
>>>     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem4:decoder14.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
>>>     cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[0] = cxl_switch_dport.0 for mem0:decoder7.0 @ 0
>>> 1)  cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[1] = cxl_switch_dport.4 for mem4:decoder14.0 @ 1
>>>     [..]
>>>     cxld_unregister: cxl decoder14.0:
>>>     cxl_region_decode_reset: cxl_region region3:
>>>     mock_decoder_reset: cxl_port port3: decoder3.0 reset
>>> 2)  mock_decoder_reset: cxl_port port3: decoder3.0: out of order reset, expected decoder3.1
>>>     cxl_endpoint_decoder_release: cxl decoder14.0:
>>>     [..]
>>>     cxld_unregister: cxl decoder7.0:
>>> 3)  cxl_region_decode_reset: cxl_region region3:
>>>     Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bc3: 0000 [#1] PREEMPT SMP PTI
>>>     [..]
>>>     RIP: 0010:to_cxl_port+0x8/0x60 [cxl_core]
>>>     [..]
>>>     Call Trace:
>>>      <TASK>
>>>      cxl_region_decode_reset+0x69/0x190 [cxl_core]
>>>      cxl_region_detach+0xe8/0x210 [cxl_core]
>>>      cxl_decoder_kill_region+0x27/0x40 [cxl_core]
>>>      cxld_unregister+0x5d/0x60 [cxl_core]
>>>
>>> At 1) a region has been established with 2 endpoint decoders (7.0 and
>>> 14.0). Those endpoints share a common switch-decoder in the topology
>>> (3.0). At teardown, 2), decoder14.0 is the first to be removed and hits
>>> the "out of order reset case" in the switch decoder. The effect though
>>> is that region3 cleanup is aborted leaving it in-tact and
>>> referencing decoder14.0. At 3) the second attempt to teardown region3
>>> trips over the stale decoder14.0 object which has long since been
>>> deleted.
>>>
>>> The fix here is to recognize that the CXL specification places no
>>> mandate on in-order shutdown of switch-decoders, the driver enforces
>>> in-order allocation, and hardware enforces in-order commit. So, rather
>>> than fail and leave objects dangling, always remove them.
>>>
>>> In support of making cxl_region_decode_reset() always succeed,
>>> cxl_region_invalidate_memregion() failures are turned into warnings.
>>> Crashing the kernel is ok there since system integrity is at risk if
>>> caches cannot be managed around physical address mutation events like
>>> CXL region destruction.
>>>
>>> A new device_for_each_child_reverse_from() is added to cleanup
>>> port->commit_end after all dependent decoders have been disabled. In
>>> other words if decoders are allocated 0->1->2 and disabled 1->2->0 then
>>> port->commit_end only decrements from 2 after 2 has been disabled, and
>>> it decrements all the way to zero since 1 was disabled previously.
>>>
>>> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Alison Schofield <alison.schofield@intel.com>
>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>> Cc: Zijun Hu <zijun_hu@icloud.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>  drivers/base/core.c          |   35 +++++++++++++++++++++++++++++
>>>  drivers/cxl/core/hdm.c       |   50 +++++++++++++++++++++++++++++++++++-------
>>>  drivers/cxl/core/region.c    |   48 +++++++++++-----------------------------
>>>  drivers/cxl/cxl.h            |    3 ++-
>>>  include/linux/device.h       |    3 +++
>>>  tools/testing/cxl/test/cxl.c |   14 ++++--------
>>>  6 files changed, 100 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index a4c853411a6b..e42f1ad73078 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -4037,6 +4037,41 @@ int device_for_each_child_reverse(struct device *parent, void *data,
>>>  }
>>>  EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
>>>  
>>> +/**
>>> + * device_for_each_child_reverse_from - device child iterator in reversed order.
>>> + * @parent: parent struct device.
>>> + * @from: optional starting point in child list
>>> + * @fn: function to be called for each device.
>>> + * @data: data for the callback.
>>> + *
>>> + * Iterate over @parent's child devices, starting at @from, and call @fn
>>> + * for each, passing it @data. This helper is identical to
>>> + * device_for_each_child_reverse() when @from is NULL.
>>> + *
>>> + * @fn is checked each iteration. If it returns anything other than 0,
>>> + * iteration stop and that value is returned to the caller of
>>> + * device_for_each_child_reverse_from();
>>> + */
>>> +int device_for_each_child_reverse_from(struct device *parent,
>>> +				       struct device *from, const void *data,
>>> +				       int (*fn)(struct device *, const void *))
>>> +{
>>> +	struct klist_iter i;
>>> +	struct device *child;
>>> +	int error = 0;
>>> +
>>> +	if (!parent->p)
>>> +		return 0;
>>> +
>>> +	klist_iter_init_node(&parent->p->klist_children, &i,
>>> +			     (from ? &from->p->knode_parent : NULL));
>>> +	while ((child = prev_device(&i)) && !error)
>>> +		error = fn(child, data);
>>> +	klist_iter_exit(&i);
>>> +	return error;
>>> +}
>>> +EXPORT_SYMBOL_GPL(device_for_each_child_reverse_from);
>>> +
>>
>> it does NOT deserve, also does NOT need to introduce a new core driver
>> API device_for_each_child_reverse_from(). existing
>> device_for_each_child_reverse() can do what the _from() wants to do.
>>
>> we can use similar approach as below link shown:
>> https://lore.kernel.org/all/20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com/
> 
> No, just have a simple starting point parameter. I understand that more
> logic can be placed around device_for_each_child_reverse() to achieve
> the same effect, but the core helpers should be removing logic from
> consumers, not forcing them to add more.
> 
> If bloat is a concern, then after your const cleanups go through
> device_for_each_child_reverse() can be rewritten in terms of
> device_for_each_child_reverse_from() as (untested):
> 

bloat is one aspect, the other aspect is that there are redundant
between both driver core APIs, namely, there are a question:

why to still need device_for_each_child_reverse() if it is same as
_from(..., NULL, ...) ?

So i suggest use existing API now.
if there are more users who have such starting point requirement, then
add the parameter into device_for_each_child_reverse() which is
consistent with other existing *_for_each_*() core APIs such as
(class|driver|bus)_for_each_device() and bus_for_each_drv(), that may
need much efforts.


could you please contains your proposal "fixing this allocation
order validation" of below link into this patch series with below
reason? and Cc me (^^)

https://lore.kernel.org/all/670835f5a2887_964f229474@dwillia2-xfh.jf.intel.com.notmuch/

A)
  the proposal depends on this patch series.
B)
  one of the issues the proposal fix is match_free_decoder()  error
logic which is also relevant issues this patch series fix, the proposal
also can fix the other device_find_child()'s match() issue i care about.

C)
 Actually, it is a bit difficult for me to understand the proposal since
 i don't have any basic knowledge about CXL. (^^)

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e42f1ad73078..2571c910da46 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4007,36 +4007,6 @@ int device_for_each_child(struct device *parent, void *data,
>  }
>  EXPORT_SYMBOL_GPL(device_for_each_child);
>  
> -/**
> - * device_for_each_child_reverse - device child iterator in reversed order.
> - * @parent: parent struct device.
> - * @fn: function to be called for each device.
> - * @data: data for the callback.
> - *
> - * Iterate over @parent's child devices, and call @fn for each,
> - * passing it @data.
> - *
> - * We check the return of @fn each time. If it returns anything
> - * other than 0, we break out and return that value.
> - */
> -int device_for_each_child_reverse(struct device *parent, void *data,
> -				  int (*fn)(struct device *dev, void *data))
> -{
> -	struct klist_iter i;
> -	struct device *child;
> -	int error = 0;
> -
> -	if (!parent || !parent->p)
> -		return 0;
> -
> -	klist_iter_init(&parent->p->klist_children, &i);
> -	while ((child = prev_device(&i)) && !error)
> -		error = fn(child, data);
> -	klist_iter_exit(&i);
> -	return error;
> -}
> -EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
> -
>  /**
>   * device_for_each_child_reverse_from - device child iterator in reversed order.
>   * @parent: parent struct device.
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 667cb6db9019..96a2c072bf5b 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1076,11 +1076,14 @@ DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
>  
>  int device_for_each_child(struct device *dev, void *data,
>  			  int (*fn)(struct device *dev, void *data));
> -int device_for_each_child_reverse(struct device *dev, void *data,
> -				  int (*fn)(struct device *dev, void *data));
>  int device_for_each_child_reverse_from(struct device *parent,
>  				       struct device *from, const void *data,
>  				       int (*fn)(struct device *, const void *));
> +static inline int device_for_each_child_reverse(struct device *dev, const void *data,
> +						int (*fn)(struct device *, const void *))
> +{
> +	return device_for_each_child_reverse_from(dev, NULL, data, fn);
> +}
>  struct device *device_find_child(struct device *dev, void *data,
>  				 int (*match)(struct device *dev, void *data));
>  struct device *device_find_child_by_name(struct device *parent,


