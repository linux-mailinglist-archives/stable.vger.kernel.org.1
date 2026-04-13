Return-Path: <stable+bounces-235969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMKiLKGz3GkDVgkAu9opvQ
	(envelope-from <stable+bounces-235969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:13:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 078853E9A8C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B07309064E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB93AE6E4;
	Mon, 13 Apr 2026 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLkJz5Pv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25533ACA73;
	Mon, 13 Apr 2026 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071087; cv=none; b=UXr9YapYExB0fffoNpDHwScmF2jMs7mP0IVZBo/9UOEm8yu8AqmEaIAHGN2Au0VMHC8ZOnUBacTHJvVIW5ftzezCDa2dgohaa4N1zxSPayXPfP+RPVQKNe4AiJmHLq0iXrpY2o4qBGd2BTEg+6olOvh6TEm5VE6I9Tbr5y/lpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071087; c=relaxed/simple;
	bh=ieqWHT3G4mAydQXwC4mz93Dc2fb1m1LZ29zaokKesto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQhGxZVqDD2+8wLvkMcYnj047W8KE/q07kZyWt0PU2OKp3VzMAtf554GpZOwagMphyA6MMB/KuY91BLUnOCAlmgZB/u1lC3LN5Lpoa8mZPrCC9J3JxK9URbaYtX4wl+EErYesb0fyomXaKvdXu1y3oQYw+5qpai6bwYv3PX7qXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLkJz5Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69362C2BCAF;
	Mon, 13 Apr 2026 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776071087;
	bh=ieqWHT3G4mAydQXwC4mz93Dc2fb1m1LZ29zaokKesto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QLkJz5PvmvfSMu5TaJt+KDY3xInepPWCvP0j27Sclh58OgV+0MgihS/AgnK1h79Ei
	 KD00VwRhkRVBt4yzxHUWeptjJXKOlZGXhRX3dYLV/kS7pqNQTifKaP/vfN2uhoY2n8
	 obt3eIgsFeg/8Z0a5pZBV2qHQ1bWcXluJ0pdxDSyc3sn/VrtTgCESpiQWtwodv7nfI
	 1qYyGMMiT8+nSJhMV4ILWwOz3bey8Bq/5P8Mytb/FkWZ79YhIi5UNSLx9DvOrDG9UD
	 I5Ai//FOkMmQYgcB+BOoBBQBZG8ImoooTLPUdzZU6p/G9fdlUPNhFNcTV4MqaM6M9X
	 10GfXiGbKZaxQ==
Message-ID: <d0d422ed-5ff2-4523-b145-573146902c9d@kernel.org>
Date: Mon, 13 Apr 2026 11:04:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Add backlight=native quirk for Dell OptiPlex
 7770 AIO
To: =?UTF-8?Q?Jan_Sch=C3=A4r?= <jan@jschaer.ch>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 stable@vger.kernel.org
References: <20260411092606.47925-1-jan@jschaer.ch>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260411092606.47925-1-jan@jschaer.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235969-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 078853E9A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 11-Apr-26 11:26 AM, Jan Schär wrote:
> The Dell OptiPlex 7770 AIO needs the same quirk as the 7760 AIO. The
> backlight can be controlled with the native controller, intel_backlight,
> but not with dell_uart_backlight.
> 
> I dumped the DSDT using acpidump, acpixtract and iasl, and confirmed
> that it contains the DELL0501 device. When loading the
> dell_uart_backlight driver with `rmmod dell_uart_backlight`, `modprobe
> dell_uart_backlight dyndbg`, it reports "Firmware version: GL_Re_V18".
> 
> Fixes: cd8e468efb4f ("ACPI: video: Add Dell UART backlight controller detection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Schär <jan@jschaer.ch>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 4cf74f173c78..4a2132ae28b4 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -878,6 +878,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7760 AIO"),
>  		},
>  	},
> +	{
> +	 .callback = video_detect_force_native,
> +	 /* Dell OptiPlex 7770 AIO */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
> +		},
> +	},
>  
>  	/*
>  	 * Models which have nvidia-ec-wmi support, but should not use it.
> 
> base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2


