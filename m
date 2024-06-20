Return-Path: <stable+bounces-54761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A47910DC0
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C6A1F2215B
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394911B29DA;
	Thu, 20 Jun 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sn1Y7aLM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AB1B011C
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902589; cv=none; b=gbsRRqspMSfQHHZcDia281bQAnAA34bAPvjr8RXSbJ7j88GumMUDFBhfndArPq3xxb0gnugutzoKQDYCw81dmd5LtGV4GSnJRXTUA8/cTFDwDGfnDeyMVwYq/ZPLA4cFOFZ+e5YHa8dplUIIi7/INXwVlK7DIyY9DQRCctzumJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902589; c=relaxed/simple;
	bh=w0O4MJAbcUJYRoLptbk3bfA6SyPgrDXAQHMZZDms4iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfwl8AUo7xoNRqn9VlxW5M3SBOPhwEZE4wvgHoZuTstSWQeS1h4+0rr7hu/hFSTEcijbOKY/2d1bx4j+JNPZU9Olrk2I/kCgnlat/GfoookPRXGBkmvkIfzmwLBwpx78wji21k0Rl7HCjwNcfN3QNNcyGo/CcBnuo/O8VXIg9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sn1Y7aLM; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F38C53FE21
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718902585;
	bh=Iv5yHHTF6kNz7NmO2DfLiCh76upALsMsvMH1lBE+Y4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=sn1Y7aLMKhiBG99gLxp4+r0mMwkZDxhOuBWP6zUxc2KCrBsKfQe2oZl2AdY5Yqu1d
	 oy/Dfw2UXM0v8jD0tFgGmnj3jAJvI+u0gt2sUsdsUBP8GnebEgnWS80vH4v/TAFlrI
	 gC7xGyloPQaq707R90zj0XM75WEVTeDACkMHlnvFzhMbuEXUUped/5Il5Y2JJb50fD
	 P2RdtYUYquI1ZH1eel06STqFpi1VQtevAQv+06lIzlFSzKJOgfFJR3YXnRrHBLo9Kl
	 0p5VRvv07CQbRr17nVwuLuStEjazXE59KJ8BtpiIPy4WDV7yd/m2m1sn061RRcV8Gw
	 sfAINPatooIcg==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4229a964745so8014295e9.2
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 09:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718902584; x=1719507384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv5yHHTF6kNz7NmO2DfLiCh76upALsMsvMH1lBE+Y4A=;
        b=wIsC0QfJn2Nun3P1bdkjnD+5HiDhBMSm96sxZMIgGifyYceO796tNRd+62dyga171S
         Fyk0qtCrD082l6+rw2CHK3fAFxg4o3xR2RsGZ8SoGaXGQblxz3GxqYfxPzn6VP8ObdzX
         hvWEPczODWS6W+MCcXbWLS79c9/ISWt1ucwmQv6iP8V7NjbTDKAwUciw5NUvdiV3Z6jE
         87Z3mdG9/iTHVRS93c14pOjHOcFRiNQY/NEsP07/b0un556LVzW/aMHOklk6bUQZwEnQ
         7iBKEWPQAZWABpVbJLKDrJhiKQcfIQ3VmHnJ8qXRhKAytXzC2MTSeZpSMTvtySN/opbD
         QvGg==
X-Forwarded-Encrypted: i=1; AJvYcCVx5efoofYoCsC+2/SnrF6aK0ZCJ2wL5fyGMwL0ELZh4qJwMYYOKrIZjFPh+xoBa3VWqTVP9I0wTF2AwvhoMRyJWlotATmj
X-Gm-Message-State: AOJu0YwJzZUL+fqW5OlbTKdhEJXBS6MtZQXlNFQ6V1x3EFEFytshu24h
	3gRtMvAai8oW5+y8al+gRlIB5qLo+9H3ZC/dgYjCHgEFO1Khn+9lLgcbxr+d9jCjdYKROZKwMcl
	q34tuJNcTj6wtoFUfjrJxBK41JMDIs7Z9HOayNn9Fk7XDBvvtNi8tR2pBeH0QCVdf10q4xirQ8/
	DqnepQ70JxkQ==
X-Received: by 2002:a05:600c:45cf:b0:424:745d:f27f with SMTP id 5b1f17b1804b1-4247529ca74mr41175025e9.37.1718895587014;
        Thu, 20 Jun 2024 07:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+a5qhfriM35fdp5TpS87N2pOujvdZdJenKkoquwLscnAQp963+R3LOzJiWNi2fupXmQWwRg==
X-Received: by 2002:a05:600c:45cf:b0:424:745d:f27f with SMTP id 5b1f17b1804b1-4247529ca74mr41174845e9.37.1718895586620;
        Thu, 20 Jun 2024 07:59:46 -0700 (PDT)
