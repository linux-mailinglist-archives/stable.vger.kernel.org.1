Return-Path: <stable+bounces-124264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E297A5F037
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 11:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4AA188D1B1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED12B265634;
	Thu, 13 Mar 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZn710ZY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91024EF69
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860262; cv=none; b=GwlFS5kZVvZGHeposX8qNOrjeqlMy/WIYbsrffRHPpxqu17NNDKk/UfxUMEnPLuV6lxgqhqWlL7VxmABLz74Ece+/rjYyCaqA1pZiF+k8z4pPwQamzZOC+fy1iKSaoYHwI38zvJradStgksCvbchz5hYcJjDY4sD6QCALYPCneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860262; c=relaxed/simple;
	bh=wzNceDon8J/X3zofZcOallzw6jXI+2u16F6PZKC+o+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1t+i0EynJLh3iJnOon2dzrH3dwwsfPL9q2LYglXYhy9SUllatqofmBZw+nak08d9H1Tswwt5mvqRQ30klJuUw772cK6mH2Ik5r0vzemuLT6mD1ugji8UZUtKk1Np/ujjkmTNUo2bqp+lcCwtz8dHM45hpKK7kwcWxCjepUUqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZn710ZY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741860258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zp7hbJOUv8j+ICa1QmH9m0BekOtVujE7tGDQXjIFMhs=;
	b=GZn710ZY87bZIcB+tvBbkVlulr/D8b3EtQKxuC9KlS19aocjX4olJ+dWvvOOpa5apAptzc
	V+r300MR3qhbcKzRp2M9QWNNU6T35QtrIeA9UbhDErgMQk0koCAKUxgyq1BWVQB2wK1fWf
	SEzo4Fw/+0tOFDWnQPrxI44alPZlmB4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-P1z6yKGWMBGuqPGSRD9ctA-1; Thu, 13 Mar 2025 06:04:17 -0400
X-MC-Unique: P1z6yKGWMBGuqPGSRD9ctA-1
X-Mimecast-MFC-AGG-ID: P1z6yKGWMBGuqPGSRD9ctA_1741860256
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac2bb3ac7edso83503966b.2
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 03:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860256; x=1742465056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp7hbJOUv8j+ICa1QmH9m0BekOtVujE7tGDQXjIFMhs=;
        b=IHvQxreNO0tr5h7VgKp1Xrpb53tBqBl1MI1uKCEG6fB8uiDYPe8BMwKxs6GUHqL0/H
         //Ld92p40vbWB3FgxzBLrwX2jj2LxoFUVzuX3VlFGX0vA0QtsUCM/ksRldfYHxN7qCnK
         ZB+73kqsUnszRw/IfzJVDyK/9YKw8zWPLbcWrbP+lmD+lqTPivgYV5ZaqGa5685C0msK
         HgI8pjjnNMXhGLTUtTdVVl2s7EwmqEH9i2cR78tzJMBvBXvcBfJhsVj83wF/JDvipY/i
         4OR/C0uCZEIi7TyRf3LnHii/pKthTxsTLjDdf81TCB0j9UDSY/f7h2tWz67O4u1OQw7H
         AATw==
X-Forwarded-Encrypted: i=1; AJvYcCWhdZahylcpmJuY4sarWsFSJzVzlLgdx3actTAl9IZLQHFCJFsJ8mfbU6kN50ne+78H1UzFF8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2W/YSMH1US8drhdZ1SqBlGMWiTHfXxUpmZemoAlw9kIfHmWmE
	5kAJe/IAScFzvQYQe9jc8V4d+r6iOLsa2fnzIudNOsXCp+xP3cUABUE8lcNLjC/HpWmhn0RL4/L
	WTluj9a7vDM1uoWjAng3TWCCeUxMMTExyFblaRQGgC7HAngpl3O/iOw==
X-Gm-Gg: ASbGncutUujBFli6nuG/4ke2KiO0M7Tu8pZ/0IW+xACEsZA2qGxcm3rL+2J7ouKchoK
	p4GuzRvYQigR06k5hO5roqRW4sPmMLmQMIKRECQSKSP7HAjuorXFJ622mr+8Xh4tANukCKOHyqi
	lP9bE0FEtZFd7bRQ/oNuoqq80v+uhUA/rYxt6/ZgOkAu+8crBsdZ/fVbQUSwl8160opf1RU8niy
	5cAUBMN7j610YMUZOJnqwprmWciX7ExnY7+hgGrQ0MuCG5R72etQdvoekJ9wGa3BloMd1Obu2+N
	w/hgv562F2cxBwm1AP3sAtz32Sege4BBo6yY/S7rZ432HQKWiDL4SgtGHov/YalheA7JEJBCKeI
	IfD2CFgj6l5u86CqVFRO9PGPCAVp2QmSWWV6gBTcUwP0POiYotZz0Q8UxdrSaWV88aA==
X-Received: by 2002:a17:907:1b16:b0:abf:607b:d0d with SMTP id a640c23a62f3a-ac252a884cfmr3339107366b.16.1741860255890;
        Thu, 13 Mar 2025 03:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2PP7hITPCpcD7bejSrfori1Gcf1IzT/fSj09zWOA3DyhQyDL4CraOrxQAIURoaxeaOxIXCg==
