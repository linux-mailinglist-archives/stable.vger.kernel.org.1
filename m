Return-Path: <stable+bounces-5506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A3A80CEC7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D6B1F216DF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D14495F4;
	Mon, 11 Dec 2023 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="axm5/STb"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E09ADB
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702306608; x=1702911408; i=deller@gmx.de;
	bh=JYU97U9zV51crpx6oD7Sozcj9lOpG+Ge0aDGQEAnIT4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=axm5/STb4+gsvKltf1jZujXVNkLqNfNYX7lJkX4lGbKBc375ZP3BBVqKsv59XXPj
	 xRCOE2ETQ85lcPXAeCpW4hQlOiBork4vQlDmaXqkinPWOE6H+SNlXcKP+e3sqhtsE
	 uAEm4LEPKNyiQSougMmUp/JA4yMaZGshLI55s+Xg12A9yNzqIqLcZpj002E9kfiOR
	 DzOCZMM3IjDCR//oXQY4CTdMQ/7TThe/EOXJEFBAkLrUOJ5gPo5hLzOxEx51xyHo1
	 4QkGsjsrHp+tLNu0eriFN+7NZzvwX8lP3co4LDO4yaVl2Q8a4CfN8I8RSmJivkdZZ
	 I5cSPkvSWxWPcSrOTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.152.58]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1rkwbM1wyS-00aRSH; Mon, 11
 Dec 2023 15:56:48 +0100
Message-ID: <aa3d0bc0-5108-4ec5-831d-27d9f326fee1@gmx.de>
Date: Mon, 11 Dec 2023 15:56:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] parisc: Fix asm operand number out of
 range build error in" failed to apply to 6.1-stable tree
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lkft@linaro.org, stable@vger.kernel.org
References: <2023120949-waged-entail-7b6b@gregkh>
 <c5d9b509-3c37-419b-a325-971d9b2c7c56@gmx.de>
 <2023121129-preoccupy-hypnotize-a2ea@gregkh>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2023121129-preoccupy-hypnotize-a2ea@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GeozyZBjxL4nVWrg/zkzIQrlZVuekutVfN6Uu4+N7QmquFefSm0
 Dy10hFm8TPfS2WeHAkA0b1+krjHN5NIiD6m7mlIRr35RjVhOkTS5OMOvB5XK7d3uC8GIb/N
 H/qssGZqDxMbp9zzdx/+8EAXwNWBIIpphdk4uZLxJRS4Vylo45Xe4VXU5a2K1Kmv0qtvW4F
 w2PBRJy61FkfKiBKzYdJA==
UI-OutboundReport: notjunk:1;M01:P0:Qu+IsxrpDAU=;GY/KHD8+vzVsDOzVqdUfbaIwBDj
 0/etpwZjpKUyTpAEXywVN1fW6xqR5M1tWoOzXi+S6F0JN97avYZougbL07C2YwVATyc0vYOrx
 GFPQM3RwbiKb6O2/VtO3kWZu/F/A6wmVATJffs/BJ0tIOwl8apu7EiJ6A21Xys+K3GiO15H7u
 JmuKWxIshdP4PHwHt/wkK4xDJ9yK3h63iiprNI82O+rU84Pu+RNbE5RQHOkF7jIek6gzEg4yJ
 qKJFFy1mHVSAqFGHB238nw4N0JAqf9f1uACPfhvRK4qBE+9U/TriKm3VpKOkMFO1IGIq3bZ6B
 nbCaH4LO6RFZSSohNWBAQQeMcUzPfboGFLkQC/ZwRv9YBnzyZbQBs2FMIOPznM7zt7pAcUDPl
 Q2kwyR9UG8gZp9OcFV/2hHtiCpbUZJAXQIJJhOXgZnYYsiIyyMZlPW+1WMF1zT2Ee8bsXdx+X
 ZsJ3nOp0flBmhZWADwfeOX1yP/9Ot2E0DrgGOU+oFagANgrCgH7t648IJl5zKqe0MW/3N+CjY
 MYkcDNgccN8MLhbII675BgjOG5vo1CFYTbTtFyXBHgv8qtgMIG624i9e8Hzxp1HqHji+EZPKE
 bi36lyoXT/1PlFb4zFIRWgGL/4d8cUZNGP2/Bw6ROuiwU4FUJq2Ebw2oz827I8ZAhd4Y89rXw
 RfKXaXEuPIQP7EZy+oYGK4LrUh404ovyv1ancDPwqA0jtOOoxhzCmNN+8TdPdT+j60UFhYEi/
 CGaBAQQzutMDaCDFATUgXSABG1oaa5tU6y/ARWhCNbV/6rFOJgcHYooYjW8BeXmQHOpIm8E/u
 jpglbqcZeIanNVEu+y5gtQdcQMREp2enbcGm+pE7CPQJrwvJNGlIh/W29O2CVHomvHh1fUHiJ
 V2areAAGEdB45XBsOS3NRbWVf7liY0HZhtLlD3NpnGY1SVCCDMOty69mbZHEHw1JkduuRF0gf
 ZQC4Uw==

Hi Greg,

On 12/11/23 07:44, Greg KH wrote:
> On Sun, Dec 10, 2023 at 05:43:53PM +0100, Helge Deller wrote:
>> On 12/9/23 13:33, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.1-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commi=
t
>>> id to <stable@vger.kernel.org>.
>>
>> Right, it does not apply, and does NOT need to be backported.
>
> Are you sure?
>
> I ask because:
>
>>> Fixes: fe76a1349f23 ("parisc: Use natural CPU alignment for bug_table"=
)
>>> Cc: stable@vger.kernel.org   # v6.0+
>
> Both of those lines imply that yes, it should be backported.  Are they
> incorrect?

Oh, I added a wrong "Fixes:" tag in the upstream commit. Instead it should=
 be:
Fixes: 43266838515d ("parisc: Reduce size of the bug_table on 64-bit kerne=
l by half")
but this commit was originally not tagged for stable series.

I see Sasha pulled it nevertheless into stable-rc series, together with th=
is commit
here: "parisc: Fix asm operand number out of range build error in".

So, either we keep both (as it is currently in stable-rc), or we drop both=
:
* parisc: Reduce size of the bug_table on 64-bit kernel by half
* parisc: Fix asm operand number out of range build error in

I'm fine with either option.

Helge

