Return-Path: <stable+bounces-221224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPCPBJVgo2myBQUAu9opvQ
	(envelope-from <stable+bounces-221224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:39:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666951C930F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970BF355392A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6313135F610;
	Sat, 28 Feb 2026 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y07saRYL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C435F607
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772306558; cv=none; b=NbS4y1s55y75QK72cLUrethB7D21uLnSusK9RSCaUfZ0WjOq6s1y+YoKaOM7Wg1pa9Lv6XGcaOaWSnRgXPga40JqyN6jB6J008lZAxIVvzYvH86CrSfyfDKthGW6Lf/CFV6XtIahvLXfgeao5TFxXMm+3X38SyihrKcph40DwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772306558; c=relaxed/simple;
	bh=Me8n7owqfLJkYyvUXHQx2u9wWsIV5A0WiPjr8BtB/4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I55q7gJFfK5C/GjVr25GhOYVQcfl1GwySB00AcsRq/9LMrpLmPoOjKnIwgIo4QUHdNEfhCmLeLN1MBp5Zr6DSW6zWlqyU7bgmKTs6hmo6lUo63gt+Oxi8Db7hqsqsIbXFOd3fRQizh7Vao/Q/a/RBOokcyIvzkdwL+ARNi20gIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y07saRYL; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d18d0e6d71so2579139a34.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 11:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772306554; x=1772911354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzurjNKz+LVtj7mOsHnigyTZSCq1BtpAu09PeT2WHx8=;
        b=y07saRYLoCC2ntjKJ4b9npncuFpyHNGurAj1W9UU09TwMAemNZ7YdHqasUjpbPHhoP
         Fo3TQCv8IK+dIhba2YaT6OHJsuv8emGbaKn4tbR/7Igqk4HAowbAi3l8jHfrBaGTwu2R
         OUN3fM8MXJ4NUfpzhIasd3aAsR5AO9H4KYl+ygBFYz6xH5mnhgIYl5GFxKUrGJTlbuYF
         LAWlOmSnzgDZGPaJzNC1RYOoG5FaBnX6R0+adFDmi6s336sHxwtI27kq1Hebwz/5EgC9
         Z6ME29ppx85j1pOAdMC1Yy+PC83TPU2cJX65viqn4Urij04tDzURGJSdIijOnHThiZLd
         RUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772306554; x=1772911354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzurjNKz+LVtj7mOsHnigyTZSCq1BtpAu09PeT2WHx8=;
        b=BVzSijJ8XKEOEqHtfx3PaKg3cB5r4VxAiAKCSpAeiUudgyqTl8YlMjtTX+13nr/Yvq
         KoqvrmacMmcnaLQaxgNCXfYu1RYL4Yja3CLdDVjixCKFWmXR0+snu33tjWSCR/fszg/o
         lxuu+Ly4fQs9W6Guz1q5P7Tk3bU/30Anae+2omVR4ko+GHnAKTTW5kEJ/OnpJH6oT8dL
         Dee8FgmSnI/gWsaA00iyaNCsvbAF6pjf1Pu5Gd6VFhhc/iyw8KT5dNc20w6Ncs/w9SbA
         8sT2UbTxuNBsBJNzCyRDLKQY4xXNk/NOJNV2u8AhueG7M57jAKuLndydV8BUEMifHswt
         z0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVMIewSFp+7UalG4vMPkPgFGqwR0ykE/NYPym+DgCaHL6qGfwgki2N5QSNNhTU54+zaVrEOBk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIcBtEyGKmvLg0pdpz3kYB7Q/rHUceEBifxkbUXrSH2RY5MlLw
	HyUCBFOoOMEi4yU+o6fGRo+S6DZVvFnsJe5hUiwidfogz9d4lNsNZmhEdrrQuL2QGPg=
X-Gm-Gg: ATEYQzzUsdMbO2DcmMa6rk1iwsGOCSfdKRrVZQ8MJMh4vzAZFIhAEG6ut6+y2qxawNt
	1fAP6WH+7ti3GMRnt2DSIExC1tcIofnu31Akgb9mJmHPiqJwTdqZsetagTjYsk45xHTBWbZGrkm
	4Nod5ib9QDQwUE+/yRPrQ0McgK1KT8oPg+KfEutfvtRhnXYGptKTf16IZtwS2psYuwkh+eGo7AT
	5V0gx4NBvoth0tNdxhMjFbno+4Arcb5gEyEpF7z7pyvusrEXgzL2ZRy+iQ7CaYaulAuVOf88UxX
	WMfPtMr44LwSnajQllQdOcne8qMYePHKCnyD4hKmThPOsSku4LKx4Mi7rq3pLVo2FJZuwqwbxlV
	jvMSMXiklIRKDckCGuCNfvvH/jvSjkJmA/7abHpcUfIyidBUeFQFzKcQ3VRXyqWYmOixGm9ngyS
	1Z+2WL8h2d0Q4WjK63cs7qQXdqOy/Eb7RM8vCiDxGpSvIJgE9lce6avWRUeBKYgCgEt7oGhwq7g
	w==
X-Received: by 2002:a05:6870:e9aa:b0:40f:e6a:c0f7 with SMTP id 586e51a60fabf-41626e15081mr3595917fac.17.1772306554592;
        Sat, 28 Feb 2026 11:22:34 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1031:c44e:9f1f:17c1? ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2cc08csm7236079fac.19.2026.02.28.11.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 11:22:34 -0800 (PST)
Message-ID: <20195663-2091-41eb-b4b3-e8542d29ae32@baylibre.com>
Date: Sat, 28 Feb 2026 13:22:32 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: st_sensors: fix trigger allocation
To: Aleksandrs Vinarskis <alex@vinarskis.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-221224-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20230601.gappssmtp.com:dkim,vinarskis.com:email,baylibre.com:mid]
X-Rspamd-Queue-Id: 666951C930F
X-Rspamd-Action: no action

On 2/28/26 11:11 AM, Aleksandrs Vinarskis wrote:
> Current hardcoded name prevents adding multiple st-sensors devices
> on the same platform. Fix by aligning trigger name with other drivers.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---
> Some platforms such as Dell XPS 9345 contains multiple accelerometers.
> Fix st_sensors that currently only allows one device at the time.
> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 8a8ab688d7980f6dd43c660f90a0eba32c38388b..3b5615d1b6dd66ee0af6ccc83eb2fbd7b2c64d29 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -124,8 +124,9 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	unsigned long irq_trig;
>  	int err;
>  
> -	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
> -					     indio_dev->name);
> +	sdata->trig = devm_iio_trigger_alloc(parent, "%s-dev%d",
> +					     indio_dev->name,
> +					     iio_device_id(indio_dev));

Is this something that could potentially break userspace? Or are all of these
just "always there" triggers that userspace doesn't have to touch?

>  	if (sdata->trig == NULL) {
>  		dev_err(parent, "failed to allocate iio trigger.\n");
>  		return -ENOMEM;
> 
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260228-st-iio-trigger-8ee1f219b566
> 
> Best regards,


