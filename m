Return-Path: <stable+bounces-166817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E47B8B1E150
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 06:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 118B74E10BC
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 04:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A4E1B413D;
	Fri,  8 Aug 2025 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plan9.rocks header.i=@plan9.rocks header.b="LS7YUvi6"
X-Original-To: stable@vger.kernel.org
Received: from plan9.rocks (vmi607075.contaboserver.net [207.244.235.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2A290F
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.244.235.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754628043; cv=none; b=oyDwUHKWJeyYJD8VEGnEPzKUdufu1/ltGpWygB11TyXxxHfAoIGzRwXSixr88D7BBCv9uRgMw/HUrLwzE6ZqSGZ5SRFyROlu53jAcYmgfCrLfg0i5kSV6xcnGTlzl6H7YlSjIzKxz9yMoiDCVD90shtE8Dlvi+J6pEEToSYwSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754628043; c=relaxed/simple;
	bh=ttHgjjFD+AMF9OawyiURTxPghu7g998cqV0vh4AYg1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=GUbCkmTp1FhsgY6ns01z971MGTWmcuaDsvPiS+pYe9yM3qG5pM3gai3Vf0IqGQyJ7b5AxYwgu89u9jllLmGjZUIc9VAW+iy0JA/Z5TAiXYPu2+thNBfVaocegn1ouRhRDCYY4yz3QWmYL0kSstMVtySWdjoGTtnYnSgpTjPk45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plan9.rocks; spf=pass smtp.mailfrom=plan9.rocks; dkim=pass (2048-bit key) header.d=plan9.rocks header.i=@plan9.rocks header.b=LS7YUvi6; arc=none smtp.client-ip=207.244.235.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plan9.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plan9.rocks
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=plan9.rocks; s=mail;
	t=1754628040; bh=ttHgjjFD+AMF9OawyiURTxPghu7g998cqV0vh4AYg1Q=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=LS7YUvi6YhT5s4x3PfNTbGbxBoRc9nLXL+uLg4YEibihojbT9FgfZZqhfSv89lpFM
	 klWgMKqBaF1tfM4AjtFyEE6K0Q+oTKR4hwN+A1G8fC690pw8Dmh+TfdOXVIHu9E6aw
	 +hEeIu/nDvs6CwfmNwJ+HZz3DqcqdzkBCwufKEnj3qT0eP1Y8msDqsgnkIp6m/U/Jn
	 S8hyj4oOmOIw8Hf+93tJl53jJrWiPAPUTByHh7VnGjOMoubvZrrg7uLB2Fw0AGZUmU
	 Izh338e3iyndO7W8ZS2AI/iXK2oxq0tfSqHdDHVtJ8JnCIp6/W8xmwpzBlsb3xxoLm
	 i1LS6Fq9kCv8Q==
Received: from [192.168.58.180] (syn-035-139-136-005.res.spectrum.com [35.139.136.5])
	by plan9.rocks (Postfix) with ESMTPSA id 0026D1200865;
	Thu,  7 Aug 2025 23:40:39 -0500 (CDT)
Message-ID: <b30b2f11-0245-4d73-b589-f3a5574ddd00@plan9.rocks>
Date: Fri, 8 Aug 2025 04:40:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] vfio gpu passthrough stopped working
To: Greg KH <gregkh@linuxfoundation.org>
References: <718C209F-22BD-4AF3-9B6F-E87E98B5239E@plan9.rocks>
 <2025080724-sage-subplot-3d0f@gregkh>
Content-Language: en-US
Cc: regressions@lists.linux.dev, stable@vger.kernel.org
From: cat <cat@plan9.rocks>
In-Reply-To: <2025080724-sage-subplot-3d0f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I will perform bisection, yes.

On 8/7/25 3:52 PM, Greg KH wrote:
> On Thu, Aug 07, 2025 at 03:31:17PM +0000, cat wrote:
>> #regzbot introduced: v6.12.34..v6.12.35
>>
>> After upgrade to kernel 6.12.35, vfio passthrough for my GPU has stopped working within a windows VM, it sees device in device manager but reports that it did not start correctly. I compared lspci logs in the vm before and after upgrade to 6.12.35, and here are the changes I noticed:
>>
>> - the reported link speed for the passthrough GPU has changed from 2.5 to 16GT/s
>> - the passthrough GPU has lost it's 'BusMaster' and MSI enable flags
>> - latency measurement feature appeared
>>
>> These entries also began appearing within the vm in dmesg when host kernel is 6.12.35 or above:
>>
>> [    1.963177] nouveau 0000:01:00.0: sec2(gsp): mbox 1c503000 00000001
>> [    1.963296] nouveau 0000:01:00.0: sec2(gsp):booter-load: boot failed: -5
>> ...
>> [    1.964580] nouveau 0000:01:00.0: gsp: init failed, -5
>> [    1.964641] nouveau 0000:01:00.0: init failed with -5
>> [    1.964681] nouveau: drm:00000000:00000080: init failed with -5
>> [    1.964721] nouveau 0000:01:00.0: drm: Device allocation failed: -5
>> [    1.966318] nouveau 0000:01:00.0: probe with driver nouveau failed with error -5
>>
>>
>> 6.12.34 worked fine, and latest 6.12 LTS does not work either. I am using intel CPU and nvidia GPU (for passthrough, and as my GPU on linux system).
> Can you use git bisect to find the offending commit?
>
>

