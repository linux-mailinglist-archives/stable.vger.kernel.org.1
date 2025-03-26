Return-Path: <stable+bounces-126647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5273A70E3A
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DBA170E59
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E0B67A;
	Wed, 26 Mar 2025 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ejdnCeO0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC271465A1;
	Wed, 26 Mar 2025 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948694; cv=none; b=Hz8sm9xI8uhnaPaQkKrZN71fs+8YIp45llUE7OvK/SKH0Y2kn2rTrXW2P5dvb/PfEjPKUj9QYgePATrQWED//UN8da50WzbYfAD/vhoX0XMZJnsy7Kh89LjiPvnGbDg4zJE3DjVBSVjRJwd9CyyWLN4+5J8Dxzp4dBLCWujU/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948694; c=relaxed/simple;
	bh=kP7ROH1z1YVE5tA+fLp3MfGeaKCOvNGqqOzrY7ykXNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxsFtn1EYkSXZX0wSqHf0muJHuu57a8M99StH9Ql6kLGqD/E7qC7mYYCVqh08z3F1OSwqlefBTEpe2fb5PATFtZKi0tHPKQk49RzWdk3J9VAuakZ+3Na+7d+Jha+ZmJtpKbIL9xAl3orILAHenRjz21v1wyGx8sugL6j4m+k7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ejdnCeO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA013C4CEE4;
	Wed, 26 Mar 2025 00:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742948694;
	bh=kP7ROH1z1YVE5tA+fLp3MfGeaKCOvNGqqOzrY7ykXNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejdnCeO0KB1PVS/D/tYElgaKJW+zYWs7giJCGLSIe45DgxmVVz/2yKUEbjwO3P9Df
	 LoZn37ojNIbfnw1KOz6asiKjOLfPTtMWjNAcg9v8Dzfvodt1Q7je6JmVvZzhg323xU
	 e7wZ+rdyhiDJSgqcH22A2eZnbrlq+BxC+wP0MlnU=
Date: Tue, 25 Mar 2025 20:23:31 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Sahil Gupta <s.gupta@arista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Kevin Mitchell <kevmitch@arista.com>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64
 mcount_loc address parsing when compiling on 32-bit
Message-ID: <2025032553-celibacy-underpaid-faeb@gregkh>
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
 <20250326001122.421996-2-s.gupta@arista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326001122.421996-2-s.gupta@arista.com>

On Tue, Mar 25, 2025 at 05:06:56PM -0700, Sahil Gupta wrote:
> The ftrace __mcount_loc buildtime sort does not work properly when the host is
> 32-bit and the target is 64-bit. sorttable parses the start and stop addresses
> by calling strtoul on the buffer holding the hexadecimal string. Since the
> target is 64-bit but unsigned long on 32-bit machines is 32 bits, strtoul,
> and by extension the start and stop addresses, can max out to 2^32 - 1.
> 
> This patch adds a new macro, parse_addr, that corresponds to a strtoul
> or strtoull call based on whether you are operating on a 32-bit ELF or
> a 64-bit ELF. This way, the correct width is guaranteed whether or not
> the host is 32-bit. This should cleanly apply on all of the 6.x stable
> kernels.
> 
> Manually verified that the __mcount_loc section is sorted by parsing the
> ELF and verified tests corresponding to CONFIG_FTRACE_SORT_STARTUP_TEST
> for kernels built on a 32-bit and a 64-bit host.
> 
> Signed-off-by: Sahil Gupta <s.gupta@arista.com>
> ---
>  scripts/sorttable.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

What is the upstream git commit of this?

If it's not upstream, then you need to document the heck out of why we
can't take whatever is upstream already, which I don't see here :(

thanks,

greg k-h

