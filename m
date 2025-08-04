Return-Path: <stable+bounces-166440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB26B19BD9
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 08:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7686177CE5
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 06:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7596E233149;
	Mon,  4 Aug 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="ZPXgwkYG"
X-Original-To: stable@vger.kernel.org
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EE233722
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290733; cv=none; b=c68VW7EdLXguFbbAVjWE9WnKp3ozC3IOvX5v+2aa2JPz9TeJJbA1eMXyfN6QkyhPjji5Bu/5xJGhc+Chv72bUjb/Qta51lfLFf6hWDNw6enTJ6/ERyiw0MpdgYKt1Vn9wo5D94V9ijpmzkGxBH0pFM+1+VshTAlZzxYKPUer458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290733; c=relaxed/simple;
	bh=1tnUJk0x0AY0ea5Yo/YXecQ/sBKAdalqKRByDlal6mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knFn6E5hEa7kLKi3HbK+Yg3VimLDAVoZ/LYR+qUIlPZHWAUtZPEjWVoBOXtBPAdZqWmF1QVwRImZcEUtPRz2sDbDjzjCKVRGlymE88oqHIHSRHOM/gI9Hpu2UQ0FiD4gcEV2tF4SNm5bXFC7lM7M8nU3QcweDxwwgNn6dJY1nf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=ZPXgwkYG; arc=none smtp.client-ip=62.149.158.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id ip6tumBfyloieip6tu0Gjc; Mon, 04 Aug 2025 08:55:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1754290551; bh=1tnUJk0x0AY0ea5Yo/YXecQ/sBKAdalqKRByDlal6mE=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=ZPXgwkYG/6ycg3OwNR8kX/TsJ30KwaHqWm6laxkP39WkrCrt3GKoI4g+ds9PXfVNZ
	 brPjHn5q+bmR/03MuXtwX1Vb74QKow2H5LPbVRVPzNBGL2LImf7ewc/RXeyDxDVOks
	 YWHpgG7XcbTzyolcjHw071u01H06P0LNC95Ga1hchoU+57m1stX7pgazfGC8xIHeUo
	 Ci56ETVIOy9+uaeaOdiex9hw/NyLKE6O2UKS0hQpcOSr0WEdvUyhTIwuPSF2MwcVmZ
	 T2igtQkUL+TJ7g1DwBvPDM1OdOU+X2v4zlNeJsdRBIRJg0ik9CHL8ySWUjGtqIXwSh
	 eocqus/+VlUHg==
Message-ID: <b25129fe-2614-4d2f-9c4c-371b7691aa3b@enneenne.com>
Date: Mon, 4 Aug 2025 08:55:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.15 50/80] pps: clients: gpio: fix interrupt
 handling order in remove path
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 stable@vger.kernel.org
Cc: Eliav Farber <farbere@amazon.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mingo@kernel.org,
 tglx@linutronix.de, bastien.curutchet@bootlin.com, calvin@wbinvd.org
References: <20250804002747.3617039-1-sashal@kernel.org>
 <20250804002747.3617039-50-sashal@kernel.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20250804002747.3617039-50-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfM1rViYKyhzk1C64KxmkEvJ+v4fCTorUJKp2KHQB1i1BRonfhzyJQ9oS5UroQxA46ZreMptf1norU8QaS/BWbTXRWqLX8cMg/90sPgFCSR3VusLLEnLm
 9LEQt0u8W1XO+gIhUpBqPI8j029NE5DGNrA1dtxQi0j6wqhBHBNl5TV8phJf8/4AkwUe1eHYIHj1T8D2uRfacXwj+L33QkbtkyNYoIXqsQOvifJ9gQKhGihb
 T4WGaaMeZOkm68Y2aLuCw1f+XGJuI2kodhdHNzerqelqT5j8wunBBbq47cT5xfJGd+gBZjUzehHHha9TZgQBXIoTIk3pNygwAXvQKrIVE3ZxG3FeB4pixjuS
 XscWzKqUDdsb8rG0/tpVb+VK60y80BhWr2TTMcvu9B9OvTN6dXDrycV7pYmsHv+uhNu0vvwN3RmpU1rxUObeYoNS6uF5Kr3I9G5PDD5BIX+sVrlgjGw=

