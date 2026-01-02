Return-Path: <stable+bounces-204472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2844CEE87F
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 13:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81EF30274DE
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845930F55A;
	Fri,  2 Jan 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="caXCaFDb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E612571D7
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356672; cv=none; b=CVsgDH445KIO3fCZlWjQ4QdINmPBuII7phFPBO56rTpw4U1EEv+7/mg29LCwTvBh80MRJOmXaqmi0lXKvkfIIiBADKHSa8TdGlxS4G4rcelH16jeZv25is1zDjJJa9EWnfbdYXFOTWfNWFuki/SJkUnrrwNo9iOJmKKJc7atujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356672; c=relaxed/simple;
	bh=drxGlulLiVHGCK3RMD8I6+ltWQy9V3l/2e+ULnsuM+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0zOf1QhvziWhjUw8LCZZWNPf6TTaJo52QfdFt1O9ZCBWd+cos2AQYjR434fFlwI4Ydm3+R7VjCAEtIs9uLGB+buFXzrXYJcRVx2wBefuMBTg51OCbYQmhNtMKPHUv4tEBFzf9VexBo6wkUM8KdYJ2qnZVNqE7S50rMiSKLR5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=caXCaFDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AB9C116B1;
	Fri,  2 Jan 2026 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767356671;
	bh=drxGlulLiVHGCK3RMD8I6+ltWQy9V3l/2e+ULnsuM+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caXCaFDbPHhIdB0mpfBT8fwsg8+/yY4GzxzXCUUUE0Ay5AOOygGCPbX16m9bZ2EGz
	 BQd2Q2/AmqSc/x3CaGTw6BMiHZIWqo2NF9rL8pWiBZXOseeKteQsl/ymlMcEUBDYtS
	 alYy3VUh/mG+hfptTo+6JFk5xv2LwKqOy78h6XOo=
Date: Fri, 2 Jan 2026 13:24:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
	lance.yang@linux.dev, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	stable@vger.kernel.org, ziy@nvidia.com
Subject: Re: FAILED: patch "[PATCH] mm/huge_memory: merge
 uniform_split_supported() and" failed to apply to 6.18-stable tree
Message-ID: <2026010206-footprint-impure-82b8@gregkh>
References: <2025122925-victory-numeral-2346@gregkh>
 <20251230031135.efpejaosso23ekke@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230031135.efpejaosso23ekke@master>

On Tue, Dec 30, 2025 at 03:11:35AM +0000, Wei Yang wrote:
> On Mon, Dec 29, 2025 at 01:33:25PM +0100, gregkh@linuxfoundation.org wrote:
> >
> >The patch below does not apply to the 6.18-stable tree.
> >If someone wants it applied there, or to any other stable or longterm
> >tree, then please email the backport, including the original git commit
> >id to <stable@vger.kernel.org>.
> >
> >To reproduce the conflict and resubmit, you may use the following commands:
> >
> >git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> >git checkout FETCH_HEAD
> >git cherry-pick -x 8a0e4bdddd1c998b894d879a1d22f1e745606215
> ># <resolve conflicts, build, test, etc.>
> >git commit -s
> >git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122925-victory-numeral-2346@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..
> >
> >Possible dependencies:
> >
> >
> 
> Hi, Greg
> 
> This one is not a fix to some bug.
> 
> We found a real bug during the mail discussion, which is 
> 
>     commit cff47b9e39a6abf03dde5f4f156f841b0c54bba0
>     Author: Wei Yang <richard.weiyang@gmail.com>
>     Date:   Wed Nov 19 23:53:02 2025 +0000
>     
>         mm/huge_memory: fix NULL pointer deference when splitting folio
> 
> It looks has been back ported to 6.18.y and 6.12.y.

I do not understand, should this not be applied?  Or should it be
applied?

confused,

greg k-h

