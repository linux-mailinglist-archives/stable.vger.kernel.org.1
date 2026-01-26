Return-Path: <stable+bounces-211550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Dd7O4dLd2msdwEAu9opvQ
	(envelope-from <stable+bounces-211550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:09:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D48781C
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8F53011F12
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB574330652;
	Mon, 26 Jan 2026 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMtYhU1y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4E32E69F
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425794; cv=none; b=XoQnB21At+yngJYhap9Qx/toIuyZzCmSSdSy8BBQ43TSUaUWIMYY/v/0dl006v0DBPNmJEe7Hmu7xQuTKbh8JHZFIsavIaVesiyJHJDe8hZG4LxH30P7tAveKoVPn9eTAei9Wg4JJ4ve6Y1coO4U3+fdZdGfcJwCu50HEHE2GuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425794; c=relaxed/simple;
	bh=wnDE18O74ACewEOtUkx+g9r1voInFTXWt7R3KDeFlXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdyJuDi29PuZ7IXqPzxazO87BdkDNU4JQnOxELJUqnItZqA0cYc6at/hZ6K801Iv7VmgxnGSt/DULYHnKYsYgyygj/Tw9S8McPA+unvZboKHtWkFJbZvkPPS0gk7FUD8mRaRHN0l583Olr3/peYPOGa8bfADp53A7zSQ+4Nqf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IMtYhU1y; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-653780e9eb3so6058433a12.1
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 03:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769425791; x=1770030591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJSwaR8/pakjmTGUa2nM+85GhOFT/jolBH1/QHEYD/M=;
        b=IMtYhU1ygWzzHBxFJbHl37I7PfYvIhSoC2u+GPazX8OFXW7jmISaJAj2YwiTJw2OPF
         uB1N6CQe1dHVeYnJNUWA0Ty0nf5xqQEyjNFMKUSSkDWkGIlIfgp5VTVnuhuuZdhnpiN0
         dPw2pWDUGP2DH4Q4to7XO+KEQq/doKIKXID2s2Q3YbqVgwFQJFDBeUPtFAmaDgP60MZ3
         ImJqrkOZnmjxz2vGpCysP0t3W+64iWT8wR2CmF1fuUetDMRumVb49Cja5T8PZ4h/VZZ0
         3gxxWx8cJ1CG7NnQkjD88YyPZqFNxdcBR7TtJhQJwL9W3ATwoxUovBe5YSOgDPbm4mf2
         KcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769425791; x=1770030591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJSwaR8/pakjmTGUa2nM+85GhOFT/jolBH1/QHEYD/M=;
        b=GmQeZEQ24lS0X7WEqLAtS6wsppF1i/CtyZsMbQcY/3+BZeJ1PhH3fFWfyivNolR5j3
         NyqHKEQ3x57jHyF+lZY5SkhXJGmSotYdVxZDC05beFdY2T1gdAHI2tlHR9cLPDQ8nfck
         FRwkZaO14G11n0YKM+XhOByUe6StvSulFKXcqSfVlPKYdXWYuR4S5PtIFgeANTHlus5X
         FsmeqytwqhQ3iSBQKz/71hVJSRqmWYBeyQFQeWiB72y2wT+WVoV7z1BZ6hAHnHwBPT59
         zvPRsDvKmKPPFeynD6zWKG9GZ9YZGXZ3Y0Y3UAkOokxGvxRPplTuwUgydlMMghPGN2TI
         2aUg==
X-Forwarded-Encrypted: i=1; AJvYcCXS9MzeTgPCyNFraWSS+FxcdoLfOw6oUesgUioxcRGCBE2Lb0W98gv37ZwB7SgkOHZJVbCJwyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53tlVKl2vWnqXNLX9On2dOoLM515/3jUaPcWk+f9udDyXhvzI
	fVQhMJ9RGsoFJhSdCnRz/+n6dyGUtMgtTcNBdacoC6p96fx4Qg5ltn3+riqbYXAibsw=
X-Gm-Gg: AZuq6aKvpqKTEH+U4gz3RmcMpJ3gjU7QuJ2/t918y4mUKibGGuTwBljp0NoNt3B+Ppw
	gxOg/M/Nzrdf2BX+n9g3czxjyJ1OW/0QKvq0kOf19U5mh9hfpP6AaPFS6lIvlpmwFuYQZimlXln
	RnxD3Z5q8yh5A+xDpryrG2Y/Yvn/O9Np/7pYZzR85F6FelrRS83fN9VcsmlHYQYU+6UYjbEeIua
	Dm3Ude2eN/1ZpClAC5t8Ks7Eqoz1UpBxyRzEPl6WpyPCXPNk3S8nNUXuuHEYWy1zo2T1Hqr7jh3
	Q5Nr9S4Ht5korTDQefyI/79CaLGwixgbwpD5zzTblKmnBQZX7afOGo+raEhT5KPziU+j+hFBrNe
	svaumn/UhBKGwUb/h+9DFdEMeYZvy03TxPpnxSdjP6Nn/pvKHcfOGGoQlufEPxyY9mfYwMTw8Fb
	r6Kqpx+AMtnoRcS38b21yX+4dZ85U4CUcMRDvMijlbS+2iA3Xf5tHhNRch7d6xKzE=
X-Received: by 2002:a17:907:9708:b0:b87:19af:3e4d with SMTP id a640c23a62f3a-b8d20a1c891mr268108966b.22.1769425790919;
        Mon, 26 Jan 2026 03:09:50 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b7d7ceasm644286966b.65.2026.01.26.03.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 03:09:50 -0800 (PST)
Message-ID: <ef6cf6c5-3b5d-45f2-af67-0567262a4561@linaro.org>
Date: Mon, 26 Jan 2026 11:09:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] media: i2c: ov02c10: Keep power on and use reset
 for power management
