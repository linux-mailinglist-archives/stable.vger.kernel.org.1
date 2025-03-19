Return-Path: <stable+bounces-124871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A1A682BC
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 02:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95381768AD
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB5422489A;
	Wed, 19 Mar 2025 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaLE5S/4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C2207E04;
	Wed, 19 Mar 2025 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742347675; cv=none; b=o4bRUmlT1975AMYe5pSaOIqSePeEaIR2A5oJ9HWj72HLOZhE6oJbYBWWwR/vBOuxwSsls79JMI8RYoVUXGiwv9oJ6WjBSKWAFiqwzSGTQRmzMOyim2TR+8THZt5cfQWuz7Zf3j2kB5omOK6rD3Ja/POz3OAEEFMNCkeDGXeznKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742347675; c=relaxed/simple;
	bh=CuVaPYVmTxG9Z/4/GY8XJLK4/KQ794QljAoN47lFzjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpsrxvIz8PLUnjCkBCFY8A3Fr3hF7L30CJOgGpx5xoz9n9touqrm66Gz+mS3nfdOIiYer1cr64M7BmgiBzLSCBS/GgeLjFdTauhNoMwKGNdtvvri0yumHqbKh4w7VxBfWNC9m/RkI3Qy2aq8DT2z6HL8nK1l0FXnM4H6ER0do2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaLE5S/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C169C4CEE3;
	Wed, 19 Mar 2025 01:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742347674;
	bh=CuVaPYVmTxG9Z/4/GY8XJLK4/KQ794QljAoN47lFzjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UaLE5S/4qIpbLqkK+uTylbL9aZ26EtlwM/+7mnRprz2E8Pi3JWsAXRg4QbCu0orKs
	 SVTSDjbX9ZE+yFitzbzo9ZCY+XJyu4ncJxN02+NDCcFf6bWmk2cW9Df87WdjD1lEYY
	 SJlTJUYUB/ntzlEHmSuGEtUw+vNsnibebqwjGya3h8ucocZwxVYdC9PZzqSjYqmW+c
	 Kw/XxQ/vCseqQYEvkokYtSJ8TNyQ4ujvQV4ckDoCY9OqVGkYi3NMXqqVAhI5DIgyJa
	 Avz0g7TrjSOPSm0DLFMWqvRtJsEdI5d8KUiH43ootRqKpNxoTiBaLAFIC2y9AX6AoF
	 EkQCyki6IB/4A==
Date: Wed, 19 Mar 2025 09:27:47 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: Fix deadlock when using NCM gadget
Message-ID: <Z9odk4aHd76nXxZ-@nchen-desktop>
References: <20250318-rfs-cdns3-deadlock-v2-1-bfd9cfcee732@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-rfs-cdns3-deadlock-v2-1-bfd9cfcee732@linaro.org>

On 25-03-18 11:09:32, Ralph Siemsen wrote:
> The cdns3 driver has the same NCM deadlock as fixed in cdnsp by commit
> 58f2fcb3a845 ("usb: cdnsp: Fix deadlock issue during using NCM gadget").
> 
> Under PREEMPT_RT the deadlock can be readily triggered by heavy network
> traffic, for example using "iperf --bidir" over NCM ethernet link.
> 
> The deadlock occurs because the threaded interrupt handler gets
> preempted by a softirq, but both are protected by the same spinlock.
> Prevent deadlock by disabling softirq during threaded irq handler.
> 
> cc: stable@vger.kernel.org
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
> v2 changes:
> - move the fix up the call stack, as per discussion at
> https://lore.kernel.org/linux-rt-devel/20250226082931.-XRIDa6D@linutronix.de/
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index fd1beb10bba72..19101ff1cf1bd 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -1963,6 +1963,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
>  	unsigned int bit;
>  	unsigned long reg;
>  
> +	local_bh_disable();
>  	spin_lock_irqsave(&priv_dev->lock, flags);
>  
>  	reg = readl(&priv_dev->regs->usb_ists);
> @@ -2004,6 +2005,7 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
>  irqend:
>  	writel(~0, &priv_dev->regs->ep_ien);
>  	spin_unlock_irqrestore(&priv_dev->lock, flags);
> +	local_bh_enable();
>  
>  	return ret;
>  }
> 
> ---
> base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
> change-id: 20250312-rfs-cdns3-deadlock-697df5cad3ce
> 
> Best regards,
> -- 
> Ralph Siemsen <ralph.siemsen@linaro.org>
> 

-- 

Best regards,
Peter

