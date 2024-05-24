Return-Path: <stable+bounces-46108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537418CEAF0
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 22:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB95281AF8
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580980031;
	Fri, 24 May 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="JR/0IOgD"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8882D66
	for <stable@vger.kernel.org>; Fri, 24 May 2024 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583149; cv=none; b=gsnGOnYAPZVQhUfZmqlnHXvDcAgXBatYZR9/uTm3tch2CZMHgzpnF65jZwTQ0fqLLq1w4oM+VlUgKUsehIOodFPFBSpUVLlcYlr0bV6jWFFOC1vk2KvdZde8DxJi9z7lD6vwJtx8kGQctbkVdejZwbWQOuw2MaUhsesUzPX90aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583149; c=relaxed/simple;
	bh=LoWM0TVymoHJriq6KJbuI3hatNBoiVI1Hv84Bj3Qfbo=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=Ux20UH27G33JyOK87FKFKeuZuM1uRySlSVOnNsUMkDFp/g6q7fnG9sbshIs+crXmwccX9UcjF8TVeoHMMS9Pebpu+9SF3c1hV0I7i1ABkvC1M3TtPRUWX3ZpPJIUxLL2Ca7UmDyEhChjcl7OdCapuUoFqFmVErgB4YCSNNtWEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=JR/0IOgD; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id 9pBgsbyKcxs4FAbgvsKHFu; Fri, 24 May 2024 20:39:05 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id AbgusmZYssrbKAbgus7jJY; Fri, 24 May 2024 20:39:04 +0000
X-Authority-Analysis: v=2.4 cv=EpDUrzcA c=1 sm=1 tr=0 ts=6650fae8
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=BXyYjBD0cXuZo9oD7aYA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AfmSTF6K3ePH28mH9PRgkAE7ar31QEyzCQWuA2HmR74=; b=JR/0IOgD1ulBHucjtrFUg/gug1
	NW39lml/9HWUGEo72+oXNTzlFjYt4JHyOrBThclN8vTX4xbQ26xfvICUQXangpReAz8jccgFl+1gO
	SgxRq7of/EtmCKEMq4xyZfyAp5Qd6CbwE3ceGHA6i+P5Lxmr80rqfdokaQhNQBlVUM0/k56tw7oUP
	qTLBn6sMxAHSsaZX38H/T8kmXTq/MNy9oGiaXqbo6ohMWrpmN26PQ/No+oznljt9g9O8EiEXTR57V
	dOyr32wzZQdxjlwCOwwlH+uiAQxm6IQesQVl5TrtvGgaTyI1yaN5/r9QOBNpL+ll3izipNj3VS9BU
	4u9UGc2w==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:39798 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sAbgs-0035AK-1m;
	Fri, 24 May 2024 14:39:02 -0600
Subject: Re: [PATCH 6.1 00/45] 6.1.92-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130332.496202557@linuxfoundation.org>
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <e530eccd-5da9-5eeb-9290-c83360b88d6d@w6rz.net>
Date: Fri, 24 May 2024 13:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1sAbgs-0035AK-1m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:39798
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBMVKSgEVSyPFkNS+CF9hdv610UeubPZsl3bm3OR8+kXGrjI8Gru8zlXpRn6jANtCQLlxVBociZkmU8549Geq6QdbdRYJzpFsBjQ7Q278lS+jcGlrN+L
 8htEgKr+E6uNTj6c+ViXGDmraKxPC2wU/6xFMbSCxkBHoHeh/huup8tlvUwwQqMci6/EWmDmZqZ+aw==

On 5/23/24 6:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.92 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.92-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


