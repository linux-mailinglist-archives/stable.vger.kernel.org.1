Return-Path: <stable+bounces-182855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0AFBAE407
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549F23BEE79
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848B22F74E;
	Tue, 30 Sep 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="MnWH6S5n"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (email.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DB1C860F
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255037; cv=none; b=HnwjfTxzkSD013Hytc6VBvFFe0eKBC0HDTEnZdzU25SJjv/1xv0Wfxfy6VxGUf0xYMLAoXiDwsxGZF0Z1J0xD41UnwvikdkW3tAG5ClPviNdNhlvYpik+RbNw1atNkI8ZaUqyNBOZwnz7dagmLT7YtNH8oxJLFb+vLY7taOqIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255037; c=relaxed/simple;
	bh=sR1/Er7syiJH3GH8DdMYrCsMdnNt6etP4jcU9xUQSz8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=W1s5H6L1Ywoi8QG4nBKtTTwUgJYFlTLFmHAqANGs11umCmeEC444RF2z/91TS/hOP4dY7yVsXx3bm0R+PwIKDJYRu8YoY3YoynxfpOOHFVGxjtE0CteTm1qWtXvYfNhJqSJuWNcyO9WNsklEWHjOI5C94FT9iBSEdmoFUtPYiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=MnWH6S5n; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4cbm3D3lFnzRhRQ;
	Tue, 30 Sep 2025 19:56:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1759255016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b18t4bE+7ndSMwb+6DA+Il9zI9AR4NfZek+6cnm09h0=;
	b=MnWH6S5nvVpeG3E/mX5pOKVYSc6tSXrcMhzHnQ3RFmfzQSHe0/1/uU5ZtrFvogAZzeGgdQ
	uIYIOA958B3eebrZ3h7rb2YeX7tnD3uwy97NJ/rj/rjTazes++jE4MO4yymTiF8PyAjWns
	kwQnY1PdCWEQjJMPFSMCjYN/ex1pDrkUSRv9UCRBkOuMkTxmxl+mE1Er0sgMqUbwfNsCVr
	qlWGazuwdMgfPJlf7y/hUBvnOI5Fhs5o7nuG5obnKn6ffizI4CP1mQeAsS8zl0MMp2n21b
	BRT450IGXYJ//kO8v+mms9DR0MB5YRrmwpPqZ7MWvNS7UrlvEkU3gIjDLUw4yw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Sep 2025 19:56:56 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>, stable@vger.kernel.org
Subject: Re: regression from 6.12.48 to 6.12.49: usb wlan adaptor stops
 working: bisected
In-Reply-To: <2025092930-manpower-flashily-e1fa@gregkh>
References: <01b8c8de46251cfaad1329a46b7e3738@stwm.de>
 <2025092930-manpower-flashily-e1fa@gregkh>
Message-ID: <87a81487448f881d9f18dbce4e093a1a@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Am 2025-09-29 15:27, schrieb Greg Kroah-Hartman:
> On Fri, Sep 26, 2025 at 05:54:00PM +0200, Wolfgang Walter wrote:
>> Hello,o
>> after upgrading to 6.12.49 my wlan adapter stops working. It is 
>> detected:
>> 
>> kernel: mt76x2u 4-2:1.0: ASIC revision: 76120044
>> kernel: mt76x2u 4-2:1.0: ROM patch build: 20141115060606a
>> kernel: usb 3-4: reset high-speed USB device number 2 using xhci_hcd
>> kernel: mt76x2u 4-2:1.0: Firmware Version: 0.0.00
>> kernel: mt76x2u 4-2:1.0: Build: 1
>> kernel: mt76x2u 4-2:1.0: Build Time: 201507311614____
>> 
>> but does nor work. The following 2 messages probably are relevant:
>> 
>> kernel: mt76x2u 4-2:1.0: MAC RX failed to stop
>> kernel: mt76x2u 4-2:1.0: MAC RX failed to stop
>> 
>> later I see a lot of
>> 
>> kernel: mt76x2u 4-2:1.0: error: mt76x02u_mcu_wait_resp failed with 
>> -110
>> 
>> 
>> I bisected it down to commit
>> 
>> 9b28ef1e4cc07cdb35da257aa4358d0127168b68
>> usb: xhci: remove option to change a default ring's TRB cycle bit
>> 
>> 
>> 9b28ef1e4cc07cdb35da257aa4358d0127168b68 is the first bad commit
>> commit 9b28ef1e4cc07cdb35da257aa4358d0127168b68
>> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
>> Date:   Wed Sep 17 08:39:07 2025 -0400
>> 
>>     usb: xhci: remove option to change a default ring's TRB cycle bit
>> 
>>     [ Upstream commit e1b0fa863907a61e86acc19ce2d0633941907c8e ]
>> 
>>     The TRB cycle bit indicates TRB ownership by the Host Controller 
>> (HC) or
>>     Host Controller Driver (HCD). New rings are initialized with
>> 'cycle_state'
>>     equal to one, and all its TRBs' cycle bits are set to zero. When
>> handling
>>     ring expansion, set the source ring cycle bits to the same value 
>> as the
>>     destination ring.
>> 
>>     Move the cycle bit setting from xhci_segment_alloc() to
>> xhci_link_rings(),
>>     and remove the 'cycle_state' argument from 
>> xhci_initialize_ring_info().
>>     The xhci_segment_alloc() function uses kzalloc_node() to allocate
>> segments,
>>     ensuring that all TRB cycle bits are initialized to zero.
>> 
>>     Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
>>     Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>     Link: 
>> https://lore.kernel.org/r/20241106101459.775897-12-mathias.nyman@linux.intel.com
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>     Stable-dep-of: a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer 
>> ring
>> after several reconnects")
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> 
>> 
> 
> Does 6.17 also have this problem?
> 
> thanks,
> 
> greg k-h

I built a 6.17 kernel and it works fine, so no, 6.17 does not have this 
problem.

Thanks a lot to you and all kernel developers who make the stable and 
longterm kernels possible. We use them since many years and are very 
happy with them.

Regards
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

