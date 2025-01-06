Return-Path: <stable+bounces-106836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6C1A024D4
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6991885D54
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAD5156C76;
	Mon,  6 Jan 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uLAUElyF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2E1DC074
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165404; cv=none; b=bdbKM3Y2mEIDf8qBG0p9SQNFDeMC4fPHv0kr9ADhnoANXwh7lITTpzUzT6o7WG0aCdgseGilgAsUER4HeEaSNHS13L+NhdW+jL6B5H9e/MVrqrlnmDP8mrYPpI6FQXs6NEfSM1+KgZCdfRJ+aNjlsglOSD6mdUPbeC8kEkCxRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165404; c=relaxed/simple;
	bh=9HasPQ9rXOJIIyqZ+j7Pc3qpsSPb8SH7kG0vWwgg8lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic1hKb2uz0M84h6T2TtoC7yuS1fla24aT3y3XvND2/YN55oSibG2QLhjy0puED1hpBFaDcabZEZPY1wl78nPcAYRoioUnNf/TtRsfQIXEyVIfZKozuJd7S6JJbc0sAHWrvzQNDgE8RCsIj0hdktqkoF75KYILGYypC6CiWwQ+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uLAUElyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63892C4CED2;
	Mon,  6 Jan 2025 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736165404;
	bh=9HasPQ9rXOJIIyqZ+j7Pc3qpsSPb8SH7kG0vWwgg8lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLAUElyFpLrZXEDBiFqvAe9gTfJlvO5SYjaomrxmM46bm8yd44/SXTk/nrVMVz2SM
	 akNJm/BJW45Oxf6Oy7hI5yE3FwHEKsCTd7adpQxB2DVbwWguz7TmTdCFXyZvSK1RKK
	 osAnsDMhSZ7UJdhZryGwZnFqRb2JWEQwV+xTG6AY=
Date: Mon, 6 Jan 2025 13:10:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
	ju.orth@gmail.com, shuah@kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, vbabka@suse.cz
Subject: Re: FAILED: patch "[PATCH] mm: reinstate ability to map write-sealed
 memfd mappings" failed to apply to 6.6-stable tree
Message-ID: <2025010641-value-reassure-b741@gregkh>
References: <2025010652-resemble-faceplate-702c@gregkh>
 <5c77a26b-9248-4f04-a5cb-256186dfb7f2@lucifer.local>
 <d583760e-38b7-484f-94a3-2c787107832f@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d583760e-38b7-484f-94a3-2c787107832f@lucifer.local>

On Mon, Jan 06, 2025 at 11:56:50AM +0000, Lorenzo Stoakes wrote:
> On Mon, Jan 06, 2025 at 11:19:17AM +0000, Lorenzo Stoakes wrote:
> > On Mon, Jan 06, 2025 at 12:06:52PM +0100, gregkh@linuxfoundation.org wrote:
> > >
> > > The patch below does not apply to the 6.6-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> >
> > I actually intentionally didn't add Cc: Stable there as I knew this needed
> > manual backport (to >=6.6.y... - the feature is only introduced in 6.6!) but I
> > guess it was added on.
> >
> > Now the auto-scripts fired anyway, can you confirm whether 6.12 got it or
> > not? To save me the effort of backporting this to 6.12 as well if I don't
> > need to.
> >
> > I'll send out a manual backport for 6.6.y shortly. Older stable kernels
> > obviously don't need this.
> 
> Correction - the feature I am fixing landed in 6.7, so no need for a backport to
> 6.6 then :)
> 
> Only 6.12 requires a backport.

Great, it applied cleanly there and is now queued up, thanks!

greg k-h

