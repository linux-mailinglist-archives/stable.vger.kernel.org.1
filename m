Return-Path: <stable+bounces-23880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC52868D18
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD684B25184
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C82137C21;
	Tue, 27 Feb 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2lNlhRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FC136981
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028963; cv=none; b=s25D9aLL/4gTa2VtORQapsAzQ0jThLNxLTIeDEBZWOA1a9/CyMKHEi/ONqAwb2kJ0UDmmYFl2jpi63gwUAYMcN78lYCcEykbXHScaOkjmThzVmYD1P1t8iMHqEh1cAjipnynWpFsRti2jhKm0Bjavb20kUmPt4F3Ed7aXrxf24s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028963; c=relaxed/simple;
	bh=It9L3a0eDgV/w9AgWuNHiXmM9N0lpQVpQ0gnva5D95U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGMPnviBJ9ZgfvdSphF0MoPBS1FV5MI2gree81ejRqRNu6ANJRrxvkb3OocpYGdhKhpmrwTKA4jfIpDQRdy7mdmmJVpcAHsXntQk1EvRwuNuOZrpdoyveHDvDDa+HramgXw4cKDq7jKPu3Phc8J4ndgly5mZNqQZQKY7D+DBF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2lNlhRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A36C433C7;
	Tue, 27 Feb 2024 10:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709028963;
	bh=It9L3a0eDgV/w9AgWuNHiXmM9N0lpQVpQ0gnva5D95U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2lNlhRvBlPdZsWhSGfTk4kiMuUe1bZv6FDbO3BzPvMOD0lGdpM+0QEg7Olz6aTcA
	 VzXyrVh22TxE9kyZxTxAKTmjLYZuerAKcqlHH483U2/3dHfK96poW3jPihX98HOeWI
	 jWZuGasUSi5i8cu+oLA96/Vx7li0C0bI2GVl1G/g=
Date: Tue, 27 Feb 2024 11:16:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm: zswap: fix missing folio cleanup in writeback
 race path
Message-ID: <2024022735-arrange-lustfully-ca5b@gregkh>
References: <2024022612-uncloak-pretext-f4a2@gregkh>
 <20240227100346.2095761-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227100346.2095761-1-yosryahmed@google.com>

On Tue, Feb 27, 2024 at 10:03:46AM +0000, Yosry Ahmed wrote:
> In zswap_writeback_entry(), after we get a folio from
> __read_swap_cache_async(), we grab the tree lock again to check that the
> swap entry was not invalidated and recycled.  If it was, we delete the
> folio we just added to the swap cache and exit.
> 
> However, __read_swap_cache_async() returns the folio locked when it is
> newly allocated, which is always true for this path, and the folio is
> ref'd.  Make sure to unlock and put the folio before returning.
> 
> This was discovered by code inspection, probably because this path handles
> a race condition that should not happen often, and the bug would not crash
> the system, it will only strand the folio indefinitely.
> 
> Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@google.com
> Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)

For obvious reasons, I can't take a patch only for 6.1, and not for
newer kernel releases (i.e. 6.6.y) as then there would be a regression.
Can you please provide a backport for that tree and then we can take
this one.

thanks,

greg k-h

