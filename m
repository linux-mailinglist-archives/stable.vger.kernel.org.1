Return-Path: <stable+bounces-47875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB088D854A
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 16:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05F0B2164C
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1412F5A5;
	Mon,  3 Jun 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="woEGFp09"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02F82D8E;
	Mon,  3 Jun 2024 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425671; cv=none; b=lmnDSPPDhy1ktSQUn6Dy26ltI6F9bRo1gay/LrjIOjfXnILsd1tzze8VMvFwDbGpOIhaZZHuBJFWM9E/5JXB+3HJg3UiQ1WAtbD5na2JXyWAXbZIrY5Y0nK5nT0gKahLlgpsZ2vpiZyYzc08VIOPbXjYAKXy1/dkCH0H5+l9TRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425671; c=relaxed/simple;
	bh=2U6Ww/ElEtbcuJBm40iFuywuFkm2IwWESN+oydX5p7Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=F5zLtFRPIKBHzS+Nfwsz31R0D3F+SOtVA+5FygdzJNyEVAT8+v0qJDasaxsJLtUA4NJ9BoilPuaYGtJUpV4edVU6leWTevmQkxl/DQFUhNqhmzfPbopJ1E8k+KaX5IZ0iMOMIAd1xrWW+MrNOTIoZA6iRa54ViFhSJ6iurQ1Oys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=woEGFp09; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717425650; x=1718030450; i=markus.elfring@web.de;
	bh=XqqTZCHeurhCB0Bc08xb2KzKAyoPa4GFLU41PH/vPdI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=woEGFp09PCwgXGAMEzPTw+Cz0/Aj5cLxNm6cadtTL9/dij9S2cOtDPu4p7uMm4jO
	 NqFupNEEKhdSR7ZwDTKr74igMx47+hfBMIRHVoksFeQr6hrIXCDoHZ6BrLyh1Zz/H
	 NG6vuC/dDf/FumDgKDbu+ysWubtGaG/4t4jq82IlrV9QmDZgNe6WGLF+usuCY1l7E
	 mmVqgWHua1WXeSPANkWLynrNA5+/KUfl2GpZ3Z3JL7QitUCExsM5T+/w1KCC5cPTM
	 VYwmFuTiexes31cPXeTSYHxU6HJ1S1rkc/3CEHSR0OVdWepkoNGMw0w+wmPu2p3Zb
	 YZrTIyUs6WbGmPlk6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8n08-1sZOlQ1psU-00rc9C; Mon, 03
 Jun 2024 16:40:50 +0200
Message-ID: <b828257d-5c69-4ff5-89e1-5d2aaf53a5e4@web.de>
Date: Mon, 3 Jun 2024 16:40:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: tip-bot2@linutronix.de, Hagar Hemdan <hagarhem@amazon.com>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <171741750653.10875.4371546608500601999.tip-bot2@tip-bot2>
Subject: Re: [tip: irq/urgent] irqchip/gic-v3-its: Fix potential race
 condition in its_vlpi_prop_update()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <171741750653.10875.4371546608500601999.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:75B7HC4z0qk4z/+G1CLRcW84vk0vRFTpabSPUpMkGPpEA52xMq9
 KOTSeRNEuNWDKOoqn+J19rvF4ju1yHxR6oGe/q+1PiUypyW/zmA/rpD1jz20WBMSEPzMWHj
 udWy1udL2vDhU5K3Qo4bHLYTM0/ILf/+Aq0+NvJXJseN/7bYAagu2K5Gts4HIS6MKZKXZ7J
 yc/zDavEv6TjitELi7AMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/PJWt2+d6UY=;8WOA5ctY9ICUVRL4jFoyBeHk3iw
 iU5ZxuYx2k5hP5i4LXBu1lwgCtUy8OJ0UvNtZUl3AuZB3REfcd1nmNVGxmktbhEptqEpSw95H
 n4yQeQDD3ppwydsi+TjW/pangjZlaXwSFvdeHA0FtdhvsRn7PIrqMTJtrEeGSdsr/57FWoTzT
 IiYGZMB+nU6WihWc/nHPrPIZDQ7ZhMbSFe86AG1H64ux2d2k6Mn5Z+Kxsk9l4DSStDI2x+Hs6
 u0/JtaA7I6bX6LtgETtxtym1PNOSTVyzJgXQuNP1KjeGRzapbyMhIWAmRAAxvy5Gwa/tBDUSm
 t5k9iTylaBho2RmcPKfI/VHlJ8HpiNycE2Ub/5iqdQSf1lCq/aX+8nbY54PXr8LGTMAof2zOF
 jrOmplV3cn4gjviHx+ZOHl274T/Kt7j9bv4FI/yG4Kt1VbhjasY4lf+cD2LFv1E+H0vs6w5gP
 yk6vZxvIdJBmOlqlFHOvyhblu9Qnn6qPl4Fe6U3UnpAGo1/rt1BYwxxneIzYUdnZmRMj4JNws
 FD/DFa6Kes4evCRWW1+LiDfy7odiqFV4MDCnQL/1y1xcjfQQLeYP1pSW9Krf0XZksa522YWE/
 Ij7Rru+IKQ8Enlms2vUNXMN6vw+zutjKGBQr0/j+LmfjgEV6gbl82Uf/CEj9iutj98d6y9zG7
 Dy8Wx7F5VZ65j+cRTqiA9a+QcBUyGUN1Y7CfNeCcqhijdJG1hyLytKCqVC/Qai5gsBD+6Hcqg
 GwkWOFVd2YLeSKVEPiQX6w+ZwmCJn9LUHeKpOSYw7wWlk6fLV3NFr7lg9G3XjLdd99Up4dYuk
 583uZT04GkYIBK6mTYGFWOaTn6RgCCC1rYMNTJ2bJwdyg=

=E2=80=A6
> [ tglx: Use guard() instead of goto ]
=E2=80=A6
> +++ b/drivers/irqchip/irq-gic-v3-its.c
=E2=80=A6
> @@ -1992,6 +1970,8 @@ static int its_irq_set_vcpu_affinity(struct irq_da=
ta *d, void *vcpu_info)
>  	if (!is_v4(its_dev->its))
>  		return -EINVAL;
>
> +	guard(raw_spinlock_irq, &its_dev->event_map.vlpi_lock);
> +
>  	/* Unmap request? */
>  	if (!info)
>  		return its_vlpi_unmap(d);

I found a similar guard() call in the implementation of the function =E2=
=80=9Ctask_state_match=E2=80=9D.
https://elixir.bootlin.com/linux/v6.10-rc2/source/kernel/sched/core.c#L226=
4

A slightly different combination of parentheses is applied there.
How do you think about to apply the following code variant accordingly?

+	guard(raw_spinlock_irq)(&its_dev->event_map.vlpi_lock);


Regards,
Markus

