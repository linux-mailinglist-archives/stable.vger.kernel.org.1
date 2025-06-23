Return-Path: <stable+bounces-156152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F46AE4CBD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CD516F1B7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8ED2D4B4E;
	Mon, 23 Jun 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK5YKi1+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E92D3A8C;
	Mon, 23 Jun 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702984; cv=none; b=Nf+4DvrCtuNt61nnNYMj+bJmiwo+T3fYqZbGVqtTJmbYJ+jl4hEVcsHTD4PKf5fWbQU87VxF4Ov0gdtkziRnYr3zVtAKaABbej4lp92gSyIh9BvYyhrcSeDdG2SW+wKJjZjgZBMTJQ9E6g0JDUo9VF/VzBQi2ErSZviwo6353Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702984; c=relaxed/simple;
	bh=yVss1NObcfteBX80RsZtJgcrS8aghWOKa6sxZlfxBB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOzl1q2pY3QBJJbbQCr9d9HwBENGKp9sCf0rsOzQVa3w1jHz5TjfdjE2eA7ypU7hD/CKdCj8BGI31UnE+dhrdCkysYCMFuGXjK2/TrDOgVkL9/wvot4UdCQfhG4NDOpIz4NBfWMm9NTFqfBRRLXaWn7uzxqOEV2OpJCHshfcJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK5YKi1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE3DC4CEEA;
	Mon, 23 Jun 2025 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750702983;
	bh=yVss1NObcfteBX80RsZtJgcrS8aghWOKa6sxZlfxBB4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tK5YKi1+fKeFW6amdvVOaTTbw0TzJ84pypUoTx93xdzWtb3xXoaysTS73WpQzadEK
	 hpqzIGUlLv12aZMhsuak+q3aJRMBpTGANlBIb2Jl41ulSJU2w9rAAuRAW7O26Mpp08
	 Pd1sSfKF5talgWCjrbxvRO6H9sOAB4gdFVf7LSRbLsTHCivJv7sbdndYxpAg8LkkBA
	 IZvwSnThn4wG5WridI/yEcjfQT8Grbxj7GhrN3mhthHPI2TRXu7Wt4/e/1AGTLTkLf
	 dOt5PdaRqrvex8POTmhPK5+4qIyIZxZL+l8i0q8g1stxU3pImak3c0Ct1iBl/U7jXk
	 /tAsUEmNCgzjg==
Message-ID: <df05fc95-84e5-4287-a5bd-f4ea081dd47f@kernel.org>
Date: Mon, 23 Jun 2025 20:23:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Use correct DMI identifier for ASUSPRO-D840SA
 LPM quirk
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org, Andy Yang <andyybtc79@gmail.com>,
 linux-ide@vger.kernel.org
References: <20250623162710.917979-2-cassel@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250623162710.917979-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 23-Jun-25 6:27 PM, Niklas Cassel wrote:
> While most entries in ahci_broken_lpm(), for Lenovo based boards,

Note the Lenovo matching is done on Lenovo laptop model / product
names not on the (mother/main)board names.

> match on
> DMI_PRODUCT_VERSION, ASUS apparently store the board name in
> DMI_PRODUCT_NAME rather than DMI_PRODUCT_VERSION.

Actually Lenovo is the weird one here, all other vendors store
the laptop model-name in PRODUCT_NAME rather then in PRODUCT_VERSION.

For motherboards the motherboard modelnr is typically stored
in BOARD_NAME and what is in PRODUCT_NAME varies.

E.g. my MSI B550M PRO-VDH desktop motherboard has:

DMI_BOARD_NAME    "B550M PRO-VDH WIFI (MS-7C95)"
DMI_PRODUCT_NAME  "MS-7C95"

So you may want to reword the commit message a bit.

Either way the patch contents looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans






> 
> Use the correct DMI identifier (DMI_PRODUCT_NAME) to match the
> ASUSPRO-D840SA board, such that the quirk will actually get applied.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Andy Yang <andyybtc79@gmail.com>
> Closes: https://lore.kernel.org/linux-ide/aFb3wXAwJSSJUB7o@ryzen/
> Fixes: b5acc3628898 ("ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index e5e5c2e81d09..aa93b0ecbbc6 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1450,7 +1450,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>  		{
>  			.matches = {
>  				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "ASUSPRO D840MB_M840SA"),
>  			},
>  			/* 320 is broken, there is no known good version. */
>  		},


