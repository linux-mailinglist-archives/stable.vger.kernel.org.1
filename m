Return-Path: <stable+bounces-181817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E9BA5F56
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 14:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0699A1B25362
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B192BD58A;
	Sat, 27 Sep 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="EOgM57Rd"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BCF19EEC2;
	Sat, 27 Sep 2025 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758977560; cv=none; b=A5zxSTGdRUoHe8g95dgEhZeM6tBuHCMvU8Vqd7pCNImobVq2X9UR7wR84ZkLEaTi70OJy1StE8ZiiRNfUIfqR4rpt9sO9eRMU1rVZ/RZRjIKtqH1AjP5J6PEaRkhOA0ACWDz8TxHCoB3MKMxyWQch+/dpPsm1inhtYDbtkgIMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758977560; c=relaxed/simple;
	bh=Kip3Y52LPzsw3NokHY3x7d/lhzyHtv+aHu3U8gq6X0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLS+VwMJ00iBfAYFLB5T2gJI/F8FHpY5vQ/LFTIW/+fd5yZP0yE2DUpstwswYOl9WifLHqvgkTk00Bk+9VNcDpS5g09y6BRVVvaIyZuCW10q1HUvIs7Hu2aBJ/UE8gSCt76i9xCjg5oa5xX6bHYNpDT++PKeHHTNgpQKHH81XKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=EOgM57Rd; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=m7XhDd4jsev9nk0x+Srd8ojE9ytbJ4lWpHxfd3vE8M8=; t=1758977558;
	x=1759409558; b=EOgM57Rd8fbQxYDdFbdHHB1qx8AGaxvNkeIemnjKqRRIwbqY63v/GIj1yBmge
	GxeVTWypAzZ9g+oSZpfFj/GnWtXAYTocAPCne8AlmioscwLJjY+5hz10K3gFaZFAOixaoVAyw8zBj
	NVVrQGgcQPoYeHITFAWd38KQ2UXtQYWChpAWTlAArifmCxdHpJb7rJ8IEPj1XKfT+p9tuRmhL7cws
	55+d20s7pUS/OGjd+XZsYNw4FMUzQGD0OUBNeYE1QZzuSA86ib+OVCQwC4RuyYhK5fdZw4OP3ljOQ
	IJOueP7WoZ7zjOGo5hl2wQG2NE2BePsZPP8tASeJIBDShH+eWA==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1v2UPk-00BNG2-07;
	Sat, 27 Sep 2025 14:52:36 +0200
Message-ID: <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>
Date: Sat, 27 Sep 2025 14:52:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't
 boot with 6.16.9 and Xe driver
To: =?UTF-8?Q?Iy=C3=A1n_M=C3=A9ndez_Veiga?= <me@iyanmv.com>,
 stable@vger.kernel.org
Cc: regressions@lists.linux.dev, daniele.ceraolospurio@intel.com,
 sashal@kernel.org
References: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1758977558;4380b613;
X-HE-SMSGID: 1v2UPk-00BNG2-07

Hi! Thx for your report.

> Hello,
> 
> After upgrading to 6.16.9 this morning, my laptop can't boot. I cannot
> get any logs because the kernel seems to freeze very early, even before
> I'm asked for the full disk encryption passphrase.
> 
> This is a regression from 6.16.8 to 6.16.9.

Does 6.17-rc7 work for you? We need to know if this needs to be fixed in
just the stable tree or if it is something that needs to be addressed in
mainline as well.

> I did a git bisect in the stable/linux and this is the commit causing
> the issue for me:
> 
> 97207a4fed5348ff5c5e71a7300db9b638640879 is the first bad commit
> commit 97207a4fed5348ff5c5e71a7300db9b638640879 (HEAD)
> Author: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Date:   Wed Jun 25 13:54:06 2025 -0700
> 
>     drm/xe/guc: Enable extended CAT error reporting
> 
>     [ Upstream commit a7ffcea8631af91479cab10aa7fbfd0722f01d9a ]
> 
> https://lore.kernel.org/all/20250625205405.1653212-3-
> daniele.ceraolospurio@intel.com/
> 
> How to reproduce:
> 
> 1. Upgrade to 6.16.9
> 2. Enable the Xe driver by passing i915.force_probe=!7d55
> xe.force_probe=7d55

Just wondering: why are those parameters needed? Is the hardware not
fully supported be the xe driver yet?

Ciao, Thorsten

