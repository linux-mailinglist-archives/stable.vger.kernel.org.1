Return-Path: <stable+bounces-89487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3B9B9167
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 13:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6951C22168
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DCE19E826;
	Fri,  1 Nov 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=581238.xyz header.i=@581238.xyz header.b="PzTAuhGO"
X-Original-To: stable@vger.kernel.org
Received: from mail.581238.xyz (86-95-37-93.fixed.kpn.net [86.95.37.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E047199E94;
	Fri,  1 Nov 2024 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=86.95.37.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465881; cv=none; b=YY5lXjGPli3Lg2HqTISY/KJ8zuOeWXtfHHqaTw49J2qQWm/OxtuEmwcpSGTPF2IevGYhBEglso41DVWy9YPj+AqKPRf7ue4VA2VYMDnMsTzYHebmUq6YjO1KYrUjZBuQpvMZUDXMF1PVM3BOiDY5syMrdfKPbFbi5gyw4NC3gwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465881; c=relaxed/simple;
	bh=KBjul5dBKmoLwCgHLQaI1cm4qq+XwuikpG7g/7aug30=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SVx8P7tJrvcTpqtYK78LnWvELJFW3VLUZAvdNHJZHJ3+zULkDwbfBSEBCr1qnK/bs0qg7OArx/SdNV90ENAZvaRgRsht4KVUjkGiPQqfz/oq2ZpjU37PA9/l/NSzVBK/WohRKwz8LAJ74xN+dODxS5UwpWUBTpe+VoHrC0WnG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=581238.xyz; spf=pass smtp.mailfrom=581238.xyz; dkim=pass (1024-bit key) header.d=581238.xyz header.i=@581238.xyz header.b=PzTAuhGO; arc=none smtp.client-ip=86.95.37.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=581238.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=581238.xyz
Received: from [192.168.1.14] (Laptop.internal [192.168.1.14])
	by mail.581238.xyz (Postfix) with ESMTPSA id E6F1B43088F3;
	Fri, 01 Nov 2024 13:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=581238.xyz; s=dkim;
	t=1730465870; bh=KBjul5dBKmoLwCgHLQaI1cm4qq+XwuikpG7g/7aug30=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=PzTAuhGOTUgNrmVo33mzOXEv27OjO4Fto9x3U/VWXcV527YGnBy2Wt0b8eT9dRWSO
	 b+A6bTNEV18LCQBwu9WTruBC5cgwGC4g5VggoP1WEgIDDz/vqezyMTrikuMptz/XqW
	 mI1hplKLnUygx1Joth16r3z9fSuZdMvMG/VS697s=
Message-ID: <70d8b6b2-04b4-48a6-964d-a957b2766617@581238.xyz>
Date: Fri, 1 Nov 2024 13:57:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rick <rick@581238.xyz>
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
 <4848c9fe-877f-4d73-84d6-e2249bb49840@581238.xyz>
 <20241028081813.GN275077@black.fi.intel.com>
 <2c27683e-aca8-48d0-9c63-f0771c6a7107@581238.xyz>
 <20241030090625.GS275077@black.fi.intel.com>
Content-Language: en-US
Autocrypt: addr=rick@581238.xyz; keydata=
 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
In-Reply-To: <20241030090625.GS275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mika

On 30-10-2024 10:06, Mika Westerberg wrote:
>> tbtrace on 6.11.5:
>> https://gist.github.com/ricklahaye/69776e9c39fd30a80e2adb6156bdb42d
>> dmesg on 6.11.5:
>> https://gist.github.com/ricklahaye/8588450725695a0bd45799d3d66c7aff
> 
> Thanks! I suspect there is something we do when we read the sideband
> that makes the device router to "timeout" and retry the link
> establishment. There is also the failure when USB 3.x tunnel is created
> but we can look that after we figure out the connection issue.
> 
> Looking at the trace we are still polling for retimers when we see the
> unplug:
> 
> [   48.684078] tb_tx Read Request Domain 0 Route 0 Adapter 3 / Lane
>                 0x00/---- 0x00000000 0b00000000 00000000 00000000 00000000
> .... Route String High
>                 0x01/---- 0x00000000 0b00000000 00000000 00000000 00000000
> .... Route String Low
>                 0x02/---- 0x02182091 0b00000010 00011000 00100000 10010001
> ....
>                   [00:12]       0x91 Address
>                   [13:18]        0x1 Read Size
>                   [19:24]        0x3 Adapter Num
>                   [25:26]        0x1 Configuration Space (CS) → Adapter
> Configuration Space
>                   [27:28]        0x0 Sequence Number (SN)
> [   48.684339] tb_rx Read Response Domain 0 Route 0 Adapter 3 / Lane
>                 0x00/---- 0x80000000 0b10000000 00000000 00000000 00000000
> .... Route String High
>                 0x01/---- 0x00000000 0b00000000 00000000 00000000 00000000
> .... Route String Low
>                 0x02/---- 0x02182091 0b00000010 00011000 00100000 10010001
> ....
>                   [00:12]       0x91 Address
>                   [13:18]        0x1 Read Size
>                   [19:24]        0x3 Adapter Num
>                   [25:26]        0x1 Configuration Space (CS) → Adapter
> Configuration Space
>                   [27:28]        0x0 Sequence Number (SN)
>                 0x03/0091 0x81320408 0b10000001 00110010 00000100 00001000
> .2.. PORT_CS_1
>                   [00:07]        0x8 Address
>                   [08:15]        0x4 Length
>                   [16:18]        0x2 Target
>                   [20:23]        0x3 Re-timer Index
>                   [24:24]        0x1 WnR
>                   [25:25]        0x0 No Response (NR)
>                   [26:26]        0x0 Result Code (RC)
>                   [31:31]        0x1 Pending (PND)
> [   48.691410] tb_event Hot Plug Event Packet Domain 0 Route 0 Adapter 3 /
> Lane
>                 0x00/---- 0x80000000 0b10000000 00000000 00000000 00000000
> .... Route String High
>                 0x01/---- 0x00000000 0b00000000 00000000 00000000 00000000
> .... Route String Low
>                 0x02/---- 0x80000003 0b10000000 00000000 00000000 00000011
> ....
>                   [00:05]        0x3 Adapter Num
>                   [31:31]        0x1 UPG
> [   48.691414] thunderbolt 0000:00:0d.2: acking hot unplug event on 0:3
> 
> Taking this into account and also the fact that your previous email you
> say that v6.9 works and v6.10 does not, I wonder if you could first try
> just to revert:
> 
>    c6ca1ac9f472 ("thunderbolt: Increase sideband access polling delay")

I compiled 6.12.0-rc5-00181-g6c52d4da1c74-dirty resulting in docking 
station not working.

Then I compiled 6.12.0-rc5-00181-g6c52d4da1c74-dirty without commit 
c6ca1ac9f472 (reverted), and now the docking station works correctly (as 
in screen output + USBs + Ethernet)

So it seems c6ca1ac9f472 is causing issues for my setup.

> 
> and see if that helps with the connection issue? If it does then can you
> take full dmesg and the trace again and with me so I can look at the USB
> tunnel issue too?

Below files are generated with commit c6ca1ac9f472 reverted!

Tbtrace: https://gist.github.com/ricklahaye/05e54f12c974d3ed3e15527af7f67ed2
Dmesg: https://gist.github.com/ricklahaye/f50ad55159dec2b5265dd20bcebe4a10

Thank you,
Kind regards,
Rick Lahaye


