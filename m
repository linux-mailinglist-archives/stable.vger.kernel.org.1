Return-Path: <stable+bounces-85077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FEE99DA7A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 02:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A32283151
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3933D5588F;
	Tue, 15 Oct 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0Fjp2AXF"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1E1DFE4
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950564; cv=none; b=VR7qP19HqJbl2BvIt0ZzeVUcPuZE5IvUTxRZ2kjO47rGxGA6zxvprRGCUU7ZYL55Qo03Bn9Ippdn5XbUohx0W3d9UxG4bSxB8DkHzp+8Wc5DaTTWv2KkNksdqXEOkcZgeNFteygMkAzCNSEQn+6ry62ZP0sMEeXXlQ/C1RTtIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950564; c=relaxed/simple;
	bh=qdp1IXm7sPtQ1iXlhRGCFjNLSsWp/D6bIF43Ev+J+nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wx9Wf/1drWZK2cJ859jBtz79VmWPR2R9aNT+qylTmIYfa6hpBW42TiLF9g90tzSrJBfqyBMA4cNJRqnBOUA2LbAlc+PHFtCkmALxyLbI2JGEtzzHZBRozz38CZHDPAfF0nlEM7dyk7WfZfz+PrfOnmnvY1Wee5qz/mR2p5Kwq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0Fjp2AXF; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728950562;
	bh=bc0gGgWaIEjvU+FNjrCKosVTwu3yCu4HMvtfsrQBbNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=0Fjp2AXF2+qI4DRHIQYAERNQtHpwIeeyPIHFzpiWw+gak7VZLf7IpDS0qzj/iwJTQ
	 apfEH8/UTVufXCjbRqJtkPWzUpi/wKLA+6h3wp/sNC3JgGt8N2F6QJsvxeZnIyJzGg
	 dxmB+JqU7K6ZzbCcStv3pteME7PVWNcqaNrrQyOL4fQaA1LNitq2JOKB2g0U99UB9m
	 T33Dd/cUm6FBacUJc1UB1BW9nx3GZIkqj+YZFANP1jVkcu7zNy3Awcjhl/K3ysYGgR
	 V6Y7vVNGILUYZUMq0EVaXzsr+KHHpcqJze0CF2qVPn39LwjIH5Uz1ofuy3gZTh5IL4
	 sNXiypG8i2/cw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 618853A029B;
	Tue, 15 Oct 2024 00:02:34 +0000 (UTC)
Message-ID: <4239bfd4-d5fe-4ac8-a087-9e1584765e61@icloud.com>
Date: Tue, 15 Oct 2024 08:02:25 +0800
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
 <695d1a26-255f-464b-884b-47a5b7421128@icloud.com>
 <670d71b354c30_3ee2294c4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <670d71b354c30_3ee2294c4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BcrNUSmlarhB_qc4nw-s5mPq3Jp_xtA9
X-Proofpoint-ORIG-GUID: BcrNUSmlarhB_qc4nw-s5mPq3Jp_xtA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_18,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410140172

On 2024/10/15 03:32, Dan Williams wrote:
> Zijun Hu wrote:
>> On 2024/10/13 06:16, Dan Williams wrote:
>>> Zijun Hu wrote:
>>> [..]
>>>>>> it does NOT deserve, also does NOT need to introduce a new core driver
>>>>>> API device_for_each_child_reverse_from(). existing
>>>>>> device_for_each_child_reverse() can do what the _from() wants to do.
>>>>>>

[snip]

>>> Introduce new superset calls with the additional parameter and then
>>> rewrite the old routines to just have a simple wrapper that passes a
>>> NULL @start parameter.
>>>
>>> Now, if Greg has the appetite to go touch all ~370 existing callers, so
>>> be it, but introducing a superset-iterator-helper and a compat-wrapper
>>> for legacy is the path I would take.
>>>
>>
>> current kernel tree ONLY has 15 usages of
>> device_for_each_child_reverse(), i would like to
>> add an extra parameter @start as existing
>> (class|driver)_for_each_device() and bus_for_each_(dev|drv)() do
>> if it is required.
> 
> A new parameter to a new wrapper symbol sounds fine to me. Otherwise,
> please do not go thrash all the call sites to pass an unused NULL @start
> parameter. Just accept that device_for_each_* did not follow the
> {class,driver,bus}_for_each_* example and instead introduce a new symbol
> to wrap the new functionality that so far only has the single CXL user.
> 

