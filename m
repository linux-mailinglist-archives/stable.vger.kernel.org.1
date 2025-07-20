Return-Path: <stable+bounces-163454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E27BB0B43B
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 10:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276DD18947EF
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C61D1E51EC;
	Sun, 20 Jul 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XevH8063"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F01E3DED;
	Sun, 20 Jul 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000380; cv=none; b=Z0/UKwfpGBNhnB8yBrVfzrzTHEtBIARquY9I+S/4q1DEwR2LcwB5fgv84F3v5tXddiPQWUMz+nNjWRIYehZ7TIetas3urOVXnyXIzXgBF6mBuJq/M962TOe0nae7KAzzF8BXhpSkmlJJNlfAata7LBcah/rh7a7auGQXsQt9qbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000380; c=relaxed/simple;
	bh=p4PUfLJ/eSyng1QdNZM1AA4Dfx2TErleZwFHoI+uYVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br5N55Wf7zrNhprlk9d3VYS/tvRPg5R3NH21myB1WFXMpzgCSE0nb4kWZaKd0qlBHcBwKQ5oFBGQ8e77MdMFqcBOBcZtDqQUZJXDQ/F67vu+cCXa1DbwwO3jU/YRRwIZMmtSWoNCyEoBpYACZFMZ7wqh9BIMAfQJBvSjIpLXCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XevH8063; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB910C4CEF7;
	Sun, 20 Jul 2025 08:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753000380;
	bh=p4PUfLJ/eSyng1QdNZM1AA4Dfx2TErleZwFHoI+uYVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XevH8063ZoGkEpwXLmJVV8TzIU3hVFQkCYvbJHa7nk8hS3+oEclY0LODWSXtiuwDS
	 KUjdIYBchD0s0lVuXjPTkLS7vYWifsA1BmfIFu+6/dXhEf5+ykSftbQrIchGLAoKDj
	 yr9OqTWK4iPh+CMc0qTmSj3WVks+6NG8d69kYA9o=
Date: Sun, 20 Jul 2025 10:32:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: Ma Ke <make24@iscas.ac.cn>, arnd@arndb.de, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] char: xillybus: Fix error handling in
 xillybus_init_chrdev()
Message-ID: <2025072033-slam-legroom-7730@gregkh>
References: <20250719131758.3458238-1-make24@iscas.ac.cn>
 <7a86086f-5b3b-104c-f06d-4194464d84e3@outbound.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a86086f-5b3b-104c-f06d-4194464d84e3@outbound.gmail.com>

On Sun, Jul 20, 2025 at 10:05:43AM +0200, Eli Billauer wrote:
> Hello,
> 
> On 19/07/2025 15:17, Ma Ke wrote:
> > Use cdev_del() instead of direct kobject_put() when cdev_add() fails.
> > This aligns with standard kernel practice and maintains consistency
> > within the driver's own error paths.
> > 
> Sorry, to the extent it matters, I'm not acknowledging this.
> 
> This is merely a code styling issue, and as far as I know, there is no
> "standard kernel practice" on this matter. If such standard practice exists,
> the correct way is to prepare a patchset of *all* occurrences of
> kobject_put() used this way, and replace them all (e.g. fs/char_dev.c,
> uio/uio.c and tty/tty_io.c). Should xillybus_class be included in this
> patchset, I will of course ack it, not that it would matter much.
> 
> In my opinion, using cdev_del() is incorrect, as you can't delete something
> that failed to be added. Practically this causes no problem, but as a
> question of style, the kobject_put() call acts as the reversal of
> cdev_alloc(). This is formally more accurate, and this is the reason I chose
> to do it this way.

But the "problem" is that just the kobject_put() might not be enough,
the kmap needs to be freed.  But the map might be the part that failed,
so then the kobject_put() is incorrect to be calling!

So yes, I agree, this patch shouldn't be applied, it's not going to
solve the real problem here in that the cdev api is a total mess in many
places like this (full disclosure, it's probably all my fault as
well...)

As failing this codepath is NOT triggerable by a user, this whole
discussion is just theory at this point in time.  So let's just leave it
alone.

Long-term, the cdev api should be fixed up, it's been on my TODO list
for decades now, and in a way I'm punting it to just wait for the rust
versions of drivers to take over as that's the correct fix for many of
these types of corner cases as the bindings will get this right.

Ma Ke, if you want a real project, please work on fixing up the cdev
api, don't worry about code paths that never can be hit like this.

thanks,

greg k-h