To: Saikiran <bjsaikiran@gmail.com>, linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bod@kernel.org, rfoss@kernel.org,
 todor.too@gmail.com, vladimir.zapolskiy@linaro.org, hansg@kernel.org,
 sakari.ailus@linux.intel.com, mchehab@kernel.org, stable@vger.kernel.org
References: <20260125171745.484806-1-bjsaikiran@gmail.com>
 <20260126061528.63785-1-bjsaikiran@gmail.com>
 <20260126061528.63785-2-bjsaikiran@gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260126061528.63785-2-bjsaikiran@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211550-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan.odonoghue@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 5B6D48781C
X-Rspamd-Action: no action

On 26/01/2026 06:15, Saikiran wrote:
> The OV02C10 sensor was experiencing brownout conditions during rapid
> power cycles (e.g., browser WebRTC permission checks) on Qualcomm
> platforms, causing the sensor to lock up and require a system reboot.
> 
> Root cause:
> The Qualcomm RPMh regulator driver does not support active discharge,
> requiring regulators to passively discharge via leakage current. This
> takes 2+ seconds on X1E80100 platforms. Without complete voltage
> discharge, the sensor's internal microcontroller does not fully reset,
> leading to I2C timeouts and a locked state.

Where do you get this conclusion from ?

Are you inferring it from what you see on the platform or can you point 
to some known data-source for this ?

2 seconds to discharge ? These regulators are PM8010 anyway - so you're 
saying the PMIC takes two seconds to discharge ?

> Solution:
> Instead of power cycling the regulators, keep them continuously enabled
> and use reset signals to control the sensor state:

If this is really a problem with the regulators and I don't think we 
have established that - then it is a fix that needs to go into the 
regulators.

Did you try out the suggested fix I gave you yesterday ?

The options are:

1. Make power_on/power_off be more consistent with the data-sheet.
    This I'd guess 99% certain what is going wrong for you or

2. If we really can establish and show a two second discharge delay
    then bring the required delay into the RPMh code so that
    regulator_bulk_disable(); is atomic from the perspective of the
    caller.

