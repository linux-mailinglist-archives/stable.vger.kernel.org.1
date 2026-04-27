Return-Path: <stable+bounces-241370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHbSOLiP72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:32:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C514766FF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF716306A7CA
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD37734D915;
	Mon, 27 Apr 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="FQs3GDZ5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2F346E6C
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306806; cv=none; b=m/zJSAH5ra2mfOqW4ShMcXp0ylplK+vmanGE3/BXCy3nNtCkNwx8VtWqqq/Q0mK8jiA9qM4GUsCzY4D2U7RxBBZgqdB/x2ME7YPNHNlHqRADMqcW3F3pz2k3+KJL04a9JWkeP/2i7WDsMPJ1IYAGoktRDTl9l2ckBhampdeSJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306806; c=relaxed/simple;
	bh=xidvJQjpM7yPCqe5PKIOorDtLSAo4K6bgw4e3ytK1qY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QZc6iWFJBA1J4NqQAdmYeZQ7A/lv6aoDEZGEbaR1drt1hX4JeUxZbJHaGcr6PNWEay3zlRoSgY6dHGmnuS1s+nZ7P3GIlQO6+Fl4aT96jLLT+c+Bur3wX/v5ZfY1e2eqhGquOYRCd2+Q2pof21pi3wIcF1WlnPc5U6WiTA8D+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=FQs3GDZ5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35fb7c1a455so3897461a91.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777306804; x=1777911604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ot5/VkkpAMcYPEn/1toyTMHXbfWqkhlcoGx5NqyUByo=;
        b=FQs3GDZ59mCkixfqWKRa0YoBHHPrPBCM6BijDOo3TqYenzhklcdOEaCrj1CAwHLtWy
         xL1nVWrmkPAF0Ub5UK46RDkBSXx5aY3iVO9/ulYVIMnQu317isIFU9saspWlKqzF1t6Q
         Jb13N3yS0TOOyXEkJQQlL+o39Iy196Yk4f5+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777306804; x=1777911604;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot5/VkkpAMcYPEn/1toyTMHXbfWqkhlcoGx5NqyUByo=;
        b=bKk22iisGXb87nCQvck1WKrDvdmRwc+H2+JIvIua6w9334VbzobX9HC8pgbEYrHjR5
         yuCEOU+KxtSZ2oXbEncwzD5HqcbhywLQi/H3t/pDoCUJ6PB93NlqYHgiT3mA5ku06Y9x
         47YZwRwvpTGJqgZDlR6lPCSw0gPtLbfjbfVfIeTus1XPLeZqnLnzT/U2vEejQ6Qfb5pu
         dINni4RyTqswMTLUdRKj5LlclO6qy3+uhuKevLkXLWGBFttt65Bwf1R8g/lTSJVGy00Q
         s6udR9wO4mDVoHVuHjMgzQVvFLCTUgHFCQQh6gUJAc58HwiMl0K/OJQNLRuGYuiKrDhG
         bDEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bUn1RtbDZd94WKjM7Aq4zwib0qbqRs0IgM6XVy0GFgTiqJZn/jNYzpHp0LuKzqtbQcFslUqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYARIKewTpBhFdBuXruX100M9esObTAywBvL3rAtiDO6jS1qtJ
	ZvKGv8hQn/5I5mDdpKzsDCoyXZsf+CmX91uIscqAFTeHcYY2MDHxkTgo7Wp8+/SMLHY=
X-Gm-Gg: AeBDiesR02NZb522PgENet164GGCxWCk6AyTfrZZnpG4DvrLFa3U3Wb4xghntuxylrC
	WcbeZz2e5TlDqteiB2uFwTWZSn3ubSG9x9Vek5/ACu2UI8ssZEzj5Zm2/KkAfkAfcSOKsW+gfAW
	HLfDTUc9m+p1R7vuCJAsUwoioH0423mZMEZdbp/vJyF2pi3E/xB5uP/y8ZcXR4h6hfeEEQ2Csej
	1McmYJ1Z9u5VM2WsmrB+sxxcso9C+ExgLiLN3/g2brEu5QxsXiQRz5YItv64qugRsnBJGPgOeUa
	RFzmgqFdNyRO0Vzo0f2tQ14WDUQ1cMZ7aDhTMb7TYKR9wjv/7gmPxkqIk5PbFHBsl621FcieVdT
	lSNejn2vUoTUC/5q5+xdkO1fQGweY+UrLNuvv+5xy2bnqEJgCyWrQfGD/Wqthk3rrXORNeAkeu3
	HGO+wK4mEUB6gznplWDH7S9G/ydCSyzwSjJo6JMKS73S2B23LlJKamc1//uOR4jfAUejINfeNf8
	nQ74b6/+BsBwp+NEMg75ka3FgfqFwpOexTsnDyU6jAzR/2OQus+6drpL2ytaFB4xQ8GJ11oPgYi
	n4BGaQ79nq71xcsbEsw7w3uy6touuc5ggbLa
