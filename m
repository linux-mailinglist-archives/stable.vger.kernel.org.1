Return-Path: <stable+bounces-88138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7B19AFFF1
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 12:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C5EB24C79
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA31DD891;
	Fri, 25 Oct 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=581238.xyz header.i=@581238.xyz header.b="YRJB3jHr"
X-Original-To: stable@vger.kernel.org
Received: from mail.581238.xyz (86-95-37-93.fixed.kpn.net [86.95.37.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868501D5ABF;
	Fri, 25 Oct 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=86.95.37.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851666; cv=none; b=uT9RNzvNB0FaCu8zgLtm4iLaH6qFLCmuS0bd8dTB/H1htDjC4JpCUJF5qvvvlGqHqZxjetdYbeCdg09Q1CLElZTboxbYd45hAxPzbVdkMYJAI4dbMLE7tscbQ6YFnQexuEibhjPWyvNjQsi/xc+Ld4PczZgddh+6fc748bbuFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851666; c=relaxed/simple;
	bh=JiqbygXWnN6LUJ8mzt5DMXjqBRj4lTk3dTMkJ4vdPBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=so324H6wgYD64BrAkDRJml6EfxK99eJrzlqzIFHYwkDCvkD2NX9kh5l2UCLoGqfRIoTJrENiFZfnD14X3X2YZVDEqwA+sXN2982y/GbklsQ4m/K98EkgW0uT75cNGwRtZ/jEpKFh2F72BA5ERHYVsdJ0gZnaEGPXrRo7PSEnSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=581238.xyz; spf=pass smtp.mailfrom=581238.xyz; dkim=pass (1024-bit key) header.d=581238.xyz header.i=@581238.xyz header.b=YRJB3jHr; arc=none smtp.client-ip=86.95.37.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=581238.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=581238.xyz
Received: from [192.168.1.244] (system.internal [192.168.1.244])
	by mail.581238.xyz (Postfix) with ESMTPSA id 744CE43088FB;
	Fri, 25 Oct 2024 12:20:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=581238.xyz; s=dkim;
	t=1729851655; bh=JiqbygXWnN6LUJ8mzt5DMXjqBRj4lTk3dTMkJ4vdPBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YRJB3jHrGvElpCRkBtdBpJZCQFqiANHCRHSU2xySSqlzQjVX+V2E+/5Cwx9XIYjQ4
	 KiSDiL1NWw1EgWNBRqAiDME/zHBx4CHUtzakhQJ+oqsA0CI2ovpx2dXPgIdsT8B3qt
	 o245xGyz0pbFkFczKrepFdUuCvWKiIuAD5PtPFDg=
Message-ID: <4848c9fe-877f-4d73-84d6-e2249bb49840@581238.xyz>
Date: Fri, 25 Oct 2024 12:20:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Sanath.S@amd.com,
 christian@heusel.eu, fabian@fstab.de, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <000f01db247b$d10e1520$732a3f60$@581238.xyz>
 <96560f8e-ab9f-4036-9b4d-6ff327de5382@amd.com>
 <22415e85-9397-42db-9030-43fc5f1c7b35@581238.xyz>
 <20241022161055.GE275077@black.fi.intel.com>
 <7f14476b-8084-4c43-81ec-e31ae3f7a3c6@581238.xyz>
 <20241023061001.GF275077@black.fi.intel.com>
Content-Language: en-US
From: Rick <rick@581238.xyz>
Autocrypt: addr=rick@581238.xyz; keydata=
 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
In-Reply-To: <20241023061001.GF275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mika

On 23-10-2024 08:10, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Oct 22, 2024 at 07:06:50PM +0200, Rick wrote:
>> Hi Mika,
>>
>> I have removed pcie_asm=force as kernel parameter but still not working on
>> latest non LTS kernel.
> 
> Okay, I still suggest not having that unless you absolutely know that
> you need it.
> 

Noted thank you!

>> In regards to the disconnect; sorry I think I might have turned of the
>> docking station myself during that test. I have taken another dmesg without
>> me disconnecting the docking station:
>> https://gist.github.com/ricklahaye/9798b7de573d0f29b3ada6a5d99b69f1
>>
>> The cable is the original Thunderbolt 4 cable that came with the docking
>> station. I have used it on this laptop using Windows (dualboot) without any
>> issues. Also on another Windows laptop also without issues. It was used in
>> 40Gbit mode.
> 
> In the dmesg you shared above, there are still unplug and USB tunnel
> creation fails so you only get USB 2.x connection with all the USB
> devices on the dock.
> 

Yes you are right. I removed all attached USB devices from the dock, but 
still see "3:3: USB3 tunnel activation failed, aborting"

> How do you determine if it "works"? I guess keyboard and mouse (both
> USB 2.x devices) and display (tunneled over USB4 link) all are working
> right? However, if you plug in USB 3.x device to the dock it enumerates
> as FullSpeed instead of SuperSpeed. There is definitely something wrong
> here. I asked from our TB validation folks if they have any experience
> with this dock but did not receive any reply yet.
> 
> What you mean by 40Gbit mode? The dock exposes two lanes both at 20G so
> it should always be 40G since we bind the lanes, also in Windows.

2 lanes of 20G indeed.

> 
> Also In Windows, do you see if the all USB devices on the dock are
> enumerated as FullSpeed or SuperSpeed? I suspect it's the former there
> too but can you check? Keyboard and mouse should be FullSpeed but there
> is some audio device that may be USB 3.x (SuperSpeed), or alternatively
> if you have USB 3.x memory stick (or any other device) you can plug that
> to the dock and see how it enumerates.

I checked on Windows with some 3.1 USB devices, and they were properly 
seen as 3.1 Superspeed+/10Gbps when attached to dock (using USBView from 
Windows SDK).

I also tried some Linux kernels, and it seems that 6.9 works, and 6.10 
doesn't.

6.9: https://gist.github.com/ricklahaye/da8c63edb0c27dc55bef351f9f4dd035
6.10: https://gist.github.com/ricklahaye/c2f314f74ecadcc4a2bd358d5d07e97b

Thank you for the help you have provided.

Kind regards,
Rick Lahaye

