Return-Path: <stable+bounces-40166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720308A96E8
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38C91C208E0
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A26115B57C;
	Thu, 18 Apr 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d+Vii8tx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44915B578
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434514; cv=none; b=uWq9ZLDfzzz9/Tw2PBDlGGRu0mOpEKGWernEw/3ABgHBLg+85vVHihO+jTyIU3EXniRZHvXxsrv+OUYrdkGpFIabRnd5YXD1JV3mZqEfSxrVbLlHIdS+Mq8mfOr5to/jMm2BnT1cpxnLVlrzZ7nsHBzPDguaWfYWYBTqXnrHS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434514; c=relaxed/simple;
	bh=NNmKGcsoVfTX1DcejEiXFHr31AzkMp5JBOtRPm0mcks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyxAijWGAAy5TRu74GaJhcWGLr/0mOQJRYLU3RDYGqp/L4QqsDwDYqu+ukg3exmF9XOaZ4T86tktq8HeZFJlFckT1w6VqffXbJ8CW/giQ01Y6DdaW8PgDCIkkE5gyp6W9jTqOtTkxRvo7kEsEFQyCevHGaMZHt9Nw67n/+M/KDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d+Vii8tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056E2C32783;
	Thu, 18 Apr 2024 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713434514;
	bh=NNmKGcsoVfTX1DcejEiXFHr31AzkMp5JBOtRPm0mcks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+Vii8tx7gw0na87BFQFtzjEwksTe9ptcDfPoyD/k0ysZhooCLPF66YzSByVqCfah
	 CWNfWbCHtSeCn6LZZw0et0fp+Ti49YYi6bSW1/2jXVxkPPrWmWmireoxrMEFN/u4jh
	 pamI8L7Pp+Eb64QJaONLW4tgu2NG1e7rs9kBSU6k=
Date: Thu, 18 Apr 2024 12:01:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: mizo@atmark-techno.com, stable@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: Patch "mailbox: imx: fix suspend failue" has been added to the
 5.10-stable tree
Message-ID: <2024041833-speed-bulgur-044d@gregkh>
References: <20240412052133.1805029-1-mizo@atmark-techno.com>
 <2024041520-wasp-suave-8d3e@gregkh>
 <Zh2_-LHx8oH9fdOS@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh2_-LHx8oH9fdOS@atmark-techno.com>

On Tue, Apr 16, 2024 at 09:02:00AM +0900, Dominique Martinet wrote:
> Hi Greg,
> 
> gregkh@linuxfoundation.org wrote on Mon, Apr 15, 2024 at 01:18:20PM +0200:
> >     mailbox: imx: fix suspend failue
> > 
> > to the 5.10-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      mailbox-imx-fix-suspend-failue.patch
> > and it can be found in the queue-5.10 subdirectory.
> 
> This only fixes typos in the commit message, but Mizobuchi sent a v2 here:
> https://lore.kernel.org/all/20240412055648.1807780-1-mizo@atmark-techno.com/T/#u
> 
> (unfortunately you weren't in cc of the patch mail either, sorry... He
> can resend if that helps with the process)
> 
> Peng Fan also gave his reviewed-by in the v2 thread, it's always
> appreciable to get an ack from someone closer to the authors.
> 
> 
> Since the code itself is identical, I'll leave the decision to update or
> not up to you; I just can't unsee the "failue" in the summary :)

I've updated the text based on the v2 and added the reviewed-by as well,
thanks for pointing it out.

greg k-h

