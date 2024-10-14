Return-Path: <stable+bounces-83656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0599199BD4F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B438281D42
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2412B73;
	Mon, 14 Oct 2024 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EOgRh8fC"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B981171C
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869370; cv=none; b=DfisLSqvpj5bnVaYVZrBS3c6ScKjrHBwxQnpCz6zV6913VGiu3dlA9tvrIOI5+JE9U2Ya9OHcjzMINQoKCtO2Fgtd7E3H8T+lx1EijbWjIbhcoT4wHLv51XM4kZtLaJeYRbsfTJGZq1N2ZQowxUb//gfFKB9uBN/vUL0M4Cy8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869370; c=relaxed/simple;
	bh=S5HwfiMBsCuQ8Bq2X7geGaQx9JB5AGW8Yq8J7Tcpo48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbIXEs+ft9fjAwlfPOAG3szM0f9jh+VcJFR/MEJCkU+3JbeDmFGYvY4rEzQt3QHxNhZ+wPia2V/k7zF3bWtARIu3W9b2U152fVVj3TCbvG7x37HmcwmiTpU0Cq5Q4KhBKbpOBlVMVjLJvkCIfbBZSq3G+eNGkOv30HyjJxCMUfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EOgRh8fC; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728869369;
	bh=p/0isTr9qkbLy7LpIsD3AA4pI52RUqudxo5eFWiJE0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=EOgRh8fCsfjvy4mq7ZwAhx5JS4ZqwKeIOldwcbyCw0N2OETXzQ+oC2/qF9iZXkoIs
	 jbkkIU8eoWvLTIQKFbsUwOiEcMsFqAKoagQemacjndLRgelf+t09+PR+PePk4IMPm8
	 15y/8GBCSJUzDaf4C/zVzqiPXtf786AUuh+BtnLy/+bVFQwNXVvAeVxfwCC5abDQPI
	 yEXQMjeuU953WkPTSeOGyrm+6r3TCgEkJZ3LAvelda//ORm03QaLpw/yNHT0Jhy2+F
	 0KgNqi2vU3PMXAnvRyW6Dk6Cn7QKrMY7hXv939MGXQOXz1InGbNHjjpUlFHJNLkJb6
	 7/g5YZvoKxGcg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 73F2D8001E4;
	Mon, 14 Oct 2024 01:29:24 +0000 (UTC)
Message-ID: <695d1a26-255f-464b-884b-47a5b7421128@icloud.com>
Date: Mon, 14 Oct 2024 09:29:17 +0800
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
 <060193f9-5de1-422b-abfb-6328a1c7b806@icloud.com>
 <670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 39yAAcbnvXMxmaUbiIE4G_uzBrweEicy
X-Proofpoint-ORIG-GUID: 39yAAcbnvXMxmaUbiIE4G_uzBrweEicy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-13_17,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410140009

On 2024/10/13 06:16, Dan Williams wrote:
> Zijun Hu wrote:
> [..]
>>>> it does NOT deserve, also does NOT need to introduce a new core driver
>>>> API device_for_each_child_reverse_from(). existing
>>>> device_for_each_child_reverse() can do what the _from() wants to do.
>>>>
>>>> we can use similar approach as below link shown:
>>>> https://lore.kernel.org/all/20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com/
>>>
>>> No, just have a simple starting point parameter. I understand that more
>>> logic can be placed around device_for_each_child_reverse() to achieve
>>> the same effect, but the core helpers should be removing logic from
>>> consumers, not forcing them to add more.
>>>
>>> If bloat is a concern, then after your const cleanups go through
>>> device_for_each_child_reverse() can be rewritten in terms of
>>> device_for_each_child_reverse_from() as (untested):
>>>
>>
>> bloat is one aspect, the other aspect is that there are redundant
>> between both driver core APIs, namely, there are a question:
>>
>> why to still need device_for_each_child_reverse() if it is same as
>> _from(..., NULL, ...) ?
> 
> To allow access to the new functionality without burdening existing
> callers. With device_for_each_child_reverse() re-written to internally
> use device_for_each_child_reverse_from() Linux gets more functionality
> with no disruption to existing users and no bloat. This is typical API
> evolution.
> 
>> So i suggest use existing API now.
> 
> No, I am failing to understand your concern.
> 
>> if there are more users who have such starting point requirement, then
>> add the parameter into device_for_each_child_reverse() which is
>> consistent with other existing *_for_each_*() core APIs such as
>> (class|driver|bus)_for_each_device() and bus_for_each_drv(), that may
>> need much efforts.
> 
> There are ~370 existing device_for_each* callers. Let's not thrash them.
> 
> Introduce new superset calls with the additional parameter and then
> rewrite the old routines to just have a simple wrapper that passes a
> NULL @start parameter.
> 
> Now, if Greg has the appetite to go touch all ~370 existing callers, so
> be it, but introducing a superset-iterator-helper and a compat-wrapper
> for legacy is the path I would take.
> 

