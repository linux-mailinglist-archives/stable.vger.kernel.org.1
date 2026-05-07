Return-Path: <stable+bounces-244612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJwxO3XF/Gk8TgAAu9opvQ
	(envelope-from <stable+bounces-244612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 19:01:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1586D4EC995
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 357DA3045231
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2CB3F9F54;
	Thu,  7 May 2026 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX6y4fyq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAD35B633
	for <stable@vger.kernel.org>; Thu,  7 May 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173248; cv=none; b=ZHQ+9wom/9kfgIzDb5s5/JOaj4O5V/Dq4J14KfED2I6j/NC8h6ji5kQ7y6+a9Hv1gjnAopxUsXB4dhM+HYMqKimZKi+Zr8xNZBnylq0adZ2WGEKRhw3wOZL1w0Wv2WblwkVGlMGsHYTfeFa90wYehW4V20tsSF8RL7tqGQirRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173248; c=relaxed/simple;
	bh=1MY0S1NrSLlFDa5YncGRvWO886u0CmCXtc+ubK184a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eguAt8QTrApvDpXV/b7DBV50z7Ykq6kAdCKmDMEofq8xtK0eBRdLZmXz1ItUhwjQzV0xvHqoggaH8rpuXqVFpfK2uG6kX950tcRtu+CoMTkfHt5wHzRxj/UwOu4Z1ye4va7P/i20I+JA3w419NQyx4iE+bVyRgJVZYnDjS5bOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX6y4fyq; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso852564eec.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778173246; x=1778778046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/aYnHghjmowXqI8WvBgOLTVpcMJSrTJbA0f1MMN/YE=;
        b=KX6y4fyqfKkHyQc6K7ULhpWbbVfPJhJlxv6uPVaQ8hT1h2mYzcH8oT9XN+tbtWotx2
         f0X/fH95iXPKFwQDnOUHTYNtoT4+2TToD6i+ubDCMdjI3RvRjayaHWjDjAt4e9d7FUpM
         E4abof6w/KGpVOsetQWvClOr1OOrEujWW50afAi5Ly3v3XhitYcv7oFR7VWzM3MEmFPd
         rj7EKFNJG9bybbKbqiQugMkSTkxEN3f2JI7nhbxtN4TCM9c7OQ1UZoQRhxO/fXMXtTqR
         /0QvXB3rzP+urjYRT6OtA2MeZtS4Q/aL30+2K+V/B3VAliW9qeA+28jOMKt/3eYauGf5
         g+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173246; x=1778778046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/aYnHghjmowXqI8WvBgOLTVpcMJSrTJbA0f1MMN/YE=;
        b=lLBcizzZEGHgCJET6pqGfVHjcro8vAsuh9tcoEOiV3KlABlu9TpNLNjKdPwAB78BxG
         UOFduiiYyeAhE/Xr2QUxsBo5O2IxBjR7l6x70ma43DFEKWYkWWBOZhvV1gwbIOvPdOlh
         X6ZPlcdYFz1XQpXyIFSKwHn2wTtEZ8wDHR/RRWr5mpzVKpwDrPWf3T65z5qGo9ODRkVj
         lyORsFiyBPrOoOHvYWpdiUtu4sTAd9XtcjAgukPCEGFUUo5Z6xtgVj6KZblHmdWw1VLT
         8C1vWenauty8H0ch+1DqO4O3oHmILussDf7NN2W+1F2Z5gNIRlZGTUBu6yhBkizyeR1x
         bjPg==
X-Gm-Message-State: AOJu0YysVEpmYbB992Cp6HMyC/+J17QyW1DCOILY7V/Sg6uajMeyYlrb
	IKLc2ziI6asL+89oiO6XsQ544jBmznSDhkiL890kdQB+zunBb/Dntosk
X-Gm-Gg: AeBDieu1WydxIYxGR0jYI8/oynpGJPhVd9behLKTNeJ4INp//jX0q9JU4LavGbjHODR
	FtwOBUy/c1XZ5vyfvY0D9WmnrtXAp6h5vrfY85H47bwJ4zAiQLRQfvYfiu6zJMj4/Ry7a+FDV+V
	nDiH1WFjZivZ+OuE4myPdZES6FC2YqRIpJA56gotEPsnqH8CJxyXa6HMKGG9iKRu+0nxKS4nG1s
	zFyqrp+no3AA1dDFb61FvlU337DdXReNudpONmt+SE+L4i0pMudI8vuuFubDayjqzDwhfCrSsbO
	EwhqTeGa0uvYKjE7lw0MeEotmlgtBoumBaRDULG8+F3+qCDRz/JzDsNqO3xMnSAywujmoUl+S0g
	1ZawQhIA4wpyyesCs/7jnDjSD4hmsUjdtv3ppHphBC8mKg+GH4emexN5/VGKLKgdDe1PhUkYKwM
	4p7X0Y1JeZSYea5ACFJly7j/66bEvEiE+FNt9Z51yCpr28OORkTS84ZJNTe1KWkoTfG0mgpO1cV
	04=
X-Received: by 2002:a05:7300:148c:b0:2c1:67e1:61a9 with SMTP id 5a478bee46e88-2f6e4374892mr1554113eec.13.1778173245923;
        Thu, 07 May 2026 10:00:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6a50:9473:7750:56ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec58efsm8840117eec.2.2026.05.07.10.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:00:45 -0700 (PDT)
Date: Thu, 7 May 2026 10:00:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>, Marek Vasut <marex@denx.de>
Cc: stable@vger.kernel.org, Mark Featherston <mark@embeddedts.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <afzE9QC-4KB6jUNF@google.com>
References: <20260507164943.760009-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507164943.760009-1-kris@embeddedTS.com>
X-Rspamd-Queue-Id: 1586D4EC995
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244612-lists,stable=lfdr.de];
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
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 04:49:43PM +0000, Kris Bahnsen wrote:
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
> Also relocates the scratch member of struct ser_req to force it
> into a different cache line to prevent any potential issues of
> DMA stepping on unrelated data in other struct members due to
> sharing the same cache line.
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
> V3 -> V4: Move scratch to end of ser_req to force it to a new
>           cache line.
> 
> V4 Note:  Change to moving scratch was tested against an SPI
>           controller without DMA. We do not currently have a
>           platform using this controller on an SPI bus supporting
>           DMA.


Marek, any chance you could give it a quick spin?

Thanks!

-- 
Dmitry

