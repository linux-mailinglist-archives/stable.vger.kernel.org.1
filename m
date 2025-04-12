Return-Path: <stable+bounces-132317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6D4A86C71
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 12:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BBD8C7831
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316C1AB530;
	Sat, 12 Apr 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWn8Bu7c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADB4C8F
	for <stable@vger.kernel.org>; Sat, 12 Apr 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744452874; cv=none; b=f7vBXG8lGMVD43u/nnCDgXUuCd8hCT207wCnozGhUGiAhgFkxavWGv8w12sseYxnkfL7Sc988i8a3NQS3iFEoFIRNAon09lS0+bCe1sUdfBouGdWbttJ0kHqucPpauMjEtpNBltAMYEtIxykiy1PbjVqWbdbMLHSSQKAC/l+0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744452874; c=relaxed/simple;
	bh=LCUZBB/bHzeo4rOC5gl7WrsnEYoejlvZ1iNrPklMcH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldp7q/JTpwnTXSpmKKUBH75FyVjkYc+x0fO8ya+k7dhD3Wf6ammlVSWxO07JfBeTBY7ZSYnE+92bDdn6z/u7FpxTJSg6XVPQkQCQm30JzrTvHaUYfeMwEInkcxXNZMI6gbrd125oquM7ZsrDb4WGNLAQ1rwzCC3Pxo3bgA6lKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWn8Bu7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9DCC4CEE3;
	Sat, 12 Apr 2025 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744452874;
	bh=LCUZBB/bHzeo4rOC5gl7WrsnEYoejlvZ1iNrPklMcH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vWn8Bu7ctybwkp/OozTvbImSaWJcZANd78eeqW7WDzqmkmesHA2rjwAQNcryMri4X
	 lmM46b9O2twsFkrkMExHKlEPBKOmosLYN5gc9GnpjqxmUzEZWJtniBErOrsSmn78QN
	 q9sUhovaCaMhnQAeCWHeoe8T5WtaPXfnJSqWWqS0=
Date: Sat, 12 Apr 2025 12:12:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ike Devolder <linux@herecura.eu>
Cc: stable@vger.kernel.org
Subject: Re: Missing paravirt backport in 6.12.23
Message-ID: <2025041249-afraid-oblong-c978@gregkh>
References: <3e1b616b.AMcAAGjWv5wAAAAAAAAAA9W7g6YAAAAANfgAAAAAABsqXwBn-jH5@mailjet.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1b616b.AMcAAGjWv5wAAAAAAAAAA9W7g6YAAAAANfgAAAAAABsqXwBn-jH5@mailjet.com>

On Sat, Apr 12, 2025 at 11:27:18AM +0200, Ike Devolder wrote:
> Hi,
> 
> Can I report an issue with 6.12 LTS?
> 
> This backport in 6.12.23
> [805e3ce5e0e32b31dcecc0774c57c17a1f13cef6][1]
> also needs this upstream commit as well
> [22cc5ca5de52bbfc36a7d4a55323f91fb4492264][2]
> 
> If it is missing and you don't have XEN enabled the build fails:
> 
> ```
> arch/x86/coco/tdx/tdx.c:1080:13: error: no member named 'safe_halt' in
> 'struct pv_irq_ops'
>  1080 |         pv_ops.irq.safe_halt = tdx_safe_halt;
>       |         ~~~~~~~~~~ ^
> arch/x86/coco/tdx/tdx.c:1081:13: error: no member named 'halt' in 'struct
> pv_irq_ops'
>  1081 |         pv_ops.irq.halt = tdx_halt;
>       |         ~~~~~~~~~~ ^
> 2 errors generated.
> make[5]: *** [scripts/Makefile.build:229: arch/x86/coco/tdx/tdx.o] Error 1
> make[4]: *** [scripts/Makefile.build:478: arch/x86/coco/tdx] Error 2
> make[3]: *** [scripts/Makefile.build:478: arch/x86/coco] Error 2
> make[2]: *** [scripts/Makefile.build:478: arch/x86] Error 2
> ```
> 
> To make it work I have added the backport of
> [805e3ce5e0e32b31dcecc0774c57c17a1f13cef6][1] as patch in my local build[3].

Looks like others also agree, it's been submitted a few days ago:
	https://lore.kernel.org/r/20250408132341.4175633-1-vannapurve@google.com

We'll pick it up in a few days for inclusion in the next round of stable
updates, thanks for the report, I didn't realize it was causing build
errors, which is odd that it didn't show up in all of the testing before
now.

thanks,

greg k-h