X-Received: by 2002:a17:90b:3b4a:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-361403d61camr43690659a91.3.1777306803667;
        Mon, 27 Apr 2026 09:20:03 -0700 (PDT)
Received: from [10.10.10.191] (97-120-253-104.ptld.qwest.net. [97.120.253.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410cc196sm33025839a91.17.2026.04.27.09.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 09:20:02 -0700 (PDT)
From: Kris Bahnsen <kris@embeddedts.com>
X-Google-Original-From: Kris Bahnsen <kris@embeddedTS.com>
Message-ID: <12a76d8c-344e-49a3-b168-6cd353d720a0@embeddedTS.com>
Date: Mon, 27 Apr 2026 09:20:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org,
 Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260424192534.3504976-1-kris@embeddedTS.com>
 <ae2YWxew6M03MFfN@google.com>
Content-Language: en-US
In-Reply-To: <ae2YWxew6M03MFfN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 24C514766FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[embeddedts.com,none];
	R_DKIM_ALLOW(-0.20)[embeddedts.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241370-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[embeddedts.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kris@embeddedts.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[embeddedts.com:dkim,embeddedts.com:email,embeddedTS.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]



On 4/25/26 9:51 PM, Dmitry Torokhov wrote:
> Hi Kris,
> 
> On Fri, Apr 24, 2026 at 07:25:34PM +0000, Kris Bahnsen wrote:
>> The workaround for XPT2046 clears the command register, giving the
>> touchscreen controller a NOP. The change incorrectly re-uses the
>> req->scratch variable which is used as rx_buf for xfer[5], so by
>> the time xfer[6] occurs, the contents of req->scratch may not be
>> 0. It was found that the touchscreen controller can end up in
>> a completely unresponsive state due to it being given a command
>> the driver does not expect.
>>
>> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
>> transmit all 0 bits, moving the 3 bytes to a single message.
>>
>> This change was tested on real TSC2046 and ADS7843 controllers,
>> but not the XPT2046 the workaround was originally created for.
>> Confirming that the original modification to clear the command
>> register does not impact either real controller.
>>
>> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
>> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
>> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
>> ---
>>  drivers/input/touchscreen/ads7846.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>> index 4b39f7212d35c..599793d27129e 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -327,7 +327,7 @@ struct ser_req {
>>  	u8			ref_off;
>>  	u16			scratch;
>>  	struct spi_message	msg;
>> -	struct spi_transfer	xfer[8];
>> +	struct spi_transfer	xfer[7];
>>  	/*
>>  	 * DMA (thus cache coherency maintenance) requires the
>>  	 * transfer buffers to live in their own cache lines.
>> @@ -403,16 +403,11 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>>  	spi_message_add_tail(&req->xfer[5], &req->msg);
>>  
>>  	/* clear the command register */
>> -	req->scratch = 0;
>> -	req->xfer[6].tx_buf = &req->scratch;
>> -	req->xfer[6].len = 1;
>> +	req->xfer[6].rx_buf = &req->scratch;
>> +	req->xfer[6].len = 3;
> 
> Doesn't this overflow "scratch" which is only 2 bytes? I guess there is
> a hole in ser_req between "scratch" and "msg" but I do not think we
> should rely on this.
> 
> Can we also set rx_buf to NULL to discard incoming data?

Well spotted! I'm quite annoyed with myself that I fixed one pointer
use bug to introduce a buffer overflow.

Will send a v2 patch later today.
 
> [credit to sashiko].
> 
> Thanks.
> 

-- 
Kris Bahnsen
Software Engineer
embeddedTS


