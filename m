Return-Path: <stable+bounces-158991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC8CAEE68B
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 20:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03133A7787
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805162E2F00;
	Mon, 30 Jun 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFBJLteb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E7244676;
	Mon, 30 Jun 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307021; cv=none; b=X443tiGFKy+nrukesaKwQsmjN1tYpRe0Fk6DQvq9aZrO3CxYBWJfPbGzAPGCWPxigXH9sYvU075A0NwD6lJN8fhWPRipAiMX7P+uCzI27nrStyIoMnLuzVvQ6T1ENDeQeKg18YiaSRk9IPYiLUuZc/YAVCthLh1RsaKx/RtDIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307021; c=relaxed/simple;
	bh=fxZkgXKGh5iBCb4qthq91bumHw5ehMMShfTNuzW0adI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTLVWjeKlAQ3FtIPP9K543Ik7LKk6tElDQtk8JAxqZXjBZDmQvt0Ao59HUjzDSlTtKbdDsmWucBlbRa50ntsfKANnMv1fruAMeMbU7hEWwfEU+tpg5g3A4Rorfu+R2UqpAyXx6Fz/bP+4FfG2fQcPy4B3vdXC9K7CdxwYPIF+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFBJLteb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCFAC4CEE3;
	Mon, 30 Jun 2025 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751307020;
	bh=fxZkgXKGh5iBCb4qthq91bumHw5ehMMShfTNuzW0adI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFBJLteblUsp0DqASbWs9PzpZJ4uBChYu8+s7yQo/kPJqflav60S28zn3EYGYUrEC
	 aG4z3M16lCDMs48NerVnQXX6WeD8YhTYmnl2YkCNeysT4gUZ4TSWXFIWNCB7V9tYDs
	 9H6ZvaLLQJnEbmIPghDp0qP6sDDf/EAVfJXXYsLc=
Date: Mon, 30 Jun 2025 20:10:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: stable@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	Corey Minyard <cminyard@mvista.com>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Corey Minyard <corey@minyard.net>
Subject: Re: [PATCH stable] ipmi:msghandler: Fix potential memory corruption
 in ipmi_create_user()
Message-ID: <2025063054-abridge-conclude-3dad@gregkh>
References: <20250630-ipmi-fix-v1-1-2d496de3c856@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-ipmi-fix-v1-1-2d496de3c856@google.com>

On Mon, Jun 30, 2025 at 05:09:02PM +0000, Brendan Jackman wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> 
> commit fa332f5dc6fc662ad7d3200048772c96b861cf6b upstream
> 
> The "intf" list iterator is an invalid pointer if the correct
> "intf->intf_num" is not found.  Calling atomic_dec(&intf->nr_users) on
> and invalid pointer will lead to memory corruption.
> 
> We don't really need to call atomic_dec() if we haven't called
> atomic_add_return() so update the if (intf->in_shutdown) path as well.
> 
> Fixes: 8e76741c3d8b ("ipmi: Add a limit on the number of users that may use IPMI")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Message-ID: <aBjMZ8RYrOt6NOgi@stanley.mountain>
> Signed-off-by: Corey Minyard <corey@minyard.net>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> I have tested this in 6.12 with Google's platform drivers added to
> reproduce the bug.  The bug causes the panic notifier chain to get
> corrupted leading to a crash. With the fix this goes away.
> 
> Applies to 6.6 too but I haven't tested it there.

So what kernels are you wanting this to be applied to?

thanks,

greg k-h

