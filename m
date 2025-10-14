Return-Path: <stable+bounces-185626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD44BD8B39
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2175E3A8515
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0922C2F90CE;
	Tue, 14 Oct 2025 10:13:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D282F5479
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436837; cv=none; b=hiPbODw0UV560GAZs07mqtJ90c0kgo/HF81IKMC4ZbZi0+7FIeunf9P2L4O6NOAxDo8cW0q4nWep9a2FukDETQp0Y9OUcwf7gJ+/wJkcLSi0PPCijReXDCumJn3lwRAkfhnoLMm5MhTLr6mBNS3EDxZ4dtXNsqvMOO6YemDMCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436837; c=relaxed/simple;
	bh=VLSfMsG7TllDtJsX1MCMDfY8R5vkv1+hAlWzgwYJMGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9SGtgM1RQGOcNTMvT2fKZYU7EbKIqxdxTX8r+teWyS/BVqFqp+f30HGufNUnaQVvupfMsDEhotvPg4K8ZfneacWQjSt4hOQVxYKhrl05ikQaPM9oXk1XHroBqw5+DnJTSLPCerHmh7r574OmyLYZkmTyEmXpafJY2ovClZA2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A3C41A9A;
	Tue, 14 Oct 2025 03:13:47 -0700 (PDT)
Received: from [10.1.25.198] (e137867.arm.com [10.1.25.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E56D3F6A8;
	Tue, 14 Oct 2025 03:13:54 -0700 (PDT)
Message-ID: <37b8fe61-318e-4bb2-9935-93014c74368c@arm.com>
Date: Tue, 14 Oct 2025 11:13:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: debug: always unmask interrupts in
 el0_softstp()
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 stable@vger.kernel.org, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20251013174317.74791-1-ada.coupriediaz@arm.com>
 <20251014092536.18831-1-ada.coupriediaz@arm.com>
 <aO4b_Ubig2FXowLa@J2N7QTR9R3.cambridge.arm.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <aO4b_Ubig2FXowLa@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2025 10:46, Mark Rutland wrote:

> On Tue, Oct 14, 2025 at 10:25:36AM +0100, Ada Couprie Diaz wrote:
>> EL0 exception handlers should always call `exit_to_user_mode()` with
>> interrupts unmasked.
>> When handling a completed single-step, we skip the if block and
>> `local_daif_restore(DAIF_PROCCTX)` never gets called,
>> which ends up calling `exit_to_user_mode()` with interrupts masked.
>>
>> This is broken if pNMI is in use, as `do_notify_resume()` will try
>> to enable interrupts, but `local_irq_enable()` will only change the PMR,
>> leaving interrupts masked via DAIF.
> I think we might want to spell thius out a bit more, e.g.
That's fair, your version lays it out better and is probably more 
accessible !
> | We intend that EL0 exception handlers unmask all DAIF exceptions
> | before calling exit_to_user_mode().
> |
> | When completing single-step of a suspended breakpoint, we do not call
> | local_daif_restore(DAIF_PROCCTX) before calling exit_to_user_mode(),
> | leaving all DAIF exceptions masked.
> |
> | When pseudo-NMIs are not in use this is benign.
> |
> | When pseudo-NMIs are in use, this is unsound. At this point interrupts
> | are masked by both DAIF.IF and PMR_EL1, and subsequent irq flag
> | manipulation may not work correctly. For example, a subsequent
> | local_irq_enable() within exit_to_user_mode_loop() will only unmask
> | interrupts via PMR_EL1 (leaving those masked via DAIF.IF), and
> | anything depending on interrupts being unmasked (e.g. delivery of
> | signals) will not work correctly.
> |
> | This can by detected by CONFIG_ARM64_DEBUG_PRIORITY_MASKING.
This could be "This was detected [...]", as that's what I did to detect 
the error,
but happy with either : we don't need to bikeshed this !
> With or without that, this looks good to me, so:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Mark.
Thanks for the quick review,
Ada

