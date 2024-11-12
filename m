Return-Path: <stable+bounces-92795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BCD9C5ACA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E011F22713
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FCC13F435;
	Tue, 12 Nov 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="wAN6IKSm"
X-Original-To: stable@vger.kernel.org
Received: from ms11p00im-qufo17281701.me.com (ms11p00im-qufo17281701.me.com [17.58.38.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADE1FA829
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422796; cv=none; b=B+Qdt9BeXHJsT8WLSrHL8QeTiFLb4AgmmJ6Af2f88B1cIlzp8wc9+ydnVENALb2ktmQeGf0zB4iSDzSNi5Py6hUEFe9AFaJW8gM5Jy1leUV2tDvSbj8TYOkt5nQ30ucH4Nu4vwKEZZ2LZTNdtOplsxJakHSMlwfAvyRwnDWgvMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422796; c=relaxed/simple;
	bh=awA7aFBLQ1vqUdnT5lTe7p33n4jdKtIQ+fo43elS3C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iq4hV/+3ZtotudzeZBrD2T/5NlaupBrkHbyIcdFxQYOsZ26YjNSN8NGaz+hQa/s76885Q7ADe/DmqA8fwyP8Co1/RYdYCbRkzZGCN2djTVMyEgyOsB3fF70rRpoP+BMNinLLMY9cG6XUIuGfh22HxU3965rfpF3EWQnMu93VpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=wAN6IKSm; arc=none smtp.client-ip=17.58.38.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731422794;
	bh=v19lituYZ5eOybH+gnxaoJL6meJAbszu8oTA7JcJvVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=wAN6IKSmgzw5jmsDrE9HipYtTCGnMgshhTD90VQZVN+3R2ndfyiGBMjkxR3DZtU7T
	 BUcKP3xBcvi3rj1wh38WhonEXfWCRGA5cnnrvEymAEM3tgDiVWLcAnD/870Pe0ptn0
	 sgru8DO+KHX4P5WTtx0CRZbCvc+rH/qxP5ffGfJg4EZPQKAYSFy/fnZm3xfkoAfUnA
	 ZykFjh+rWtYy/W+OC4Vk4v/9AfauXHOQQOxYzwZ7AjR3XPHGYNJ2p/3bHWDwmlm4en
	 Xp7vWzOtimyUJJejrLPFZApCOKCmfVQ+1dnuLuqhHBlYAD9iIfqXzmQKbYLSKSW2zT
	 kWjFT50MKnsAA==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17281701.me.com (Postfix) with ESMTPSA id 5825674236B;
	Tue, 12 Nov 2024 14:46:31 +0000 (UTC)
Message-ID: <2952f37a-7a11-42d9-9b90-4856ed200610@icloud.com>
Date: Tue, 12 Nov 2024 22:46:27 +0800
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
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024111205-countable-clamor-d0c7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y0CU276VVlOBEkwLR8uXIbCXGGMqwIrK
X-Proofpoint-ORIG-GUID: Y0CU276VVlOBEkwLR8uXIbCXGGMqwIrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411120119

On 2024/11/12 19:43, Greg Kroah-Hartman wrote:
> On Tue, Nov 05, 2024 at 08:20:22AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> class_dev_iter_init(struct class_dev_iter *iter, struct class *class, ...)
>> has return type void, but it does not initialize its output parameter @iter
>> when suffers class_to_subsys(@class) error, so caller can not detect the
>> error and call API class_dev_iter_next(@iter) which will dereference wild
>> pointers of @iter's members as shown by below typical usage:
>>
>> // @iter's members are wild pointers
>> struct class_dev_iter iter;
>>
>> // No change in @iter when the error happens.
>> class_dev_iter_init(&iter, ...);
>>
>> // dereference these wild member pointers here.
>> while (dev = class_dev_iter_next(&iter)) { ... }.
>>
>> Actually, all callers of the API have such usage pattern in kernel tree.
>> Fix by memset() @iter in API *_init() and error checking @iter in *_next().
>>
>> Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
>> Cc: stable@vger.kernel.org
> 
> There is no in-kernel broken users of this from what I can tell, right?
> Otherwise things would have blown up by now, so why is this needed in
> stable kernels?
> 

For all callers of the API in current kernel tree, the class should have
been registered successfully when the API is invoking.

so, could you remove both Fix and stable tag directly?

> thanks,
> 
> greg k-h


