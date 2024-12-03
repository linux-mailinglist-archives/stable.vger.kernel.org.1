Return-Path: <stable+bounces-96203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7489E1650
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD92B28216
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269BF1D63EC;
	Tue,  3 Dec 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e2wriAW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69A1BD50C;
	Tue,  3 Dec 2024 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214595; cv=none; b=exVSiYtXWX6zzvn+fBFT35PmEtwgLeBfLl1V+8SK7UXDvfXcGemLql5Nqpu49ifqqn/2vEae9zWa5nO81zfEaJseH5YZ/eA6xhjB5C1uJrXAaQYj4NADNn1VkvmiblIHfojzXrVuOyj/pAOa1g87bOeu6y3DI3gi1Bd8btXHKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214595; c=relaxed/simple;
	bh=gr+H3XZmKeDmDuvmIoh4XdlQSQrfI4LNHWPT5Reg6s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMz0F7PkG2Nt8C6ty4aFz1KnFkdpJhyA+LFG8Lnpxi583kywV2X/IA+6wL+6TCF+UMpbWc8tRHaR4wyBYKAQKa51qxEJQ2JLXGuBuh0SjhhLPNMmM4kasUJmKrxcwW8aVLn2HhHnqD+/f0azcnzYBpDAOOwv1g9/o7cyEl0kY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e2wriAW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA1DC4CED6;
	Tue,  3 Dec 2024 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733214595;
	bh=gr+H3XZmKeDmDuvmIoh4XdlQSQrfI4LNHWPT5Reg6s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2wriAW26+VqeIIRTXrjKhtwQ6ZKNTwdLALoF5L9YbbczRKPsFoqtI5n5hIdvg4xA
	 BSF15JGMSaak1PZgERIyNEsDEY94k3+3lVixOYnMMjjZnA8uCCxz4Kh+eLd2cyOLC0
	 BETOq9qQ2pBoHaFU187RepnCrurkjvBF8vQT3DrY=
Date: Tue, 3 Dec 2024 09:29:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	chenqiuji666@gmail.com, David Lin <dtwlin@gmail.com>,
	Alex Elder <elder@kernel.org>
Subject: Re: Patch "staging: greybus: uart: Fix atomicity violation in
 get_serial_info()" has been added to the 6.12-stable tree
Message-ID: <2024120343-passage-reputably-7afd@gregkh>
References: <20241201123620.1513386-1-sashal@kernel.org>
 <Z03J_ZvB-NUArQkH@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z03J_ZvB-NUArQkH@hovoldconsulting.com>

On Mon, Dec 02, 2024 at 03:53:49PM +0100, Johan Hovold wrote:
> Hi Sasha,
> 
> On Sun, Dec 01, 2024 at 07:36:20AM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     staging: greybus: uart: Fix atomicity violation in get_serial_info()
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      staging-greybus-uart-fix-atomicity-violation-in-get_.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 61937fd741031632e0a1337553e51b754748ca0d
> > Author: Qiu-ji Chen <chenqiuji666@gmail.com>
> > Date:   Thu Nov 7 19:33:37 2024 +0800
> > 
> >     staging: greybus: uart: Fix atomicity violation in get_serial_info()
> >     
> >     [ Upstream commit fe0ebeafc3b723b2f8edf27ecec6d353b08397df ]
> >     
> >     Our static checker found a bug where set_serial_info() uses a mutex, but
> >     get_serial_info() does not. Fortunately, the impact of this is relatively
> >     minor. It doesn't cause a crash or any other serious issues. However, if a
> >     race condition occurs between set_serial_info() and get_serial_info(),
> >     there is a chance that the data returned by get_serial_info() will be
> >     meaningless.
> >     
> >     Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> >     Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")
> >     Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> >     Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> >     Reviewed-by: Alex Elder <elder@riscstar.com>
> >     Link: https://lore.kernel.org/r/20241107113337.402042-1-chenqiuji666@gmail.com
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> The CC stable tag was omitted on purpose here so please drop this one
> and any dependencies from all stable queues.

Now dropped from all queues, thanks.

greg k-h

