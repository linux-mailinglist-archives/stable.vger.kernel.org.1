Return-Path: <stable+bounces-233590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE+1CEr71GmgzQcAu9opvQ
	(envelope-from <stable+bounces-233590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:40:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 760AE3AE87B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D851B3100433
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80213B2FE1;
	Tue,  7 Apr 2026 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF2nORHV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1303B38B0
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565327; cv=none; b=GSB4BU1pBzpHsFXlXc+M8RnwV4KrA9GiLdltrN86tlseAvzC9EYqs/ubNGsijgAdoBNV6E+0qlR2gbzmHif6r8F/SYqwS8Vi0BCKUqHCYbA5pCmoNoYaM764/fTFEYqYENmgf5vocaFT/+wgoER2xf0hyHCS2vzhnc0ObTg0y7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565327; c=relaxed/simple;
	bh=p7kRNGFym4WYDAP2C6aSKau97wS1gbpSFOfUdV5lT6o=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YugEM0InS9r2rx/uHxjdIoIUGoBlJk/+prafsI4GydRv8AZRy8yJv0UbqVtKhAuhnBBN3N9zGdc/wtcc1lkt1mMTusteorHExDB50r6em4NXfR6PMXf0f39msJ8PDTR+gRlu6NPFy9CSkBUF63JkUaSAUIRY51Atmnm0E+lJntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF2nORHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE58C19421
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 12:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775565327;
	bh=p7kRNGFym4WYDAP2C6aSKau97wS1gbpSFOfUdV5lT6o=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=KF2nORHVl2eHxvA+HwCPCaj671bXGbfzZlAaHXIQt9c+m+lrRjMXjhCeWQw9rM9P/
	 45uwCCyFhLIJkp9RIomYJwQLXuFJiJwub29YONb9whwkoxTJ8cAfryk3gnDKVA47eR
	 inh+OE06lxmff4OAewq7wBu7ph5lRdGnVNOLgz/1Pnk0uY2rem/5EDvb47zDG6sbb+
	 TvkIMJJg6y5HpAJyI5Zl2OIsyGbFFLzCKhKIQ9+tgOIFHS5qA1eZaQ1KuQwCq0gxy7
	 9C7DO7iQEKoS5WBQW4LRLJ6DwXEbcZVPm5MQNnWaZ8GwoVllEDM4+ox0+M8tSgjOgX
	 ZXfCMdnXh+eBw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a1307438ddso4746278e87.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 05:35:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWh7A1PmGPms3i8ubGz+xuaRf8x17jYvvawPH0SveP/VnjAgN4SwU0SryNGZrsMJh1dG9uEohw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/u0ceMVR2QGFOUCDZdBiKy+ynaa//amd18Jnl+fPs0rmB/Dnq
	IxydXRblzG4Rt8SOhzsSQ1slnyLYjMJP6lKSH/u/NpEQj3jkxdjw/f7sxek9RAHb5CEadysJAJS
	kqRJsgDy2MtW9HvCY6our7/Sa43P82cvIMn11PU0y1A==
X-Received: by 2002:a05:6512:3b8f:b0:5a2:a13e:9082 with SMTP id
 2adb3069b0e04-5a33758cb31mr5808613e87.35.1775565326034; Tue, 07 Apr 2026
 05:35:26 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Apr 2026 05:35:24 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Apr 2026 05:35:24 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260407122031.2669397-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407122031.2669397-1-johan@kernel.org> <20260407122031.2669397-2-johan@kernel.org>
Date: Tue, 7 Apr 2026 05:35:24 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfgmqrAGHOeiXV_oVqPU8LKBdTJOVTUmWgAHwUxResvuQ@mail.gmail.com>
X-Gm-Features: AQROBzDJhJdMsjRiMmP4gv9TTZ5pzxUfZagwzLiw2SNz-rK5kC94yN8Adje07PA
Message-ID: <CAMRc=MfgmqrAGHOeiXV_oVqPU8LKBdTJOVTUmWgAHwUxResvuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: max77650: fix OF node reference imbalance
To: Johan Hovold <johan@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,collabora.com,linaro.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-233590-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 760AE3AE87B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 14:20:29 +0200, Johan Hovold <johan@kernel.org> said:
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
>
> Fix this by using the intended helper for reusing OF nodes.
>
> Fixes: bcc61f1c44fd ("regulator: max77650: add regulator support")
> Cc: stable@vger.kernel.org	# 5.1
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/regulator/max77650-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
> index a809264c77fc..11b04a13f889 100644
> --- a/drivers/regulator/max77650-regulator.c
> +++ b/drivers/regulator/max77650-regulator.c
> @@ -337,7 +337,7 @@ static int max77650_regulator_probe(struct platform_device *pdev)
>  	parent = dev->parent;
>
>  	if (!dev->of_node)
> -		dev->of_node = parent->of_node;
> +		device_set_of_node_from_dev(dev, parent);
>
>  	rdescs = devm_kcalloc(dev, MAX77650_REGULATOR_NUM_REGULATORS,
>  			      sizeof(*rdescs), GFP_KERNEL);
> --
> 2.52.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

