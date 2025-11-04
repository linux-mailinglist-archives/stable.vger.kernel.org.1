Return-Path: <stable+bounces-192365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C40C30BDD
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 12:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1FE94E196E
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32512D46CC;
	Tue,  4 Nov 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G2XThxHh"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62F2D8DA3
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255932; cv=none; b=sTBt638LfxS4lTP0rHVl1SGBLXTfKk/qNbNDK+/zWutEw90i0nVJlgcCkcRWKIkI31GfgloiIdi5B1O4tyxvGX7W6nnCvtcBIvoEi3DprGrO5CCDFICgo1hWUjQvIurrxHoRMUdBcH6ucCAn1R+yCcdMCL3ILVMrOxvpqqaBz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255932; c=relaxed/simple;
	bh=cQ8ji/FNzj9BqB190stuaa7uhYfAWNouaPoCG9WFaso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzQTDotuJrTuFP5Fxb7DmnPOUj1IHUpDEJ+km7FO+prKSstkCj/Bm5jL0laB9WtCovZlGd7SxyNvLd1OwNrTkmNSkOz5YO6EcnpkuNKjkVN0hu8V3hNI9cQy5f/m3fDxR8hzIu8ij+uhxX7ob/DriXB7WOaY6Pd/21ijHyGBP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G2XThxHh; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8b2b414-149b-4f35-8333-43011804ea2a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762255916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhSjqnMto0B1aHiw1zZoaXhk7sqXONGcL69jg069DmA=;
	b=G2XThxHhXidEsRt/QZRNzrjjoW1sfirR6AJWYMy8t5haHFaBNQRWMfw1THbEf6OdZzuASW
	Zu1CDlp8FFBPiVdpewnQRbiNElUJbTUCDUTDkVw5YxVMlWZvSQ9G1VYdj85z8BCi2J5c3U
	jjDBv4HAaWHUap1KR0oj0enVJDXWg1w=
Date: Tue, 4 Nov 2025 11:31:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ptp: Return -EINVAL on ptp_clock_register if required
 ops are NULL
To: Tim Hostetler <thostet@google.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>
References: <20251030180832.388729-1-thostet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251030180832.388729-1-thostet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/10/2025 18:08, Tim Hostetler wrote:
> ptp_clock should never be registered unless it stubs one of gettimex64()
> or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
> of function pointers is null.
> 
> Cc: stable@vger.kernel.org
> Fixes: d7d38f5bd7be ("ptp: use the 64 bit get/set time methods for the posix clock.")
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> ---
>   drivers/ptp/ptp_clock.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index ef020599b771..0bc79076771b 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -325,6 +325,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>   	if (info->n_alarm > PTP_MAX_ALARMS)
>   		return ERR_PTR(-EINVAL);
>   
> +	if (WARN_ON_ONCE((!info->gettimex64 && !info->gettime64) ||
> +			 !info->settime64))
> +		return ERR_PTR(-EINVAL);
> +
>   	/* Initialize a clock structure. */
>   	ptp = kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
>   	if (!ptp) {


The patch itself LGTM, but I believe it should be targeted to net-next,
as it doesn't actually fix any problem with GVE patches landed net tree
already.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

