Return-Path: <stable+bounces-124753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C965A6634F
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 01:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86853177924
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 00:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39727E1;
	Tue, 18 Mar 2025 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b="jwvHETpI"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F472F37;
	Tue, 18 Mar 2025 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256295; cv=none; b=q9Xbm3siZjJZwQdBmIJFKDOfhj+25/lYwnCxFdh3Bv5ABjWhciKGdZgXbloz2HKoOVSVGXKqy2LSgTDVlEGFK2DOMGGdo5lIOrKNvIYX88J9xDExY5kURqYL09smhmRlGb/wx93bZzkVi0GhxN9N7P3CSG7VbHv6h+iaFl072Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256295; c=relaxed/simple;
	bh=tq8CJmlloYYC2eaCfLaHJmKFdrQ4nc0xPppw+yoA80k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=asEvxgIp4eLDF8fNnN1XSWwHnyPK/IgL1TXdQvN1kqRU4+YJiu88QhJnQvmx90Ervxq9VrB3IluUFKfjLEEhBmSwqboTteMR6z6hrCRhLtvRzGCAbU07Rwnvr6Hsh87hxceRJ8oXUvCn3infVFHZhQ/WR81n879qy0HKY9MUUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr; spf=pass smtp.mailfrom=grabatoulnz.fr; dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b=jwvHETpI; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grabatoulnz.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37C4920483;
	Tue, 18 Mar 2025 00:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grabatoulnz.fr;
	s=gm1; t=1742256290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cnZvwqRAZ5oUuL6AcZoPaXLC4uzSfS6n9w4sjjDfis0=;
	b=jwvHETpIklG1xJuNa6j02vXLJRwWjpcheZyGlhvhDM+b1DPG0XuVs8jIb2yaRuLKWEYX3j
	HThhKziv/XSFlhuBHPIQ9KZjkI7A8m86Gsa12ePsLnoIhnoQEUoKfxVdI69obwnaKNYeVQ
	g2TdCkrsbbnf4KiNCdDn0QIIxCtS2RYdJj8ZWlIPc9Mh6EZOjIBBTLCyrwxAgh36YLYz/P
	nAgbzxG0kh6Wv44bv18kYnDDqtAxFs8Pf2GV3hvnLCU4oRaiVN1sIlq3EpVEcbMnSrwk6t
	WtUKFinCaSx1mF/Mz5LclYX0HQhcMZfk0WnH8FwDMlRlLVJgFS2fYvqgSC5fUg==
Message-ID: <5fe0557a-b9ec-4600-a10f-20c494aa2339@grabatoulnz.fr>
Date: Tue, 18 Mar 2025 01:04:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
From: Eric <eric.4.debian@grabatoulnz.fr>
To: Niklas Cassel <cassel@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <Z8rCF39n5GjTwfjP@ryzen>
 <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com> <Z88rtGH39C-S8phk@ryzen>
 <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com> <Z9BFSM059Wj2cYX5@ryzen>
 <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com> <Z9LUH2IkwoMElSDg@ryzen>
 <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com> <Z9L5p6hTp6MATJ80@ryzen>
 <6d125c69-35b2-45b5-9790-33f3ea06f171@redhat.com> <Z9hXRYQw1-fX0_PY@ryzen>
 <06f76ca1-1a07-4df5-ba50-e36046f58d88@grabatoulnz.fr>
Content-Language: en-US
In-Reply-To: <06f76ca1-1a07-4df5-ba50-e36046f58d88@grabatoulnz.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffvvehfjggtgfesthekredttddvjeenucfhrhhomhepgfhrihgtuceovghrihgtrdegrdguvggsihgrnhesghhrrggsrghtohhulhhniidrfhhrqeenucggtffrrghtthgvrhhnpeeuhffhheehvdffkeeujedvudeftdekleehvdffleegkeehteelvefhteffgfdvgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegruddphhgvlhhopeglkffrggeimedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegrudgnpdhmrghilhhfrhhomhepvghrihgtrdegrdguvggsihgrnhesghhrrggsrghtohhulhhniidrfhhrpdhnsggprhgtphhtthhopedufedprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrt
 hdrtghomhdprhgtphhtthhopegtrghrnhhilhesuggvsghirghnrdhorhhgpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjhhhpsegvnhgulhgvshhsohhsrdhorhhg
X-GND-Sasl: eric.degenetais@grabatoulnz.fr

Hi Niklas, hi Hans,

Le 17/03/2025 à 20:15, Eric a écrit :
> Hi Niklas,
>
> Le 17/03/2025 à 18:09, Niklas Cassel a écrit :
>>
>> I sent a patch that implements your original suggestion here:
>> https://lore.kernel.org/linux-ide/20250317170348.1748671-2-cassel@kernel.org/ 
>>
>>
>> I forgot to add your Suggested-by tag.
>> If the patch solves Eric's problem, I could add the tag when applying.
> I'll report back when the kernel with your proposed patch is built and 
> tested on my system.

The test is a success as far as I am concerned. With this new patch, 
DIPM is disabled on the Samsung SSD, but not the Maxtor disk on the same 
controller :


(trixieUSB)eric@gwaihir:~$ sudo hdparm -I 
/dev/disk/by-id/ata-Samsung_SSD_870_QVO_2TB_S5RPNF0T419459E | grep 
"interface power management"
             Device-initiated interface power management
(trixieUSB)eric@gwaihir:~$ sudo hdparm -I 
/dev/disk/by-id/ata-MAXTOR_STM3250310AS_6RY2WB82 | grep "interface power 
management"
        *    Device-initiated interface power management


and the SSD is successfully detected at reboot by both the UEFI and the 
linux kernel.

>>
>> Kind regards,
>> Niklas

Kind regards

Eric


