Return-Path: <stable+bounces-120028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76BA4B4B0
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 21:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DBB3A4433
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC61EC011;
	Sun,  2 Mar 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b="FgGwZzQc"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17EA2E630;
	Sun,  2 Mar 2025 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740947545; cv=none; b=qx7UTUQWR4BxSY6h+jZ5ApnMXADvL/TFWzGNSId9agObjX3MCTh+IVhmyOj3B8yj+EXBKj2y5jdxogqaqoHa4QKfJLVndzNvsLoamlhDF5o9fwG6V0jRHn0VB1Z0d3dvCwvs65S9tuGW0gIr1EJ6mrpjsAoyqdlKMI5AfzF+NRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740947545; c=relaxed/simple;
	bh=WgBZ0EUGu5LbJPsp1TumVU8UKT0UY2GPhCUt6jzcPDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRoQnWyyJGsWcHCBmmjEf85Y9Mvhg4sPg9/tVBjnw+wM4Rz2LYXPi2ArNQW8OvdcO5oaphsEYO5Yg466s9YkGzYTDCCHTNV38l6IGTtZVBZGTDwvQPh2k/UWNq9uSk1dLFeRpgM3cVBkboinjb64un4/iIbtUxtXaIqgv4LNKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr; spf=pass smtp.mailfrom=grabatoulnz.fr; dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b=FgGwZzQc; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grabatoulnz.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 138A241B5F;
	Sun,  2 Mar 2025 20:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grabatoulnz.fr;
	s=gm1; t=1740947534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAj8Bui5A168/ZUm/f+SKzndhklrmdcxeEf7EOra8qo=;
	b=FgGwZzQcglmWcu3KKXkfNsjGm1BMs/HLhWKY/8Ux92yeRoTWW05x8qRsFJJgoe66gfLuYp
	IvFQ4FHKnyljez78QaIQG1RpsLNsEwQdoKGtI1Ig9+cW9WHk5aqRp03lASAdbZqVkxPvX3
	UZl4zW1LtBBd3VOkwHgLjF5L+3uX05ExwIwIsgZI7uDtiOXW1muVX+Q8SYwlGuZ4R4xIza
	V4IieWfbUSOP2am63hBgoWRje4SA1fhyfIMHFcKsBtpt7uAVF0Q/wUNdRdsJSk/6BUIb1V
	SBXEcE5SQ1j3zh6Xdx97+iVzuq/xHNjjLDgzZp7v4/XNTDc2UjeDjKkq/F2nzA==
Message-ID: <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
Date: Sun, 2 Mar 2025 21:32:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>,
 Salvatore Bonaccorso <carnil@debian.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan> <Z8SyVnXZ4IPZtgGN@ryzen>
Content-Language: en-US
From: Eric <eric.4.debian@grabatoulnz.fr>
In-Reply-To: <Z8SyVnXZ4IPZtgGN@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeljedukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefgrhhitgcuoegvrhhitgdrgedruggvsghirghnsehgrhgrsggrthhouhhlnhiirdhfrheqnecuggftrfgrthhtvghrnhephfdtieeulefgudeuffeiueejgfetgfehueejgeekteeiheefffelkedujeekteegnecuffhomhgrihhnpeguvggsihgrnhdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegruddphhgvlhhopeglkffrggeimedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegrudgnpdhmrghilhhfrhhomhepvghrihgtrdegrdguvggsihgrnhesghhrrggsrghtohhulhhniidrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrrhhni
 hhlseguvggsihgrnhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhhphesvghnughlvghsshhoshdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-Sasl: eric.degenetais@grabatoulnz.fr

Hi Niklas,

Le 02/03/2025 à 20:32, Niklas Cassel a écrit :
> On Sun, Mar 02, 2025 at 05:03:48PM +0100, Salvatore Bonaccorso wrote:
>> Hi Mario et al,
>>
>> Eric Degenetais reported in Debian (cf. https://bugs.debian.org/1091696) for
>> his report, that after 7627a0edef54 ("ata: ahci: Drop low power policy  board
>> type") rebooting the system fails (but system boots fine if cold booted).
>>
>>
For what it's worth, before getting these replies I tested the 
ahci.mobile_lpm_policy=1 kernel parameter, which did work around the 
problem.
> The model and fw version of the SSD.
>
> Anyway, I found it in the bug report:
> Device Model:     Samsung SSD 870 QVO 2TB
> Firmware Version: SVQ02B6Q
>
> The firmware for this SSD is not great, and has caused us a lot of pain
> recently:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata?id=cc77e2ce187d26cc66af3577bf896d7410eb25ab
> https://lore.kernel.org/linux-ide/Z7xk1LbiYFAAsb9p@ryzen/T/#m831645f6cf2e6b528a8d531fa9b9f929dbf3d602
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata?id=a2f925a2f62254119cdaa360cfc9c0424bccd531
>
>
> Basically, older firmware versions for this SSD have broken LPM, but from
> user reports, the latest firmware version (which Eric is using) is
> apparently working:
> https://bugzilla.kernel.org/show_bug.cgi?id=219747
> https://lore.kernel.org/stable/93c10d38-718c-459d-84a5-4d87680b4da7@debian.org/
>
>
> Eric is using the latest SSD fimware version. So from other peoples reports,
> I would expect things to work for him as well.
>
> However, no one has reported that their UEFI does not detect their SSD.
> This seems to be either SSD firmware bug or UEFI bug.
>
> I would expect your UEFI to send a COMRESET even during a reboot, and a
> according to AHCI spec a COMRESET shall take the decide out of sleep states.
>
> Considering that no one else seems to have any problem when using the latest
> firmware version for this SSD, this seems to be a problem specific to Eric.
> So... UEFI bug?
>
> Have you tried updating your BIOS?

I had not tried to update my bios (bit shy on this due to a problem long 
ago with a power failure during bios update which left me with an 
unbootable machine).

However, as far as I see, there is no newer version of it :

My mobo model is :

sudo dmidecode -t 2

# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 2.7 present.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
     Manufacturer: ASUSTeK COMPUTER INC.
     Product Name: M5A99X EVO R2.0
     Version: Rev 1.xx


 From asus's website I get that the latest bios version for this model 
is version

M5A99X EVO R2.0 BIOS 2501
Version 2501
3.06 MB
2014/05/14

And I appear to already use it :

sudo dmidecode -s bios-version
2501

>
>
> Kind regards,
> Niklas

kind regards,

Eric


