Return-Path: <stable+bounces-203559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEF8CE6E77
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8522A3007278
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861A319B5A3;
	Mon, 29 Dec 2025 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MukqzPTu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01A4F881;
	Mon, 29 Dec 2025 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016134; cv=none; b=X4pmblrV/fj9aIDv4nHgA4tpwBzl1L+aWBLkxZ2f+PxoHfLztutnvqLGHCtRzvkMntSd6MeDnPCAL6+BP3xBCEFbml+38I/8qUbGMr4YTzyV9XhZ360d71TIODDoA80sNEoZNqT2kDdvHP+f79vnZ5siOkJsE5LszmpaLHhkJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016134; c=relaxed/simple;
	bh=f1JrNkfMgWML4zyEvBqsLqEFTnIkQkdzkh5GzQE1TUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjM4BEz/V2SE0aJFQ2LLLEyikqM1Xw2pOOf9Clt9t8p+9YCahdef70Un+MVq5kEj5DbBNUEI3Z/eggdG5LrrBJSE/b+1zns46E/S1exOEllbqMnAVGb/Z9qxvynUQYqFZVILNwVoVwoqFljETHp8J4mm/PCm0wNhx2KJJxD0zOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MukqzPTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422C4C4CEF7;
	Mon, 29 Dec 2025 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016133;
	bh=f1JrNkfMgWML4zyEvBqsLqEFTnIkQkdzkh5GzQE1TUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MukqzPTu4QEGy9dKqXop8xDT3Xk9+X1ELbR6m2tv+5/vBr3T3OtQWQafCuu9QSXep
	 xqe95LkLidTEG9xdYPEQIFLPYkbnEeYC5L9bO601+z9p/6tFzbaUZo7oZ3Nqbe5URY
	 gmg9O1PPwwSZd8imUOM0Q8OgdfzEQhzmu5E3zWQY=
Date: Mon, 29 Dec 2025 14:48:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	chenchangcheng@kylinos.cn
Subject: Re: Patch "usb: usb-storage: No additional quirks need to be added
 to the EL-R12 optical drive." has been added to the 6.18-stable tree
Message-ID: <2025122940-spinout-baguette-f8fb@gregkh>
References: <20251227193644.48579-1-sashal@kernel.org>
 <0c02d5d7-259d-4e4e-a556-0d86473e636c@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c02d5d7-259d-4e4e-a556-0d86473e636c@rowland.harvard.edu>

On Sat, Dec 27, 2025 at 03:15:49PM -0500, Alan Stern wrote:
> On Sat, Dec 27, 2025 at 02:36:44PM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     usb: usb-storage: No additional quirks need to be added to the EL-R12 optical drive.
> > 
> > to the 6.18-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      usb-usb-storage-no-additional-quirks-need-to-be-adde.patch
> > and it can be found in the queue-6.18 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This commit will be modified by commit 0831269b5f71 ("usb: usb-storage: 
> Maintain minimal modifications to the bcdDevice range.") in Greg's 
> usb-linus branch, which has not yet been merged into the mainline 
> kernel.  The two commits should be added to the -stable kernels at the 
> same time, if possible, which probably means holding off on this one 
> until the next round.

I've picked this up now, thanks.

greg k-h