On 04/08/25 02:27, Sasha Levin wrote:
> From: Eliav Farber <farbere@amazon.com>
> 
> [ Upstream commit 6bca1e955830808dc90e0506b2951b4256b81bbb ]
> 
> The interrupt handler in pps_gpio_probe() is registered after calling
> pps_register_source() using devm_request_irq(). However, in the
> corresponding remove function, pps_unregister_source() is called before
> the IRQ is freed, since devm-managed resources are released after the
> remove function completes.
> 
> This creates a potential race condition where an interrupt may occur
> after the PPS source is unregistered but before the handler is removed,
> possibly leading to a kernel panic.
> 
> To prevent this, switch from devm-managed IRQ registration to manual
> management by using request_irq() and calling free_irq() explicitly in
> the remove path before unregistering the PPS source. This ensures the
> interrupt handler is safely removed before deactivating the PPS source.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Link: https://lore.kernel.org/r/20250527053355.37185-1-farbere@amazon.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
> 
> LLM Generated explanations, may be completely bogus:
> 
> Based on my analysis of the commit and the surrounding context, here is
> my assessment:
> 
> **Backport Status: YES**
> 
> This commit should be backported to stable kernel trees for the
> following reasons:
> 
> 1. **Fixes a Real Bug**: The commit addresses a genuine race condition
>     where an interrupt can occur after the PPS source is unregistered but
>     before the IRQ handler is freed. This can lead to a kernel panic - a
>     serious stability issue that affects users.
> 
> 2. **Clear Race Condition Pattern**: The code shows the problematic
>     ordering:
>     - In probe: `pps_register_source()` → `devm_request_irq()`
>     - In remove: `pps_unregister_source()` → (implicit devm cleanup frees
>       IRQ)
> 
>     This creates a window where the hardware can generate an interrupt
> after the PPS source is gone but before the handler is removed, causing
> the handler to access freed memory.
> 
> 3. **Minimal and Contained Fix**: The change is small and focused:
>     - Changes `devm_request_irq()` to `request_irq()`
>     - Adds explicit `free_irq()` call before `pps_unregister_source()`
>     - Only 3 lines of functional code changes
>     - No new features or architectural changes
> 
> 4. **Similar to Other Stable Fixes**: This follows a common pattern seen
>     in other drivers where devm resource ordering causes issues in
>     removal paths. The kernel has many similar fixes for CAN drivers,
>     network drivers, and other subsystems that have been backported to
>     stable.
> 
> 5. **Low Risk of Regression**: The change is straightforward and doesn't
>     modify the driver's functionality - it only fixes the resource
>     cleanup ordering. The manual IRQ management is a well-established
>     pattern.
> 
> 6. **Affects User-Visible Stability**: A kernel panic during device
>     removal/module unload is a serious issue that can affect system
>     stability, especially in environments where PPS devices might be
>     dynamically added/removed or during system shutdown.
> 
> The commit message clearly describes the problem, the root cause, and
> the solution. The fix is conservative and follows established kernel
> patterns for fixing devm ordering issues. This is exactly the type of
> bug fix that stable kernel rules recommend for backporting.
> 
>   drivers/pps/clients/pps-gpio.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 374ceefd6f2a..2866636b0554 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -210,8 +210,8 @@ static int pps_gpio_probe(struct platform_device *pdev)
>   	}
>   
>   	/* register IRQ interrupt handler */
> -	ret = devm_request_irq(dev, data->irq, pps_gpio_irq_handler,
> -			get_irqf_trigger_flags(data), data->info.name, data);
> +	ret = request_irq(data->irq, pps_gpio_irq_handler,
> +			  get_irqf_trigger_flags(data), data->info.name, data);
>   	if (ret) {
>   		pps_unregister_source(data->pps);
>   		dev_err(dev, "failed to acquire IRQ %d\n", data->irq);
> @@ -228,6 +228,7 @@ static void pps_gpio_remove(struct platform_device *pdev)
>   {
>   	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
>   
> +	free_irq(data->irq, data);
>   	pps_unregister_source(data->pps);
>   	timer_delete_sync(&data->echo_timer);
>   	/* reset echo pin in any case */


-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

