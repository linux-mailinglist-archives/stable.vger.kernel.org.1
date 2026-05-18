Return-Path: <stable+bounces-249278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNk5CF8QC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:13:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE756D60F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A17302F0E1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855C47ECF7;
	Mon, 18 May 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZjmHy9y"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC5421EE7
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109623; cv=none; b=Dpn2uS99sOnniqL+JJZqdoF2mf/rJ9bTymtA9BD4xxmKthv04tgSIjkXcngXVnE4YsFBugJelLY3pENGXu1fkBIDUE4z2MoHIlUE5T9bfhThR7v4Bj7FzPBeAG5yMvR40dr1beD6s+YC/PYzrKIJGx/1Q8mFPKg+ZLiRj8i04Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109623; c=relaxed/simple;
	bh=Ya02RhlqEZpt7PO2wzq7RoXZ3jq5BLY2qWaxfoLcUG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpzw0Ty7u6nRpz3nVWD9AjczBQq6wlovgMqUBEVr/Qk3MGrmJPe/BUGwfnLjmjIQC1VQksXVlq4BpiFNFVhS//YibTabIvQHw/DDUimqtdB7KB+C16Gi4zDHdDZiGVrwe/DsT80mW8Em+n9poQ5oFgJrL3ELEb4IAwZuB7zm+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZjmHy9y; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so24186561fa.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779109620; x=1779714420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUiMRRSmY+S3AmG7AOP23s7PvAi6QEqj5i/lCE5ZaFI=;
        b=SZjmHy9yKIvkTmQ4HMkgRX7Wv10JqQHA9wJi2Z6tlqVzrh1M58B0QMt4f27EArepy6
         eTqUMHA80581sUiSe4j6U7OskACtRSUA8jnvz3IFl+W/b1Wjr2ZLmoRrMv/K95v0mhJT
         MzQTkae7EBaZnT0MagNsy6mF2AhI5j5G/7KC2BelW2wmwIFVqvLqSvxC82Fzbjr2Gdgt
         cqfyb8XGMEJe23f8v/bDMbNhMDmHjUufbSL3F2kBUzjwBuj0kybWxGMu4SYXk5h4vQvu
         kBxCjv3HetS4By+3tb5FDrHxgPt9Q36Kgj0CdMmC3doBfFPX9xSXLZSMjRykee+Sjc6U
         D0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109620; x=1779714420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUiMRRSmY+S3AmG7AOP23s7PvAi6QEqj5i/lCE5ZaFI=;
        b=En2H1AGGQRn6CJMcmIMjaNagSgj7N6Kt49fxgEjzs2nnE2ETxjo1kAjiPsLcPHBLPe
         tL+pCnkSu7/xNvLT4N0N+SlDY8zJl1J81gZa4q9V7bXty+/T9hO/k5dleIx4zaThhXTL
         gH05k3c35gBx0shHuhzZzGbpMJnt4i0oWw7z3mBEZqFBfHDys2HJBFQIX9iLhDZFTNFQ
         gxw8zh365iR7QexcNh2UNxF45d9BtO/WbtQhI+wM+vuzbq8kViL1jCogQNIY348UvRyb
         3GhGgxyYXDoNGMgtq8LIAPet3b6hDFXkiD1ckOrkmPJ2dC6fL0oJF/EpDdASvUTEh/5a
         mZRg==
X-Forwarded-Encrypted: i=1; AFNElJ9IyAJmZ9qh4Mv2F0NUDfn6eAyT7CNnK4w9gCxErpqai3mcOiprRzzddszUp5WKsAWs+PjcmTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysIlxjdpCDptymSVwbtUXafNf1RoWeLE6BWmtAgPRT09CTz4aF
	DhAgxhLd5JUDV2OyfgUNkD1KGMdAgHfy05sHlnchtp0aBrmRDH5UWgMH
