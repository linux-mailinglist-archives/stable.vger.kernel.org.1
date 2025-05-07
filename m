Return-Path: <stable+bounces-142060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C19AAE0BE
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDFDB22171
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EBF288539;
	Wed,  7 May 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tjhgxxRw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545021504D;
	Wed,  7 May 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624510; cv=none; b=lbAf0AJB30HjgdLhKZ2F4S7Ri/SocjRkivKPBuZqAafyfiIW3X5Wh4r2ugyXgCmmRUIHDSfKbLPF3DklA2KTsh53ztIebBh/Q0tTLmAt8s7SkQU2zwkJ9VgMzHEv9hg5yehNYnmx0UIg1vuE1PrYMrNCtNm3W1VZWsnv6X0lnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624510; c=relaxed/simple;
	bh=CdK7UDpe+n+B1AWq9r87Xx3u1iESZApxZFrTY8qGDqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQLzv1UCRKBjctksa7jvYXx41sivgM/9wln40chrIa29GGZudTkicMyYx6IRPO2GQvDOzJDD/+wxXlNq9ueZktbDPNOOmhdtPYacR/I3YKfcjknQqI/qjXbKIuq9c1cFebv0Cgo9v5LWkJKfjkPhXvc3WgYfFgYK6UxHRkBUlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tjhgxxRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDEFC4CEE7;
	Wed,  7 May 2025 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746624509;
	bh=CdK7UDpe+n+B1AWq9r87Xx3u1iESZApxZFrTY8qGDqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjhgxxRwjnUcD9W61ES6yNSC/lNNdWqKqVZ/a6ny9Dp7iTX5oFrypxwWMAPWWT5m0
	 3lhymGGYWycmcf4Zo79zgfW8uw/qlbGzTsxzZG0ZHtTi36+PlPo1CKy1bRU2N4MtJl
	 llNzHwLh5ULfTT5HfDIW5GowegJd1HIr/tJNuefk=
Date: Wed, 7 May 2025 15:28:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hideki Yamane <henrich@iijmio-mail.jp>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Sergey Shtylyov <s.shtylyov@omp.ru>, Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	h-yamane@sios.com
Subject: Re: [PATCH 6.1 150/167] of: module: add buffer overflow check in
 of_modalias()
Message-ID: <2025050751-backer-update-3b45@gregkh>
References: <20250429161051.743239894@linuxfoundation.org>
 <20250429161057.791863253@linuxfoundation.org>
 <20250507200533.ac131fe0c774b23054b4261e@iijmio-mail.jp>
 <2025050737-banked-clarify-3bf8@gregkh>
 <20250507222156.6c59459565246dc1b5ae37fc@iijmio-mail.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507222156.6c59459565246dc1b5ae37fc@iijmio-mail.jp>

On Wed, May 07, 2025 at 10:21:56PM +0900, Hideki Yamane wrote:
> On Wed, 7 May 2025 13:12:02 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > It does not apply there cleanly, please submit tested patches against
> > those branches if you wish to have it applied there.
> 
>  Diff attached, and built fine with those patches and corresponded branches
>  on my laptop. Those changes just adds checks for length, so I guess no harm
>  with that.
> 
> 
>  I'm not familiar with Linux kernel development (my previous 1-liner patch
>  was merged 20 years ago ;) so maybe I did something wrong again, please
>  point out, then. Thank you.

I'll take Uwe's backports, but in the future, when you send a patch on
like this, you also need to sign-off on it, especially as you had to
modify it from the original change.

thanks,

greg k-h

