Return-Path: <stable+bounces-6841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB26814EBC
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 18:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3459A1F257F9
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C63011B;
	Fri, 15 Dec 2023 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WNTv6ut2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136230117
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 17:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED08BC433C7;
	Fri, 15 Dec 2023 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702661153;
	bh=XKcTSER4YuTeVU1/+sROnM1hhMS/soAk0eYUrw4Xi2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNTv6ut29nvww8ApcCyxcgsMOgkYFdB2n/Ix3oE4xF8FLxfHvhzZlQti7EsUYiWp+
	 TC5ndhgJWNGRt0tEUH7cByBP+/KwxIGBvQaUwbp2rOn54r7HCa5RVrJzdqMgs8SrO3
	 PFGm7G13ygJMg/cxf8BzR0kUDdODQN0TGG8IdxYs=
Date: Fri, 15 Dec 2023 18:25:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: stable@vger.kernel.org
Subject: Re: backport: perf/x86/uncore: Don't WARN_ON_ONCE() for a broken
 discovery table
Message-ID: <2023121545-willing-grew-7edb@gregkh>
References: <lrkyqil4zh097.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrkyqil4zh097.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>

On Fri, Dec 15, 2023 at 05:57:24PM +0100, Mahmoud Adam wrote:
> Hi,
> 
> Please backport following commit to 6.1 and 5.15.
> 
> Commit 5d515ee40cb57ea5331998f27df7946a69f14dc3 upstream
> 
> On SPR MCC the discovery table of UPI is broken, there is a patchset [1]
> to mitigate this which landed around v6.3, this can't be backported to
> stable releases since it is based on SPR related patches which will be
> needed in case of mitigation backport, but already WARN_ON_ONCE in this
> case is not needed here since this is hardware problem that linux can do
> nothing about it, this patch replace WARN_ON_ONCE with pr_info, and
> specify what uncore unit is dropped and the reason
> 
> [1] https://lore.kernel.org/all/20230112200105.733466-1-kan.liang@linux.intel.com/

Now queued up, thanks.

greg k-h