current kernel tree ONLY has 15 usages of
device_for_each_child_reverse(), i would like to
add an extra parameter @start as existing
(class|driver)_for_each_device() and bus_for_each_(dev|drv)() do
if it is required.

>> could you please contains your proposal "fixing this allocation
>> order validation" of below link into this patch series with below
>> reason? and Cc me (^^)
>>
>> https://lore.kernel.org/all/670835f5a2887_964f229474@dwillia2-xfh.jf.intel.com.notmuch/
>>
>> A)
>>   the proposal depends on this patch series.
>> B)
>>   one of the issues the proposal fix is match_free_decoder()  error
>> logic which is also relevant issues this patch series fix, the proposal
>> also can fix the other device_find_child()'s match() issue i care about.
>>
>> C)
>>  Actually, it is a bit difficult for me to understand the proposal since
>>  i don't have any basic knowledge about CXL. (^^)
> 
> If I understand your question correctly you are asking how does
> device_for_each_child_reverse_from() get used in
> cxl_region_find_decoder() to enforce in-order allocation?
> 

yes. your recommendation may help me understand it.

> The recommendation is the following:
> 
> -- 8< --
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3478d2058303..32cde18ff31b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -778,26 +778,50 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  	return rc;
>  }
>  
> +static int check_commit_order(struct device *dev, const void *data)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +
> +	/*
> +	 * if port->commit_end is not the only free decoder, then out of
> +	 * order shutdown has occurred, block further allocations until
> +	 * that is resolved
> +	 */
> +	if (((cxld->flags & CXL_DECODER_F_ENABLE) == 0))
> +		return -EBUSY;
> +	return 0;
> +}
> +
>  static int match_free_decoder(struct device *dev, void *data)
>  {
> +	struct cxl_port *port = to_cxl_port(dev->parent);
>  	struct cxl_decoder *cxld;
> -	int *id = data;
> +	int rc;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxld = to_cxl_decoder(dev);
>  
> -	/* enforce ordered allocation */
> -	if (cxld->id != *id)
> +	if (cxld->id != port->commit_end + 1)
>  		return 0;
>  

for a port, is it possible that there are multiple CXLDs with same IDs?

> -	if (!cxld->region)
> -		return 1;
> -
> -	(*id)++;
> +	if (cxld->region) {
> +		dev_dbg(dev->parent,
> +			"next decoder to commit is already reserved\n",
> +			dev_name(dev));
> +		return 0;
> +	}
>  
> -	return 0;
> +	rc = device_for_each_child_reverse_from(dev->parent, dev, NULL,
> +						check_commit_order);
> +	if (rc) {
> +		dev_dbg(dev->parent,
> +			"unable to allocate %s due to out of order shutdown\n",
> +			dev_name(dev));
> +		return 0;
> +	}
> +	return 1;
>  }
>  
>  static int match_auto_decoder(struct device *dev, void *data)
> @@ -824,7 +848,6 @@ cxl_region_find_decoder(struct cxl_port *port,
>  			struct cxl_region *cxlr)
>  {
>  	struct device *dev;
> -	int id = 0;
>  
>  	if (port == cxled_to_port(cxled))
>  		return &cxled->cxld;
> @@ -833,7 +856,7 @@ cxl_region_find_decoder(struct cxl_port *port,
>  		dev = device_find_child(&port->dev, &cxlr->params,
>  					match_auto_decoder);
>  	else
> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> +		dev = device_find_child(&port->dev, NULL, match_free_decoder);
>  	if (!dev)
>  		return NULL;
>  	/*


