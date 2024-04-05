Return-Path: <stable+bounces-36030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F1689956D
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD0A1C21661
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFCB1AACB;
	Fri,  5 Apr 2024 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATJJbeL2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9417BB7
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298900; cv=none; b=QWcUrAkAv3wfbk9IwgQ8BxTwPFGMxJnZOpmDNL08sP8Lv3HwAA7v1xKc1hikW3Bt9gUgDvx+sDM0STrB7EPmW0HDxTL7jcJkU6WheAzfnRfBxMzbrzxGPl+j3AU3HNvqH1/y60lOIEBBoXOiPmJW3WquPdJxtDWJKpoOFWDRxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298900; c=relaxed/simple;
	bh=hX0JvNgE07XTsIxRLqCdToLc7GpoeQcKXrRZ2D4tm/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAjr3s+iR+cVnC2onvyWbK+Y0db7U1flU0glautHPkQjdcCUMG0Y0AyHFhrMVphxnRXTNzVINvhDixi231DuUUZlwJ+1X2LV+HZNbXoXfSM5W4l8ez2AEgRt12EcQBMhWNcRWQPmBGBvqHRcWYV6qV/VbMFJ3M1NAF7eiqqxqS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATJJbeL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4F6C433F1;
	Fri,  5 Apr 2024 06:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298900;
	bh=hX0JvNgE07XTsIxRLqCdToLc7GpoeQcKXrRZ2D4tm/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATJJbeL20+ATAjNvpiGNet3CeScVyXtC715hdjQT3o9zrzxbo3zAcoT5e4Qzi+jVy
	 7tyrjYtrj8/gyCeNu2xEsJy5cp9OV9tNt2OnP1n3pNURVfb7m+umsY56ZxXBs8ebh4
	 OAWlGZ6/FCCI7QoDuUjNhBPBuQX8nweTwwSjn8cs=
Date: Fri, 5 Apr 2024 08:34:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Cc: stable@vger.kernel.org, Steve French <smfrench@gmail.com>,
	Shyam Prasad N <nspmangalore@gmail.com>, bharathsm@microsoft.com,
	Shyam Prasad N <sprasad@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>
Subject: Re: Requesting backport for fc20c523211 (cifs: fixes for
 get_inode_info)
Message-ID: <2024040512-koala-landside-7486@gregkh>
References: <CAFTVevX=yujOXoDJYRJWuPgvWfVYUL5ZmoKfy_3u5qHi741Sag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTVevX=yujOXoDJYRJWuPgvWfVYUL5ZmoKfy_3u5qHi741Sag@mail.gmail.com>

On Wed, Apr 03, 2024 at 12:34:43PM +0530, Meetakshi Setiya wrote:
> commit fc20c523211a38b87fc850a959cb2149e4fd64b0 upstream
> cifs: fixes for get_inode_info
> requesting backport to 6.8.x, 6.6.x, 6.5.x and 6.1.x
> 
> This patch fixes memory leaks, adds error checking, and performs some important
> code modifications to the changes introduced by patch 2 of this patch series:
> https://lore.kernel.org/stable/CAFTVevX6=4qFo6nwV14sCnfPRO9yb9q+YsP3XPaHMsP08E05iQ@mail.gmail.com/
> commit ffceb7640cbfe6ea60e7769e107451d63a2fe3d3
> (smb: client: do not defer close open handles to deleted files)
> 
> This patch and the three patches in the mails that precede this are related and
> fix an important customer reported bug on the linux smb client (explained in the
> mail for patch 1). Patches 2, 3 and 4 are meant to fix whatever regressions were
> introduced/exposed by patch 1.
> The patches have to be applied in the mentioned order and should be backported
> together.

Then PLEASE send this as a patch series, as picking patches out of
emails that arrive in random order in a "correct" way is tough, if not
impossible for us to do.

Please send these as a backported set of patches, OR as a list of
"cherry-pick these git ids in this order" type of thing.  But spreading
it out over 4 emails just does not work, and is very very confusing.

Think about it, would you want to recieve these 4 emails and have to try
to guess which one is applied before which?

Please fix this up and resend it in an easier way.

thanks,

greg k-h

