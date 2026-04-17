Return-Path: <stable+bounces-238502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAeeNQNV4mnx4QAAu9opvQ
	(envelope-from <stable+bounces-238502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:42:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD0541CBF1
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72A8E309E80B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843933FE12;
	Fri, 17 Apr 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ehuk.net header.i=@ehuk.net header.b="H5DN4j02"
X-Original-To: stable@vger.kernel.org
Received: from james.steelbluetech.co.uk (james.steelbluetech.co.uk [78.40.151.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16433DEDD;
	Fri, 17 Apr 2026 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.151.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440090; cv=none; b=DtyJKfNn/gTov4HG0ghFd2td5sGGYn04JKj7XtC3lOlS7pQODXBoueFcu10JNYoUnyYZOAEstFYdXmnph/IT7AHh29TkbDC9kPHLmjXsLAPHRUTPTyGCkd7OFet5GPnOmB/axWBkcoShzoeTUFOgw0+R0Th0JPCHZDfMkHbEXQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440090; c=relaxed/simple;
	bh=UvEnnGVnAl6uzFHCVhtpZ0w7r047UYq5JM45UNESAM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/1tBdjcThmOEgzsLX41EVmte+qBT0fRNMDL8/c6bbNr10tLEFQEP/Ov5z1Oc64ibfzoCT/ZPLCeyzlLLjptrXNYUdDQmQJe7E8RuERYgdlr7FgdpTndrVK5m7BghGMH07rnw8BkvZyvCJOV6WTMvKOBWD/iompdeiuay3lcS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ehuk.net; spf=pass smtp.mailfrom=ehuk.net; dkim=pass (2048-bit key) header.d=ehuk.net header.i=@ehuk.net header.b=H5DN4j02; arc=none smtp.client-ip=78.40.151.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ehuk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ehuk.net
Received: from [10.0.5.25] (tv.ehuk.net [10.0.5.25])
	by james.steelbluetech.co.uk (Postfix) with ESMTP id 0EEB2BFC14;
	Fri, 17 Apr 2026 16:34:46 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 james.steelbluetech.co.uk 0EEB2BFC14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ehuk.net; s=default;
	t=1776440086; bh=W1yDXO8OMwNHOA1eKZOCKDrQbH41rIyMbiA1zfcPux4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H5DN4j02PS36Jp56c+2A/LIaUCjMqTrttcgDAuW8cn346tHwkL8CwO66m/FaAdlQY
	 GKuCIOqGfnCQ0X5+dfsp0r+RjP9nk1Uq2ZXEOcrE1IUK/IJ9VUJVGbRTYTxELpFKpe
	 JfaUKNg5behgL8NTPuAp7/NKtp0A5FtxF7umCbBuCOklIa2sGNelymjGv7buBbsdjt
	 SpOg2gNk8zlamWKFPLIHm1YtWm90XW2/VMHKbUqGIKpKWNuGUI2mxySf1cYFSP07hu
	 ymmlObvtq8sQv8M4HRHo7t+eT/5N7CQ0GGxtQWjVjznb9CoIxkUyg2fxZ1U1d+/O4Z
	 4srBlNWXRZgsA==
Message-ID: <2b619b76-2b73-4787-84c5-78f52dc316a2@ehuk.net>
Date: Fri, 17 Apr 2026 16:34:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155728.181580293@linuxfoundation.org>
 <172f1405-0094-4957-9758-e700ec76516f@ehuk.net>
 <2026041742-armrest-clicker-84fd@gregkh>
Content-Language: en-GB
From: Eddie Chapman <eddie@ehuk.net>
In-Reply-To: <2026041742-armrest-clicker-84fd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ehuk.net,none];
	R_DKIM_ALLOW(-0.20)[ehuk.net:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238502-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddie@ehuk.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ehuk.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ehuk.net:dkim,ehuk.net:mid]
X-Rspamd-Queue-Id: 4BD0541CBF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17/04/2026 07:25, Greg Kroah-Hartman wrote:
> On Thu, Apr 16, 2026 at 07:55:19PM +0100, Eddie Chapman wrote:
>> On 13/04/2026 16:59, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.12.82 release.
>>> There are 70 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.82-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>> I just wanted to point out that the revert of "PCI: Enable ACS after
>> configuring IOMMU for OF platforms" is missing here despite being queued in
>> the 6.1 & 6.6 rcs (it is meant to be reverted from 6.12 as well). I noticed
>> when updating to 6.12.82-rc1 today as I was bit by the regression (all my
>> IOMMU groups messed up).
>>
>> The revert for 6.12 is in fact here:
>> https://lore.kernel.org/stable/20260320172335.29778-1-john@kernel.doghat.io/
>>
>> but unfortunately easily missed as shown by the confusion here (same
>> thread):
>> https://lore.kernel.org/stable/99426bd8-32e5-4246-9d3b-772e136bc078@leemhuis.info/
>>
>> subsequently clarified by the patch author here (also same thread):
>> https://lore.kernel.org/stable/5hng5r6q525scbclramuv2h2hphljbcsscwohvrs7teuedgfvl@ncr7tqhr4l4z/
>>
>> Other than that 6.12.82-rc1 boots and runs fine for me on the one AMD Ryzen
>> system I've tried it on.
> 
> That was not obvious at all, please don't make us dig through email
> threads to know what to and not to apply, it doesn't scale when dealing
> with the email volume we get.
> 
> Can someone resend that patch, properly marked fro 6.12, so we know to
> apply it there?
> 
> thanks,
> 
> greg k-h
> 

Adding Manivannan Sadhasivam who is the author of the revert that is in 
the 5.10, 5.15, 6.1 and 6.6 queues right now.

Manivannan, not sure if you are able to provide an updated patch for 
6.12 where the revert is missing right now?

FWIW I applied the patch at
https://lore.kernel.org/stable/20260320172335.29778-1-john@kernel.doghat.io/
on top of 6.12.82-rc1 today and booted on an AMD system to test. It has 
context issues but still applies fine, and I can confirm that my IOMMU 
groups are no longer messed up. As a result have been able to pass 
through 2 separate PCI cards to 2 separate VMs which I am unable to do 
without the revert.

