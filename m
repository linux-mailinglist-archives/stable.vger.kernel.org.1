Return-Path: <stable+bounces-124170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69513A5E251
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A6D189D671
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09624EF75;
	Wed, 12 Mar 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b="FLDsya/R"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874881E9B30;
	Wed, 12 Mar 2025 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799481; cv=none; b=N/s7tCsHd4Xzbnr+EuZkWp24rQPH1xkL/D5v89l/aiMxxV/mjS4L0OFUM9AXqXIOM4O1G6WH+l4u1keKZg2empBwHfwDrzHiTB5a47yceUqj3wxqu3PcK+pU2Opfu8cq/J81/u1tBgl1P7CZDv7/p1t8faqomgm5+cYEjF+zqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799481; c=relaxed/simple;
	bh=4LDcg8Sxy3EgAzkKdfJkvL6GOjFHFaDcvDYjPhhPcfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp3Tcef1YyEyg5gkuYrO3w2Rs9iNdZGWunfbEQvqQuGYvBVCIzVqxC0x1/MEnl5wmMT6wY1B6ER36OwjGduvVBJbayW6OIpl+022oJgQ6WbNCtWCJSSnxCpwv1MxK+4EiZyH82ZmPsUNq9pOung1zPlrPEocEWNZ3DVL76SchB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr; spf=pass smtp.mailfrom=grabatoulnz.fr; dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b=FLDsya/R; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grabatoulnz.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5C1C41D02;
	Wed, 12 Mar 2025 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grabatoulnz.fr;
	s=gm1; t=1741799470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bA54f/UYJzFN2KJWbZl3s2pphxeeYmUnTOD2wpcBBZc=;
	b=FLDsya/R1CtJm7yIb2bk2Y84JpEF0v6hpLl0Kaeoe0z8ra7sH7YOn+T6TuGJIS3FWKnKMu
	+FhY6yi7Cd5dNvi3O94CqGrukvhGr9/R5XePEX6HvyLp+ZgsaH2CtjixPzYfqbR7e+SNAK
	9HpVHrAKOGgn0l1cgPWJt4m6v537B/iHVXrOH5TCDnk11Wi9F7yODyILPtLgHASzpbXfJj
	MyfypselSdtalCGRjQDaQFMDeSoJF9rYDinjk7j5eHwseKF5PhMnDoCssvkgrANZVP/l/V
	odmPZpMDtRUWwjiFCkNmjGxA+T7tutstIr4JXjIx5sP8TMIaBOHFsxM5UFOlxw==
Message-ID: <9670400b-4723-4028-b5ae-5005ed3766c1@grabatoulnz.fr>
Date: Wed, 12 Mar 2025 18:11:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen> <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen> <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen> <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen>
Content-Language: en-US
From: Eric <eric.4.debian@grabatoulnz.fr>
In-Reply-To: <Z9BFSM059Wj2cYX5@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepgfhrihgtuceovghrihgtrdegrdguvggsihgrnhesghhrrggsrghtohhulhhniidrfhhrqeenucggtffrrghtthgvrhhnpeffgfdufeeigedtleelteetvefhgffguedtueejvdelueekieduiefggeejgfeikeenucfkphepvdgrtddumegtsgdtgeemleegudemsgdutddtmeegvdduieemjegvfhhfmehfvgdvheemleehrgdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdtgeemleegudemsgdutddtmeegvdduieemjegvfhhfmehfvgdvheemleehrgdupdhhvghloheplgfkrfggieemvdgrtddumegtsgdtgeemleegudemsgdutddtmeegvdduieemjegvfhhfmehfvgdvheemleehrgdungdpmhgrihhlfhhrohhmpegvrhhitgdrgedruggvsghirghnsehgrhgrsggrthhouhhlnhiirdhfrhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheptggrshhsvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptggrrhhnihhls
 eguvggsihgrnhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhhphesvghnughlvghsshhoshdrohhrgh
X-GND-Sasl: eric.degenetais@grabatoulnz.fr

Hi Niklas

Le 11/03/2025 à 15:14, Niklas Cassel a écrit :
> Hello Hans, Eric,
>
> Eric, could you please run:
> $ sudo hdparm -I /dev/sdX | grep "interface power management"
>
> on both your Samsung and Maxtor drive?
> (A star to the left of feature means that the feature is enabled)

Here is the result (apparently PM is enabled on the maxtor but it 
doesn't create the same problem) :

(trixieUSB)eric@gwaihir:~$ sudo hdparm -I 
/dev/disk/by-id/ata-MAXTOR_STM3250310AS_6RY2WB82 | grep "interface power 
management"
        *    Device-initiated interface power management
(trixieUSB)eric@gwaihir:~$ sudo hdparm -I 
/dev/disk/by-id/ata-Samsung_SSD_870_QVO_2TB_S5RPNF0T419459E | grep 
"interface power management"
        *    Device-initiated interface power management

>
>
> One guess... perhaps it could be Device Initiated PM that is broken with
> these controllers? (Even though the controller does claim to support it.)
>
> Eric, could you please try this patch:
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index f813dbdc2346..ca690fde8842 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -244,7 +244,7 @@ static const struct ata_port_info ahci_port_info[] = {
>   	},
>   	[board_ahci_sb700] = {	/* for SB700 and SB800 */
>   		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
> -		.flags		= AHCI_FLAG_COMMON,
> +		.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
>   		.pio_mask	= ATA_PIO4,
>   		.udma_mask	= ATA_UDMA6,
>   		.port_ops	= &ahci_pmp_retry_srst_ops,
Will do. I'll report back as soon as I've built the modified kernel and 
tested it.
>
>
> Kind regards,
> Niklas

Kind regards

Eric


