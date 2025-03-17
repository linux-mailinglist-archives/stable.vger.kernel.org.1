Return-Path: <stable+bounces-124736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10244A65DB0
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 20:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41613B7621
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B51DE2AA;
	Mon, 17 Mar 2025 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b="RlXvvYOZ"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF345BE3;
	Mon, 17 Mar 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238963; cv=none; b=guhymBI98qmVodHba783F5I5IoXwcWRoSyrapPU4VweHMYKAZpCcYEJhJzY1inQbv9xCg0vkjEssVHdJC10Tz2WD1vuPWwdqNc0ZtrqFfFUcF+TSjas21/gAKUWm1F9T68ZZQWg6988VN48oJxybWBHbfzaW+PMjYMvSbGFPUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238963; c=relaxed/simple;
	bh=XhMpa/9ycy9v4wKZ+kzITAJZDZd9KukS6JT0HJiU3eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gARM57RGggi2hfQPc9dGvIKeCdlG4alntmhkn7RiztVUACX+Lllz5WA1UdyNjEno9QMVV6ic5DfeyNH6hj2zPNHRPuYGdMvpq3C2kvGqCWr6KW0GvplTpzoZEkGuHxPQnJfXfX5QjpheONNmiUZKOaEDLVIQscle0niB5WkPocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr; spf=pass smtp.mailfrom=grabatoulnz.fr; dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b=RlXvvYOZ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grabatoulnz.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E7FE41DF4;
	Mon, 17 Mar 2025 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grabatoulnz.fr;
	s=gm1; t=1742238959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KykuL0mQ6nnqkDB6Avuz8qXKuB1dwfpUj+NOwP1wvQQ=;
	b=RlXvvYOZImWR7jpdNpLxs0YPpYOeLXrX3ptOL4CvSbmX/qNjoMUYZlxrmhhi7bAd7MTvRS
	LVVn88PB8O4eUakx/inc/myUoSeYSnZuRMbrDzip271VTK5ugKj/lDo1ffelY5NtUsSLkN
	FTO38e88o/ayyvcFhf0aMjvfu2twOLR/rHR7/EQFhBlGDbjbPhDA0Ud35bbp1b7DSTMjSD
	Zh+dUyPQMRLMdLlhR2Tb1Zf5VrR0XjixGGx/DPWpNcLlPydUpGIYNp5Q5O+9GsbybJt4X+
	V1eqA7JZ6lFy4EXO+C5dQ7R2H3PHJG6DvJe4cZ+D4GnLYzlFBO2rQtIJ6W2rRQ==
Message-ID: <06f76ca1-1a07-4df5-ba50-e36046f58d88@grabatoulnz.fr>
Date: Mon, 17 Mar 2025 20:15:47 +0100
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
References: <Z8rCF39n5GjTwfjP@ryzen>
 <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com> <Z88rtGH39C-S8phk@ryzen>
 <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com> <Z9BFSM059Wj2cYX5@ryzen>
 <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com> <Z9LUH2IkwoMElSDg@ryzen>
 <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com> <Z9L5p6hTp6MATJ80@ryzen>
 <6d125c69-35b2-45b5-9790-33f3ea06f171@redhat.com> <Z9hXRYQw1-fX0_PY@ryzen>
Content-Language: en-US
From: Eric <eric.4.debian@grabatoulnz.fr>
In-Reply-To: <Z9hXRYQw1-fX0_PY@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepgfhrihgtuceovghrihgtrdegrdguvggsihgrnhesghhrrggsrghtohhulhhniidrfhhrqeenucggtffrrghtthgvrhhnpeevffegtdduieefhfeihfdtudefjedttdefhefhtefftdeujeeileehteeuieegheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegruddphhgvlhhopeglkffrggeimedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegrudgnpdhmrghilhhfrhhomhepvghrihgtrdegrdguvggsihgrnhesghhrrggsrghtohhulhhniidrfhhrpdhnsggprhgtphhtthhopedufedprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrt
 hdrtghomhdprhgtphhtthhopegtrghrnhhilhesuggvsghirghnrdhorhhgpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjhhhpsegvnhgulhgvshhsohhsrdhorhhg
X-GND-Sasl: eric.degenetais@grabatoulnz.fr

Hi Niklas,

Le 17/03/2025 à 18:09, Niklas Cassel a écrit :
>
> I sent a patch that implements your original suggestion here:
> https://lore.kernel.org/linux-ide/20250317170348.1748671-2-cassel@kernel.org/
>
> I forgot to add your Suggested-by tag.
> If the patch solves Eric's problem, I could add the tag when applying.
I'll report back when the kernel with your proposed patch is built and 
tested on my system.
>
> Kind regards,
> Niklas

Kind regards

Eric



