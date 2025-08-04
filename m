Return-Path: <stable+bounces-166453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D13B19DFD
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F80178304
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE61242D8E;
	Mon,  4 Aug 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3D7OXgi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9E242D89;
	Mon,  4 Aug 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297505; cv=none; b=JTVkWtHyOPK7PnxRs9Fe8U54WX3u7id5rmfhaKjPVga5/oe+YIkYDvO28BK6v3J9J9EfztNCar1Jv4LUSDE9fFppfElVXL/r1uOuTd2lku9uhkMS5IQLlM28iap6JDc13Md6DdCurPWI6otYpB5rDpctDeGBOOPxeZdwhWmjX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297505; c=relaxed/simple;
	bh=6BVLxWZDI6oTK0aU1mKaqp/Pgk0nOrw3tsRdbFp16HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osK1YhNuzFbrJG87XafrSVPP+PFo6/Rwja2cND53sCwdcHCtQVnfzzae5YnMQNsU9/mdXOr6OG1+AzeBhvxrsrEpdTykHO/dvnQSTBb5dMDCSWmXcCUJ9z9J8cBaKKwxpCAdUMVMu3gwzYC38F7w7UG51MEvnOuuCvR2Kh8o6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3D7OXgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A78C4CEE7;
	Mon,  4 Aug 2025 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754297504;
	bh=6BVLxWZDI6oTK0aU1mKaqp/Pgk0nOrw3tsRdbFp16HI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C3D7OXgiMHabUt/rRD2FtPPdy8d8FouZqA+W80TuQoGYUBZ1DezjM2p0AZgo7NtZw
	 ioz6HXkBw0633CzdgZ9w35jdE/5S/Dgo8Dg/eYnCGCo0bJQBzZAAGMsDhDas3GqEaB
	 Sb+gwC0dGyh1Vf+ve7cqOXEGTLKrNOL6gWWY/XR+xesiLNfgp62ejlorSjANpdwkq1
	 M8QW3/8Q6lxxjY4st1QPVAywKJPkkPXqKlzPkRWuzSkbldqMQy/FtiPQXdRheeKgOP
	 8nNdQ6cRH9nANNGYHPNHcwPHCipgUjuJIW7lW/GHgLLIVXKyZlhcdVZtK3OLyQR4vJ
	 YF0JFPVUT6tUg==
Message-ID: <592e9a1e-a58f-435d-aff7-13c13fe0598a@kernel.org>
Date: Mon, 4 Aug 2025 10:51:42 +0200
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
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <CAHp75VdfJvKb6VegNWCiiKoQkMBf0dQPs5yP3XfPM1icgtuyeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On 4-Aug-25 10:47 AM, Andy Shevchenko wrote:
> On Mon, Aug 4, 2025 at 10:34 AM Hans de Goede <hansg@kernel.org> wrote:
>>
>> Testing has shown that reading multiple registers at once (for 10 bit
>> adc values) does not work. Set the use_single_read regmap_config flag
>> to make regmap split these for is.
>>
>> This should fix temperature opregion accesses done by
>> drivers/acpi/pmic/intel_pmic_chtdc_ti.c and is also necessary for
>> the upcoming drivers for the ADC and battery MFD cells.
> 
> ...
> 
>> +       /* Reading multiple registers at once is not supported */
>> +       .use_single_read = true,
> 
> By HW or by problem in regmap as being suggested here:
> https://lore.kernel.org/linux-gpio/CALNFmy1ZRqHz6_DD_2qamm-iLQ51AOFQH=ahCWRN7SAk3pfZ_A@mail.gmail.com/
> ?

This is a hw limitation. I tried with i2ctransfer to directly
access the chip and it returns invalid values (1) after
the first byte read.

> As a quick fix I am fine with this.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thank you.

Regards,

Hans


1) I don't remember if it was 0, 0xff or repeating
of the first byte. But it definitely did not work.




