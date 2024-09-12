Return-Path: <stable+bounces-75923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8544A975EB9
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 04:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B847C1C22A79
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 02:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3DE524D7;
	Thu, 12 Sep 2024 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XLT02dwg"
X-Original-To: stable@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04B24211
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726106728; cv=none; b=l6jzXUPnPfr/QaYXlPgVo5MOnxzqjV5BUhcE/yceu6ac328MMObVZ76uxUeghC6Vs0Iqm9yHA8xp+m4pekwdrtYWN0Gaj1fV/YgmFn/qptGYdgqcXZtOKSd1TDcQoo0vBbKuEVbwTsQWaiPZs8WFwZFi5blJEyFdI4+Nw0b1DIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726106728; c=relaxed/simple;
	bh=0pmeX/z+j72cb4J3z4ZaQtSuqC+IOGeYo6guIbU3biM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXpeUUTAzr5jHByiYabKmmKVXakDDIK8bwPlIcDjtm0fEPS6FdYbrW51jcc6097cwsR/zzZTCGGhGfUvUWi5OKFdy2U45nGYj/GHF3Fufwrdc8Fx8HqtIydVCxjUoRADDLrXDlD14k+bn6X8HEfTwmufPVvU8duuypgpnmqxE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XLT02dwg; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726106668;
	bh=byMjieFugiNxx5KlyLidvQZLqis0xkRYRocj1tfwfUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XLT02dwgGqHNswiYYSw90lQWbD2u7dYPk7fnV40HnoUdI8NdbW8+E/j/B1Lag1c6C
	 CkrsAeUwwWZUBN5GQmtCNkXXvzWVF5vMr3Yn9MIMZRE2bp86b2gie6Lgsrv+p8i84P
	 Qq4hdqoHI+yWdFcwed88EFs5+cfla43XzdW36fKM=
X-QQ-mid: bizesmtpsz11t1726106657tzfafq
X-QQ-Originating-IP: nhMhboSuofqrzBgdCknn7xPJ/FCvu0e5qZ48sRJpnSc=
Received: from [10.4.11.213] ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 10:04:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2093590711908520985
Message-ID: <3C99CA59CA6C0CAE+e5693100-b4f1-428f-a26c-56c54fa600a3@uniontech.com>
Date: Thu, 12 Sep 2024 10:04:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 2/2] iio: adc: ad7124: fix DT configuration parsing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <2024090914-province-underdone-1eea@gregkh>
 <20240910090757.649865-1-helugang@uniontech.com>
 <0ACF46DADA3C2900+20240910090757.649865-2-helugang@uniontech.com>
 <2024091053-boundless-blob-20bd@gregkh>
 <0D03D3D118FBAF5F+abf1276e-4c7d-4c9a-8d6f-278b69022680@uniontech.com>
 <2024091052-reach-proclaim-b8ae@gregkh>
From: HeLuang <helugang@uniontech.com>
In-Reply-To: <2024091052-reach-proclaim-b8ae@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0



在 2024/9/10 18:06, Greg KH 写道:
> On Tue, Sep 10, 2024 at 05:43:21PM +0800, HeLuang wrote:
>>
>>
>> 在 2024/9/10 17:23, Greg KH 写道:
>>> On Tue, Sep 10, 2024 at 05:07:57PM +0800, He Lugang wrote:
>>>> From: Dumitru Ceclan <mitrutzceclan@gmail.com>
>>>>
>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>
>>> Why is this 2 different addresses?
>>>
>>> And why was this sent twice?
>>>
>>> confused,
>>>
>>> greg k-h
>>>
>>
>> Hi,greg
>>
>> About the two email addresses because the email address mismatch message
>> from the checkpatch.pl,so I just and the signed-off-by one,should we just
>> ignore it?
> 
> Please use what is in the upstream commit.
> 
>> Also pls just pass over the first patch mail because of lack of dependency.
> 
> Please tell us what is going on, otherwise we get confused.
Actually
61cbfb5368dd ("iio: adc: ad7124: fix DT configuration parsing")
depends on
a6eaf02b8274 ("iio: adc: ad7124: Switch from of specific to fwnode based 
property handling")
so just need to cherry-pick them together!
> 
> Please fix this up and resend a new series that we can take.
OK.
> 
> thanks,
> 
> greg k-h
> 

