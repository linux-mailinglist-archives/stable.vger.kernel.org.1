Return-Path: <stable+bounces-69919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ADD95C285
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 02:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B2D1C21E03
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 00:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FBEAD59;
	Fri, 23 Aug 2024 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rkUTTEh+"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6E12B72
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724373547; cv=none; b=P3xtIm3nVU/9l4j1OLQdDGMfaeLjhSyl/ZCjKs0Jx/IQdvfwMsKvL75bPHxoV+YNJZ8O+jua7lY6nNZf5NcWQq2Hy1HAvPpZ5lF5XWJ/B92ar/+IKT9XqmOCT7D0UkXz8jp0XjKy1LhPR/L4s6ZFLOmv8eXVCAlr6S6FgomajPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724373547; c=relaxed/simple;
	bh=/laXggx2klEzVGUGM2bjdt1/OHA2TkIhdeXgWoSgbPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOurnNhrRFbsTxvaBKSEQATGhqyQuzMvtArVksMcaTFumj9hlgveWs1MkTzK7mV6epV0RKoLTbs82p6/7puiLf5zXn/0N67VcHP85kAxldMp1Dn3JLVlWlN4YpkJjktD5324nsodzxsLw4Bl1Z27P1wXld6tJP5ovA5ULg5FOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rkUTTEh+; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724373545;
	bh=B8wjtzR5qk15ePHAWKkx67BEkSWotpF/j+NOFA0Mw6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=rkUTTEh+kDk22eiTdaTBxgSdeWBL42jhQzp0se1h1y9aM8MQeAy1SeiLEMLR2I9UC
	 coVJARIQ4bIx2clH6lPqaTprQplVlpW4WltJoLFQDqanpZ5WYcoa54iHR+cPlfC3RB
	 8ZM/XIcljqbhJPsb9qUdhlKHYJRIK8iVbhZMAP7TZkjWtoty3t6bQHEJNat8DLoGQc
	 zaW5UnCosAXhXuGLV3gtP4uSV2nLBBAXCaC8Ae6LMaXrgJd40KRvII2Dt7XknZxTwa
	 CYmwdM/2LQW4qBMiUxhMGVMYEjn1C2ckeUl6W+Ldhv+F1EtJ6K48A/gUzn3pQi6zC/
	 X385NgLI+UdQQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 3C03E740227;
	Fri, 23 Aug 2024 00:39:01 +0000 (UTC)
Message-ID: <1ba43657-2730-46eb-a6b9-8e316b35fa02@icloud.com>
Date: Fri, 23 Aug 2024 08:38:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
 <2024082315-capably-broiler-b4e6@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024082315-capably-broiler-b4e6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: akOgwyWebDOWsFbgyKp6U-MN65vhYBIz
X-Proofpoint-GUID: akOgwyWebDOWsFbgyKp6U-MN65vhYBIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_17,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=598
 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408230003

On 2024/8/23 08:14, Greg Kroah-Hartman wrote:
> On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> An uninitialized variable @data.have_async may be used as analyzed
>> by the following inline comments:
>>
>> static int __device_attach(struct device *dev, bool allow_async)
>> {
>> 	// if @allow_async is true.
>>
>> 	...
>> 	struct device_attach_data data = {
>> 		.dev = dev,
>> 		.check_async = allow_async,
>> 		.want_async = false,
>> 	};
>> 	// @data.have_async is not initialized.
> 
> As Dmitry said, this is incorrect, please fix your broken code analysis
> tool, it is obviously not working properly :(
> 

let us slow down firstly to confirm if what Dmitry said is right firstly.

it is not related to any analysis tool, i notice it by reading code.

> thanks,
> 
> greg k-h


