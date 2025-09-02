Return-Path: <stable+bounces-176989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9547AB3FD8E
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3370F1B22B65
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298142ED15C;
	Tue,  2 Sep 2025 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dAY/WZU1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF910EEC0
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811794; cv=none; b=FDs95omLfNM5mRkI9Q5TNKydQROfgLYMDPDYIonXIXS+UMloXeLxbpeDzXv3iYuyq4A27AJ8IPAnxv16td25K2xagOxagNcbohGjRJ4ZxQxUbKvSygvHNUkJrWFco/m8vc7GvJPyk3GO6HE6Ujh+it+BZBLAR+JtmrreufwR57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811794; c=relaxed/simple;
	bh=4Xr3MgVLvcyS3MYbKzhy65gyGhMd61jNWAJJSRf8Jbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTZuWGjbsIVcY9XfsK6gCU2OOvDJ/eosFgpKi5zTWFhHNKYWV3MavoDiZHvd3bbb7SLeUNAStlYHCXuRYYLUB1rSGtEu0iHYwii/+cz1RD1RhkPq0lT+pENz/MzufgrXS8XBYo2/T0hxRedU63+jJVEVnNb00bG5H/AvLx6R+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dAY/WZU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C530CC4CEED;
	Tue,  2 Sep 2025 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756811794;
	bh=4Xr3MgVLvcyS3MYbKzhy65gyGhMd61jNWAJJSRf8Jbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAY/WZU1oMdEysLvHbsplShcI8d+z7cbsIKf4eIoisPpKBDDB8yuoMtlyFHbE6lrt
	 d6/iUnK3dEX0a5wFKmnSLFXF2M63iGcIH0cHJ3hrrMocqnjS1IiAMR/aE/dju788xp
	 3zaW4SC8vuxwdbO1I7BZQJHGzKBt61+/jWbiovAg=
Date: Tue, 2 Sep 2025 13:16:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Teddy Astie <teddy.astie@vates.tech>
Cc: xen-devel@lists.xenproject.org, stable@vger.kernel.org,
	Juergen Gross <jgross@suse.com>, kernel test robot <lkp@intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthoine Bourgeois <anthoine.bourgeois@vates.tech>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v5.10.y] xen: replace xen_remap() with memremap()
Message-ID: <2025090203-clothes-bullish-a21f@gregkh>
References: <4cc9c1f583fb4bfca02ff7050b9b01cb9abb7e7f.1756803599.git.teddy.astie@vates.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc9c1f583fb4bfca02ff7050b9b01cb9abb7e7f.1756803599.git.teddy.astie@vates.tech>

On Tue, Sep 02, 2025 at 09:28:32AM +0000, Teddy Astie wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> From: Juergen Gross <jgross@suse.com>
> 
> [ upstream commit 41925b105e345ebc84cedb64f59d20cb14a62613 ]
> 
> xen_remap() is used to establish mappings for frames not under direct
> control of the kernel: for Xenstore and console ring pages, and for
> grant pages of non-PV guests.
> 
> Today xen_remap() is defined to use ioremap() on x86 (doing uncached
> mappings), and ioremap_cache() on Arm (doing cached mappings).
> 
> Uncached mappings for those use cases are bad for performance, so they
> should be avoided if possible. As all use cases of xen_remap() don't
> require uncached mappings (the mapped area is always physical RAM),
> a mapping using the standard WB cache mode is fine.
> 
> As sparse is flagging some of the xen_remap() use cases to be not
> appropriate for iomem(), as the result is not annotated with the
> __iomem modifier, eliminate xen_remap() completely and replace all
> use cases with memremap() specifying the MEMREMAP_WB caching mode.
> 
> xen_unmap() can be replaced with memunmap().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Acked-by: Stefano Stabellini <sstabellini@kernel.org>
> Link: https://lore.kernel.org/r/20220530082634.6339-1-jgross@suse.com
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Teddy Astie <teddy.astie@vates.tech> [backport to 5.10.y]
> ---

Why is this needed for 5.10.y at all?  What bug does it fix?  And why
are you still using Xen on a 5.10.y kernel?  What prevents you from
moving to a newer one?

thanks,

greg k-h

