Return-Path: <stable+bounces-36046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D8D899952
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53064B233C3
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A5160782;
	Fri,  5 Apr 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rTDThqmZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836615FD1C
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308786; cv=none; b=rq8Yq3kU4F9r886oCB0EjSKx4A+fGh7ha/7sqeVvZ8dTJlPzSWgUy+t9Jlek73kJVyjPJg1Otz7jzASG2G1yu44l1JiN+vFfHo281NHnGTsmKfXHoBSPkaR/cRS6JR76J1q2g0QDmFtiAGMI/aQoi3W6Gk2j1VTbJ00senu54jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308786; c=relaxed/simple;
	bh=gEk1Z9WRCdN0cB1UG87AYIXQ4U4udVyCX24K7lbSUxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3QXJvt6t1hRAIpePZnKDEVXqXgKWAPsImSTi3PzR7v6/pDjjiewfN90om0/O4+T/WOj1R+C7Hw5jR6UjtBpXl11E1mxT20LZs2nByhTd6DoEe6Ac3hevTGy4Z/WJzZF5dobbP6G0a589Nx3d5VLLnKeA3P0QJUyrGzJcU/0NSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rTDThqmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45CDC433B2;
	Fri,  5 Apr 2024 09:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712308785;
	bh=gEk1Z9WRCdN0cB1UG87AYIXQ4U4udVyCX24K7lbSUxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTDThqmZJtjJ9oZagZtLbxNUsuLRnXwKW0X02FAu4jPgQI1Vc1qJjskZl6bRjb5v0
	 Ij3W5C1vZlfWmKJ+4lHj6Eqr8BQN8z8GjrhFBtXwUgyAEsHuKoZFyrRuc9bj5HLb/v
	 zJ2xnVKY+s5Xiw99hehJqWchG9i7bs67Pg22o+7Y=
Date: Fri, 5 Apr 2024 11:19:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Russ Anderson <rja@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6.6.y] Revert "x86/mm/ident_map: Use gbpages only where
 full GB page should be mapped."
Message-ID: <2024040521-shudder-generic-923c@gregkh>
References: <2024040118-disgrace-tanning-bf41@gregkh>
 <20240402172908.4137792-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402172908.4137792-1-steve.wahl@hpe.com>

On Tue, Apr 02, 2024 at 12:29:09PM -0500, Steve Wahl wrote:
> From: Ingo Molnar <mingo@kernel.org>
> 
> This reverts commit d794734c9bbfe22f86686dc2909c25f5ffe1a572.
> 
> While the original change tries to fix a bug, it also unintentionally broke
> existing systems, see the regressions reported at:
> 
>   https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
> 
> Since d794734c9bbf was also marked for -stable, let's back it out before
> causing more damage.
> 
> Note that due to another upstream change the revert was not 100% automatic:
> 
>   0a845e0f6348 mm/treewide: replace pud_large() with pud_leaf()
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: <stable@vger.kernel.org>
> Cc: Russ Anderson <rja@hpe.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Link: https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
> Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> (cherry picked from commit c567f2948f57bdc03ed03403ae0234085f376b7d)
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> 
> Thought I'd try and be of help.  The pud_large() / pud_leaf() change
> is what caused the difficulty in reversion.

Thanks, Sasha already did this one, I'll go queue the other backports up
now though.

greg k-h

