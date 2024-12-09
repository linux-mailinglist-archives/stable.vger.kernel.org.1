Return-Path: <stable+bounces-100261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD72B9EA11C
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 22:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF7F2824CB
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131919CC24;
	Mon,  9 Dec 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QFPLwNF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D549652
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778980; cv=none; b=QSxqVJryXQRQJXUSsNKVeDyIG7sqc9jwzujdukARJ+iApEYOr7/0Yk3yv5yCCW1Zmzd1SGpfA8q69XoYBQ4654aHk0B+xqOZDGrPcDAikK/GJBUGC4lJATJQXap00YJMU9P5LbLJSZeO7lBL2IimMjH5jAXUJvCPUvtYfZvhmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778980; c=relaxed/simple;
	bh=I8DNGOSoGse90CgHCajbmWURDoMo4ftbtCFvA0K8b28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuKjAhr98KwAhpNDlI8YWrwTXIg9E26P1JWLYF9BDZWzFHsWLf/f1/Dv6iEy7pE/Qu0KudML1A3Rt+5gBIS6xCBUKylphnHM4TwusfjEP5RGRUxfqiwq3NpgOLUL+8XVAARrzwy7rIRjqk1LTNEvws46VfmyPQEhn6BSHP9Z438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QFPLwNF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3627EC4CED1;
	Mon,  9 Dec 2024 21:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733778978;
	bh=I8DNGOSoGse90CgHCajbmWURDoMo4ftbtCFvA0K8b28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFPLwNF4xKBvEnaro9eDh4SGolsKdhIuYUlPulYfDnWIZ0J+pHFJ1CCUjXzbI/wuB
	 S8DLuAJyGjU+M+92GYOMfcM1EN+FAypxV6h3D0D6kuF6dksJw+eQwsodlzkKwjq+Ti
	 QIaYaJpEX/+nY1F1z+5if99wFO/6gbFxWhZKbtNk=
Date: Mon, 9 Dec 2024 22:15:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, pkaligineedi@google.com,
	hramamurthy@google.com
Subject: Re: [PATCH 5.15] gve: Fixes for napi_poll when budget is 0
Message-ID: <2024120934-catching-ashen-1ea9@gregkh>
References: <20241126191922.2504882-1-ziweixiao@google.com>
 <2024120216-gains-available-f94f@gregkh>
 <CAG-FcCPpEOEyeFUH7FGFQmsnS-eZi6CLq_FqPkJ6aKQ-+p210w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG-FcCPpEOEyeFUH7FGFQmsnS-eZi6CLq_FqPkJ6aKQ-+p210w@mail.gmail.com>

On Mon, Dec 09, 2024 at 10:46:58AM -0800, Ziwei Xiao wrote:
> On Mon, Dec 2, 2024 at 1:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Nov 26, 2024 at 07:19:22PM +0000, Ziwei Xiao wrote:
> > > Netpoll will explicitly pass the polling call with a budget of 0 to
> > > indicate it's clearing the Tx path only. For the gve_rx_poll and
> > > gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
> > > to do all the work. Add check to avoid the rx path and xdp path being
> > > called when budget is 0. And also avoid napi_complete_done being called
> > > when budget is 0 for netpoll.
> > >
> > > The original fix was merged here:
> > > https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
> > > Resend it since the original one was not cleanly applied to 5.15 kernel.
> > >
> > > Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
> > > Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> > > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > > Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > > ---
> >
> > No git id?  :(
> 
> Sorry for missing that. Here is the commit id:
> 
> commit 278a370c1766 upstream.
> 
> Do I need to resend a V2 to contain the above line? Thank you!
> 

Yes please.

thanks,

greg k-h

