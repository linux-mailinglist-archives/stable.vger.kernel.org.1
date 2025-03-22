Return-Path: <stable+bounces-125813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C5A6CBF3
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 20:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7893B2433
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B864C6C;
	Sat, 22 Mar 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b="MnzIXJGb"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602542AB0;
	Sat, 22 Mar 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742670719; cv=none; b=GFsyNL7r4IGh3PgO9hHWbXhLxTrhgwsq4GSku/XdU2/np1FsTOV3uYQ4DdmsUVadGLYAww+lXn8FEGWfA4iXRR/vb7ZtcUWyplk55dyf9ZzIZpCxleyqprnOLOoLpdqZ3+CGyhNWRNau0kX2xwWcA76hR3+aQ2kWdF/hmzlQehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742670719; c=relaxed/simple;
	bh=rl7XHTSALGkshOTWUCTsRWgHWs7NO3dE7n+XvjAhlzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyFbWAjJorLmTeXQ7m8zzSgkJgIL/sgjxibeh+zdZN5teeM0rFYZ6DlSxIDEXgJFxQ/F4JHrMQ6S3gEanQUsFgmA6iQUWyeUmq+JZCgeO2QVFePcougZh7k5aGzxsM0/cNhZvAVB3rDc1r8uwaLTHvaudlu9ELygjQRRaGvv3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr; spf=pass smtp.mailfrom=grabatoulnz.fr; dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b=MnzIXJGb; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grabatoulnz.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5423D42D43;
	Sat, 22 Mar 2025 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grabatoulnz.fr;
	s=gm1; t=1742670709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl7XHTSALGkshOTWUCTsRWgHWs7NO3dE7n+XvjAhlzk=;
	b=MnzIXJGbzH9aBGTWVzWft+nr4lWZuKKQAQIclR6n/qrpJ0bsbiQGO6XARftEd0+fptD9I5
	dU3zfFp+VFxNVI7rG7884Cttz/kBQIGFWD3AHtS61jDH0E5E7v0vZT/rwCrrxvbnzh6+xn
	FV19y39qcy/iWr9qJPgFlrTUhCwqPLIqWgoz6aap6ATa8Az/xbbJqKxe9iu7LppFdEBggp
	FNrTHglsS6F5zVXLaze07yGtNRPUePz/vcDhOWII23/ZIVl7M5dMqx89E3jUb9GxP9sdI2
	h+zZ1wtSzZO2Pb21qLKZy2QK2B4JoaSfkGwVyw/ckeNngzltr25F74pdixECkg==
Message-ID: <4c0764e6-586d-42c1-9d6b-5283097f96ec@grabatoulnz.fr>
Date: Sat, 22 Mar 2025 20:11:29 +0100
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
Cc: Hans de Goede <hdegoede@redhat.com>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen> <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
 <Z9LUH2IkwoMElSDg@ryzen> <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com>
 <Z9L5p6hTp6MATJ80@ryzen> <6d125c69-35b2-45b5-9790-33f3ea06f171@redhat.com>
 <Z9hXRYQw1-fX0_PY@ryzen>
 <06f76ca1-1a07-4df5-ba50-e36046f58d88@grabatoulnz.fr>
 <5fe0557a-b9ec-4600-a10f-20c494aa2339@grabatoulnz.fr>
 <Z9k4ic4nSkbUMAPA@ryzen>
Content-Language: en-US
From: Eric <eric.4.debian@grabatoulnz.fr>
In-Reply-To: <Z9k4ic4nSkbUMAPA@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheegjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepgfhrihgtuceovghrihgtrdegrdguvggsihgrnhesghhrrggsrghtohhulhhniidrfhhrqeenucggtffrrghtthgvrhhnpeffgfdufeeigedtleelteetvefhgffguedtueejvdelueekieduiefggeejgfeikeenucfkphepvdgrtddumegtsgdtgeemleegudemsgdutddtmeegvdduieemjegvfhhfmehfvgdvheemleehrgdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdtgeemleegudemsgdutddtmeegvdduieemjegvfhhfmehfvgdvheemleehrgdupdhhvghloheplgfkrfggieemvdgrtddumegtsgdtgeemleegudemsgdutddtmeegvdduieemjegvfhhfmehfvgdvheemleehrgdungdpmhgrihhlfhhrohhmpegvrhhitgdrgedruggvsghirghnsehgrhgrsggrthhouhhlnhiirdhfrhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheptggrshhsvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptggrrhhnihhls
 eguvggsihgrnhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhhphesvghnughlvghsshhoshdrohhrgh
X-GND-Sasl: eric.degenetais@grabatoulnz.fr

Hi Niklas, hi Hans

Le 18/03/2025 à 10:10, Niklas Cassel a écrit :
> Hello Eric,
>
> On Tue, Mar 18, 2025 at 01:04:48AM +0100, Eric wrote:
>> Hi Niklas, hi Hans,
>>
>> [...]
>> The test is a success as far as I am concerned. With this new patch, DIPM is
>> disabled on the Samsung SSD, but not the Maxtor disk on the same controller:
>>
>>
>> [...]
>>
>>
>> and the SSD is successfully detected at reboot by both the UEFI and the
>> linux kernel.
> Thank you for all your perseverance!
>
> Hopefully, your efforts will make sure that others with ATI AHCI do not
> encounter the same issue that you faced.
Thank you for your work !
>
> Kind regards,
> Niklas


Kind regards,

Eric


