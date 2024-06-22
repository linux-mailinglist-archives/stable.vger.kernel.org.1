Return-Path: <stable+bounces-54867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB93913392
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 13:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC561C2122F
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE3153828;
	Sat, 22 Jun 2024 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CLfKWaAU"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8B14C591;
	Sat, 22 Jun 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719057083; cv=none; b=gROoAAQDFGpFFfHdsSTxhPt732WtoievXNhao/moQTYnyhOTimLodCMNb8kDArE6wHtz3z+uZwczqF3pbW3FeIo9XrK4CSS1w5+Jbn93ALonyLDReHX6b9NDhH5VbHNcUgOoonwx8M81grepJX4rQSIbeyRKIynGT8g/B5hNPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719057083; c=relaxed/simple;
	bh=dYwe/2HOqdVUREi/y8BiuImELO+D/e6Aq1ECbDTwTp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEo2vbRZDaEelORjjfaIjuvMcIp3pBpxi88ADa+qZ7ntIL1INp6iFvi/aMUkJGcxgkP2gOZnObT8otfsGqdwGe/ikz0zd8Fp61qz/EFvCkNcdeVjyfpaxH6GLEamoJYTfbwPHWDFc+k5AXQAV7pRcW9Ac8NLQ7KNcIMXt1yNafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CLfKWaAU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719057070;
	bh=dYwe/2HOqdVUREi/y8BiuImELO+D/e6Aq1ECbDTwTp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLfKWaAU03aMQwZf2fl9fqu6CSza4jxeb8fYBqrvgCKFzmzk1PYhSDuqB5sQnz72S
	 WJnson11oQfMkr6jkDSXh9aJcHI998ZnDnRglttmxR9iA4szb3d8sMhfoXQwi3edVU
	 LGbACZC7sIu4c8GgiexsubBb07OM1WUjX2xN0sYM=
Date: Sat, 22 Jun 2024 13:51:08 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] nvmem: core: one fix and several cleanups
 for sysfs code
Message-ID: <a9d4e4d7-3aa3-4d08-a90e-2c5cfe907aff@t-8ch.de>
References: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
 <171905336506.244973.16113259707012674277.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171905336506.244973.16113259707012674277.b4-ty@linaro.org>

On 2024-06-22 11:49:25+0000, Srinivas Kandagatla wrote:
> On Thu, 20 Jun 2024 18:00:32 +0200, Thomas Weißschuh wrote:
> > Patch 1 is a bugfix.
> > All other patches are small cleanups.
> > 
> > Hint about another nvmem bugfix at [0].
> > 
> > [0] https://lore.kernel.org/lkml/20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net/
> > 
> > [...]
> 
> Applied, thanks!

Thanks!

> [2/5] nvmem: core: mark bin_attr_nvmem_eeprom_compat as const
>       commit: 178a9aea2c5db8328757fdea66922bda0236e95c

Please note that patch 2 has a dependency on patch 1.
In the current state this will probably lead to build errors in
linux-next, as nvmem-fixes is not part of linux-next.

I should have mentioned that.

In theory patch 2 could even be squashed into patch 1, as it really is
mostly an extension of it.

> [3/5] nvmem: core: add single sysfs group
>       commit: 80026ea9fdc22bbc8bfa9b41f54baba314bacc55
> [4/5] nvmem: core: remove global nvmem_cells_group
>       commit: e76590d9faf8c058df9faf0b6513f055beb84b57
> [5/5] nvmem: core: drop unnecessary range checks in sysfs callbacks
>       commit: 050e51c214c5bbe5ffd9e7f5927ccdcd2da18fe3