I honestly can't imagine two seconds is a real thing here but, if it is, 
then the thing that needs to change is the regulator driver to account 
for that long delay not the users of the regulators.
> - power_off(): Assert hardware reset GPIO (keep regulators/clock ON)
> - power_on(): Release hardware reset + trigger software reset via
>    register 0x0103 (standard OmniVision software reset)
> 
> This approach:
> - Eliminates the 2+ second discharge delay
> - Enables instant camera reopening (~17ms vs 2.3s)
> - Properly resets the sensor state machine via reset signals
> - Maintains correct power sequencing on first initialization
> - Follows OmniVision sensor conventions (0x0103 software reset)
> 
> The first power-on still performs full regulator and clock
> initialization. Subsequent power cycles only toggle reset signals,
> avoiding the discharge delay entirely.
> 
> Tested on Lenovo Yoga Slim 7x (X1E80100) with rapid camera open/close
> cycles - no brownouts or lockups observed.
> 
> Fixes: 44f89010dae0 ("media: i2c: add OmniVision OV02C10 sensor driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>   drivers/media/i2c/ov02c10.c | 119 +++++++++++++++++++++---------------
>   1 file changed, 69 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
> index 7e9454e8540c..08d268de60ec 100644
> --- a/drivers/media/i2c/ov02c10.c
> +++ b/drivers/media/i2c/ov02c10.c
> @@ -22,6 +22,8 @@
>   #define OV02C10_CHIP_ID			0x5602
>   
>   #define OV02C10_REG_STREAM_CONTROL	CCI_REG8(0x0100)
> +#define OV02C10_REG_SOFTWARE_RESET	CCI_REG8(0x0103)
> +#define OV02C10_SOFTWARE_RESET_TRIGGER	0x01
>   
>   #define OV02C10_REG_HTS			CCI_REG16(0x380c)
>   
> @@ -390,8 +392,8 @@ struct ov02c10 {
>   	u32 link_freq_index;
>   	u8 mipi_lanes;
>   
> -	/* Power cycling rate limit */
> -	ktime_t last_power_off;
> +	/* Power management: track if regulators are enabled */
> +	bool powered;
>   };
>   
>   static inline struct ov02c10 *to_ov02c10(struct v4l2_subdev *subdev)
> @@ -680,25 +682,16 @@ static int ov02c10_power_off(struct device *dev)
>   	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>   	struct ov02c10 *ov02c10 = to_ov02c10(sd);
>   
> -	/* 1. Assert Reset */
> -	gpiod_set_value_cansleep(ov02c10->reset, 1);
> -
> -	/* 2. Disable Clock (Stop sensor state machine) */
> -	clk_disable_unprepare(ov02c10->img_clk);
> -	usleep_range(1000, 1500);
> -
> -	/* 3. Disable Power */
> -	regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
> -			       ov02c10->supplies);
> -
>   	/*
> -	 * 4. Discharge Wait
> -	 * Wait for regulators to fully discharge before returning.
> -	 * This delay ensures clean power cycling.
> +	 * Keep regulators and clock ON to avoid discharge delay.
> +	 * Just assert hardware reset to put sensor in reset state.
> +	 * This allows instant power-on without waiting for regulator discharge.
>   	 */
> -	usleep_range(50000, 55000);
> +	if (ov02c10->reset)
> +		gpiod_set_value_cansleep(ov02c10->reset, 1);
>   
> -	ov02c10->last_power_off = ktime_get();
> +	/* Keep clock running - sensor needs it for software reset */
> +	/* Keep regulators enabled - avoids 2.3s discharge delay */
>   
>   	return 0;
>   }
> @@ -708,50 +701,63 @@ static int ov02c10_power_on(struct device *dev)
>   	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>   	struct ov02c10 *ov02c10 = to_ov02c10(sd);
>   	int ret;
> -	s64 delta_us;
>   
>   	/*
> -	 * Mandatory Cool-Down:
> -	 * If the camera was powered off within the last 3 seconds, ensure at least
> -	 * 2 seconds have elapsed to allow full regulator discharge and sensor reset.
> -	 * This prevents brownouts during rapid open/close/open sequences.
> +	 * On first power-on, do full initialization.
> +	 * On subsequent power-ons, regulators/clock are already on,
> +	 * so we just need to release reset and do software reset.
>   	 */
> -	delta_us = ktime_us_delta(ktime_get(), ov02c10->last_power_off);
> -	if (delta_us < 3000000) {
> -		dev_dbg(dev, "Enforcing %lld us cool-down period\n", 2000000 - delta_us);
> -		fsleep(2000000 - delta_us);
> +	if (!ov02c10->powered) {
> +		/* First time: enable everything */
> +		if (ov02c10->reset) {
> +			gpiod_set_value_cansleep(ov02c10->reset, 1);
> +			usleep_range(2000, 2200);
> +		}
> +
> +		ret = clk_prepare_enable(ov02c10->img_clk);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable imaging clock: %d", ret);
> +			return ret;
> +		}
> +
> +		usleep_range(2000, 2200);
> +
> +		ret = regulator_bulk_enable(ARRAY_SIZE(ov02c10_supply_names),
> +					    ov02c10->supplies);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable regulators: %d", ret);
> +			clk_disable_unprepare(ov02c10->img_clk);
> +			return ret;
> +		}
> +
> +		ov02c10->powered = true;
>   	}
>   
> -	/*
> -	 * Standard Power-Up Sequence:
> -	 * 1. Enable Regulators
> -	 * 2. Enable Clock
> -	 * 3. Release Reset (with ample boot time)
> -	 */
> -
> -	ret = regulator_bulk_enable(ARRAY_SIZE(ov02c10_supply_names),
> -				    ov02c10->supplies);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to enable regulators: %d", ret);
> -		return ret;
> +	/* Release hardware reset */
> +	if (ov02c10->reset) {
> +		/* Ensure reset was asserted for at least 2ms */
> +		usleep_range(2000, 2200);
> +		gpiod_set_value_cansleep(ov02c10->reset, 0);
> +		/*
> +		 * Wait for sensor microcontroller to stabilize after reset release.
> +		 * 50ms prevents black frames during rapid power cycling by ensuring
> +		 * the sensor's internal state machine is fully initialized before
> +		 * software reset and register configuration.
> +		 */
> +		msleep(50);
>   	}
>   
> -	ret = clk_prepare_enable(ov02c10->img_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to enable imaging clock: %d", ret);
> -		regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
> -				       ov02c10->supplies);
> +	/* Perform software reset to ensure clean state */
> +	ret = cci_write(ov02c10->regmap, OV02C10_REG_SOFTWARE_RESET,
> +			OV02C10_SOFTWARE_RESET_TRIGGER, NULL);
> +	if (ret) {
> +		dev_err(dev, "failed to send software reset: %d", ret);
>   		return ret;
>   	}
>   
> -	/* Wait for power/clock to stabilize */
> +	/* Wait for software reset to complete */
>   	usleep_range(5000, 5500);
>   
> -	if (ov02c10->reset) {
> -		gpiod_set_value_cansleep(ov02c10->reset, 0);
> -		usleep_range(80000, 85000);
> -	}
> -
>   	return 0;
>   }
>   
> @@ -924,6 +930,19 @@ static void ov02c10_remove(struct i2c_client *client)
>   		ov02c10_power_off(ov02c10->dev);
>   		pm_runtime_set_suspended(ov02c10->dev);
>   	}
> +
> +	/* Clean up regulators/clock if still enabled */
> +	if (ov02c10->powered) {
> +		/* Assert reset before disabling power for clean shutdown */
> +		if (ov02c10->reset)
> +			gpiod_set_value_cansleep(ov02c10->reset, 1);
> +
> +		clk_disable_unprepare(ov02c10->img_clk);
> +		regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
> +				       ov02c10->supplies);
> +		ov02c10->powered = false;
> +	}
> +
>   	v4l2_subdev_cleanup(sd);
>   	media_entity_cleanup(&sd->entity);
>   	v4l2_ctrl_handler_free(sd->ctrl_handler);


