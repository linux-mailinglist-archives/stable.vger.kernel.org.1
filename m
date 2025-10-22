Return-Path: <stable+bounces-188956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5264BFB452
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E238356BD8
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F80312820;
	Wed, 22 Oct 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N+ivhJdU"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28830F53E;
	Wed, 22 Oct 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127168; cv=none; b=mglLpQwL9GGQW+9E8q2jnNkcoICGzzfCKg1X/e95V1hfTJHUyEsy1b0tEGLel3RLVkpTlwgUvzb2z+GVug4kLsMX+k5MkVySvUopfoCpAkvAkd4DRG2xzIWdWAac2KAp2rd1GjZlzIOzFSDuayOy1hKlro/vLX7o6tFDQ5JgfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127168; c=relaxed/simple;
	bh=QmEpF6sPqLGtPfR97ODlWi8K2yCDWkjPz1yM9eoEWZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCELPSzJgExu0dAksMqOoTu61hkdjzmYW5bntlNwqNFGoCgFDMZBf5kRjJXVRKuRNXi3CT+rLCgIff1m8dFRjhn6LKpFaoufC5AnM9NrueUy4+NcNaUuB2lNJMo/SjW9ifCwU2Mk0Jqt8BEHpFR1nhl470MON3rwdiuNy8KlDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=N+ivhJdU; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cs4Q20Hn5z9tm8;
	Wed, 22 Oct 2025 11:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761127162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs9gC2MuUAS+IiZaGoI5syk4lSYwDHEmE+5KRFDk2J8=;
	b=N+ivhJdUViE2sx8JFuqurvh6YesjViJsAfOk6IZ+HoHyiqnBEGcpE2j+L/CCRW0M5ucsL7
	Xon9ZukDAIY5YQjrCATS/9RJZl9VM0L6qORNgjwPpEdK92UNhxWRC2hVjlRtJSGA/wZvA+
	zAAOn+Ltj3A52VpZ+QMGuhAlFe7O22IVwr1bFg+/XWAJu+ljWO2gU3Pbfccj0XqCXb5cHH
	50KgDJH7KcL15jY7IT0SzIDTaemRvYyPk1lOoTZOSZrWsvlMxYK5eu+qhqo7sYVa8Cga6K
	UbEzSiKHdzw7JG3vtZ/PhtE6e74egcYx9dKUL9wLEw8WGv1ZnHPP5x+Vyj4TDw==
Message-ID: <72267a6c-13c7-40bd-babb-f73a28625ca4@mailbox.org>
Date: Wed, 22 Oct 2025 11:59:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
To: "mani@kernel.org" <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Bandi, Ravi Kumar"
 <ravib@amazon.com>,
 "thippeswamy.havalige@amd.com" <thippeswamy.havalige@amd.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6e55d69c8ea0868a40e
X-MBO-RS-META: az7nnbuxz6o4bpe17pfhm65i8n7q5a34

