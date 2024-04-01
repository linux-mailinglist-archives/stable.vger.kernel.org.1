Return-Path: <stable+bounces-35502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94318946BD
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 23:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510201F21E04
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1D53E35;
	Mon,  1 Apr 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYea+jdw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1CC55C08
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008348; cv=none; b=rbJHbeDDjsLAcc2O1LsWI0OECDu/X7qwpAOsfNWEO3afntiiHpPbe3WhwFS6apYEZDhbIjcRKhXIK9FRilnIqKEucCO6IM5Ruby/HST/FhCmQcaWEtjPaoAbrcS26TXiwj0SlhIH80mWhEvd5gtwkzgorVvLiHz+R/RuWG+9fPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008348; c=relaxed/simple;
	bh=5fbKXR///4goIzEKJYUgn3qBpX+Q3ZKFHarBQH+0pus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXUAFIwcr80aMXsc0e131mhpag1E5f5mawnxoXfDez8EnZDYFP3rDB7EMKb+UCsmlz6KE81M6njx96retWNCTPxQneNE6GAi6Bxq2QVM5AgVlPaqaSB2p7ppIDgxvWRtM2D3bE9ORjPcjV+FGpZJHwcWVfIRgh+ELGAD0iF8+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYea+jdw; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso3233469a91.3
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712008347; x=1712613147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mM1b39oiEhT6In1uMqmz7PeUufaOToxj08phl283fC0=;
        b=eYea+jdwz8ZmBeDeu1yA9Mw6h4dI0d+xsdezaP5em7Hq7OnEI6Tf4QBZPAW6H0h/RL
         PxiGAQQg3j4l0fkV0zKcq+VktmU3xfD3oVOZEq8RK8icddkyzq5rUdb714oKpSVUSP9+
         +keTiYkOABpL0sxpWYrRZk1EI1dn3gNJ7ckPascbQXejPiBR18SR6tpmIyOJG4VkynBI
         +8jIUn7hbuZQBLg4OLTMPelSeguaaE7i/qZu1euOvsvcnaFdKMd9FwpRWV5pqK+rpE4X
         gRyjAPtDduI1sdnjn2bBd5p+ubK8TO5lkbg9DEHTzXPiDbYMZ/oniMCfqWCMiT+t/zJL
         IB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008347; x=1712613147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mM1b39oiEhT6In1uMqmz7PeUufaOToxj08phl283fC0=;
        b=qF132sSQ6cI4lkLGxscuYa3PNU4vmE01CsIuAPQrJXuMFAGRjX7bj7vB7ruvWn8PCG
         cvCc8ColDzhQrJ5SKfYBpxCZdy8namAkt6Akd0PVVTr9k8VZdVg+XQP4Qg3cFA/vRVXn
         LdVhzQsxewZkKjuLsTFNOD6BKAewzju4IkQKJd6tQ2IautDYPGhyBajBZ93h9p1N+W7Y
         NdCIe6wd8aqFgFhNAJVI15gdl/lwwiLPYCDGkLQZQFBGbGL0IiLxUikFg6DxLa1m8HnZ
         NbOfnNipVq5a44jnQ4Ng4LnsTz1S1XV/KizGoo91q80xmasq3e3pCac6IZjrk/rC9n2p
         Rf6Q==
X-Gm-Message-State: AOJu0YyipKD+qtKa6KlhJ+4M91DGyglsbX6oumqrXVTcANhKMQcSATGT
	f7aP9T/zwQWRCPLk9KdBIuTNuMZSlmN6V+W2L+5daO3ihPOJLNs/ALkFCLP2Wa0=
X-Google-Smtp-Source: AGHT+IHykcmbELfgIlTQmOtjz/TvR1jJmD8LrAAF07o/QINgHGKm5XzDN3tHHoDJDMPB34Hj+x94OQ==
X-Received: by 2002:a17:90b:4396:b0:29c:6ff8:fa32 with SMTP id in22-20020a17090b439600b0029c6ff8fa32mr7809138pjb.3.1712008346671;
        Mon, 01 Apr 2024 14:52:26 -0700 (PDT)
Received: from [10.10.13.50] ([104.129.198.116])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090ab00100b0029de90f4d44sm10502786pjq.9.2024.04.01.14.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 14:52:26 -0700 (PDT)
Message-ID: <fb216446-26d5-4d73-a5f8-faf1ba689c3c@gmail.com>
Date: Mon, 1 Apr 2024 14:52:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Add additional HyperX IDs to xpad.c on LTS v4.19 to
 v6.1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Chris Toledanes <chris.toledanes@hp.com>,
 Carl Ng <carl.ng@hp.com>, Max Nguyen <maxwell.nguyen@hp.com>
References: <20240315215918.38652-1-hphyperxdev@gmail.com>
 <2024031724-flakily-urchin-eed6@gregkh>
Content-Language: en-US
From: "Nguyen, Max" <hphyperxdev@gmail.com>
In-Reply-To: <2024031724-flakily-urchin-eed6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/17/2024 12:07 PM, Greg KH wrote:
> On Fri, Mar 15, 2024 at 02:59:19PM -0700, Max Nguyen wrote:
>> Add additional HyperX Ids to xpad_device and xpad_table
>>
>> Add to LTS versions 4.19, 5.4, 5.10, 5.15, 6.1
>>
>> Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
>> Reviewed-by: Carl Ng <carl.ng@hp.com>
>> Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
>> ---
>>   drivers/input/joystick/xpad.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

Hi Greg,
Thanks for your help so far.  I am committed to figuring this out so thank you again your patience.  I had a couple questions to confirm before I resubmit.

I had done option 1 to include in stable when I submitted to mainline.  I saw that my patch was picked up in the latest stable.  Will it be eventually picked up by the older LTS versions?

I need to add the upstream commit ID to my patches.  I intended to go with option 3 since there is some deviation in my patch from the upstream.  Am I just missing the upstream commit ID and deviation explanation for my patch?


