Return-Path: <stable+bounces-154826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF3FAE0E2C
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B771BC56A5
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881EA1E8342;
	Thu, 19 Jun 2025 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm6A5MCj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006830E84F;
	Thu, 19 Jun 2025 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750362399; cv=none; b=a6OabKymN5orfPBoV3vPTE+lBIiaZAwBsiO8sWB2K4Gll/UkvuP/4c6J+BZ3KV8cf7LYsqM6u9CPbeZtB2wW+Ga03CYx0WE6iDxaEUqbkS+F1cVJjCNW0E6An9D0XE9bPcgYbBZihuh9mJOJYjOJfIy+vObbB5Vt0+E1hRocOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750362399; c=relaxed/simple;
	bh=MASH+kTZsKvi5+VHnn3W5k6X1hgb4oFZp0idBrnCUis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF8rrAevOeAa/6daCbH6qThU36Io6PRoHXRiPZDaMNc5Qv+FrbmcnZDDMy8gfnYioJfcOT8nrkkCoM3tRw1vNv27PQgtJyUPoZ2M1MNWGKD+5BBtt7uxkOKt2Ryi8Lw4+aDMLrCaOY+gybxwh3hypv1tuAaCQMJojK7KFDRZCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm6A5MCj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234b440afa7so12009855ad.0;
        Thu, 19 Jun 2025 12:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750362397; x=1750967197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iC29fuO8mbswXSn6G5clAGlBNuIVVD5fTppqMkm/Nrg=;
        b=cm6A5MCjv29uR5VyKBNJ9FCj4SegJgqok0e4/07T/RkRoJxjNvxxmyo2AWnJXkZtiV
         n48ytGIXm+fBSrXy/36uTWbRV/LnMN5P3hiqPkM35z5ansPFa3Hdx2kqE7NUWJp0t2S3
         BZI43rW5Fa+HyRHHy7rsz4x/QYZ0Zkyivjegm7XHWwHNy/FCEyMLxqVOMuMppwDFni6K
         0UHbDkY3OijCsnONML5TwWl/QCQcTQPebC+N8cf2wlCl529t1bVKLE3J/qV/mjFT7IlM
         RynZpC6C/FJFQ6wLIdR26KHoQyygkWLl4jo+P/P3z/OCMJgQqL0Nt9Kon7YDz7b0vjZB
         ToNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750362397; x=1750967197;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC29fuO8mbswXSn6G5clAGlBNuIVVD5fTppqMkm/Nrg=;
        b=cPIBdvKiMbJv+0UuDXdqbZyam4ZacsIn6N/ktx0dHR1CULbjv4myJH31gOwudskIpZ
         JTzueWev+GAUA0gi+c/KO5dredI85Ip3DbjdtfuPWZplPdreaJ4VPPPsY7yFRZkY35yw
         4b2AkI1mPUHH6FlTwiGqadWg46EyMmBuvm0qnkkYlAOYvTV/Mn8sFn6h7wGKnmKSpjuI
         DMKpFCdVniZ4/fqL9jtWOvsr4DX43XWOUlNOQMWZ5iXvHJjQtBhlFJRFo87a9ruUifmF
         leUyIyilhTDMtH7Y1os5LiChkzvuXIP0osuI2ot2L8RFSJbzLpjmwqa6ALj6YcIYWV02
         FjBg==
X-Forwarded-Encrypted: i=1; AJvYcCXjTuUoR2cdAknmu2/3m1NWyzcqj/kV0cApd7MrADyQGCVBMssy/vYCNAwO0n/Cxz+y/41rMc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnedCVZ71BeVpk+N6Yzbpb5QG3czGz8z19v0s+NodxWmMuK7f
	VSgSeP7mCiRrNts6s/SNdq1OTThFbPuh3lhvvT9BQ54TPumIf7d7wFpg
X-Gm-Gg: ASbGncsWQ/3oQRIw0aim7NW7PNQbJnm+CeGR8i+CBvCGEkJV46kOEQwQ4DDQ2cEKq9H
	bAcf4dEmmcb9vUfrmZxvqJD/ZQevQIGjMIXNiFxOO3hbr9Mj2WLbe6cDa8VlHN7Pk3M0Jhs1iS8
	/7VvstigEA0WbZt3+2i//y5b7IKM1eflqpLugVi17i7B3a3ER0Ext+0tI7dHr3YHz+cueQBhKdr
	tGYbcmJg+N6DumJXxK0j/GMQCL2Ql5pEsZ0quCv4Epwm9vo0ZTzNnXcCj89vqhj+NjLn1qNO3+s
	1l6YQ3Gei4EQkT9WW3uL4W4OlkPqETr0sH5dnn0g43X65ODo3DVOjeei+ms1rR9H46fLxpBoS1B
	Ny9XXqtAauWQrsj/EHrMtHPEq
X-Google-Smtp-Source: AGHT+IEzKjqVNqmf4xOc4yV1g/AX4iLbEtAvpXqbmJy/eBU++oEkbmywSG0qcYIRGMspOnXI2U9TZw==
X-Received: by 2002:a17:903:2311:b0:235:866:9fac with SMTP id d9443c01a7336-237d96b63bfmr1993805ad.2.1750362396889;
        Thu, 19 Jun 2025 12:46:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86f8261sm1307595ad.221.2025.06.19.12.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 12:46:36 -0700 (PDT)