On 10/22/25 11:55, mani@kernel.org wrote:
> On Wed, Oct 22, 2025 at 08:59:19AM +0200, Stefan Roese wrote:
>> Hi Bjorn,
>> Hi Ravi,
>>
>> On 10/21/25 23:28, Bjorn Helgaas wrote:
>>> On Tue, Oct 21, 2025 at 08:55:41PM +0000, Bandi, Ravi Kumar wrote:
>>>>> On Tue, Oct 21, 2025 at 05:46:17PM +0000, Bandi, Ravi Kumar wrote:
>>>>>>> On Oct 21, 2025, at 10:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>> On Sat, Sep 20, 2025 at 10:52:32PM +0000, Ravi Kumar Bandi wrote:
>>>>>>>> The pcie-xilinx-dma-pl driver does not enable INTx interrupts
>>>>>>>> after initializing the port, preventing INTx interrupts from
>>>>>>>> PCIe endpoints from flowing through the Xilinx XDMA root port
>>>>>>>> bridge. This issue affects kernel 6.6.0 and later versions.
>>>>>>>>
>>>>>>>> This patch allows INTx interrupts generated by PCIe endpoints
>>>>>>>> to flow through the root port. Tested the fix on a board with
>>>>>>>> two endpoints generating INTx interrupts. Interrupts are
>>>>>>>> properly detected and serviced. The /proc/interrupts output
>>>>>>>> shows:
>>>>>>>>
>>>>>>>> [...]
>>>>>>>> 32:        320          0  pl_dma:RC-Event  16 Level     400000000.axi-pcie, azdrv
>>>>>>>> 52:        470          0  pl_dma:RC-Event  16 Level     500000000.axi-pcie, azdrv
>>>>>>>> [...]
>>
>> First a comment on this IRQ logging:
>>
>> These lines do NOT refer to the INTx IRQ(s) but the controller internal
>> "events" (errors etc). Please see this log for INTx on my Versal
>> platform with pci_irqd_intx_xlate added:
>>
>>   24:          0          0  pl_dma:RC-Event   0 Level     LINK_DOWN
>>   25:          0          0  pl_dma:RC-Event   3 Level     HOT_RESET
>>   26:          0          0  pl_dma:RC-Event   8 Level     CFG_TIMEOUT
>>   27:          0          0  pl_dma:RC-Event   9 Level     CORRECTABLE
>>   28:          0          0  pl_dma:RC-Event  10 Level     NONFATAL
>>   29:          0          0  pl_dma:RC-Event  11 Level     FATAL
>>   30:          0          0  pl_dma:RC-Event  20 Level     SLV_UNSUPP
>>   31:          0          0  pl_dma:RC-Event  21 Level     SLV_UNEXP
>>   32:          0          0  pl_dma:RC-Event  22 Level     SLV_COMPL
>>   33:          0          0  pl_dma:RC-Event  23 Level     SLV_ERRP
>>   34:          0          0  pl_dma:RC-Event  24 Level     SLV_CMPABT
>>   35:          0          0  pl_dma:RC-Event  25 Level     SLV_ILLBUR
>>   36:          0          0  pl_dma:RC-Event  26 Level     MST_DECERR
>>   37:          0          0  pl_dma:RC-Event  27 Level     MST_SLVERR
>>   38:         94          0  pl_dma:RC-Event  16 Level     84000000.axi-pcie
>>   39:         94          0  pl_dma:INTx   0 Level     nvme0q0, nvme0q1
>>
>> The last line shows the INTx IRQs here ('pl_dma:INTx' vs 'pl_dma:RC-
>> Event').
>>
>> More below...
>>
>>>>>>>>
>>>>>>>> Changes since v1::
>>>>>>>> - Fixed commit message per reviewer's comments
>>>>>>>>
>>>>>>>> Fixes: 8d786149d78c ("PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver")
>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>> Signed-off-by: Ravi Kumar Bandi <ravib@amazon.com>
>>>>>>>
>>>>>>> Hi Ravi, obviously you tested this, but I don't know how to reconcile
>>>>>>> this with Stefan's INTx fix at
>>>>>>> https://lore.kernel.org/r/20251021154322.973640-1-stefan.roese@mailbox.org
>>>>>>>
>>>>>>> Does Stefan's fix need to be squashed into this patch?
>>>>>>
>>>>>> Sure, we can squash Stefan’s fix into this.
>>>>>
>>>>> I know we *can* squash them.
>>>>>
>>>>> I want to know why things worked for you and Stefan when they
>>>>> *weren't* squashed:
>>>>>
>>>>>    - Why did INTx work for you even without Stefan's patch.  Did you
>>>>>      get INTx interrupts but not the right ones, e.g., did the device
>>>>>      signal INTA but it was received as INTB?
>>>>
>>>> I saw that interrupts were being generated by the endpoint device,
>>>> but I didn’t specifically check if they were correctly translated in
>>>> the controller. I noticed that the new driver wasn't explicitly
>>>> enabling the interrupts, so my first approach was to enable them,
>>>> which helped the interrupts flow through.
>>>
>>> OK, I'll assume the interrupts happened but the driver might not have
>>> been able to handle them correctly, e.g., it was prepared for INTA but
>>> got INTB or similar.
>>>
>>>>>    - Why did Stefan's patch work for him even without your patch.  How
>>>>>      could Stefan's INTx work without the CSR writes to enable
>>>>>      interrupts?
>>>>
>>>> I'm not entirely sure if there are any other dependencies in the
>>>> FPGA bitstream. I'll investigate further and get back to you.
>>>
>>> Stefan clarified in a private message that he had applied your patch
>>> first, so this mystery is solved.
>>
>> Yes. I applied Ravi's patch first and still got no INTx delivered
>> to the nvme driver. That's what me triggered to dig deeper here and
>> resulted in this v2 patch with pci_irqd_intx_xlate added.
>>
>> BTW:
>> I re-tested just now w/o Ravi's patch and the INTx worked. Still I think
>> Ravi's patch is valid and should be applied...
> 
> How come INTx is working without the patch from Ravi which enabled INTx routing
> in the controller? Was it enabled by default in the hardware?

Yes, this is my best guess right now. I could double-check here, but
IMHO it makes sense to enable it "manually" as done with Ravi's patch
to not rely on this default setup at all.

Thanks,
Stefan


