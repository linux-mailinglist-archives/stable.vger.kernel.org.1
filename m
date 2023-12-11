Return-Path: <stable+bounces-5345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2D80CA84
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED3F1C210D6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C93D965;
	Mon, 11 Dec 2023 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sHFNXcyo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F93D3BD;
	Mon, 11 Dec 2023 13:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF09C433C8;
	Mon, 11 Dec 2023 13:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702300067;
	bh=ZDCtyG813baQDVWKjc89UP4RJr4fKedSXMPxHtc1i/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHFNXcyodzwBK+JWl3fj37d2dGy1Q7Qo4oaSMXrFvju/1jTUCBOIx/6Y5QAfI1vnR
	 3QxEB6c7oHLf8poxzBjt69BeppZLm9EM2GC14khbC3xZ7PK/E7+2PPQdly9yiHRhHx
	 UlK1UAJ7WGakdKBxsFiRc7V7tihpnH0mNGVgyVkc=
Date: Mon, 11 Dec 2023 14:07:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guillaume Tucker <gtucker@gtucker.io>
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>, stable@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	"kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Subject: Re: stable/LTS test report from KernelCI (2023-12-08)
Message-ID: <2023121131-delirious-roster-e729@gregkh>
References: <738c6c87-527e-a1c2-671f-eed6a1dbaef3@collabora.com>
 <2023120846-taste-saga-c4a9@gregkh>
 <1ca05280-a03c-66c0-cd67-87c58c8f3929@gtucker.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca05280-a03c-66c0-cd67-87c58c8f3929@gtucker.io>

On Mon, Dec 11, 2023 at 11:14:03AM +0100, Guillaume Tucker wrote:
> On a related topic, it was once mentioned that since stable
> releases occur once a week and they are used as the basis for
> many distros and products, it would make sense to have
> long-running tests after the release has been declared.  So we
> could have say, 48h of testing with extended coverage from LTP,
> fstests, benchmarks etc.  That would be a reply to the email with
> the release tag, not the patch review.

What tests take longer than 48 hours?

> I've mentioned before the concept of finding "2nd derivatives" in
> the rest results, basically the first delta gives you all the
> regressions and then you do a delta of the regressions to find
> the new ones.  Maintainer trees would be typically comparing
> against mainline or say, the -rc2 tag where they based their
> branch.  In the case of stable, it would be between the stable-rc
> branch being tested and the base stable branch with the last
> tagged release.

Yes, that is going to be required for this to be useful.

> One last thing, I see there's a change in KernelCI now to
> actually stop sending the current (suboptimal) automated reports
> to the stable mailing list:
> 
>   https://github.com/kernelci/kernelci-jenkins/pull/136
> 
> Is this actually what people here want?

If these reports are currently for me, I'm just deleting them as they
provide no value anymore.  So yes, let's stop this until we can get
something that actually works for us please.

thanks,

greg k-h