Message-ID: <52564e1f-ab05-4347-bd64-b38a69180499@gmail.com>
Date: Thu, 19 Jun 2025 12:46:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tulip 21142 panic on physical link disconnect
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Greg Chandler <chandleg@wizardsworks.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
 <385f2469f504dd293775d3c39affa979@wizardsworks.org>
 <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
 <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
 <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com>
 <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org>
 <12ccf3e4c24e8db2545f6ccaba8ce273@wizardsworks.org>
 <8c06f8969e726912b46ef941d36571ad@wizardsworks.org>
 <alpine.DEB.2.21.2506192007440.37405@angie.orcam.me.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCZ7gLLgUJMbXO7gAKCRBhV5kVtWN2DlsbAJ9zUK0VNvlLPOclJV3YM5HQ
 LkaemACgkF/tnkq2cL6CVpOk3NexhMLw2xzOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJn
 uAtCBQkxtc7uAAoJEGFXmRW1Y3YOJHUAoLuIJDcJtl7ZksBQa+n2T7T5zXoZAJ9EnFa2JZh7
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <alpine.DEB.2.21.2506192007440.37405@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maciej,

On 6/19/25 12:36, Maciej W. Rozycki wrote:
> On Thu, 19 Jun 2025, Greg Chandler wrote:
> 
>> So what I know for sure is this:
>> The tulip driver on alpha (generic and DP264) oops/panic on physical
>> disconnect, but only when an IP address is bound.
>> It does not panic when no address is bound to the interface.
>> It does not matter if the driver is compiled in, or if it is compiled as a
>> module.
>> It does not matter if all of the options are set for tulip or if none of them
>> are:
>>      New bus configuration
>>      Use PCI shared mem for NIC registers
>>      Use RX polling (NAPI)
>>      Use Interrupt Mitigation
>> The physical link does not auto-negotiate, and mii-tool does not seem to be
>> able to force it with -F or -A like you would expect it to.
>> The kernel does not drop the "Link is Up/Link is Down" messages when the PHY
>> "links"
>> The switch and interface both show LEDs as if linked at 10-Half-Duplex, and
>> the lights turn off when the link is broken.
>> Subsequently they do relink at 10-Half again if plugged back in.
>> I did also attempt to test the kernel level stack for nfsroot, just to see if
>> it worked prior to init launching everything else, and it did not.
>> I used the same IP configuration for that test as all of the tests in these
>> emails.
>> All of the oops/panics seem to happen at:
>>      kernel/time/timer.c:1657 __timer_delete_sync+0x10c/0x150
> 
>   FYI something's changed a while ago in how `del_timer_sync' is handled
> and I can see a similar warning nowadays with another network driver with
> the MIPS platform.
> 
>   Since I'm the maintainer of said driver I mean to bisect it and figure
> out what's going here, but haven't found time so far owing to other
> commitments (and the driver otherwise works just fine regardless, so it's
> minor annoyance).  If you beat me to it, then I'll gladly accept it, but
> otherwise I'm just letting you know you're not alone with this issue and
> that it's not specific to the DEC Tulip driver on your system.
 > >   For the record:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1563 __timer_delete_sync+0x110/0x118
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.4.0-rc3-00030-gae62c49c0cef #21
> Stack : 807a0000 80095a8c 00000000 00000004 806a0000 00000009 80c09dac 807d0000
>          807a0000 807056ec 80769fac 807a13f3 807d30c4 1000ec00 80c09d58 80787a18
>          00000000 00000000 807056ec 00000000 00000001 80c09c94 00000077 34633236
>          20202020 00000000 807d7311 20202020 807056ec 1000ec00 00000000 00000000
>          806fcb60 806fcb38 807a0000 00000001 00000000 fffffffe 00000000 807d0000
>          ...
> Call Trace:
> [<80048ecc>] show_stack+0x2c/0xf8
> [<80645c88>] dump_stack_lvl+0x34/0x4c
> [<80641d00>] __warn+0xb4/0xe8
> [<80641d84>] warn_slowpath_fmt+0x50/0x88
> [<800b177c>] __timer_delete_sync+0x110/0x118
> [<8040f4b0>] fza_interrupt+0x904/0x1004
> [<80098d7c>] __handle_irq_event_percpu+0x84/0x188
> [<80098f1c>] handle_irq_event+0x38/0xbc
> [<8009d4e4>] handle_level_irq+0xc8/0x208
> [<80098110>] generic_handle_irq+0x44/0x5c
> [<8064f450>] do_IRQ+0x1c/0x28
> [<80041cf0>] dec_irq_dispatch+0x10/0x20
> [<80043754>] handle_int+0x14c/0x158
> [<8008bf64>] do_idle+0x5c/0x15c
> [<8008c368>] cpu_startup_entry+0x20/0x28
> [<8064657c>] kernel_init+0x0/0x114
> 
> ---[ end trace 0000000000000000 ]---
> 
> -- the arrival of this particular device state change interrupt means the
> timer set up just in case the device gets stuck can be deleted, so I'm not
> sure why calling `del_timer_sync' to discard the timer has become a no-no
> now; this code is 20+ years old now, though I sat on it for a while and
> then it took some time and effort to get it upstream too.  The issue has
> started sometime between 5.18 (clean boot) and 6.4 (quoted above).
> 
>   Maybe it'll ring someone's bell and they'll chime in or otherwise I'll
> bisect it... sometime.  Or feel free to start yourself with 5.18, as it's
> not terribly old, only a bit and certainly not so as 2.6 is.

I am still not sure why I could not see that warning on by Cobalt Qube2 
trying to reproduce Greg's original issue, that is with an IP assigned 
on the interface yanking the cable did not trigger a timer warning. It 
could be that machine is orders of magnitude slower and has a different 
CONFIG_HZ value that just made it less likely to be seen?
-- 
Florian