X-Received: by 2002:a17:907:1b16:b0:abf:607b:d0d with SMTP id a640c23a62f3a-ac252a884cfmr3339101766b.16.1741860255380;
        Thu, 13 Mar 2025 03:04:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bbbsm62889366b.54.2025.03.13.03.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:04:14 -0700 (PDT)
Message-ID: <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
Date: Thu, 13 Mar 2025 11:04:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>
Cc: Eric <eric.4.debian@grabatoulnz.fr>,
 Salvatore Bonaccorso <carnil@debian.org>,
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
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z9BFSM059Wj2cYX5@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Niklas, Eric,

On 11-Mar-25 3:14 PM, Niklas Cassel wrote:
> Hello Hans, Eric,
> 
> On Mon, Mar 10, 2025 at 09:12:13PM +0100, Hans de Goede wrote:
>>
>> I agree with you that this is a BIOS bug of the motherboard in question
>> and/or a bad interaction between the ATI SATA controller and Samsung SSD
>> 870* models. Note that given the age of the motherboard there are likely
>> not going to be any BIOS updates fixing this though.
> 
> Looking at the number of quirks for some of the ATI SB7x0/SB8x0/SB9x0 SATA
> controllers, they really look like something special (not in a good way):
> https://github.com/torvalds/linux/blob/v6.14-rc6/drivers/ata/ahci.c#L236-L244
> 
> -Ignore SError internal
> -No MSI
> -Max 255 sectors
> -Broken 64-bit DMA
> -Retry SRST (software reset)
> 
> And that is even without the weird "disable NCQ but only for Samsung SSD
> 8xx drives" quirk when using these ATI controllers.
> 
> 
> What does bother me is that we don't know if it is this specific mobo/BIOS:
>      Manufacturer: ASUSTeK COMPUTER INC.
>      Product Name: M5A99X EVO R2.0
>      Version: Rev 1.xx
> 
>      M5A99X EVO R2.0 BIOS 2501
>      Version 2501
>      3.06 MB
>      2014/05/14
> 
> 
> that should have a NOLPM quirk, like we do for specific BIOSes:
> https://github.com/torvalds/linux/blob/v6.14-rc6/drivers/ata/ahci.c#L1402-L1439

That seems to be a Lenovo only thing though and with Intel chipsets.

> Or if it this ATI SATA controller that is always broken when it comes
> to LPM, regardless of the drive, or if it is only Samsung drives.

I'm pretty sure we can assume this will happen on all ATI SATA
controllers, the new LPM default is pretty recent and these boards are
getting old, so likely have not that many users who use distros which
ship cutting edge kernels.

I do agree with you that it is a question if this is another bad
interaction with Samsung SATA SSDs, or if it is a general ATI SATA
controller problem, but see below.

> Considering the dmesg comparing cold boot, the Maxtor drive and the
> ASUS ATAPI device seems to be recognized correctly.
> 
> Eric, could you please run:
> $ sudo hdparm -I /dev/sdX | grep "interface power management"
> 
> on both your Samsung and Maxtor drive?
> (A star to the left of feature means that the feature is enabled)
> 
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
>  	},
>  	[board_ahci_sb700] = {	/* for SB700 and SB800 */
>  		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
> -		.flags		= AHCI_FLAG_COMMON,
> +		.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
>  		.pio_mask	= ATA_PIO4,
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_pmp_retry_srst_ops,
> 
> 
> 
> Normally, I do think that we need more reports, to see if it is just
> this specific BIOS, or all the ATI SB7x0/SB8x0/SB9x0 SATA controllers
> that are broken...
> 
> ...but, considering how many quirks these ATI controllers have already...

Right in the mean time Eric has reported back that the above patch fixes
this. Thank you for testing this Eric,

One reason why ATA_QUIRK_NO_NCQ_ON_ATI was introduced is because
disabling NCQ has severe performance impacts for SSDs, so we did not want
to do this for all ATI controllers; or for all Samsung drives. Given that
until the recent LPM default change we did not use DIPM on ATI chipsets
the above fix IMHO is a good fix, which even keeps the rest of the LPM
power-savings.

> ...and the fact that the one (Dieter) who reported that his Samsung SSD 870
> QVO could enter deeper sleep states just fine was running an Intel AHCI
> controller (with the same FW version as Eric), I would be open to a patch
> that sets ATA_FLAG_NO_LPM for all these ATI controllers.

Right I think it is save to assume that this is not a Samsung drive problem
it is an ATI controller problem. The only question is if this only impacts
ATI <-> Samsung SSD combinations or if it is a general issue with ATI
controllers. But given the combination of DIPM not having been enabled
on these controllers by default anyways, combined with the age of these
motherboards (*) I believe that the above patch is a good compromise to
fix the regression without needing to wait for more data.

Regards,

Hans

*) And there thus being less users making getting more data hard. And
alo meaning not having DIPM will impact only the relatively few remaining
users