X-Gm-Gg: Acq92OHOyb1Xc8VHWWoPvKJSKj6PeZETDqsO/l/R6ZMdNfkl7QAZa/zUSPCM5sUQgcB
	5PCxYVx/vmduc700CkSv73RfbjPkX/3IJSVA6x8XuSA82zAPn4mv1YMB2v/1OboYS+X+eTUVF1o
	cfq4/I+facdKvT4OlUYxEWABxmqzmxjpWXePUJOvopTrZHT+11E4e6iousPdowlqiSFXdqWJqoD
	Q4BH/Y0K/xy3x0sd2U40/THCt4wkj21Srgh8h9ChO3loVvIHsDqLqxMRijsdN7AQdTFiH26JRAm
	ROzj60LLimHVYKBwjv6P2YlEFdw9E3EstvNp9hU0BGvrYFm0Zs93Fek/zBoWWb/ZNVGh/xWvbm/
	kxLkoe65kqwrYKDujGE3KTZVmEQMSw34YLuKiSr4G7hYRS610sZX6l8gGcXdDnOsSF++eAP4NHo
	uZtu7gY653tvPY8oKWqXQ6DtDmIYmgWx8w
X-Received: by 2002:a05:651c:41d7:b0:38b:e6c7:2c4d with SMTP id 38308e7fff4ca-39561c68693mr44652781fa.12.1779109619856;
        Mon, 18 May 2026 06:06:59 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c41c1sm11742241fa.12.2026.05.18.06.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:06:59 -0700 (PDT)
Message-ID: <02a983b5-3527-4dfe-b8b3-55b5435f1c9e@gmail.com>
Date: Mon, 18 May 2026 16:06:58 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
To: Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260518094238.1986-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BEEE756D60F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249278-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 18/05/2026 12:42, Stepan Ionichev wrote:
> bm1390_trigger_handler() returns from three error paths without
> calling iio_trigger_notify_done(). The success path at the end
> does, so on a single transient regmap or read failure the trigger
> use_count is never decremented, and the !atomic_read(&trig->use_count)
> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
> The buffered-data flow stays wedged until the trigger is detached.
> 

I still believe the use-count should be decremented by the IIO, after it 
has called trigger handlers. (Unless there is an use-case where the 
use-count is not decremented.) Well, let's wait for a little while so 
Jonathan & others have time to comment. I have been wrong at times ;)

> Funnel all returns through a single done label that calls
> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().
> 
> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> v2:
> - Use a bool and IRQ_RETVAL() instead of irqreturn_t (Andy)
> 
> v1: https://lore.kernel.org/all/20260517160801.269-1-sozdayvek@gmail.com/
> 
>   drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> index 08146ca0f..81368e578 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>   	struct iio_poll_func *pf = p;
>   	struct iio_dev *idev = pf->indio_dev;
>   	struct bm1390_data *data = iio_priv(idev);
> +	bool handled = true;

I would inverse the logic. At this point, the IRQ is _not_ handled. 
Hence I'd default this false and only toggled it to true when the IRQ is 
indeed successfully acked and data is read. That should allow you to 
touch the 'handled' only once after the initialization.

>   	int ret, status;
>   
>   	/* DRDY is acked by reading status reg */
>   	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
> -	if (ret || !status)
> -		return IRQ_NONE;
> +	if (ret || !status) {
> +		handled = false;
> +		goto done;
> +	}
>   
>   	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
>   
> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>   		ret = bm1390_pressure_read(data, &data->buf.pressure);
>   		if (ret) {
>   			dev_warn(data->dev, "sample read failed %d\n", ret);
> -			return IRQ_NONE;
> +			handled = false;
> +			goto done;
>   		}
>   	}
>   
> @@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>   				       &data->buf.temp, sizeof(data->buf.temp));
>   		if (ret) {
>   			dev_warn(data->dev, "temp read failed %d\n", ret);
> -			return IRQ_HANDLED;
> +			goto done;
>   		}
>   	}
>   
>   	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
>   				    data->timestamp);
> +done:
>   	iio_trigger_notify_done(idev->trig);
>   
> -	return IRQ_HANDLED;
> +	return IRQ_RETVAL(handled);
>   }
>   
>   /* Get timestamps and wake the thread if we need to read data */


Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

