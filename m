Return-Path: <stable+bounces-166476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F97B1A0DD
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C3A189D1FC
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55452255E40;
	Mon,  4 Aug 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8cGWlwl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B21EF39E;
	Mon,  4 Aug 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309331; cv=none; b=uHHu3aW0zUZ1FGgV3DVXGCx4M0YRljFyaA4QxJrj6jRolp6vMuXr2i/SUPKk1TzjWiXyAwMj/r6Ht60rYEoxIABWI3QIXQvwfAEhgsoPRSrbyzL3jpFdqRuuTz30ss5BrT5V1f0/0XO+6xA3vnIAy3lJN67Vks3hP7hLc4/4t/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309331; c=relaxed/simple;
	bh=YGSO5X0nuiZ854QyAUDIn8QwdSxWBr3sO5oQ1hm84MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAUkO2KhoHarDSJeeqQB2PlVlqwqVRSsBTlqmywkhNX9KvvPmh8UL5cYv3Ffp74a71kXzIzidCeE71JhabLsauK4BzWjBkQJMME9rlieh5o12mFKMh948CirK5b3lOiAAEk0zANXfXP/GQ0s0R7jXQrMNGP5S1270Syiwig1r4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8cGWlwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D7AC4CEE7;
	Mon,  4 Aug 2025 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754309330;
	bh=YGSO5X0nuiZ854QyAUDIn8QwdSxWBr3sO5oQ1hm84MM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R8cGWlwl6UdZ8ilRCYMUYr7w8mQdlzDEpoBjja8FLQydOchJb/o067FBSrWIq2Ze5
	 Vx0hntCRE/WhhDa8iF10Og1KygSbXlEKDHGgl+SYpc/2f2Mmzp8pblyH0ONLVTlNRM
	 uuE/jsgpQoASDsqfk0zkxSBcRcCaxPmQexZfPhCC4xrmaZWh52coeYIDfAPorUS9Nn
	 pKrdc1DG1adlugShSNyuWlJB4hNREYwuQamCVST4LZOBRkAIHzriZt64z/Oi6Luos3
	 U0Jh95N6cCh24444V/efQO8hogpweb0WdgkKPwOrOO58SEKKbkETkGfjqU8ADWHMHU
	 gmTq6VC2PoQrA==
Message-ID: <7e144b7f-8bc5-45f2-87af-acc1d7a70fb1@kernel.org>
Date: Mon, 4 Aug 2025 14:08:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read
 regmap_config flag
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250804083419.205892-1-hansg@kernel.org>
 <CAHp75VdfJvKb6VegNWCiiKoQkMBf0dQPs5yP3XfPM1icgtuyeg@mail.gmail.com>
 <592e9a1e-a58f-435d-aff7-13c13fe0598a@kernel.org>
 <CAHp75VcxZXk7N3F4f=edSTHXQO9reF2kvF3JUNxNu_J6VOuoRA@mail.gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <CAHp75VcxZXk7N3F4f=edSTHXQO9reF2kvF3JUNxNu_J6VOuoRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4-Aug-25 10:57 AM, Andy Shevchenko wrote:
> On Mon, Aug 4, 2025 at 10:51 AM Hans de Goede <hansg@kernel.org> wrote:
>> On 4-Aug-25 10:47 AM, Andy Shevchenko wrote:
>>> On Mon, Aug 4, 2025 at 10:34 AM Hans de Goede <hansg@kernel.org> wrote:
> 
> ...
> 
>>>> +       /* Reading multiple registers at once is not supported */
>>>> +       .use_single_read = true,
>>>
>>> By HW or by problem in regmap as being suggested here:
>>> https://lore.kernel.org/linux-gpio/CALNFmy1ZRqHz6_DD_2qamm-iLQ51AOFQH=ahCWRN7SAk3pfZ_A@mail.gmail.com/
>>> ?
>>
>> This is a hw limitation. I tried with i2ctransfer to directly
>> access the chip and it returns invalid values (1) after
>> the first byte read.
> 
>> 1) I don't remember if it was 0, 0xff or repeating
>> of the first byte. But it definitely did not work.
> 
> Perhaps elaborate the above in the comment, by at least putting
> keyword HW there?

Ok, I've just send out a v2 clarifying the comment.

Regards,

Hans



