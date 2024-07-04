Return-Path: <stable+bounces-57997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C8926EBA
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 07:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A941F23225
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 05:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD21A01B4;
	Thu,  4 Jul 2024 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jWXJ71Vi"
X-Original-To: stable@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE31A00EE
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720070106; cv=none; b=czjce0pVNhLMEtmIOitYvQpNmyNdAbbbRSTzXQlcUEqt3KmPzVXw95CUpBcztnR4eKYC52tOubRBWOsPUm6cMPuu0cihYL4vB0aYfdxaht4Fl1N7EGrysLjVbZVQI/x+tekKh8ZkqrNprplP6Iy9DN8LJxRTmFqi8kUrXyqX9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720070106; c=relaxed/simple;
	bh=LXfAyb8GU64Zak6+PgM5rVvulUbL4JrmfcLJZeyATIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o4I1253y7NZkdfL6ttWugKik/Xz18Bi78ot928EW+X2bl7QvmYVsVMPlBJAvVMJj95oppQF40MfXjLpKdtFq7T+nEfV+aAk6N51w4389EEMngl58DrdrZY/7vcjKAt6TKqPbX/cpLuxqzhv0en4I8rYT8312Oqa2RyMBeaSTCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jWXJ71Vi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4645Euv3060357;
	Thu, 4 Jul 2024 00:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720070096;
	bh=75nA6Tc9Y/nedOUsRjIvp50Am8SbS1/8ldjp+Jidz4E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jWXJ71ViXPWN1OEd3+mzAffLvnpWrRNmsci48vkzIevy7sbdBSLc7pBaNg2C/sE8j
	 JTPjUDGSywOQFngNal6yTMdRBHXXdTEJi9K0WlzauP3sfOJnC+KjL961YnKY666xNy
	 1rkJvX7o8yHT+L6mJH5Rb0E1fl9sIN6wqGylZWpE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4645EuZT026158
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 00:14:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 00:14:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 00:14:56 -0500
Received: from [172.24.29.211] (lt5cd2489kgj.dhcp.ti.com [172.24.29.211])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4645Es7D090458;
	Thu, 4 Jul 2024 00:14:55 -0500
Message-ID: <7cdc5fa7-ab14-4e2c-bcdb-eee0f99000cb@ti.com>
Date: Thu, 4 Jul 2024 10:44:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] serial: 8250_omap: Fix Errata i2310 with
 RX FIFO level check" failed to apply to 5.15-stable tree
To: <gregkh@linuxfoundation.org>, <vigneshr@ti.com>
CC: <stable@vger.kernel.org>
References: <2024070338-skid-sauna-cd1d@gregkh>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <2024070338-skid-sauna-cd1d@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Greg

On 7/3/2024 7:41 PM, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x c128a1b0523b685c8856ddc0ac0e1caef1fdeee5
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070338-skid-sauna-cd1d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>
> Possible dependencies:


This patch has dependency on 
https://lore.kernel.org/all/20240703102925.298849298@linuxfoundation.org/ 
Which is already queued for 5.15.


>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From c128a1b0523b685c8856ddc0ac0e1caef1fdeee5 Mon Sep 17 00:00:00 2001
> From: Udit Kumar <u-kumar1@ti.com>
> Date: Tue, 25 Jun 2024 21:37:25 +0530
> Subject: [PATCH] serial: 8250_omap: Fix Errata i2310 with RX FIFO level check
>
> Errata i2310[0] says, Erroneous timeout can be triggered,
> if this Erroneous interrupt is not cleared then it may leads
> to storm of interrupts.
>
> Commit 9d141c1e6157 ("serial: 8250_omap: Implementation of Errata i2310")
> which added the workaround but missed ensuring RX FIFO is really empty
> before applying the errata workaround as recommended in the errata text.
> Fix this by adding back check for UART_OMAP_RX_LVL to be 0 for
> workaround to take effect.
>
> [0] https://www.ti.com/lit/pdf/sprz536 page 23
>
> Fixes: 9d141c1e6157 ("serial: 8250_omap: Implementation of Errata i2310")
> Cc: stable@vger.kernel.org
> Reported-by: Vignesh Raghavendra <vigneshr@ti.com>
> Closes: https://lore.kernel.org/all/e96d0c55-0b12-4cbf-9d23-48963543de49@ti.com/
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Link: https://lore.kernel.org/r/20240625160725.2102194-1-u-kumar1@ti.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ddac0a13cf84..1af9aed99c65 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -672,7 +672,8 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
>   	 * https://www.ti.com/lit/pdf/sprz536
>   	 */
>   	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
> -		(iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT) {
> +	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
> +	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
>   		unsigned char efr2, timeout_h, timeout_l;
>   
>   		efr2 = serial_in(up, UART_OMAP_EFR2);
>

