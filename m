Return-Path: <stable+bounces-56058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CAF91B76B
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 08:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9161F2135B
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 06:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A5B13AA51;
	Fri, 28 Jun 2024 06:57:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C61D6A022;
	Fri, 28 Jun 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557853; cv=none; b=gggYeyAVtI3iSAAmmlNSFccrKwXHiPoG9KPExHnc6fnlDIpaMdJs9WuwZKKW02CazfpTlt/Ku/qBacAiuq4PkMdwFdhfWw07C3UiG20/v2+G2BZE5hB7rWxzHB3HPxZfT8QrdW5LM94HD+v0yWF6JPWWXCWpPY9/zVMNHm0r8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557853; c=relaxed/simple;
	bh=mwSoBB60EtT2S5VQ+dSI7S4vHGFLYgvA6VHDZInb8ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXSmKc1fgAMosqp7Ps4gMb8uf3uc4MQzDmLUqNIuvtmvqO3VQgFAT1Z1xaEHFDxjVup0DSd+Gw4cEeAkhjyX4X1kxWslOnGws8CJFdJUMkFtQZ0MXcZrfGd+86WE2iCjWigkYFt8Sr+S3+V7itAPFVPmJGUSsdZ0Euo1Gsps+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1sN5Xr-0005gq-00; Fri, 28 Jun 2024 08:57:19 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 2B209C0120; Fri, 28 Jun 2024 08:55:38 +0200 (CEST)
Date: Fri, 28 Jun 2024 08:55:38 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, ms@dev.tdt.de
Subject: Re: Patch "MIPS: pci: lantiq: restore reset gpio polarity" has been
 added to the 6.9-stable tree
Message-ID: <Zn5easOVbv3VGAMu@alpha.franken.de>
References: <20240627185200.2305691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627185200.2305691-1-sashal@kernel.org>

On Thu, Jun 27, 2024 at 02:52:00PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     MIPS: pci: lantiq: restore reset gpio polarity
> 
> to the 6.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mips-pci-lantiq-restore-reset-gpio-polarity.patch
> and it can be found in the queue-6.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

can you drop this patch from _all_ stable patches, it was reverted already
in the pull-request to Linus. Thank you.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

