Return-Path: <stable+bounces-210313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67248D3A68D
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E50B430875D1
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AF3590B5;
	Mon, 19 Jan 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PslAOGdI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11430AAD6;
	Mon, 19 Jan 2026 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821208; cv=none; b=JRH66VwtP9wfLcoi2J9aZn/1HLDyZZhVMerMmZcgWuprmsQZeMloqkSMzSL3/04KQX3btoaXC+O+Gq1BeqURsX/ZOW6BCYMxvTJGHZ1yvKEFbulhgyYzirPyOvKE3kO89rnEF0eEPqPPYHHjJVCobktV4bS/+j6LldvcVKKlDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821208; c=relaxed/simple;
	bh=rNSGZxud567v10BeseS20OgT8ZnWC/4wEOvJuFKo2ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrEJA5gjVJFP7w2H2w1vydXXJlbtxXdoHwxVvAV74JL3ci4nObUkm7LHJ7gBdRrN6ocNszFjyGsDoc4bRys4xNq4NHS5X7cIdldv2dZIRhcAf3imewqQ0Ob2771G3Z7pek2Zz6CW4+gq3SLCR9kfj38sGNfe+lAV2zTddBj8VpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PslAOGdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A68C116C6;
	Mon, 19 Jan 2026 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768821208;
	bh=rNSGZxud567v10BeseS20OgT8ZnWC/4wEOvJuFKo2ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PslAOGdIEsdznmz9Gs7juprKKAU50rukxeIZPbn90DxmhLsjwnUBGVju1K5hvfsug
	 6LZuAtCJweaxftQwl7Xzf+dSnTZxNRKqZMXp88zmwNPyA0Xf4eUIx8u0M/kZRdUixr
	 ghaZ7+gsvQ2tXWwvVAK91Lgr6M/tTaYBmgg0TZXU=
Date: Mon, 19 Jan 2026 12:13:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 205/451] firmware: imx: scu-irq: Init workqueue
 before request mbox channel
Message-ID: <2026011917-afternoon-tiara-d453@gregkh>
References: <20260115164230.864985076@linuxfoundation.org>
 <20260115164238.316830827@linuxfoundation.org>
 <b510c4fd58410b0d1125aedcae95a38f28990142.camel@decadent.org.uk>
 <2026011806-uncapped-marvelous-d81b@gregkh>
 <b50803c9347a3c49bff42608fc9c9ea9e117a96f.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b50803c9347a3c49bff42608fc9c9ea9e117a96f.camel@decadent.org.uk>

On Sun, Jan 18, 2026 at 12:08:54PM +0100, Ben Hutchings wrote:
> On Sun, 2026-01-18 at 09:42 +0100, Greg Kroah-Hartman wrote:
> > On Sat, Jan 17, 2026 at 09:08:35PM +0100, Ben Hutchings wrote:
> > > On Thu, 2026-01-15 at 17:46 +0100, Greg Kroah-Hartman wrote:
> > > > 5.10-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > > 
> > > > [ Upstream commit 81fb53feb66a3aefbf6fcab73bb8d06f5b0c54ad ]
> > > > 
> > > > With mailbox channel requested, there is possibility that interrupts may
> > > > come in, so need to make sure the workqueue is initialized before
> > > > the queue is scheduled by mailbox rx callback.
> > > [...]
> > > 
> > > This is an incomplete fix; you also need to pick:
> > > 
> > > commit ff3f9913bc0749364fbfd86ea62ba2d31c6136c8
> > > Author: Peng Fan <peng.fan@nxp.com>
> > > Date:   Fri Oct 17 09:56:27 2025 +0800
> > >  
> > >     firmware: imx: scu-irq: Set mu_resource_id before get handle
> > 
> > How did you determine this?  There's no "Fixes:" tag to give us a clue
> > as to if it's needed anywhere or not.
> 
> I looked at the first fix and asked myself "what other initialisation
> does the interrupt handler depend on?", and then I found this.  I think
> all versions of the driver need both fixes.

Ok, now queued up, thanks.

greg k-h

