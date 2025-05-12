Return-Path: <stable+bounces-143149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B69AB32D0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AE41890363
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09B2550D4;
	Mon, 12 May 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lzJVQTxy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28F18641;
	Mon, 12 May 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041236; cv=none; b=YQ1gKhlqRS7IXkt+Rt2gpFVv3W8MF+38ON9W/YRjCcP8BE0y/fmCr5LzGBfS4cKczTiTef9P3dKaENZdfyom9Hc3fWf3DbwJlURJk5HtR4eR++ffEyuQIIFQkzOQ+p/8xmeF/D3UBwOBE3X6GcajLsdaiTBpPpr238vpfU9/DPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041236; c=relaxed/simple;
	bh=9eDfnTJ1cqtmus6meHc4U3rLnqtzmxI6G3DHKL8WDZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8G+qg4FTzKunpBut9vbqzuFP4s2V+xsoN7rm5RPbn5szmalxusyob2PpGikp9VAq4ZJ2fuOqwSj5ipCM7dgjFQWxVPb8EBHR/EjPtnDGd7Kk+DSxMlb/Ut5sq0CbHjkRneTnlbRDLyLZnPXybPyF2G/HshO5SuB4HrNzQtYBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lzJVQTxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2719CC4CEE7;
	Mon, 12 May 2025 09:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747041233;
	bh=9eDfnTJ1cqtmus6meHc4U3rLnqtzmxI6G3DHKL8WDZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzJVQTxyt2/53WT1Ag/ArEtsUNeUNFfnMLAyeWnrvqkVsLedKICqfafCHsIgX5b9q
	 rSajuYRd41ZbcnUMaBUCzMsuRNxNdeGk4nJlHQRlmva5BnkwqVFgR2dTRiXWHQxoYK
	 qxvJ+js1eZwylcBc+HrMG2XWG4MTmbHKxn6zNQPM=
Date: Mon, 12 May 2025 11:13:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Patch "s390/entry: Fix last breaking event handling in case of
 stack corruption" has been added to the 6.6-stable tree
Message-ID: <2025051244-darn-overbuilt-c16b@gregkh>
References: <20250511175902.3461288-1-sashal@kernel.org>
 <20250512080244.12203Abb-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512080244.12203Abb-hca@linux.ibm.com>

On Mon, May 12, 2025 at 10:02:44AM +0200, Heiko Carstens wrote:
> On Sun, May 11, 2025 at 01:59:02PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     s390/entry: Fix last breaking event handling in case of stack corruption
> > 
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      s390-entry-fix-last-breaking-event-handling-in-case-.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This patch shouldn't be applied as it is to 6.6, 6.1, and 5.15 stable kernels,
> since it won't compile. I'll provide a slightly modified variant.
> 


Now dropped, thanks.

greg k-h

