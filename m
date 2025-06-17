Return-Path: <stable+bounces-152852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CACADCDCC
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183503B58B4
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB5E28C03B;
	Tue, 17 Jun 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nnI0O+fL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335A2E718F
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167794; cv=none; b=ghCxcoVKSYP0EXEbd25avJxVInphhMg8ckaPauytvnPSfMXv88V94H2PtzZFGZ5ROmNv7jyfDipx4zH0sUhC4c2uuej2JL2VhaQ0aEM48l544DMZQiHYTB6MyD1yVgQ3F/A3kJVI+OIMZrdKW6hLkMdm5wpPv/Dru3G+lMIy1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167794; c=relaxed/simple;
	bh=bwG0FE3meA+oM30CXfe0P6ugNBRT0AfQt3U6GUT9604=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9O1r4X2WjFm66xoRkWTigFfxnDNSSyCU3z4EJE01atQnubKtEh1TvV6x5Ir+AMHfXCAElbNi4/1HiXsOsrIYEX2ZwBydmVegSk8CXpYZiujFgub3C/noroEndflbVXn+Ldv9rJuW3s5pFhDTB30q2mjDxI5ep5BFHwuTYfFO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nnI0O+fL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0387C4CEE3;
	Tue, 17 Jun 2025 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750167794;
	bh=bwG0FE3meA+oM30CXfe0P6ugNBRT0AfQt3U6GUT9604=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnI0O+fLK+4vmlmHSLWTlEGMkD9GfieiQe4wHZ/j2P3oSu1csnPP6V0lWeBdRYl2+
	 EQlZ0XOWK9r9UKQdQscGtD0ahckB+9IXCZqw6htsr3vRRrZ0K7XdoOYzoS3IOItrqO
	 MIoL+HWVs+lDbs2LAjTpwRM0bidO8/QFR6gU3ul0=
Date: Tue, 17 Jun 2025 15:43:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: Revert of a commit in 6.6-stable
Message-ID: <2025061702-print-cohesive-3a1b@gregkh>
References: <906ba919-32e6-4534-bbad-2cd18e1098ca@kernel.dk>
 <313f2335-626f-4eea-8502-d5c3773db35a@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313f2335-626f-4eea-8502-d5c3773db35a@kernel.dk>

On Thu, Jun 12, 2025 at 11:49:46AM -0600, Jens Axboe wrote:
> On 6/12/25 11:38 AM, Jens Axboe wrote:
> > Hi Greg and crew,
> > 
> > Can you revert:
> > 
> > commit 746e7d285dcb96caa1845fbbb62b14bf4010cdfb
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Wed May 7 08:07:09 2025 -0600
> > 
> >     io_uring: ensure deferred completions are posted for multishot
> > 
> > in 6.6-stable? There's some missing dependencies that makes this not
> > work right, I'll bring it back in a series instead.
> 
> Oh, and revert it in 6.1-stable as well. Here's the 6.1-stable
> commit:
> 
> commit b82c386898f7b00cb49abe3fbd622017aaa61230
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed May 7 08:07:09 2025 -0600
> 
>     io_uring: ensure deferred completions are posted for multishot

Both now reverted, thanks,

greg k-h

