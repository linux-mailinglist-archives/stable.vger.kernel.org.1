Return-Path: <stable+bounces-200038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07BCA4777
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 17:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0131230BAFE1
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0C43009CA;
	Thu,  4 Dec 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g5vsSAlj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A363002CA;
	Thu,  4 Dec 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864994; cv=none; b=rmR+s3cP1mAnDcl6pYtJfJl9RxRzx7rmYlWggfrqdPXVcI15FHt63t/firV8nwnwpIWxySvEjCVI0CCgwmBg6kUqXJR66nix5DlqkseElxHvPnwaelwjg9b8tVbRtqrExuV08bZk+gQwRktUBzsTrpsVv0iTuMFSWnWAW5laac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864994; c=relaxed/simple;
	bh=An2BxO+S0ZrHLRF/BdDPEpDVM46IIuIL33gO+IY611A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWgDhOuoj0vU4NtOAMQ5YnCNnW/Y3/VjKlBaSoDGWpeo3QCSF7rsHWW8X6Un7NxDDsbMNxMXqkS7SwxUU+/S8n3Py0vNiRQkhkWXvUuGMZgGnmBhox4FzF83VAIaE523YHA484uWtwo9SqIHtL7TtVCcCR7iZkUJKatt6a5pWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g5vsSAlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FCFC4CEFB;
	Thu,  4 Dec 2025 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764864993;
	bh=An2BxO+S0ZrHLRF/BdDPEpDVM46IIuIL33gO+IY611A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5vsSAljd2ab7gcLQ5b/sCYMMVL5KPb2tjqU3nMkmrOE8Wa7hVkk/277tYrzF3GEh
	 l1nYtsCYYrh8HXTpOEGk24UwLQS/vr5bIEd4Zmo0+DdQgJeztYwXncqZmmcGu4RYrB
	 2QGcMKJYqjB9xtvHOfdax395ESXg3qnqh9qWemew=
Date: Thu, 4 Dec 2025 17:16:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
Message-ID: <2025120413-impotence-cornfield-16aa@gregkh>
References: <20251203152346.456176474@linuxfoundation.org>
 <CAG=yYw=7i7O7nLLDQ5hdP03wHFSQ04QEXtP8dX-2ytBmiJWsaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYw=7i7O7nLLDQ5hdP03wHFSQ04QEXtP8dX-2ytBmiJWsaw@mail.gmail.com>

On Thu, Dec 04, 2025 at 02:38:10PM +0530, Jeffrin Thalakkottoor wrote:
>  hello
> 
> Compiled and booted  6.17.11-rc1+
> 
> dmesg shows err and warn

Are these new from 6.17.10?  if so, can you bisect to find the offending
commit?

thanks,

greg k-h

