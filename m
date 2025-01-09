Return-Path: <stable+bounces-108070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B2EA0725F
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 11:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7399F3A72C5
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 10:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A982153F5;
	Thu,  9 Jan 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c2TY2aFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A2215199;
	Thu,  9 Jan 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417071; cv=none; b=rqyoO0D+sBwzIhM4nvmdBt4XcMOrrhkGlKayKJ3wIiI/UCqZHWZRroNnBl5fFjCJuIiUjEGEmiN+hkMTJkqm+t96y7bkKVpJC+5wOK5RkHD/UhxqwwUNP7soVfKYXURWPUdxIa/Ll1AtACICJWWdYRq3jTHeTwa7oXR3sjbFIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417071; c=relaxed/simple;
	bh=Sf3kHF5BxLC/TgfSE9nFpiuMLERbd9Tfv5dQ0tBn/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx1hPqW7qJ8TBq1CgMW41ZonAgZ67tTneU0VeZieGtLY4c2CdiF0fuQw/ihwtIsMbz69hZVzVjDQEkS6/VUuzxQKas1UPvL+SdA2NoepNrICWCkr6BywzX7V97DrAoXMyPp1PnNUnXhqXAN6M9rDGg+eK1+TJTAJcgQ+fviPqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c2TY2aFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB87C4CED2;
	Thu,  9 Jan 2025 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736417070;
	bh=Sf3kHF5BxLC/TgfSE9nFpiuMLERbd9Tfv5dQ0tBn/f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2TY2aFnktLr7If3goUOm9BTLfwYTuSkkW8nrfIudUftMMHBwoV2jchyF/7htKhUe
	 RjOOhPEnf56mbVoKP+RhcQ18oA6sb2Or8IW2htALRHCf3sNZbFsZ0+3zc50yclnbjF
	 7fEwiIsouxlGeLsu97EjEi/swf0lfQLLISnaMlYQ=
Date: Thu, 9 Jan 2025 11:04:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: stable@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	zhengyejian1@huawei.com, hagarhem@amazon.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.4] ftrace: use preempt_enable/disable notrace macros to
 avoid double fault
Message-ID: <2025010920-eclair-battery-fa8d@gregkh>
References: <20250108031736.3318120-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108031736.3318120-1-koichiro.den@canonical.com>

On Wed, Jan 08, 2025 at 12:17:36PM +0900, Koichiro Den wrote:
> Since the backport commit eea46baf1451 ("ftrace: Fix possible
> use-after-free issue in ftrace_location()") on linux-5.4.y branch, the
> old ftrace_int3_handler()->ftrace_location() path has included
> rcu_read_lock(), which has mcount location inside and leads to potential
> double fault.
> 
> Replace rcu_read_lock/unlock with preempt_enable/disable notrace macros
> so that the mcount location does not appear on the int3 handler path.
> 
> This fix is specific to linux-5.4.y branch, the only branch still using
> ftrace_int3_handler with commit e60b613df8b6 ("ftrace: Fix possible
> use-after-free issue in ftrace_location()") backported. It also avoids
> the need to backport the code conversion to text_poke() on this branch.
> 
> Reported-by: Koichiro Den <koichiro.den@canonical.com>
> Closes: https://lore.kernel.org/all/74gjhwxupvozwop7ndhrh7t5qeckomt7yqvkkbm5j2tlx6dkfk@rgv7sijvry2k
> Fixes: eea46baf1451 ("ftrace: Fix possible use-after-free issue in ftrace_location()") # linux-5.4.y
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  kernel/trace/ftrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, now queued up.

greg k-h

