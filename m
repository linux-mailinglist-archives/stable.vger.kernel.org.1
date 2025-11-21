Return-Path: <stable+bounces-196503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397DC7A862
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96013A349A
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7218834EF14;
	Fri, 21 Nov 2025 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j+D9ZBtA"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457B34F487
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738286; cv=none; b=dFG9FoZHhm9TLQ3lup2NmdNbn3fyF8nIWAXA5z3kxD0ZyD9JCVuTChfEOgAiNQJCiK0KHgan6vakDU/j/+zvamKhGp4PJKlDPc6pbvKaBXPyDRh3Reil8cFvENWWoXgDd42emlj9IOqh5t45qT3NjPUR4C09HtPoWafP/WUtpkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738286; c=relaxed/simple;
	bh=jLqKxQ8X29aVd/cFW/VJ1isuzqtpA61AoT0JxdGcTeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji44kiVB3tC68VXbOh5mVZbUrvfB9UV3QI2UMYyT+8kQx8U+zaDunXY2QifAn9pS6ob2YRhwmGfTYN0oNm5HytrwImuVEMrCqv75xfl9tB0Ni+A1IoYZNF5XHy7bWH7wJdnAXMsN1kwC4MDOgTsKLnuibGz36JdhidBC9FZIyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j+D9ZBtA; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Nov 2025 15:17:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763738280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XoU+3RJsy1nSFSv3/JtuVaaz9FtJQECWLE+Re75HYkE=;
	b=j+D9ZBtALnuBPR8r2wU1dqExABVFcow8ZG7S2U6WQGyqc0t/x2CKgMT45btb6BWFnrDohj
	s7NQtyyI7TIBmz+ygSj48D2hQGORZFe9lE/MEgh+6JyibpXx5N1BdPgGGY9aeVdnZBsYPE
	fKZ1Z+mDHkeXkhw7GYXJqXWZvMDcPDc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y 0/5] LBR virtualization fixes
Message-ID: <xgsmwdvpvacnvlay77a4qqeofemunst5mtokf5oupw27mjz2pp@2ssqtpcunrw2>
References: <2025112046-confider-smelting-6296@gregkh>
 <20251120233936.2407119-1-yosry.ahmed@linux.dev>
 <2025112118-everyone-perish-5a7a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025112118-everyone-perish-5a7a@gregkh>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 21, 2025 at 10:55:38AM +0100, Greg KH wrote:
> On Thu, Nov 20, 2025 at 11:39:31PM +0000, Yosry Ahmed wrote:
> > This is a backport of LBR virtualization fixes that recently landed in
> > Linus's tree to 6.12.y.
> > 
> > Patch 1 is not a backport, it's introducing a helper that exists in
> > Linus's tree to make the following backports more straightforward to
> > apply.
> 
> Why not include the actual commit that adds that helper?

It was introduced as part of a much larger commit,
160f143cc131 ("KVM: SVM: Manually recalc all MSR intercepts on userspace
MSR filter change"), which was a part of a 30+ patch series. The effort
and risk to backport all of that for the helper is not justifiable.

> 
> > Patch 2 should already be in queue-6.12, but it's included here as the
> > remaining patches depend on it.
> 
> So this series will not apply?

It applies on 6.12.y today, but if it gets merged to 6.12.y first [1],
then we may need to drop patch 2 from the to apply. There's a change
that git drops it though because it should be identical ot the patch
[1].

[1]https://lore.kernel.org/stable/20251121130147.807480816@linuxfoundation.org/

> 
> confused,
> 
> greg k-h

