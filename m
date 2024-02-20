Return-Path: <stable+bounces-20880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7D85C5A5
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CCF283AA6
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26114D42B;
	Tue, 20 Feb 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjGAziXd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478414C5AB
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460433; cv=none; b=sQv3mt7CW3mNGufsAshxi8oOjbG4GhO91guRPnXTXi+eR0JaMJLKtHQ1EseR67vUVVc0fQpaJm98Dnu2+bHsu3HowTJLwCAG0i948ie06NKk9dl3ChMC3LarS7Pg2cIZRhv1NuGcrtoDyQI0IidCs3ZTcMvY/To38i6Q7B5HxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460433; c=relaxed/simple;
	bh=PmvLGFQ+0aIXaqdPsbrpxg5YSFT9hJPwma8ap5Plz4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHT2UXqjrmuigaKrqk5wm94b1bQiMrIEUZiYnw2tA2uXEIxE1o1kUP17Iz4WMR7NtYkDmv4xYFOQpApn5tR8qr0fnoUJ8LXeYSKu+450GWIfeR4rFagfl0HdB7VbYLzRE7g8AABa1ZmKjbZjXaQa22jiU6RujpuVPOISrXiKEEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjGAziXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E60C433F1;
	Tue, 20 Feb 2024 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708460431;
	bh=PmvLGFQ+0aIXaqdPsbrpxg5YSFT9hJPwma8ap5Plz4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjGAziXdwpvBChFWpSYynjklLTZIPWAhdqrovW30jChkY51hzlo+2F5X8GXi0nqWo
	 F4ay0XjnN7NC9YcLfdk0y06dZ7y2glcJZ0ZeK+9WpkMokGNnEbu0R5aNLRM5J2OwVR
	 qUWsb6EWBbfLCyynzTwLtGpZd2y2edrs6dtrNFEg=
Date: Tue, 20 Feb 2024 21:20:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] arch/arm/mm: fix major fault accounting when
 retrying under per-VMA lock
Message-ID: <2024022018-guidance-patio-4504@gregkh>
References: <2024021921-bleak-sputter-5ecf@gregkh>
 <20240220190351.39815-1-surenb@google.com>
 <20240220190351.39815-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220190351.39815-2-surenb@google.com>

On Tue, Feb 20, 2024 at 11:03:51AM -0800, Suren Baghdasaryan wrote:
> The change [1] missed ARM architecture when fixing major fault accounting
> for page fault retry under per-VMA lock.
> 
> The user-visible effects is that it restores correct major fault
> accounting that was broken after [2] was merged in 6.7 kernel. The
> more detailed description is in [3] and this patch simply adds the
> same fix to ARM architecture which I missed in [3].
> 
> Add missing code to fix ARM architecture fault accounting.
> 
> [1] 46e714c729c8 ("arch/mm/fault: fix major fault accounting when retrying under per-VMA lock")
> [2] https://lore.kernel.org/all/20231006195318.4087158-6-willy@infradead.org/
> [3] https://lore.kernel.org/all/20231226214610.109282-1-surenb@google.com/
> 
> Link: https://lkml.kernel.org/r/20240123064305.2829244-1-surenb@google.com
> Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")
> Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/arm/mm/fault.c | 2 ++
>  1 file changed, 2 insertions(+)

No git id?  :(


