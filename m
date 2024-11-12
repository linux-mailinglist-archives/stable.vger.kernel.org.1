Return-Path: <stable+bounces-92801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B869C5D89
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FE5B45906
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DD020103E;
	Tue, 12 Nov 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tMbAGiyA"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108A200117
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423964; cv=none; b=bI0RUmWLzx9NFS3G5tL7hS/vxw8/7vAN7bg3MMp7PA+EVHfq7iSPrFV2oZEOTUtnMPq0QsoHc5/kaIJezddfn8YhEZTrWVL/jJfXMECws9Da6ngIo514MaiHo+rY4zrrJQDSHsKs6jH4sAJQ0WG4jdzKNoEPCDVqnMmjrV6lgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423964; c=relaxed/simple;
	bh=CiKypDlwM8sVOJy8bpgngsCBsOX0TAO4x3tdC9Z3GZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYv4f4756qc3RJOPYG0h63f7xR2XrlOFsqzUiKvbybE+MIN/GdMDxcbqy/FPNwczPfKM+rN+suyUKQe42eGIN3M30X38B02U4aEYi/xxXbHRxkjwk7CcEYJQepveoHJiAAUIVQ6gE5PRISelWZVxLBo/k+t0VqiAggslgPoCl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tMbAGiyA; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731423962;
	bh=XorazmH3mbRA6gmyPuFX63LufteZd2QGwsYoXHaDemQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=tMbAGiyAjBo+qZkKlCGLbR2/loFAqPZq+WEVxuXTwxTblKe+fbADQUb36k1fm4fzx
	 +ruV2iBxZw8jFDF4kb9dU7Mjg5+vDqV1Zp1FbMdpG6Qbw5qO5JTtXpwg16c5jqCG4Y
	 hVE7218sLTdxXPF+qiffE1B7ybSjsWshtOng6sKnuNJcwoEhEc1ai3PQ2bi32U5GlE
	 sAI0ZbRAtFEbnDLMWQe9icAKwOgPRdKUtfZlBrsTu00MRukUiXVgw7A9jE8sZvbx69
	 NlRPJGKF0Ou3J0qvVFsTnCEcri5Gl0Q/mUgOscev6U27awjIAxSz3NF7EHbUl7//DE
	 Kdq+3sHEjzJrg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 0F0603A101D;
	Tue, 12 Nov 2024 15:05:57 +0000 (UTC)
Message-ID: <9db43c73-cdbb-4a89-ad1c-c05baf632a72@icloud.com>
Date: Tue, 12 Nov 2024 23:05:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver core: class: Fix wild pointer dereference in
 API class_dev_iter_next()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
 <20241105-class_fix-v1-1-80866f9994a5@quicinc.com>
 <2024111205-countable-clamor-d0c7@gregkh>
 <2952f37a-7a11-42d9-9b90-4856ed200610@icloud.com>
 <2024111230-erratic-clay-7565@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024111230-erratic-clay-7565@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9Wrctp99loJh0h8kHn2eRsK-RRstRV4g
X-Proofpoint-ORIG-GUID: 9Wrctp99loJh0h8kHn2eRsK-RRstRV4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411120121

On 2024/11/12 22:57, Greg Kroah-Hartman wrote:
> On Tue, Nov 12, 2024 at 10:46:27PM +0800, Zijun Hu wrote:
>> On 2024/11/12 19:43, Greg Kroah-Hartman wrote:
>>> On Tue, Nov 05, 2024 at 08:20:22AM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> class_dev_iter_init(struct class_dev_iter *iter, struct class *class, ...)
>>>> has return type void, but it does not initialize its output parameter @iter
>>>> when suffers class_to_subsys(@class) error, so caller can not detect the
>>>> error and call API class_dev_iter_next(@iter) which will dereference wild
>>>> pointers of @iter's members as shown by below typical usage:
>>>>
>>>> // @iter's members are wild pointers
>>>> struct class_dev_iter iter;
>>>>
>>>> // No change in @iter when the error happens.
>>>> class_dev_iter_init(&iter, ...);
>>>>
>>>> // dereference these wild member pointers here.
>>>> while (dev = class_dev_iter_next(&iter)) { ... }.
>>>>
>>>> Actually, all callers of the API have such usage pattern in kernel tree.
>>>> Fix by memset() @iter in API *_init() and error checking @iter in *_next().
>>>>
>>>> Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
>>>> Cc: stable@vger.kernel.org
>>>
>>> There is no in-kernel broken users of this from what I can tell, right?
>>> Otherwise things would have blown up by now, so why is this needed in
>>> stable kernels?
>>>
>>
>> For all callers of the API in current kernel tree, the class should have
>> been registered successfully when the API is invoking.
> 
> Great, so the existing code is just fine :)
> 
>> so, could you remove both Fix and stable tag directly?
> 
> Nope, sorry.  Asking a maintainer that gets hundreds of patches to
> hand-edit them does not scale.
>
okay, let me send a updated revision now.

> But really, as all in-kernel users are just fine, why add additional
> code if it's not needed?  THat's just going to increase our maintance
> burden for the next 40+ years for no good reason.
> 

IMO, this fix is very necessary for the API.

> thanks,
> 
> greg k-h


