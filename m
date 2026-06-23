Return-Path: <stable+bounces-268020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4cnMEzLoOmqqKwgAu9opvQ
	(envelope-from <stable+bounces-268020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:10:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7376B9DCB
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:10:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=asEztcvP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268020-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268020-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39CF4303CFB4
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58F3395AED;
	Tue, 23 Jun 2026 20:10:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E5311C38;
	Tue, 23 Jun 2026 20:10:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245421; cv=none; b=TM3DzsWTNL+2dMiogvVn4GxA4ASXMFv2qfH1hzwqdlcIQ5rzVVtoJ5WedYdvO7DKUtw2/4aPqZ0pHKuPumUtq1C3/F7mQLshFeNa3GXwPUjFTJ9g8v1QzMu1LlAI0JZ724XYJhlKPvDK7Er74hsav+ObJZlRyMECpPD0oEtWm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245421; c=relaxed/simple;
	bh=Nt3A2NFe2hgxN+mXwP/5LU9r32AXsdxR1NzGfIsWQSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVzsIhN8qMyIj3MwvqmY3NuG9muoOp0eOxv+pSoblVbsdh2Odowa3OGLR1xYn3NmOUrZI1hICe/UHC08raGmu72yNs+YXTPmiYBzVZgEXt5lSWQGPZ2INDHbKAEPQL/6EU7d/YyBVtHMxtNkmCmP5nkAW2lTPCH+dAc2x8vlYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asEztcvP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1071F000E9;
	Tue, 23 Jun 2026 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782245420;
	bh=8TrQZE9vH39dIRDw32V4DNDUUodeQOx70heLgohi/mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=asEztcvPQ0Qf1LSCraHYg3M2kMxixqmxcDmg7KxK4v9lajXjJ7NiSl+hkqIlYTIqF
	 QuNpna1+Hpu92/DLFRuk5Fc/Y8fRH4s5Yy1v+n6GLoDgEjycRjTrPiCwJqbTRrWM6z
	 h8O3pSBLK7EE+rdh0OgE3Wm0J8Ca7iLPnaQX4zVGtnf9nkbKpFkyo5oF3SdCvSGVaO
	 /a0owvNBzJ6tOB1esP/TbrU0HrTDVDidVJNdOz09qbt1nw5BHBgjOrEhRZv9wZCU/k
	 1NjfCzKtHhlREKUcVXwgGX41rxC4GJdUwv2SiXbuij/Fn4Iy0980+aKiVwGtQy3a0Y
	 XYuP7M3bcNMqQ==
Date: Tue, 23 Jun 2026 22:10:16 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, s.hauer@pengutronix.de, 
	festevam@gmail.com, carlos.song@nxp.com, haibo.chen@nxp.com, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] i2c: imx: mark I2C adapter when hardware is powered
 down
Message-ID: <ajrn2kvH_MelCv4Q@zenone.zhora.eu>
References: <20260525030400.3182911-1-carlos.song@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525030400.3182911-1-carlos.song@oss.nxp.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268020-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:carlos.song@oss.nxp.com,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:carlos.song@nxp.com,m:haibo.chen@nxp.com,m:linux-i2c@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[i.mx:server fail,vger.kernel.org:server fail,nxp.com:server fail,sto.lore.kernel.org:server fail,zenone.zhora.eu:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC7376B9DCB

Hi Oleksij,

Any chance you can give this a review?

Thanks,
Andi

On Mon, May 25, 2026 at 11:04:00AM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> On some i.MX platforms, certain I2C client drivers keep a periodic
> workqueue which continues to trigger I2C transfers.
> 
> During system suspend/resume, there exists a time window between:
>   - suspend_noirq and the system entering suspend
>   - the system starting to resume and resume_noirq
> 
> In this window, the I2C controller resources such as clock and pinctrl
> may already be disabled or not yet restored.
> 
> If a workqueue triggers an I2C transfer in this period, the driver
> attempts to access I2C registers while the hardware resources are
> unavailable, which may lead to system hang.
> 
> Mark the I2C adapter as suspended during noirq suspend and block new
> transfers until resume, ensuring that I2C transfers are only issued
> when hardware resources are available.
> 
> Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> Change for v5:
>   - Remake commit log including the issue detail from Mukesh's
>     suggestion.
> Change for v4:
>   - Restore hrtimer when pm_runtime_force_suspend failed when slave mode
>     enabled.
> Change for v3:
>   - Add hrtimer_cancel in i2c_imx_suspend_noirq to cancel slave_timer for
>     safe suspend in i2c slave mode.
> Change for v2:
>   - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
>     to prevent potential deadlock if a transfer is active during suspend.
>   - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
>     fails.
> ---
>  drivers/i2c/busses/i2c-imx.c | 45 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 28313d0fad37..73317ddd5f02 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1922,6 +1922,47 @@ static int i2c_imx_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int __maybe_unused i2c_imx_suspend_noirq(struct device *dev)
> +{
> +	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	i2c_mark_adapter_suspended(&i2c_imx->adapter);
> +
> +	/*
> +	 * Cancel the slave timer before powering down to prevent
> +	 * i2c_imx_slave_timeout() from accessing hardware registers
> +	 * while the clock is disabled.
> +	 */
> +	hrtimer_cancel(&i2c_imx->slave_timer);
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		i2c_mark_adapter_resumed(&i2c_imx->adapter);
> +		if (i2c_imx->slave) {
> +			hrtimer_forward_now(&i2c_imx->slave_timer, I2C_IMX_CHECK_DELAY);
> +			hrtimer_restart(&i2c_imx->slave_timer);
> +		}
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused i2c_imx_resume_noirq(struct device *dev)
> +{
> +	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	i2c_mark_adapter_resumed(&i2c_imx->adapter);
> +
> +	return 0;
> +}
> +
>  static int i2c_imx_suspend(struct device *dev)
>  {
>  	/*
> @@ -1955,8 +1996,8 @@ static int i2c_imx_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops i2c_imx_pm_ops = {
> -	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				  pm_runtime_force_resume)
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend_noirq,
> +				  i2c_imx_resume_noirq)
>  	SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend, i2c_imx_resume)
>  	RUNTIME_PM_OPS(i2c_imx_runtime_suspend, i2c_imx_runtime_resume, NULL)
>  };
> -- 
> 2.43.0
> 

