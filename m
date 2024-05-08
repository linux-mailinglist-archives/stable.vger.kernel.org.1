Return-Path: <stable+bounces-43457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74B8BFDAC
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 14:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE241F223C0
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EBA56B70;
	Wed,  8 May 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="BkR85RNs"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A422071;
	Wed,  8 May 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172678; cv=none; b=PSSsROc2rLG/kmtiFt5FMRaA1L64bNqEGTOgPHrPrALJUhjVKPqnlG5AKZvWKDPbK3SZyfZn9SWyIUzi7SUyT64uMdcsI4IXCvyeMoq3HUTuu5ad7q7ZDhi0d8SGbM1coapZfVeyHN0CcPVSmRYSxLsL9lV3OnvOmxBD5OVeTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172678; c=relaxed/simple;
	bh=zjLlvB+WbJijsa7Xq2sGoO7LgZnL7gRVI2UA3wsYzcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geN/5VNbdH8GTK1diKdVxyoZZgNg5vvSEWXIsjkTzSpn9n9rtlGjkRCazZmEAgm+mJNNtaoEXKTBFH0anbIvmk6LBlIW8T0RxozZZg6pTnreZ2rBk7dXufm17g7HSGpjbAsDrvrVHlhwdMxhUDWfJKZY9YikbOf2nnz9PDXvnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=BkR85RNs; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=zjLlvB+WbJijsa7Xq2sGoO7LgZnL7gRVI2UA3wsYzcY=;
	t=1715172676; x=1715604676; b=BkR85RNsJiheEHp4jencaeLhwFiknHBpEcEwEG6g/9FugG1
	DHRX6V5j0wmaijOjWzC2ylJr2jo3MNzJFKHDX4J77455GieigLGDxVDTQGDv3ayDtAQXbHJH7VjbQ
	jLz8UmQAx8QK0Sh6UazeUdKOhdl8G7Hm66WrbI2w8K72EJtzFvPbSkkY84mYInFQypdnwo0ACDuM6
	uiQFt6Shmx+Dtfz7bNW+dVbSNMMCPrZUpFNda8xdf/NYPNQJmgdIXzLU8rs3RReKYrCv6Lf96rMxg
	zyy/9Ls6Ni7lJ0DmC/mXqFHBtsZV3vUD7nJO4S074nOYe3/zw+cCRCWBTMgU1y8w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s4glL-0003Db-Ck; Wed, 08 May 2024 14:51:11 +0200
Message-ID: <7e3fdac4-e0bc-42f4-9bb3-a6b16f323491@leemhuis.info>
Date: Wed, 8 May 2024 14:51:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.9.0: WARNING: workqueue: WQ_MEM_RECLAIM
 ttm:ttm_bo_delayed_delete [ttm] is flushing !WQ_MEM_RECLAIM
 events:qxl_gc_work [qxl]
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc: airlied@gmail.com, airlied@redhat.com, daniel@ffwll.ch,
 dreaming.about.electric.sheep@gmail.com, dri-devel@lists.freedesktop.org,
 kraxel@redhat.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 spice-devel@lists.freedesktop.org, tzimmermann@suse.de,
 virtualization@lists.linux.dev, Anders Blomdell <anders.blomdell@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 David Wang <00107082@163.com>
References: <20240430061337.764633-1-00107082@163.com>
 <20240506143003.4855-1-00107082@163.com>
 <ac41c761-27c9-48c3-bd80-d94d4db291e8@leemhuis.info>
 <b57f8ede-5de6-4d3d-96a0-d2fdc6c31174@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <b57f8ede-5de6-4d3d-96a0-d2fdc6c31174@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715172676;62cce3d8;
X-HE-SMSGID: 1s4glL-0003Db-Ck

On 08.05.24 14:35, Anders Blomdell wrote:
> On 2024-05-07 07:04, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 06.05.24 16:30, David Wang wrote:
>>>> On 30.04.24 08:13, David Wang wrote:
>>
>>>> And confirmed that the warning is caused by
>>>> 07ed11afb68d94eadd4ffc082b97c2331307c5ea and reverting it can fix.
>>>
>>> The kernel warning still shows up in 6.9.0-rc7.
>>> (I think 4 high load processes on a 2-Core VM could easily trigger
>>> the kernel warning.)
>>
>> Thx for the report. Linus just reverted the commit 07ed11afb68 you
>> mentioned in your initial mail (I put that quote in again, see above):
>>
>> 3628e0383dd349 ("Reapply "drm/qxl: simplify qxl_fence_wait"")
>> https://git.kernel.org/torvalds/c/3628e0383dd349f02f882e612ab6184e4bb3dc10
>>
>> So this hopefully should be history now.
>>
> Since this affects the 6.8 series (6.8.7 and onwards), I made a CC to
> stable@vger.kernel.org

Ohh, good idea, I thought Linus had added a stable tag, but that is not
the case. Adding Greg as well and making things explicit:

@Greg: you might want to add 3628e0383dd349 ("Reapply "drm/qxl: simplify
qxl_fence_wait"") to all branches that received 07ed11afb68d94 ("Revert
"drm/qxl: simplify qxl_fence_wait"") (which afaics went into v6.8.7,
v6.6.28, v6.1.87, and v5.15.156).

Ciao, Thorsten

