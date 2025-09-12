Return-Path: <stable+bounces-179321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5A9B54219
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 07:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB6C56628C
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 05:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDA23BCEE;
	Fri, 12 Sep 2025 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="euhe+BKr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1A4207A
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655424; cv=none; b=S4EL/ipILVsxWbB7WP4qehtMhot74243/UqwujISJ4FVbYM/NnbFIJmwJAp2aZQHVq1vA2sAPo3bdxiHn9eWgCIrsj4GbRGF0dJEcQbjjIFyaWeqxxzxA83kj0GhDXajNfVvUI0JN+R+d/+TICiAp16hoJTqgMWumStvLjowpRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655424; c=relaxed/simple;
	bh=3O9EryjgMr711548abAwUsZubJEliuPr5cV+nvQOhKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoIAIf6q7NND48twatYbm2DzZ2jv1f/CNf1V0KNJ84yqsoV5gpZmwWhZ2P5c86Y5LI2QWvCfw6KmEOvL1yFH4HPZnosxBBl6FXjdizsDE7DNpLRioxK6zyreLC1sGe4yoSqWxoOziFACMCqD3+0aF3RsupIdZKo8N+SB23IIbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=euhe+BKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD9BC4CEF4;
	Fri, 12 Sep 2025 05:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757655423;
	bh=3O9EryjgMr711548abAwUsZubJEliuPr5cV+nvQOhKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euhe+BKrBg1AO1uU1jWNDuzCV0ejhjtD6VolKHG77OXRKyZtw3JVSyqaI2bZ22for
	 9juzJNkYfugyv4nklbc+fPCsDzwS8vgiU7cwwwbmn91PkLpIJMB0s0ic0UrpildwVQ
	 o5z/v3vEgPsTWAb6HZQvor0kiQk7HMDdOANEtIhY=
Date: Fri, 12 Sep 2025 07:36:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: stable@vger.kernel.org
Subject: Re: Fwd: [PATCH] fs/netfs: fix reference leak
Message-ID: <2025091220-agony-sporty-c547@gregkh>
References: <20250911222501.1417765-1-max.kellermann@ionos.com>
 <CAKPOu+9CjL-=xsT48k+PfQme2zCr1HnoWh5jcJgpp-BzPhqoDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPOu+9CjL-=xsT48k+PfQme2zCr1HnoWh5jcJgpp-BzPhqoDw@mail.gmail.com>

On Fri, Sep 12, 2025 at 12:27:23AM +0200, Max Kellermann wrote:
> Hi Greg, sorry I mistyped the "stable" email address, so I'm
> forwarding this patch to you.
> Here's the original email:
> https://lore.kernel.org/lkml/20250911222501.1417765-1-max.kellermann@ionos.com/

What is the commit id of this in Linus's tree?  If it's not there yet,
there's no need for us to worry about it until then, so perhaps just
send it to us when that happens?

thanks,

greg k-h

