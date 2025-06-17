Return-Path: <stable+bounces-152748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB550ADC01B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 06:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A091891BE2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 04:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8B218AB4;
	Tue, 17 Jun 2025 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wUp21Ajd"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46ED26AEC;
	Tue, 17 Jun 2025 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750133534; cv=none; b=ohAMtCFMpqghdxf7kDClT2w7NpLPtH7OOIENWwbA0RGwfsnijeWkdU3p5MCdBD5pT9oFIXCxarRV8E8j3fhkFctSeJ0mUxyQ1XfXXhEf2J8tb3RWZB2NVPxjD47osak0rLXgxDpN9SgJRW7rffHCCwkh7ssFSihG6fT2jm55dOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750133534; c=relaxed/simple;
	bh=JWE9XrW7o25fB9QBNfzUhz8ChSXBoRC1u/TBJe5cdCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag65aayqjrhFWQ46MBS6Yf/1VU9ogBF5d5nIKPt5ItdCW9Fo7sxJ+D701SAWwwv8UScdfbWFo3vsEXdFsPJVJpH/vg7keSOdbbsOiRZtiFpbkps0nyUYAdahI6xRDAq7MBkHxh6tLmZJ/BBIPEgjnOSVC5gIuQc5uJLJxqsFSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=wUp21Ajd; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C912814C2D3;
	Tue, 17 Jun 2025 06:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1750133530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XX8+qhfEGH0k+ywJ112SNfSj63R1ck8gDTnzE+ym2g=;
	b=wUp21Ajd/JQH/+PS0K/4gn9cgb/17jF41qPkk8gcSKMrkD5zqWoJ/DGi2FFroxmgx/1CE4
	COAcAU7ewt3sBw6F1HKYjqlI9xiP3hAn9IKMc0zwx4op7+nsmhQZ9vIMuHlQ8h8ksso8lg
	b0uvjyqSzXobwudh6IvueWhmuK1y8nwSBxN0ZzE9c4SbyDCYM3oDnUMrOehukZU/2YY7hU
	ePgkurAEZpb+iakCr824vLRTagEGrbyLGrqlrYLRtNzBqe8bfg3R3zm6IPI/blRjHgfbxV
	M9bM6Z6je3GQ6FB1y+pp27/ebN/VA0y6uVw9OwVlu16XkObTOYLHTLcjt/SP0Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id eb5b656e;
	Tue, 17 Jun 2025 04:12:06 +0000 (UTC)
Date: Tue, 17 Jun 2025 13:11:51 +0900
From: asmadeus@codewreck.org
To: Danis Jiang <danisjiang@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	security@kernel.org, stable@vger.kernel.org,
	Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: Re: [PATCH] net/9p: Fix buffer overflow in USB transport layer
Message-ID: <aFDrBwql20jYrvp1@codewreck.org>
References: <20250616132539.63434-1-danisjiang@gmail.com>
 <aFCh-JXnifNXTgSt@codewreck.org>
 <CAHYQsXR43MGM826eHtEkmH4X2bM-amM29A38XUj+hMbNF2vDJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHYQsXR43MGM826eHtEkmH4X2bM-amM29A38XUj+hMbNF2vDJQ@mail.gmail.com>

Danis Jiang wrote on Tue, Jun 17, 2025 at 11:01:40AM +0800:
>>> Add validation in usb9pfs_rx_complete() to ensure req->actual does not
>>> exceed the buffer capacity before copying data.
>>
>> Thanks for this check!
>>
>> Did you reproduce this or was this static analysis found?
>> (to knowi if you tested wrt question below)
> 
> I found this by static analysis.

Ok.

>> I still haven't gotten around to setting up something to test this, and
>> even less the error case, but I'm not sure a single put is enough --
>> p9_client_cb does another put.
>> Conceptually I think it's better to mark the error and move on
>> e.g. (not even compile tested)
>> ```
>>         int status = REQ_STATUS_RCVD;
>>
>>         [...]
>>
>>         if (req->actual > p9_rx_req->rc.capacity) {
>>                 dev_err(...)
>>                 req->actual = 0;
>>                 status = REQ_STATUS_ERROR;
>>         }
>>
>>         memcpy(..)
>>
>>         p9_rx_req->rc.size = req->actual;
>>
>>         p9_client_cb(usb9pfs->client, p9_rx_req, status);
>>         p9_req_put(usb9pfs->client, p9_rx_req);
>>
>>         complete(&usb9pfs->received);
>> ```
>> (I'm not sure overriding req->actual is allowed, might be safer to use
>> an intermediate variable like status instead)
>>
>> What do you think?
> 
> Yes, I think your patch is better, my initial patch forgot p9_client_cb.

Ok, let's go with that then.

Would you like to resend "my" version, or should I do it (and
refer to your patch as Reported-by)?

Also if you resend let's add Mirsad Todorovac <mtodorovac69@gmail.com> too Ccs,
I've added him now.
(Mirsad, please check lore for full context if quote wasn't enough:
 https://lkml.kernel.org/r/20250616132539.63434-1-danisjiang@gmail.com
)


Thanks,
-- 
Dominique Martinet | Asmadeus

