Return-Path: <stable+bounces-86479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F29A07D9
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456F3286AE8
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AC02071F9;
	Wed, 16 Oct 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ias5yNUX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677FF20697A;
	Wed, 16 Oct 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076001; cv=none; b=trxuezDbJxtnmeqgQXMAmP+4XgMIEYwR1hchwBpIvNiUV353gjySPBAo2phbs6e17B+97t4DO8WNOQ4EOWvruehfzs29pSWDySSb5Y59iWiNWZCAh0P9rlDmsOJD7+xtzfdKG+WxeqJQdceIRnFtbk5tsf1zV8Fvynmtfh/OtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076001; c=relaxed/simple;
	bh=uaEzU7JTp6BnN5jwsrIHyfXMRt8Rkxv2xJ3PkOTxGQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICpG13ZnYFDwHoPvtSu7qf2ng5e0Z3LCuRLRsDl6klzx5byhvJBYnspad17qf5rDZH/+D4l4+A2r/d47sfZQfZw/Ke0sSSvFfuQNA6jK9IC8jc/fi4cA5iE4VkCeT923cu5smBs/LccfOpUvEquN/dng1gM0fPaW/KbSoxcyD/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ias5yNUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7524EC4CECD;
	Wed, 16 Oct 2024 10:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729076000;
	bh=uaEzU7JTp6BnN5jwsrIHyfXMRt8Rkxv2xJ3PkOTxGQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ias5yNUX5vRlKVMlW7VlgwKGn2rpQElE+rccgNdBek6SnGRHFu1Y5LHLfe+RvxHU0
	 sPtSViXgRfGZjDvvGwwJvia4rGDVw7assOCCGVjjAo1tq4dtNG0+5Jmp4h2xchHau0
	 +W9wPmMPPw8LEX5lm1sQfZvHii0ye96B1agcCTOY=
Date: Wed, 16 Oct 2024 12:53:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joel GUITTET <jguittet.opensource@witekio.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Sasha Levin <sashal@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Bad commit backported on the v5.15.y branch ?
Message-ID: <2024101626-savings-ensnare-1ac2@gregkh>
References: <AM9P192MB1316ABE1A8E1D41C4243F596D7792@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
 <06bab5c5-e9fd-4741-bab7-6b199cfac18a@leemhuis.info>
 <AM9P192MB131641B00A0EB08E81A24801D7462@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P192MB131641B00A0EB08E81A24801D7462@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>

On Wed, Oct 16, 2024 at 09:23:10AM +0000, Joel GUITTET wrote:
> Thanks for the reply Thorsten.
> 
> So is anybody able to indicate why this commit 1fe15be1fb6135 has been backported to 5.15.y?

Because it has a "Fixes:" tag on it.  Is that tag not correct?

> Actually this creates a bug on v5.15 (see commands executed in my original message).

What "original message"?

> I don't know for 6.8 or 6.12 release, I'm not able to update my target with such gap.

It's already in the following releases:
	5.10.209 5.15.148 6.1.75 6.6.14 6.7.2 6.8
so if it needs to be reverted somewhere, please send the reverts with
the reason why.

thanks,

greg k-h

