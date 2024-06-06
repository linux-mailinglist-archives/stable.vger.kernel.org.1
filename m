Return-Path: <stable+bounces-48304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED438FE765
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52C11C254E4
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE67194C9A;
	Thu,  6 Jun 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQuKFFwX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88D645;
	Thu,  6 Jun 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679797; cv=none; b=nOPzHbbNMxxrWf6yFI8nR15MmIuQGrir53TPoo1/V5n5ay78ZocUHEanVzmVcudo28jhHhM70T2XuyEW1qIbKkTUekobX432W6AX+kBGo0VHP8tNfMBY8+5FSd/oRscRsOUvtV0UotwmCrMoPtgJeeNAwxQcGgLy3ADagI9Yv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679797; c=relaxed/simple;
	bh=XEoKHX4ViWUaR5aLlIIjGdyBcDx923iyOAkacapH3Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiSMpDN8DcCGyMRqeitacDiZOI9TDSWv1hqyl6/baW/8iYjXge5DsedPU+ccUH55LzZgAIjpZyMRpm6FVMcePu1JZT/bmDjbuAve2YMVYnbkyoG0L24sViNmAlLkRQSAkZkTHpQfQJbSk3MhhNI1QUOw0Y8tWF7L8zrhVmAoI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQuKFFwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E869C2BD10;
	Thu,  6 Jun 2024 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717679797;
	bh=XEoKHX4ViWUaR5aLlIIjGdyBcDx923iyOAkacapH3Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQuKFFwXcli+6DAWWlLwI8AZGSiQ9fq7jCrGkCOZrm2bBltA3QYOGEWPNydqat6wZ
	 uZmKBCy6Z/iYqGE7fgCMiq4NU2A89/YPa8F5ESdfdcLOuvgn0JmAFlVmHP8qtaBrzN
	 w+sUijpNkSZkufewRqflKH3DSLkMNNNRDt1EgP10=
Date: Thu, 6 Jun 2024 15:16:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: Patch "arm64: fpsimd: Drop unneeded 'busy' flag" has been added
 to the 6.6-stable tree
Message-ID: <2024060620-maternal-railcar-43d2@gregkh>
References: <20240530191110.24847-1-sashal@kernel.org>
 <CAMj1kXH7rfoV_rsxHrwgY5++OuqTXHYdN_Zje4+HxTeQiwx1NA@mail.gmail.com>
 <2024060623-endorphin-gallstone-bf81@gregkh>
 <CAMj1kXEHRDCucONDVfe65k+O5kT0zrkLtuFh49pr-UvRh=Z-2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEHRDCucONDVfe65k+O5kT0zrkLtuFh49pr-UvRh=Z-2A@mail.gmail.com>

On Thu, Jun 06, 2024 at 03:13:14PM +0200, Ard Biesheuvel wrote:
> On Thu, 6 Jun 2024 at 15:10, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, May 31, 2024 at 08:16:56AM +0200, Ard Biesheuvel wrote:
> > > On Thu, 30 May 2024 at 21:11, Sasha Levin <sashal@kernel.org> wrote:
> > > >
> > > > This is a note to let you know that I've just added the patch titled
> > > >
> > > >     arm64: fpsimd: Drop unneeded 'busy' flag
> > > >
> > > > to the 6.6-stable tree
> > >
> > > Why?
> >
> > Because:
> >
> > > >     Stable-dep-of: b8995a184170 ("Revert "arm64: fpsimd: Implement lazy restore for kernel mode FPSIMD"")
> >
> > It's needed for the revert?
> >
> 
> No it is not - the revert itself is not needed, given that the patch
> being reverted does not belong in v6.6 either.

See my response now to the other commit, I've dropped them all now,
thanks and sorry for the confusion.

greg k-h

