Return-Path: <stable+bounces-243949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGaULJ5d+WmO8AIAu9opvQ
	(envelope-from <stable+bounces-243949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 05:01:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEF24C6170
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 05:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3AE0301AA6B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 03:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B707B3A1CFE;
	Tue,  5 May 2026 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPUUYsu9"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17735C1A1
	for <stable@vger.kernel.org>; Tue,  5 May 2026 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777950096; cv=none; b=JNrqjTuhCaXaJiyadDwPvW0xLbmvvg4c3qi499fZEbLfpGkiGmK+4JLiPpGUZmjEF23CjdyXIq3xtdTxzXqQdna1Nwg2CPtXKFkJTNhuLeWVWXdiTH4gk6GF9uUVScS8lroiiHI8EZo9ujCLdCCKA4D1WnYYM4eRaeww1hGmyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777950096; c=relaxed/simple;
	bh=1ZZq3AZcXhdVVTCNk7Y6efOxIfjWHrNXrTwSSibK9+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKKjzXTWKGR/invt4VzZZembtdSfo4AY714DCKlMMTPXNkUKZhFscJufJlQoSdvox+6JshRsvwe8nUzGkUTYdFXHvyYB3rgv4VuqPvo3cquhZWeBoI4tLn1OeVRl/FhVK9+N9pRs2Frw5QL21GvGqYsDGjxc0YYQl8yht37ArzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPUUYsu9; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ee990e8597so4726651eec.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 20:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777950094; x=1778554894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=El9tXtPSumoZ+MStmDgSuEySorMFvbhYEvY/QycU3Vk=;
        b=RPUUYsu9Jc17qV39uZNMtCuh2kXqJ3Xr2PodS9bZLuEUZO8SMXVnBrVbDS8k8uBmqM
         54beor3a4LtE3lJ/uWIyNE/eFBKta4aWibf5WIjMlv2ZbXwcpvEiAzgB1tL4B7x9/cfV
         qg9jYsDa/27uV1iCoFmXVmaR8WoT8/KuAWrTjE+8g90h5nVNs5C/c+ONtVFQ5/Ua+TKi
         8/g6kVu3fwvupNpPzMy49Ol0QdeQH/9UhCk96ELuQzPlLkr2AzZBB8Ay/yDqDXY/pGoW
         Tq1PrAsF4uxMpq5KJSC+il+XBU6yBWUCM261Fw20xMT2fspVL/FuIvGVlIPALgFIIMMg
         e2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777950094; x=1778554894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El9tXtPSumoZ+MStmDgSuEySorMFvbhYEvY/QycU3Vk=;
        b=D8CBzrlro8YlGN0AzEfX1lKJx+Clj/bgIgnqsOCw/R3H8a2W60bURA05LjziCokvyt
         xzoALrn78HBQBal0PTdOMR5tIb90RWOsrPZ/3IS82hsLq9SuzLH6DwoUW0dixUfynC77
         jR6nFGeGvvbQi8mDuK1UYBbzCpYIbcRzFOm0o4W/VLESGXj2LNw+2SucwbZbyQGBZRAs
         i2JM5vwXS45czV5IPT0kqeO9XBJfxtd961swEnQ1IYsgAAkqBSHn6Z4ZdOmygo+7Qwbo
         MAJSgrcXuFoyBZIfusW6AVjEtbJFifOKT303ByJFBeMgcMHfzsD7KBwju1AFZ7VFOgGC
         zghg==
X-Forwarded-Encrypted: i=1; AFNElJ989FSQ/iRn3MIawLO4Fco7qtjvdfCNGvjb9l5RMyuPm4905kRVaZiEsvQ/JXQMu07JJffrAnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/IpEnTMOvKYhu4cY+YcswpOs1/GVRamNw4E8+SP+fDJp7W7LS
	XMtwr076qVhNs55yAhEFKcfwwBczU7GtltDoEkyQGBxuyhwBl3orJTQoaXFgpQ==
X-Gm-Gg: AeBDieu40jXXgNvgzbXwGF9tuEtKtVC7DYFFoiIDDBddkJXr9rdiVXkJa9kQaRYXWhC
	JbLtwxCJKuHsZapk/7mhSSELyN66PQEvWlnhhcx7UG615CUiEFqLMqcUOfXn/ZTsrACl/99txI1
	sRlZpNJSgb/n+aANIzG48LwqE5vSzwBgHTHg3K8hbOgNi4BTN1hESDX+caPB6Rammm6c0mTbK4g
	T1yKanf/ce/JeoHSHspXVXY+11GOkg97esBFGOVfx/EeurcXgTKeeO+IrGkjonw+Evc5PW1m8HT
	VIV1Unuhf3awbURNXKxrxLoPqTuFCdL8n+fFSuZhbJOQyjr/djjEcXbx6aEs9NfIHRhUA8Q/0XS
	34VxOib2WSCuetGlCgK8JswmjreTGWx4tLrlQYGqmSItpezM9eAtQDO3wG9HAozTpmW0ZZUxGIO
	+X6hBH8dBQIKJd58RpJRz5wboEza+1nGkVslShobK1c6CNb4gQ39Xuza6THE7jBoouIVMTS6T/p
	Hc=
X-Received: by 2002:a05:7300:bc9a:b0:2d3:f43c:d684 with SMTP id 5a478bee46e88-2f40745dcc3mr566666eec.2.1777950093512;
        Mon, 04 May 2026 20:01:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b781555sm19279870eec.21.2026.05.04.20.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 20:01:32 -0700 (PDT)
Date: Mon, 4 May 2026 20:01:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <aflcL6y_ugHV5p8s@google.com>
References: <20260430173739.3843425-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430173739.3843425-1-kris@embeddedTS.com>
X-Rspamd-Queue-Id: 1AEF24C6170
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243949-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]

Hi Kris,

On Thu, Apr 30, 2026 at 05:37:38PM +0000, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits and use the scratch variable for the rx_buf for
> both the 1 byte command to and 2 byte response from the controller.
> 
> This change was tested on real TSC2046 and ADS7843 controllers,
> but not the XPT2046 the workaround was originally created for.
> Confirming that the original modification to clear the command
> register does not impact either real controller.
> 
> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
> Cc: stable@vger.kernel.org
> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
> 
> V1 -> V2: Don't use rx_buf when clearing command reg
> V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
>           output on xfer with len and NULL buffers
> 
>  drivers/input/touchscreen/ads7846.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 4b39f7212d35c..488bcc8393293 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>  	spi_message_add_tail(&req->xfer[5], &req->msg);
>  
>  	/* clear the command register */
> -	req->scratch = 0;
> -	req->xfer[6].tx_buf = &req->scratch;
> +	req->xfer[6].rx_buf = &req->scratch;

Sashiko (I believe correctly) pointed out that by doing this "scratch"
is now write only and this may cause DMA from the device stomp on
message status and other unrelated data that shares the same cacheline
with scracth. While it was already a problem before now it is even more
likely.

Since scratch is now write-only I believe moving it below "sample"
forces it into separate cacheline and fixes this problem. Could you
please try making this change?

Thanks.

-- 
Dmitry