Received: from [192.168.1.126] ([213.204.117.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54d9sm29503065e9.28.2024.06.20.07.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 07:59:46 -0700 (PDT)
Message-ID: <1fee07fd-3beb-4201-9575-5ad630386e2f@canonical.com>
Date: Thu, 20 Jun 2024 17:59:42 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] bnx2x: Fix multiple UBSAN
 array-index-out-of-bounds
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240612154449.173663-1-ghadi.rahme@canonical.com>
 <20240613074857.66597de9@kernel.org>
Content-Language: en-US
From: Ghadi Rahme <ghadi.rahme@canonical.com>
In-Reply-To: <20240613074857.66597de9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13/06/2024 17:48, Jakub Kicinski wrote:
> On Wed, 12 Jun 2024 18:44:49 +0300 Ghadi Elie Rahme wrote:
>> Fix UBSAN warnings that occur when using a system with 32 physical
>> cpu cores or more, or when the user defines a number of Ethernet
>> queues greater than or equal to FP_SB_MAX_E1x using the num_queues
>> module parameter.
>>
>> The value of the maximum number of Ethernet queues should be limited
>> to FP_SB_MAX_E1x in case FCOE is disabled or to [FP_SB_MAX_E1x-1] if
>> enabled to avoid out of bounds reads and writes.
> You're just describing what the code does, not providing extra
> context...

Apologies for the lack of explanation.

Currently there is a read/write out of bounds that occurs on the array
"struct stats_query_entry query" present inside the "bnx2x_fw_stats_req"
struct in "drivers/net/ethernet/broadcom/bnx2x/bnx2x.h".
Looking at the definition of the "struct stats_query_entry query" array:

struct stats_query_entry query[FP_SB_MAX_E1x+
         BNX2X_FIRST_QUEUE_QUERY_IDX];

FP_SB_MAX_E1x is defined as the maximum number of fast path interrupts and
has a value of 16, while BNX2X_FIRST_QUEUE_QUERY_IDX has a value of 3
meaning the array has a total size of 19.
Since accesses to "struct stats_query_entry query" are offset-ted by
BNX2X_FIRST_QUEUE_QUERY_IDX, that means that the total number of Ethernet
queues should not exceed FP_SB_MAX_E1x (16). However one of these queues
is reserved for FCOE and thus the number of Ethernet queues should be set
to [FP_SB_MAX_E1x -1] (15) if FCOE is enabled or [FP_SB_MAX_E1x] (16) if
it is not.

This is also described in a comment in the source code in
drivers/net/ethernet/broadcom/bnx2x/bnx2x.h just above the Macro definition
of FP_SB_MAX_E1x. Below is the part of this explanation that it important
for this patch

/*
  * The total number of L2 queues, MSIX vectors and HW contexts (CIDs) is
  * control by the number of fast-path status blocks supported by the
  * device (HW/FW). Each fast-path status block (FP-SB) aka non-default
  * status block represents an independent interrupts context that can
  * serve a regular L2 networking queue. However special L2 queues such
  * as the FCoE queue do not require a FP-SB and other components like
  * the CNIC may consume FP-SB reducing the number of possible L2 queues
  *
  * If the maximum number of FP-SB available is X then:
  * a. If CNIC is supported it consumes 1 FP-SB thus the max number of
  *    regular L2 queues is Y=X-1
  * b. In MF mode the actual number of L2 queues is Y= (X-1/MF_factor)
  * c. If the FCoE L2 queue is supported the actual number of L2 queues
  *    is Y+1
  * d. The number of irqs (MSIX vectors) is either Y+1 (one extra for
  *    slow-path interrupts) or Y+2 if CNIC is supported (one additional
  *    FP interrupt context for the CNIC).
  * e. The number of HW context (CID count) is always X or X+1 if FCoE
  *    L2 queue is supported. The cid for the FCoE L2 queue is always X.
  */

Looking at the commits when the E2 support was added, it was originally
using the E1x parameters [f2e0899f0f27 (bnx2x: Add 57712 support)]. Where
FP_SB_MAX_E2 was set to 16 the same as E1x. Since I do not have access to
the datasheets of these devices I had to guess based on the previous work
done on the driver what would be the safest way to fix this array overflow.
Thus I decided to go with how things were done before, which is to limit
the E2 to using the same number of queues as E1x. This patch accomplishes
that.

However I also had another solution which made more sense to me but I had
no way to tell if it would be safe. The other solution was to increase the
size of the stats_query_entry query array to be large enough to fit the
number of queues supported by E2. This would mean that the new definition
would look like the following:

struct stats_query_entry query[FP_SB_MAX_E2+
         BNX2X_FIRST_QUEUE_QUERY_IDX];

I have tested this approach and it worked fine so I am more comfortable now
changing the patch an sending in a v3 undoing the changes in v2 and simply
increasing the array size. I believe now that using FP_SB_MAX_E1x instead
of FP_SB_MAX_E2 to define the array size might have been an oversight when
updating the driver to take full advantage of the E2 after it was just
limiting itself to the capabilities of an E1x.

>
>> Fixes: 7d0445d66a76 ("bnx2x: clamp num_queues to prevent passing a negative value")
> Sure this is not more recent, netif_get_num_default_rss_queues()
> used to always return 8.
The value of the number of queues can be defined by the kernel or the
user, which is why I used the commit that I did for the Fixes tag
because it is the job of the clamp to make sure both these values are
in check. Setting the Fixes tag to when netif_get_num_default_rss_queues()
was changed ignores the fact that the user value can be out of bounds.
>> Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
>> Cc: stable@vger.kernel.org
>>   drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
>> index a8e07e51418f..c895dd680cf8 100644
>> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
>> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
>> @@ -66,7 +66,12 @@ static int bnx2x_calc_num_queues(struct bnx2x *bp)
>>   	if (is_kdump_kernel())
>>   		nq = 1;
>>   
>> -	nq = clamp(nq, 1, BNX2X_MAX_QUEUES(bp));
>> +	int max_nq = FP_SB_MAX_E1x - 1;
> please don't mix declarations and code
>
>> +	if (NO_FCOE(bp))
>> +		max_nq = FP_SB_MAX_E1x;
> you really need to explain somewhere why you're hardcoding E1x
> constants while at a glance the driver also supports E2.
> Also why is BNX2X_MAX_QUEUES() higher than the number of queues?
> Isn't that the bug?
The reason I did not patch BNX2X_MAX_QUEUES() is because the macro is
working as expected by returning the actual number of queues that can be
handled by a NIC using an E2/E1x chip. It was the driver that was not able
to handle the maximum an E2 NIC can take.

