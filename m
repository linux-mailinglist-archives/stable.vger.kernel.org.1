Return-Path: <stable+bounces-73938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB1970A71
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 00:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD0D281DA7
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6F13A261;
	Sun,  8 Sep 2024 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF1sp9E9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF04EACD;
	Sun,  8 Sep 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725834111; cv=none; b=DY3T89ALma7axNxvQkk62Af03GIdaW7vcCY1Ca7EZKsh7O9euAvRRorSbhkJuUZVmUgNA96gmLXBciSau/WwopQ6321LpuipBRSAGLT8GE9OlBVVu5aynbLqGFjNx2NGtYJ7DNiEdZMqEhRn9SbcSg8WUwftQR42FWxlpUxWyBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725834111; c=relaxed/simple;
	bh=z/TNyaiBwjBqzhdB0KSfpNqprTUg2wWQj0oQzur0CBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4XvuJOcFF4zFh6es8qCW3GOzHRM8JoAKrsJQJG6KBm3jSpdq2FOtYmSQZp8F1bqf9e7L8Y3L1W45Wm8aaEvBR0pMbBR2xRG39WphijpeaHqrYvzikWNX6tDRXGbK/UmmImmM3dDDQWVhiyv6TpburFh/4FG7xQYLxY6Esl9VI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF1sp9E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9491C4CEC3;
	Sun,  8 Sep 2024 22:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725834110;
	bh=z/TNyaiBwjBqzhdB0KSfpNqprTUg2wWQj0oQzur0CBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oF1sp9E95gKz0dnEdqPrFVTbiEwXmxoguh2Z5vrfcf8YWjlCzQprh3ryXTHUSs3MM
	 mjYmRO1+F/qb5wHlhAt6CajPnHrfEOJXDfL2DtppYPcDAKvSPqZtHEjseOK0TH7v4Q
	 iQQl/eYEtyAp/GAsRQBqYsBrRuYm+Uo79GblJiSVJ99dCpqwyebl40Wh+ll1hplnEv
	 7ZNXM2Qmqs/ZKFxPVs3Rz1PGrBOlnKZBfIMdd8s+4qoh4IfBtRQbWP/GZEybXsBl72
	 Jq59WmrdnL3avrV6OBAQ+JijCko7nT1cSO+uS0ICmcMUVuleaIyQkLdKN1LmOwsWv2
	 qUoZDIMGNEnig==
Date: Sun, 8 Sep 2024 18:21:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Patch "irqchip/gic-v4: Make sure a VPE is locked when VMAPP is
 issued" has been added to the 6.6-stable tree
Message-ID: <Zt4jfSmTNl1QrARC@sashalap>
References: <20240908133637.1651482-1-sashal@kernel.org>
 <86bk0yupwx.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86bk0yupwx.wl-maz@kernel.org>

On Sun, Sep 08, 2024 at 04:27:10PM +0100, Marc Zyngier wrote:
>On Sun, 08 Sep 2024 14:36:37 +0100,
>Sasha Levin <sashal@kernel.org> wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     irqchip/gic-v4: Make sure a VPE is locked when VMAPP is issued
>>
>> to the 6.6-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      irqchip-gic-v4-make-sure-a-vpe-is-locked-when-vmapp-.patch
>> and it can be found in the queue-6.6 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit 1a232324773145ff7ce59b6a1b52b3247223f9d4
>> Author: Marc Zyngier <maz@kernel.org>
>> Date:   Fri Jul 5 10:31:55 2024 +0100
>>
>>     irqchip/gic-v4: Make sure a VPE is locked when VMAPP is issued
>>
>>     [ Upstream commit a84a07fa3100d7ad46a3d6882af25a3df9c9e7e3 ]
>>
>>     In order to make sure that vpe->col_idx is correctly sampled when a VMAPP
>>     command is issued, the vpe_lock must be held for the VPE. This is now
>>     possible since the introduction of the per-VM vmapp_lock, which can be
>>     taken before vpe_lock in the correct locking order.
>>
>>     Signed-off-by: Marc Zyngier <maz@kernel.org>
>>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>     Tested-by: Nianyao Tang <tangnianyao@huawei.com>
>>     Link: https://lore.kernel.org/r/20240705093155.871070-4-maz@kernel.org
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index e25dea0e50c7..1e0f0e1bf481 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1804,7 +1804,9 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
>>  		for (i = 0; i < vm->nr_vpes; i++) {
>>  			struct its_vpe *vpe = vm->vpes[i];
>>
>> -			its_send_vmapp(its, vpe, true);
>> +			scoped_guard(raw_spinlock, &vpe->vpe_lock)
>> +				its_send_vmapp(its, vpe, true);
>> +
>>  			its_send_vinvall(its, vpe);
>>  		}
>>  	}
>> @@ -1825,8 +1827,10 @@ static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
>>  	if (!--vm->vlpi_count[its->list_nr]) {
>>  		int i;
>>
>> -		for (i = 0; i < vm->nr_vpes; i++)
>> +		for (i = 0; i < vm->nr_vpes; i++) {
>> +			guard(raw_spinlock)(&vm->vpes[i]->vpe_lock);
>>  			its_send_vmapp(its, vm->vpes[i], false);
>> +		}
>>  	}
>>
>>  	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
>>
>
>No please.
>
>Not only you are missing the essential part of the series (the patch
>introducing the per-VM lock that this change relies on), you are also
>missing the fixes that followed.
>
>So please drop this patch from the 6.6 and 6.1 queues.

Will do, thanks!

-- 
Thanks,
Sasha

