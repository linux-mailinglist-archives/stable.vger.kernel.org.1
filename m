Return-Path: <stable+bounces-161424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A6FAFE69C
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C66E04FA
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C7F22B595;
	Wed,  9 Jul 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="JUcMmPbp"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C039461
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058410; cv=none; b=D+j20UsWz32OfU9owYunHM30BU2FNKvGrEKpHQb6kUIz84I+x8D8kYCQ0aXJ/CBNNxBQaD9rqWA14Gxyu1NTfrrhhcnjyCiTimBxPqdUcKNbvZTd6PsxrifwveRM+gQydhC/j+SYBlKaBzMyf+XlgVfLrz6UyvQGI/It1W0x174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058410; c=relaxed/simple;
	bh=z1NonGCwFNHSslLRrC3a77FwRB114PAvIGd97MFBOQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdxuV+FOZbfz2Phdsfoeaw7R/VgDjTN7lmietRdbcqtR8EswotEuD1iZGn1MxBx/bI6DOITUg/8wANjmi4dhAy/yWCS15YszVX/pju7JA9ZyQ9hTTfmFPTtJu3PCGhmxNCZvphguSuyvBiqwk78fJsplrhSVk+pLqR2r3G+Ss48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=JUcMmPbp; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id ZNqlue0kaMETlZSQZuhlfv; Wed, 09 Jul 2025 10:53:27 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ZSQYu7tlE6FUDZSQYuXLle; Wed, 09 Jul 2025 10:53:26 +0000
X-Authority-Analysis: v=2.4 cv=UsdlNfwB c=1 sm=1 tr=0 ts=686e4a27
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=NEAV23lmAAAA:8
 a=badPxlQgyaJOncwre8UA:9 a=QEXdDO2ut3YA:10 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tlr6v9PxHau51PRgCsTb4NzXUuuNhIcSwEVy4gSiwhk=; b=JUcMmPbpeUXVMVmNKpOaISfIVB
	iLUHBVsvOHyepsYpCj+O3b1SHTedCgjHXabden2N2KRLOm0qaHYGarRxRtwtcPDMl/0uY8EpnFfk2
	vrguUrCWjRyxsKL/qkqoiEIhH7g/p4GY74D31ck4XTjVrLbgfb0avHtE+IsVs/kXeQx9tHRWTMdz0
	BYrDptRHvDOUYzPzK4cNcOQmotPgIqLwhdiWK1yTmH68XzkJL+hdDPk5/0MQIW/Coqt9T1vD4rISu
	+DSSSgs/HaC4JNlJLjBZtSgAQoch2pXtc/KEbo5HiorzdT6FUHm1ivzOeDN9ZzqxIUOu3pyCdnByZ
	s2f7OLeg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:49570 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uZSQX-00000003qOF-0XsK;
	Wed, 09 Jul 2025 04:53:25 -0600
Message-ID: <081ac1f2-2d47-4029-a2a3-f3a975083785@w6rz.net>
Date: Wed, 9 Jul 2025 03:53:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 129/139] scripts: clean up IA-64 code
To: Greg KH <gregkh@linuxfoundation.org>, WangYuli <wangyuli@uniontech.com>
Cc: chuck.lever@oracle.com, masahiroy@kernel.org, nicolas@fjasle.eu,
 patches@lists.linux.dev, stable@vger.kernel.org, dcavalca@meta.com,
 jtornosm@redhat.com, guanwentao@uniontech.com
References: <20250703143946.229154383@linuxfoundation.org>
 <E845ABA28076FEFB+20250708032644.1000734-1-wangyuli@uniontech.com>
 <2025070857-junkman-tablet-6a45@gregkh>
 <572685AD12256749+e24050a6-dde6-4447-8b45-69578b352e5f@uniontech.com>
 <2025070914-hankering-saucy-ec33@gregkh>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <2025070914-hankering-saucy-ec33@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1uZSQX-00000003qOF-0XsK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:49570
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC7bcfv6lHVKx6uPD+4/hQZMlzvma1TX70aSYpDdaouj7RGb/RjmniVzHC2robVv2NqSZtL6d0XWUDbhq3Gh8iAZjkLaIKm5hh2bZKPE8eFkuasaHpQ0
 WZF6NatRg+fV6OIBZY+WjndxjjE6aWrzgFhpMtjF1k8jz6rp623Orxdx8N7a9gqeZU1RIbb4Skgz/A==

On 7/9/25 01:47, Greg KH wrote:
> On Tue, Jul 08, 2025 at 03:45:16PM +0800, WangYuli wrote:
>> Hi greg k-h,
>>
>> On 2025/7/8 15:20, Greg KH wrote:
>>> Is ia-64 actually being used in the 6.6.y tree by anyone?  Who still has
>>> that hardware that is keeping that arch alive for older kernels but not
>>> newer ones?
>>>
>> I'm afraid I don't quite follow your point.
>>
>> In v6.7-rc1, we introduced the commit to remove the IA-64 architecture code.
>>
>> This means linux-6.6.y is the last kernel version that natively supports
>> IA-64, and it also happens to be the currently active LTS release.
> 6.12.y is the "currently active LTS release", along with 6.6.y and older
> ones.  So are all ia64 users sticking with 6.6.y only?
>
>> In any case, I'm quite confused by the current situation because we've
>> essentially broken IA-64 build support in this kernel version.
> Sorry, I didn't realize this, it came in for a different patch that
> fixed a different issue as the thread shows.
>
>> If you genuinely believe that no one is using IA-64 devices with
>> linux-6.6.y, then it might be best to directly backport commit cf8e865
>> ("arch: Remove Itanium (IA-64) architecture") to completely remove IA-64.
>>
>> This would avoid any misunderstanding.
>>
>> Otherwise, someone in the future will inevitably assume linux-6.6.y still
>> supports IA-64, when in reality, it's no longer functional.
> Who assumes this?  Again, who is still using/maintaining this arch for
> 6.6.y anymore?
>
> I'm all for reverting this, but would like to see some reports of real
> users first :)
>
> thanks,
>
> greg k-h

I think IA-64 is maintained by Frank Scheiner <frank.scheiner@web.de>. 
There's repos for stable and mainline.

https://github.com/linux-ia64/linux-stable-rc

https://github.com/johnny-mnemonic/linux-ia64



