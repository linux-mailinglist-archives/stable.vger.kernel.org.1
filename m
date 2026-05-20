Return-Path: <stable+bounces-249975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /VBVHr3NDWoF3gUAu9opvQ
	(envelope-from <stable+bounces-249975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:05:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55E590793
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04AEA321CAC0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17CA3ECBD8;
	Wed, 20 May 2026 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f98UF8sS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20863DCD9D
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288145; cv=none; b=RR+GarkgtJHR4RxpJMZVPIhLTWBgVuY/D6c83dexC7dzsUcdpAsXUBwjojwdoDHDrhRPfgLaFxtqa2KFGvndzhhxcRREyPShF3yaZdg4ZbtHzQAdtq7eCkQjuZz5DjbrXydOH9CzZL7y77W1dih4rY7Xq0TjIMvf6ynQFANt32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288145; c=relaxed/simple;
	bh=yWZvIL+ViufOig3Sc5+axdwyoyP4wX+AOeYG7YbHiyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJmaq97pkuF5gmSxEXlzqfiD8pMrLkCx1msz5JhBpHkwZhiBi611uj7HKD7LfjNYC+806pQCL0Y+J81lH8epfh5g4Mveyka0HBQ9IuWCzEoBNzzWGZ9jeoYdGXdYOZOIUTIsOCqPxKNmqZqA3nkT6VNmG54322uXZr5ac5KUaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f98UF8sS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48d146705b4so55006895e9.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779288142; x=1779892942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usJ38430MjuWmc7xeBXCbfLGPtT8LL3NOyxym8359x0=;
        b=f98UF8sS/NyOE7uz2u6elAjnIqE3ckWT9gLOMSrLk98NGnyz1KAiZGa7HtpkZm/ta2
         /rpxNaMnd+sHngf7kdsiDMHSaSxMUtul4vPxcQZn12yF2qcFz63Nry9Bz9emYXINuJkf
         mN2ZsSPCXiKf9IJCQi6CThQDPgyczLyK1r+HewXeLyZU5WVnfS0fULwbGqr9iQfJL0zG
         8NzpaMFi1P0A7sgL6LGMk4b8vcGB0EIAkLzoiqQ8p40YVLMxvt+llheNBMKeLx6wym/z
         aOr2+DEADEMikEPuNY9zVOIP+kBQ/7ljMOtMfmw1sr972AgsSRQd8PZd4lGZNiApmvSr
         7zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288142; x=1779892942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usJ38430MjuWmc7xeBXCbfLGPtT8LL3NOyxym8359x0=;
        b=AvUPLQefN8HhYwZf48HwEiyltEtkUqwFDvtsl/GcVadR2zFk9yS6rPH9tvq0DQrujt
         TKCeySZA8EpRTvDIb1Iwk6PGqCfDUgMtEhAjkAGXColdEihGP6p+eXPmMKJGRRnqI53z
         ASiaRqWlzFh++m/EqjmfuFo03w9KzkS/JFn9py3Zq5cgCRS6jX9ualLCWELfy7AE/xWP
         wysxVTlunUPyDqLUbqbg1EByYrfDU6YeFaj4f56F9MPfcWrXCm2TAZdwtndsTUWLoRXq
         bAqBBSNbCuHlOH2TmpczbDK26ntZ5vRqFYqrtFTy2KQyYgOE+jNrPuPn4YO6F4L7nyUm
         orXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9f48ppeVCiktQ8kd075F1mlStsrDuhNdQyjwEbmG/bkiLiihMaOwdV9zwSVGs+bA5jG4N6MUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+viOCyv59JhWdJiMCOi4UL2PDFlIPdxCiDh0uMgS/rHLCBQXM
	WqGUiszSm3YPC2/6jiN7+Z1JCLIdztCApZSy/6isAiB7zFGW8Tg2gyaK
X-Gm-Gg: Acq92OFMyc2LUpBKoHnwYzZ8BNlrlGClIY6nkXgoHmcwFUq6sZcOcTIWVru69zJHpaI
	rDdQ8OZrHUcglwbPU67jQMveedFHxjkTaAV2277NsAQF1AeiETCn/1QeJReAf/sZgxgert84rcX
	CHsuFxcW7DyAE6Tk6x6AJqVpEhwVMLXVo24R3m+hE9RRu7pQ7QAlwUxroNme0mKMNAu6CyWd2kM
	PvI2VvBWgHbV1NFBoGmx/KfUz1p5mHqVxLlF7biIKRSRQvbK//bH4mNQkkWqLlKwc/E+VIxuzPM
	Glvs9h2dM4WNf28nGKZ3DJPRleLOB5P1faS+XCN8jAzxh436eQk6iYpQplTPQ7Bu8bN7z7BcwqR
	gf+fOf/oJ1OekdpuhC+PAFy/ic8mLGu2kw4urTi8NC1n26tOkb3o5a53oDZ4KGbJOQG1PPZvei7
	ZhIQsDSEanOqq351gX7VDusb9Opd8IW/iLN9geP1x1ABp8f26rvExH+Jdd6kBJrqpO
X-Received: by 2002:a05:600c:858d:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48fe66129efmr250763065e9.27.1779288141940;
        Wed, 20 May 2026 07:42:21 -0700 (PDT)
Received: from [192.168.2.178] (109-252-156-195.dynamic.spd-mgts.ru. [109.252.156.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaa2949asm196145965e9.1.2026.05.20.07.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 07:42:21 -0700 (PDT)
Message-ID: <c8d16352-63a3-4512-b90c-a79e7e96dd3c@gmail.com>
Date: Wed, 20 May 2026 17:42:19 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: max77620: Avoid regmap mutex deadlock in power-off
 handler
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
Content-Language: en-US
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249975-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[digetx@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ulisboa.pt:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0A55E590793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

20.05.2026 17:28, Diogo Ivo пишет:
> max77620_pm_power_off() is called via the sys-off framework as a
> SYS_OFF_MODE_POWER_OFF handler, which runs in an atomic notifier chain
> with IRQs disabled after smp_send_stop(). regmap_update_bits() acquires
> the regmap mutex in this path; if another CPU held that mutex when it
> was stopped, the power-off sequence deadlocks.
> 
> Replace regmap_update_bits() with i2c_smbus_write_byte_data(), which
> bypasses the regmap lock entirely. The I2C core detects the atomic
> context via i2c_in_atomic_xfer_mode() and uses i2c_trylock_bus() rather
> than a blocking acquisition, avoiding the deadlock.
> 
> Tested on Pixel C, powers off correctly.
> 
> Assisted-by: Claude:claude-sonnet-4-6
> Fixes: 744b13107d0d ("mfd: max77620: Provide system power-off functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> ---
> This patch was tested on a local branch that sets pm_power_off =
> max77620_pm_power_off() unconditionally so that the function runs.
> I haven't checked whether the other bits in ONOFFCNFG1 are safe to
> discard at power-off time as I don't have access to the datasheet.
> If someone with access to the datasheet confirms they're not I'll
> respin the patch taking that into account.
> ---
>  drivers/mfd/max77620.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> index 3af2974b3023..8c768968a317 100644
> --- a/drivers/mfd/max77620.c
> +++ b/drivers/mfd/max77620.c
> @@ -487,10 +487,14 @@ static int max77620_read_es_version(struct max77620_chip *chip)
>  static void max77620_pm_power_off(void)
>  {
>  	struct max77620_chip *chip = max77620_scratch;
> +	struct i2c_client *client = to_i2c_client(chip->dev);
>  
> -	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
> -			   MAX77620_ONOFFCNFG1_SFT_RST,
> -			   MAX77620_ONOFFCNFG1_SFT_RST);
> +	/*
> +	 * Atomic context: IRQs disabled. Use raw I2C write, bypassing
> +	 * regmap locking entirely.
> +	 */
> +	i2c_smbus_write_byte_data(client, MAX77620_REG_ONOFFCNFG1,
> +				  MAX77620_ONOFFCNFG1_SFT_RST);
>  }
>  
>  static int max77620_probe(struct i2c_client *client)
> 
> ---
> base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87
> change-id: 20260520-max77620_poweroff-08e39429835f
> 
> Best regards,
> --  
> Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

Kernel parks secondary CPUs before powering off system, hence there
shouldn't be a locking contention.

Have you checked whether regmap_write_bits() works?

