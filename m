Return-Path: <stable+bounces-60768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5CA93A07A
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 14:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE4F1C20B4A
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6F152181;
	Tue, 23 Jul 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="acL7sdIT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52B1514F6
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737260; cv=none; b=uGtzwUh6+cwlzehxdcDm8KTiZyUr6/PH/stkjzFbjzR4ujaQB1wwFhz6dj1g9hHAlomdm40sLRYtLLuhX4uHrs4nP58T76rEyYSr6CfP5WkzEPXKj1DuSbGE7CHwSmT+vtkKq7U4wOPknaqv99i7UFYQSbhrk7lu6I7wfggla4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737260; c=relaxed/simple;
	bh=+epO4cxc9Ps0LL2DvOYYUBvh6+A3szvyXdbvG3+yGFw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSCIDhtTyGr0/HI/ILHrWns9P7t/+1F6rcccf9POiBPbnvWFtij2APAfbaSG2XlSwbWqseXCMvWPQBmoUnFunxcWiis17OqyHybPuc2lV/8HhC+br3GYZz7xdz/u7092eZDu9gKnn8L3Y5qhp35iljEneMSbSa/pMOWgL8buya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=acL7sdIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164A2C4AF09;
	Tue, 23 Jul 2024 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721737260;
	bh=+epO4cxc9Ps0LL2DvOYYUBvh6+A3szvyXdbvG3+yGFw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=acL7sdITzuvwVA3GvSRf+A8cQqxUdopN8pbz9epGrXCl6gfHc0jjLc7B2WgQ/jtKi
	 WrqUziEEjLoviqkSR+prIBjZkc/EWMisAW9zrvVq21WUnwaS5RJ09A96ATi1ddhiEP
	 EGsxGwSs75yMOpDLVpeHz+spkWNKZ3KRCcIfgOUE=
Date: Tue, 23 Jul 2024 14:20:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: rafael.j.wysocki@intel.com, ebiggers@kernel.org,
	oleksandr@natalenko.name, s.l-h@gmx.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] thermal: core: Allow thermal zones to
 tell the core to ignore" failed to apply to 6.10-stable tree
Message-ID: <2024072348-penknife-heroism-3415@gregkh>
References: <2024072302-policy-spleen-3156@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072302-policy-spleen-3156@gregkh>

On Tue, Jul 23, 2024 at 02:17:02PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x e528be3c87be953b73e7826a2d7e4b837cbad39d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072302-policy-spleen-3156@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..
> 
> Possible dependencies:
> 
> e528be3c87be ("thermal: core: Allow thermal zones to tell the core to ignore them")
> 7c8267275de6 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

Nevermind, I fixed this up by hand.

greg k-h

