Return-Path: <stable+bounces-128552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FEDA7E07D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F58C3B6311
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E232CCA5;
	Mon,  7 Apr 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZfKVtUn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054221940A2
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034515; cv=none; b=etVwSE1HamgxksnRsB8Cerfe8AXISAaxU1YxtMxm5ip8HJ0TbFvDAedZVA7SelaUuC/rzUywF4wYMI0zGT4RquChHoFDSLk51JF19qkQdAyWPUlUy96AD28SIviKXumv5l8Vu+n2fJR1WBXn4Hd0fAQnSMikms4R1g+Nl0db+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034515; c=relaxed/simple;
	bh=pwbCQRfk/gReP+Hhb7SwJzfHtTnW/J/qHql2+ZwpIBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAE6gzBw00WcL/eDxkxNfW4siEg9sm61Rwe7i2bR+d7Wa0KMx6qBTPyIOHZERFFala+k1r9rYuFBxH4yqYchKn+OcN9KlifKhIvI1k2wQuKRbHPJfGHvRW9VJjgA1fCyXzhDQqEjUPWP+XYcGULPKtPBLk4nqu/WRfATW5aMGp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZfKVtUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C37C4CEDD;
	Mon,  7 Apr 2025 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744034514;
	bh=pwbCQRfk/gReP+Hhb7SwJzfHtTnW/J/qHql2+ZwpIBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZfKVtUnj5u/YtfE8YQtixZXjY/Z85RxGh7l21pwQmVXviOVv1xDqLkkqF43o21rJ
	 eQLE+6xB7oqm5ExDXYAvLG+yK/HWWXz+2jjkexv4fyZpGmcWF/mo93axjISpCZx1bS
	 cxuXdRlRYzMouUxKLGlL8nL75PgD2M/03CbFADbM=
Date: Mon, 7 Apr 2025 16:01:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: 6.1-stable fix
Message-ID: <2025040725-watch-animating-4561@gregkh>
References: <0b556f07-d48a-4d01-84a9-1c79cb82f7dd@kernel.dk>
 <c31bd917-2166-468f-a998-da44d250b274@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31bd917-2166-468f-a998-da44d250b274@kernel.dk>

On Mon, Apr 07, 2025 at 07:56:18AM -0600, Jens Axboe wrote:
> On 4/3/25 10:55 AM, Jens Axboe wrote:
> > Hi,
> > 
> > Ran into an issue testing 6.1, which I discovered was introduced by
> > a backport that was done. Here's the fix for it, please add it to
> > the 6.1-stable mix. Thanks!
> 
> Ping on this - saw a 6.1 stable release this weekend, but this fix
> wasn't in it.

That's because you sent this after I announced the -rc1 release :)

I'll add it to the queue now, thanks.

greg k-h

