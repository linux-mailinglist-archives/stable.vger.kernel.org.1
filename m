Return-Path: <stable+bounces-180885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F49B8F237
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 08:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6841A7AB1FC
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA532F0C5F;
	Mon, 22 Sep 2025 06:24:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA32D592D;
	Mon, 22 Sep 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522264; cv=none; b=sLkzrjuNA5b6a/e+5pjzM/maNgV1ecYUnaDDgRqF5wXLfmQzMwI01tTzhEmFcyZltbOejzGhBHjsSeCc484MuJg7JS8toNOHqwHg/agNtlUhwHXlsXaSzSu73MTrruI6uilickLytBorsYWwQ/WkEciswCafnTT53zE3mOtari8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522264; c=relaxed/simple;
	bh=zLaj/kEorTU+TDsrPw5VwC2WYQbDrFDJtAW7FmpzXOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADfpfYd6VaKoDM848AZqyyW5bTVkm3i0inFK0Ww7lZl04ZoJVnCZmH/BoWQgt8dlF/8htZLfbFpWKOeUH+cnxkYdBovLHHx3iWp70CD9e6SPp9lOx5+EtoBqcwzkGQ1BX5G5Oyan9//86qEjEQW2GPFBCbRML5Vs67jJilgj2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 55DE05830BC;
	Mon, 22 Sep 2025 06:20:09 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60CB1443C6;
	Mon, 22 Sep 2025 06:19:57 +0000 (UTC)
Message-ID: <bfffde06-5d4c-4e2c-adfe-e48590bf2f3d@ghiti.fr>
Date: Mon, 22 Sep 2025 08:19:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Use an atomic xchg in pudp_huge_get_and_clear()
To: Paul Walmsley <pjw@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250814-dev-alex-thp_pud_xchg-v1-1-b4704dfae206@rivosinc.com>
 <c8afb3b4-e5d5-628b-6bce-0b1b3137a667@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <c8afb3b4-e5d5-628b-6bce-0b1b3137a667@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhephffhuddtveegleeggeefledtudfhudelvdetudfhgeffffeigffgkeethfejudejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvvddruddtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehpjhifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepl
 hhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

On 9/20/25 03:39, Paul Walmsley wrote:
> Hi Alex,
>
> On Thu, 14 Aug 2025, Alexandre Ghiti wrote:
>
>> Make sure we return the right pud value and not a value that could
>> have been overwritten in between by a different core.
>>
>> Fixes: c3cc2a4a3a23 ("riscv: Add support for PUD THP")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>> Note that this will conflict with
>> https://lore.kernel.org/linux-riscv/20250625063753.77511-1-ajd@linux.ibm.com/
>> if applied after 6.17.
> Two quick questions on this one:
>
> - I see that you're using atomic_long_xchg() here and in some similar
> functions in pgtable.h, rather than xchg().  Was curious about the
> rationale for that?


Both functions amount to the same, I just used the same function as for 
existing similar functions.


>
> - x86 avoids the xchg() for !CONFIG_SMP.  Should we do the same?


Sounds like micro optimization to me, but up to you.


>
> thanks,
>
> - Paul
>

