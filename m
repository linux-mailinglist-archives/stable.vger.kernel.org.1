Return-Path: <stable+bounces-152321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31959AD41F0
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 20:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6119179EA0
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C7243379;
	Tue, 10 Jun 2025 18:31:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4919238C1B;
	Tue, 10 Jun 2025 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580304; cv=none; b=La2ASn5eoeOn3wLNbseUFEjaxNjMPUatXM/6ST4LAtJ0usdNUV/O03ijVpDHPFgF/kpaGiXNV5XLAGuikH7AZVzyHQK2mXk5iZ6AJIQhQgi+kUofLjfSI7qQG9oOK0jaE6K5htbDrIBFZrJygtKjHNDVzoTYSuW2VTgl1RS/yMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580304; c=relaxed/simple;
	bh=QUg0jZlbuzFB5jP9wY8764cHVeJKKVjbPNKXc2oti5c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=O8LDDphFNceRgB+wGD0Z/tE3QZaFZ+4hGx4l6de+nlYcPWVEX9QbeAInp+HwEkjim5xGh4jXzr5oR/NVTBq6Uw+AQy1BwQySQqZR7QG/U6YyZ27y4obaKnf6+zk/sHb8THtQLbSVHIt8NkcqLzaIJ+qJNMToTQ2mh4BeFlu2Lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 55AIXZf6000833;
	Tue, 10 Jun 2025 11:33:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Jun 2025 11:33:35 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
Message-ID: <70660feba172c7933cd5521527df523c@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit


Thanks!  I appreciate you getting back to me.  I've got about 30 huge 
bugs I am shaking down, and this one just cropped up, so I haven't been 
able to put a lot of time into it yet.
I rolled a full debug kernel last night to troubleshoot what appears to 
be a spinlock/mutex issue with something else, but I'm sure it'll help 
with this too.

If I find anything out I will also reply with the details....



On 2025/06/10 09:27, Florian Fainelli wrote:
> Howdy!
> 
> On 6/9/25 15:43, Greg Chandler wrote:
>> 
>> This is a from-scratch build (non-vendor/non-distribution)
>> Host/Target = alpha ev6
>> Kernel source = 6.12.12
>> 
>> My last working kernel on this was a 2.6.x, it's been a while since 
>> I've had time to bring this system up to date, so I don't know when 
>> this may have started.
>> I had a 3.0.102 in there, but I didn't test the networking while using 
>> it.
>> 
>> Please let me know what I can do to help out with figuring this one 
>> out.
> 
> I don't have an Alpha machine to try this on, but I do have a 
> functional Cobalt Qube2 (MIPS 32/64) with these adapters connected 
> directly over PCI:
> 
> 00:07.0 Ethernet controller: Digital Equipment Corporation DECchip 
> 21142/43 (rev 41)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr+ Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 32 
> bytes
>         Interrupt: pin A routed to IRQ 19
>         Region 0: I/O ports at 1000 [size=128]
>         Region 1: Memory at 12082000 (32-bit, non-prefetchable) 
> [size=1K]
>         Expansion ROM at 12000000 [disabled] [size=256K]
>         Kernel driver in use: tulip
> 
> 
> 00:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 
> 21142/43 (rev 41)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 32 
> bytes
>         Interrupt: pin A routed to IRQ 20
>         Region 0: I/O ports at 1080 [size=128]
>         Region 1: Memory at 12082400 (32-bit, non-prefetchable) 
> [size=1K]
>         Expansion ROM at 12040000 [disabled] [size=256K]
>         Kernel driver in use: tulip
> 
> the machine is not currently on a switch that I can control, but I can 
> certainly try to plug in the cable and see what happens, give me a 
> couple of days to get back to you, and if you don't hear back,  please 
> holler. Here are the bits of kernel configuration:
> 
> CONFIG_NET_TULIP=y
> CONFIG_TULIP=y
> # CONFIG_TULIP_MWI is not set
> # CONFIG_TULIP_MMIO is not set
> # CONFIG_TULIP_NAPI is not set

