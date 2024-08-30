Return-Path: <stable+bounces-71646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B3966283
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 15:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BEE5B22EAB
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F071ACDEF;
	Fri, 30 Aug 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="priTOzaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AE1ACDE3
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023118; cv=none; b=KJ6V1jgbdHtIYM6kY9zh0iEzaQx7liNeoWUcLQr/ZAtbvk26fcBUbO+DtI6Nph3fY6oRwA1GWOXnNwe2Hj8ofQhVaaGgwn7JfR2BIpVH6es2HWElC2HO80PFcuDY6GpXmgra9Vy2XZH2NzASpDIbU4JWaltIO2IIC+D7m5giJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023118; c=relaxed/simple;
	bh=r5yz4U75mnt2aeVOM4JD2ZY6K2UnpWEAaRR2ZsM5WSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7RYAgNsnyQ79x633dgwm6PVsSUOb/cr186JCzJStANOvs2LvGpch+AMrZlEhJirZQsmEn7f4+c/wkmnuhgNHnssDnEHWzcEzAsLXnOKOto0xRMEFmImuf85d/8m0lGIXk9OGkU1w0QrHZNyIdnZRmLazs97SxV/LpDl20oSVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=priTOzaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43F1C4CEC2;
	Fri, 30 Aug 2024 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725023118;
	bh=r5yz4U75mnt2aeVOM4JD2ZY6K2UnpWEAaRR2ZsM5WSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=priTOzaKZ1/GhFAGqpOzRJgzjurqCwAG5PWVJAsFXLt0g0C0e+7jjVQZcNGREllwm
	 shPR3dWMoeM7S+uwpnWgU625KeAFmZJJl2uY4QozkdlAklDYaRP5Epg6KGw8q0byxS
	 QwowJFu+NiPZGeUMxRemdMq37IO+0BD3ZW6aBZ6Q=
Date: Fri, 30 Aug 2024 15:05:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zhenghan Wang <wzhmmmmm@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 1/1] ida: Fix crash in ida_free when the bitmap is
 empty
Message-ID: <2024083006-childish-lumpiness-cccd@gregkh>
References: <20240830083010.25451-1-hsimeliere.opensource@witekio.com>
 <20240830083010.25451-2-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830083010.25451-2-hsimeliere.opensource@witekio.com>

On Fri, Aug 30, 2024 at 10:29:55AM +0200, hsimeliere.opensource@witekio.com wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> commit af73483f4e8b6f5c68c9aa63257bdd929a9c194a upstream.
> 
> The IDA usually detects double-frees, but that detection failed to
> consider the case when there are no nearby IDs allocated and so we have a
> NULL bitmap rather than simply having a clear bit.  Add some tests to the
> test-suite to be sure we don't inadvertently reintroduce this problem.
> Unfortunately they're quite noisy so include a message to disregard
> the warnings.
> 
> Reported-by: Zhenghan Wang <wzhmmmmm@gmail.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  lib/idr.c      |  2 +-
>  lib/test_ida.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 

Now queued up, thanks.

greg k-h

