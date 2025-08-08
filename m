Return-Path: <stable+bounces-166824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8283B1E52D
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 11:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1261895711
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF90266F15;
	Fri,  8 Aug 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plan9.rocks header.i=@plan9.rocks header.b="K0OGGPxm"
X-Original-To: stable@vger.kernel.org
Received: from plan9.rocks (vmi607075.contaboserver.net [207.244.235.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2521B9E7
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.244.235.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643641; cv=none; b=NP4pexi3EaDx/znkkNDVBijlU/tDbbq4zr0scn4dcV01gqlu/ke19C2N4PBSExtlmEOMl4WUWuekO+kxL/uGnlP2xMzc9VfH9T3qtD+WIafdRKbUbATLPJrNOMXgpc+NcoQ4IbzctaZ+DWLjf9qOXrdWo0bunejWzLMp61j10w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643641; c=relaxed/simple;
	bh=x2Kt98L8PnA+jFA4+yH9ThQYSqlpJEKGNl+UHe2H4YA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=nw6a9lFMea3tCnVzZkSfCNZDajVsbA9KRuo/iw0J6Nija+mePwR9jvWKQK1wNSxw9Rjt1V/uImjhi36eWrZ/H6TmL1JSW5RXpod046y21ZUYjrZ1PU2OWJIj2iTXn6bkBA5pV49yxswdpwD8T9sOxsT/RGdzt8fZZJEfJdiXPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plan9.rocks; spf=pass smtp.mailfrom=plan9.rocks; dkim=pass (2048-bit key) header.d=plan9.rocks header.i=@plan9.rocks header.b=K0OGGPxm; arc=none smtp.client-ip=207.244.235.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plan9.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plan9.rocks
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=plan9.rocks; s=mail;
	t=1754643637; bh=x2Kt98L8PnA+jFA4+yH9ThQYSqlpJEKGNl+UHe2H4YA=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=K0OGGPxmoqpF7g4gnHwXRx9NVcMjQ3hIXbji/xhgzoNRpRyDCH9atZeGxKsh/kTbW
	 yXMaWk8RWvaH+k4dEW1DCRpK/6IzAqgtQJwL0GX8ZhRh7QcJvPn8goHHILzvVcvGqx
	 b0DAuRhAXjlot1PUbCmbOEtucideBRAilpnfqSNaFcJ7q1VwDnZl+pbRS/9K9phntT
	 xaVXgA1PMnYuv1J4aU9NF/yEOrF1WNC41M+Dc7C9r0Qp+EgS/fH66h5rYyGSePs2DY
	 G+AsAKLwCMT8RC4Pcst9SpaZdw5pD1nJTyMBVBScMb6dpUN7RYFRBqDuG/CNLhLd+u
	 dCGvLXoKBK9VQ==
Received: from [192.168.58.180] (syn-035-139-136-005.res.spectrum.com [35.139.136.5])
	by plan9.rocks (Postfix) with ESMTPSA id 9330B120051C;
	Fri,  8 Aug 2025 04:00:37 -0500 (CDT)
Message-ID: <06159138-b27e-4b9e-9fdd-51abc1e06469@plan9.rocks>
Date: Fri, 8 Aug 2025 09:00:36 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] vfio gpu passthrough stopped working
From: cat <cat@plan9.rocks>
To: Greg KH <gregkh@linuxfoundation.org>, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <718C209F-22BD-4AF3-9B6F-E87E98B5239E@plan9.rocks>
 <2025080724-sage-subplot-3d0f@gregkh>
 <b30b2f11-0245-4d73-b589-f3a5574ddd00@plan9.rocks>
Content-Language: en-US
In-Reply-To: <b30b2f11-0245-4d73-b589-f3a5574ddd00@plan9.rocks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

fb5873b779dd5858123c19bbd6959566771e2e83 is the first bad commit
commit fb5873b779dd5858123c19bbd6959566771e2e83
Author: Lu Baolu <baolu.lu@linux.intel.com>
Date:   Tue May 20 15:58:49 2025 +0800

     iommu/vt-d: Restore context entry setup order for aliased devices

     commit 320302baed05c6456164652541f23d2a96522c06 upstream.

     Commit 2031c469f816 ("iommu/vt-d: Add support for static identity 
domain")
     changed the context entry setup during domain attachment from a
     set-and-check policy to a clear-and-reset approach. This inadvertently
     introduced a regression affecting PCI aliased devices behind 
PCIe-to-PCI
     bridges.

     Specifically, keyboard and touchpad stopped working on several Apple
     Macbooks with below messages:

      kernel: platform pxa2xx-spi.3: Adding to iommu group 20
      kernel: input: Apple SPI Keyboard as
  /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/input/input0
      kernel: DMAR: DRHD: handling fault status reg 3
      kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
      0xffffa000 [fault reason 0x06] PTE Read access is not set
      kernel: DMAR: DRHD: handling fault status reg 3
      kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
      0xffffa000 [fault reason 0x06] PTE Read access is not set
      kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
      kernel: DMAR: DRHD: handling fault status reg 3
      kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
      0xffffa000 [fault reason 0x06] PTE Read access is not set
      kernel: DMAR: DRHD: handling fault status reg 3
      kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00

     Fix this by restoring the previous context setup order.

     Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity 
domain")
     Closes: 
https://lore.kernel.org/all/4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch/
     Cc: stable@vger.kernel.org
     Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
     Reviewed-by: Kevin Tian <kevin.tian@intel.com>
     Reviewed-by: Yi Liu <yi.l.liu@intel.com>
     Link: 
https://lore.kernel.org/r/20250514060523.2862195-1-baolu.lu@linux.intel.com
     Link: 
https://lore.kernel.org/r/20250520075849.755012-2-baolu.lu@linux.intel.com
     Signed-off-by: Joerg Roedel <jroedel@suse.de>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

  drivers/iommu/intel/iommu.c  | 11 +++++++++++
  drivers/iommu/intel/iommu.h  |  1 +
  drivers/iommu/intel/nested.c |  4 ++--
  3 files changed, 14 insertions(+), 2 deletions(-)

On 8/8/25 4:40 AM, cat wrote:
> I will perform bisection, yes.
>
> On 8/7/25 3:52 PM, Greg KH wrote:
>> On Thu, Aug 07, 2025 at 03:31:17PM +0000, cat wrote:
>>> #regzbot introduced: v6.12.34..v6.12.35
>>>
>>> After upgrade to kernel 6.12.35, vfio passthrough for my GPU has 
>>> stopped working within a windows VM, it sees device in device 
>>> manager but reports that it did not start correctly. I compared 
>>> lspci logs in the vm before and after upgrade to 6.12.35, and here 
>>> are the changes I noticed:
>>>
>>> - the reported link speed for the passthrough GPU has changed from 
>>> 2.5 to 16GT/s
>>> - the passthrough GPU has lost it's 'BusMaster' and MSI enable flags
>>> - latency measurement feature appeared
>>>
>>> These entries also began appearing within the vm in dmesg when host 
>>> kernel is 6.12.35 or above:
>>>
>>> [    1.963177] nouveau 0000:01:00.0: sec2(gsp): mbox 1c503000 00000001
>>> [    1.963296] nouveau 0000:01:00.0: sec2(gsp):booter-load: boot 
>>> failed: -5
>>> ...
>>> [    1.964580] nouveau 0000:01:00.0: gsp: init failed, -5
>>> [    1.964641] nouveau 0000:01:00.0: init failed with -5
>>> [    1.964681] nouveau: drm:00000000:00000080: init failed with -5
>>> [    1.964721] nouveau 0000:01:00.0: drm: Device allocation failed: -5
>>> [    1.966318] nouveau 0000:01:00.0: probe with driver nouveau 
>>> failed with error -5
>>>
>>>
>>> 6.12.34 worked fine, and latest 6.12 LTS does not work either. I am 
>>> using intel CPU and nvidia GPU (for passthrough, and as my GPU on 
>>> linux system).
>> Can you use git bisect to find the offending commit?
>>
>>

