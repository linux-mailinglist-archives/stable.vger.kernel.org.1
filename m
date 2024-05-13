Return-Path: <stable+bounces-43655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0644A8C4215
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15EF1F22501
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4494415357A;
	Mon, 13 May 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="keR+sE7y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A39153572
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607537; cv=none; b=Lq1jgKEU8geudqJblPjFR/c68B1Lv8vLPBF2snzF6zbi6L2xFXDp4RKWuXvPk+1Q5emrEBNgi5mySrQo0/WRjQyb4C+VOMOTP1PRlBIFYAwDc9/O9Jof+zjFhgL37ejKyfcSo31ApCkXjPC3ID/BQ6vPG56r8jNCyWUVoT5N2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607537; c=relaxed/simple;
	bh=6oORK3K/jND4g9/0GobikbJ2wrVBGIF6CxhyVVIPlAY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8y/VinouGwG65Qsz1juXo2oiwVynlq+QvVQRu+ff5iyxxUBWVEUPTuJa/WI3MSKKK4xQgzV8RK1kLxs6UEBu4N2APPWTEACnf1uekyqQlJOUAQUWb6jMC6tgsgK/lBjNXLIAiQSA/LL6utw8q8hs9DUR9pcjore3gQpQ2LVPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=keR+sE7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220B1C4AF0E;
	Mon, 13 May 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607536;
	bh=6oORK3K/jND4g9/0GobikbJ2wrVBGIF6CxhyVVIPlAY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=keR+sE7ygrJXJRRNBi8RFevTrimenMyEbRawjb+ccUc4mpfQYWI6CNvLDZfCt0aZ/
	 CHMlOd3XaUI3tQcm/ijIkFtujFZgR8hljWk8eutnshhDQkLQuS1kwzdZIA1Ler5lAp
	 dZM+O9WDIRnxnWWMjE1ugeSbMPK9Ogyviu4aKod8=
Date: Mon, 13 May 2024 15:38:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dan.carpenter@linaro.org, rientjes@google.com, stable@vger.kernel.org,
	vbabka@suse.cz
Subject: Re: FAILED: patch "[PATCH] mm/slab: make __free(kfree) accept error
 pointers" failed to apply to 6.1-stable tree
Message-ID: <2024051337-facelift-bakeshop-cbba@gregkh>
References: <2024051335-aversion-endearing-7ab9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024051335-aversion-endearing-7ab9@gregkh>

On Mon, May 13, 2024 at 03:31:35PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x cd7eb8f83fcf258f71e293f7fc52a70be8ed0128
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051335-aversion-endearing-7ab9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 
> cd7eb8f83fcf ("mm/slab: make __free(kfree) accept error pointers")
> a67d74a4b163 ("mm/slab: Add __free() support for kvfree")
> 54da6a092431 ("locking: Introduce __cleanup() based infrastructure")

Nevermind, I got this to work here and 6.6.y already, sorry for the
noise.

greg k-h

