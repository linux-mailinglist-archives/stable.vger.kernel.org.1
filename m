Return-Path: <stable+bounces-89687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EDF9BB2A0
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436EA1C21328
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9C1B393D;
	Mon,  4 Nov 2024 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df9dP2iH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68B1B3724
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717810; cv=none; b=VG1jyXEKPuRGb17gIfxSgFe0zaPBxUjQqqdt4vpa6DzZnj1hNs2TpYNx5d1OjyKs7nXhWoHaUHN6W1UfO4IdqqvyGhLNFhEZqpHwxvxO6ImESEtcsB9KSl8v9En2Tt0k8LT/OfwGqQHTxDM8YCILbkPiVIq1DJ72eWj+vmXTr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717810; c=relaxed/simple;
	bh=1TyfpMB49W7e6uhiaqD3fSYUNRWaPkxT0aDfpdYwK6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1heIgrFt58OlOjfOB2tIQNmYB9wVCweu7DEeLIFyg7kzsss7cX7ZeyrsPkNDgklvYWzYBBmMU+x9/dV+lRwt6CKte7Jy+4SVr0LjZbQzHaFAlOKGZFKO5FrUptjuzyRgaFZM3LA1Yh1nptxJ9UezUb0tBwlCDfJY9lKZnutUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df9dP2iH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDD9C4CECE;
	Mon,  4 Nov 2024 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717810;
	bh=1TyfpMB49W7e6uhiaqD3fSYUNRWaPkxT0aDfpdYwK6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Df9dP2iHI6+vyMwjBeza4rXmGSfUWMD12N1S7TkZSoYB3WxGADb0K+DMXm9eerF2n
	 DyJTbFVKX/It02XHtiMunEoVumA03StdZ9N89yUenwYCIrTtwIP++wi9fc3Svlhegl
	 NNHzF8C0RNTXJXRrAdQDcj8iwHQJE42EPVwQZR42JPHmYkIMUY2vvsi9612mnSqPIi
	 4BgyIQEayv7hsGRixjQep3GK2ilayodPLT/6mFJllJSq2RwpiC4h6EPxQHCFivfyWx
	 5rcBTkQU80NOYt4MzpwEK9VghTlSO2hMDtqa6opVpclJEgUVVFa5jMiytU1zMQ/w9/
	 IzjVgQJ1cPEFw==
Date: Mon, 4 Nov 2024 05:56:48 -0500
From: Sasha Levin <sashal@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, sylv@sylv.io, andreyknvl@gmail.com,
	kernel@gpiccoli.net, kernel-dev@igalia.com
Subject: Re: [PATCH 6.1.y / 6.6.y 0/4] Backport fix(es) for dummy_hcd
 transfer rate
Message-ID: <ZyiocGrNzElt0Kxi@sashalap>
References: <20241103022812.1465647-1-gpiccoli@igalia.com>
 <3f678883-75e3-42b9-8f30-56b5b4c4379d@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3f678883-75e3-42b9-8f30-56b5b4c4379d@rowland.harvard.edu>

On Sat, Nov 02, 2024 at 10:41:19PM -0400, Alan Stern wrote:
>On Sat, Nov 02, 2024 at 11:13:49PM -0300, Guilherme G. Piccoli wrote:
>> Hi folks, here is a series with some fixes for dummy_hcd. First of all,
>> the reasoning behind it.
>>
>> Syzkaller report [0] shows a hung task on uevent_show, and despite it was
>> fixed with a patch on drivers/base (a race between drivers shutdown and
>> uevent_show), another issue remains: a problem with Realtek emulated wifi
>> device [1]. While working the fix ([1]), we noticed that if it is
>> applied to recent kernels, all fine. But in v6.1.y and v6.6.y for example,
>> it didn't solve entirely the issue, and after some debugging, it was
>> narrowed to dummy_hcd transfer rates being waaay slower in such stable
>> versions.
>>
>> The reason of such slowness is well-described in the first 2 patches of
>> this backport, but the thing is that these patches introduced subtle issues
>> as well, fixed in the other 2 patches. Hence, I decided to backport all of
>> them for the 2 latest LTS kernels.
>>
>> Maybe this is not a good idea - I don't see a strong con, but who's
>> better to judge the benefits vs the risks than the patch authors,
>> reviewers, and the USB maintainer?! So, I've CCed Alan, Andrey, Greg and
>> Marcello here, and I thank you all in advance for reviews on this. And
>> my apologies for bothering you with the emails, I hope this is a simple
>> "OK, makes sense" or "Nah, doesn't worth it" situation =)
>>
>> Cheers,
>>
>>
>> Guilherme
>>
>>
>> [0] https://syzkaller.appspot.com/bug?extid=edd9fe0d3a65b14588d5
>> [1] https://lore.kernel.org/r/20241101193412.1390391-1-gpiccoli@igalia.com/
>>
>>
>> Alan Stern (1):
>>   USB: gadget: dummy-hcd: Fix "task hung" problem
>>
>> Andrey Konovalov (1):
>>   usb: gadget: dummy_hcd: execute hrtimer callback in softirq context
>>
>> Marcello Sylvester Bauer (2):
>>   usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
>>   usb: gadget: dummy_hcd: Set transfer interval to 1 microframe
>>
>>  drivers/usb/gadget/udc/dummy_hcd.c | 57 ++++++++++++++++++++----------
>>  1 file changed, 38 insertions(+), 19 deletions(-)
>
>I'm not aware of any reasons not to backport these commits to the stable
>kernels, if they fix a real problem for you.
>
>However, it probably wasn't necessary to post the patches explicitly.
>(Not unless they required some modifications for the backports.)  I
>should think all you really needed to do was ask the appropriate
>maintainers to queue those commits for the stable kernels you listed.

I've queued this up. And yes, giving us the IDs would be easier (which
is what I ended up doing here).

Thanks!

-- 
Thanks,
Sasha