you maybe regard my idea as a alternative proposal if Greg dislike
introducing a new core driver API. (^^)

> [..]
>>> If I understand your question correctly you are asking how does
>>> device_for_each_child_reverse_from() get used in
>>> cxl_region_find_decoder() to enforce in-order allocation?
>>>
>>
>> yes. your recommendation may help me understand it.
>>

below simple solution should have same effect as your recommendation.
also have below optimizations:

1) it don't need new core API.
2) it is more efficient since it has minimal iterating.

i will submit it if you like it. (^^)

index e701e4b04032..37da42329ff3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -796,8 +796,9 @@ static size_t show_targetN(struct cxl_region *cxlr,
char *buf, int pos)

 static int match_free_decoder(struct device *dev, void *data)
 {
+       struct cxl_port *port = to_cxl_port(dev->parent);
        struct cxl_decoder *cxld;
-       int *id = data;
+       struct device **target_dev = data;

        if (!is_switch_decoder(dev))
                return 0;
@@ -805,15 +806,19 @@ static int match_free_decoder(struct device *dev,
void *data)
        cxld = to_cxl_decoder(dev);

        /* enforce ordered allocation */
-       if (cxld->id != *id)
-               return 0;
-
-       if (!cxld->region)
-               return 1;
-
-       (*id)++;
-
-       return 0;
+       if (cxld->id == port->commit_end + 1) {
+               if (!cxld->region) {
+                       *target_dev = dev;
+                       return 1;
+               } else {
+                       dev_dbg(dev->parent,
+                               "next decoder to commit is already
reserved\n",
+                               dev_name(dev));
+                       return -ENODEV;
+               }
+       } else {
+               return cxld->flags & CXL_DECODER_F_ENABLE ? 0 : -EBUSY;
+       }
 }

 static int match_auto_decoder(struct device *dev, void *data)
@@ -839,7 +844,7 @@ cxl_region_find_decoder(struct cxl_port *port,
                        struct cxl_endpoint_decoder *cxled,
                        struct cxl_region *cxlr)
 {
-       struct device *dev;
+       struct device *dev = NULL;
        int id = 0;

        if (port == cxled_to_port(cxled))
@@ -848,8 +853,8 @@ cxl_region_find_decoder(struct cxl_port *port,
        if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
                dev = device_find_child(&port->dev, &cxlr->params,
                                        match_auto_decoder);
-       else
-               dev = device_find_child(&port->dev, &id,
match_free_decoder);
+       else if (device_for_each_child(&port->dev, &dev,
match_free_decoder) > 0)
+               get_device(dev);
        if (!dev)
                return NULL;
        /*


>>> The recommendation is the following:
>>>
>>> -- 8< --
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 3478d2058303..32cde18ff31b 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -778,26 +778,50 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>>>  	return rc;
>>>  }
>>>  
>>> +static int check_commit_order(struct device *dev, const void *data)
>>> +{
>>> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>>> +
>>> +	/*
>>> +	 * if port->commit_end is not the only free decoder, then out of
>>> +	 * order shutdown has occurred, block further allocations until
>>> +	 * that is resolved
>>> +	 */
>>> +	if (((cxld->flags & CXL_DECODER_F_ENABLE) == 0))
>>> +		return -EBUSY;
>>> +	return 0;
>>> +}
>>> +
>>>  static int match_free_decoder(struct device *dev, void *data)
>>>  {
>>> +	struct cxl_port *port = to_cxl_port(dev->parent);
>>>  	struct cxl_decoder *cxld;
>>> -	int *id = data;
>>> +	int rc;
>>>  
>>>  	if (!is_switch_decoder(dev))
>>>  		return 0;
>>>  
>>>  	cxld = to_cxl_decoder(dev);
>>>  
>>> -	/* enforce ordered allocation */
>>> -	if (cxld->id != *id)
>>> +	if (cxld->id != port->commit_end + 1)
>>>  		return 0;
>>>  
>>
>> for a port, is it possible that there are multiple CXLDs with same IDs?
> 
> Not possible, that is also enforced by the driver core, all kernel
> object names must be unique (at least if they have the same parent), and
> the local subsystem convention is that all decoders are registered in
> id-order.


