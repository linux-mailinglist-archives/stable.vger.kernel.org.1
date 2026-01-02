Return-Path: <stable+bounces-204476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC62CEEA91
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 14:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16340300E00B
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 13:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5E84039;
	Fri,  2 Jan 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CO7Ogowy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C29EEB3
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767359951; cv=none; b=TMu4e9tQiDpPIcwv8pzC4BjlLf3E4RB7WiNPxUtx3tvybR4nNYtGd9BK/iQBdp4kSdxJS/MEdLD61qRJBz6WrIS5xFSG37gWSrYI8NXLIkwGt3KJklCI+VEQUQEKJ0FOAq6i3rV6Yb1A6ImN4hwASEJDTA5FTG6ydMqp4Ricszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767359951; c=relaxed/simple;
	bh=oJCHeyuSpWx41ubzozeRFUns+tfC+zeOW0bogt0G/x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4FKpoVwRcNtNX/amQW0whu/rf9bQBChAVmefmY07vqnrpmArGkuD78wwWrdVRKqeye27yG6st0tk+PL0/PIYi2QV9aA+jnA7Pb7laNPvHU15/sUmXISEq3Pz39ulqlB5pL0vzUho74au2DtVv3STdcK6Ov1bmurC8m2mDaZtEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CO7Ogowy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9979C116B1;
	Fri,  2 Jan 2026 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767359950;
	bh=oJCHeyuSpWx41ubzozeRFUns+tfC+zeOW0bogt0G/x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CO7OgowymLEC2S6JLqJVvKtWgRhXGzG1Gpoznp45WpB9wtBgqILChOIz/SpGMGD6r
	 LmPihBn4hL1hXW0Wn+cWow6PTiJkOu8ix6qbAo/GoxlJcq5jMnoWqB31oVM4d3qwd2
	 yfbMo0LOM6G6Z6SRiK4vHMJjZxx8v0K9Z9tsH4F4=
Date: Fri, 2 Jan 2026 14:19:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacob Highgate <jacob.highgate@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Request to backport a fix for boot issues with Southern Island
 GPUs
Message-ID: <2026010200-nutmeg-step-ffa3@gregkh>
References: <3bb3d050-03ba-4d72-bb29-da1b6a9b6fc1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bb3d050-03ba-4d72-bb29-da1b6a9b6fc1@gmail.com>

On Fri, Jan 02, 2026 at 02:27:50AM -0500, Jacob Highgate wrote:
> Hello,
> 
> I would like to see the patch linked below backported to the 6.18 kernel.
> 
> Currently, on the 6.18 kernel, systems using Southern Island GCN GPUs are
> unable to boot using the amdgpu driver and they are shown an oops message.
> 
> Linked issues:
> 
> https://gitlab.freedesktop.org/drm/amd/-/issues/4744
> 
> https://gitlab.freedesktop.org/drm/amd/-/issues/4754
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2422040
> 
> 
> This commit will fix it:
> 
> Subject - drm/amdgpu: don't attach the tlb fence for SI
> 
> Commit ID - eb296c09805ee37dd4ea520a7fb3ec157c31090f
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c?id=eb296c09805ee37dd4ea520a7fb3ec157c31090f
> 
> 
> Thank you
> 
> 

Now queued up, thanks.

greg k-h

