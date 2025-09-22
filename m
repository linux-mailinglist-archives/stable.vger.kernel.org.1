Return-Path: <stable+bounces-180964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADA7B9196F
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 16:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47955424F83
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 14:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058D41A317D;
	Mon, 22 Sep 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0VdEKbNH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34519D8BC
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550115; cv=none; b=qLvtDfKbKjJ25WUeueSkjw8pkWTexT7ewYR49pgL6TvHX6KPxzQ/pYd0VCNofELJaFu7l1wXcS/iFVyWx81RvrCAaeeNk2OJqe6mqkvaJMb+1dKEFx8XmfNK1yRJhr9cwKSYCWgbpSL2y4UqtnP05dsmMJbFgXTOe9l/v0FT0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550115; c=relaxed/simple;
	bh=FGz4u6YWFdM9FFPNxqhaEbzWjzl1h3cSfLsjREsEdA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6ZJd2lYZvKT6CeCxAxaa/P7lr/YI/s4My4DgzqjHHUl8/ZY23plCYHOrEh4N0qUwu8AEpvhSGXk1ESVfMiLKI14/dUgo2sfUajAH86hIEt1jKtGdVjq9Uh+UoG67P8+67qyNTyPZfiW0co76fLaXHnw3/LH1Fg5gQH/MEiVxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0VdEKbNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD9DC4CEF0;
	Mon, 22 Sep 2025 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758550115;
	bh=FGz4u6YWFdM9FFPNxqhaEbzWjzl1h3cSfLsjREsEdA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0VdEKbNHKK6HoWHsVSAqYOn5+NdXzVp+/FxFLnS5Ri3MgmL94lPg1CF9wVkVGdLc5
	 JeeQouuXqeFlhz4h5rhLjIIxR1AyZLadxH5bNmgS+e9qBgA+Bh+xxUclfnNHeqt6mp
	 2ySz8D6SyFm6E+K3JZTK+/qT7IQp5LEsSx1gbNts=
Date: Mon, 22 Sep 2025 16:08:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: bp@alien8.de, sashal@kernel.org, stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "x86/sev: Guard sev_evict_cache() with
 CONFIG_AMD_MEM_ENCRYPT" has been added to the 6.12-stable tree
Message-ID: <2025092254-payment-rely-632c@gregkh>
References: <2025092205-quaking-approve-4cd6@gregkh>
 <371ed3b2-8c7c-40bb-4e23-6a246a715168@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371ed3b2-8c7c-40bb-4e23-6a246a715168@amd.com>

On Mon, Sep 22, 2025 at 08:37:51AM -0500, Tom Lendacky wrote:
> On 9/22/25 00:52, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      x86-sev-guard-sev_evict_cache-with-config_amd_mem_encrypt.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Maybe I didn't use the tag correctly, but I put 6.16.x on the stable tag
> to indicate that the patch only applied to 6.16 and above. Before 6.16,
> there isn't a stub version of the function, so all off those releases
> are fine.
> 
> So this patch doesn't need to be part of the 6.12 stable tree.

Thanks for letting me know, I've now dropped this.  I was triggering off
of the "Fixes:" tag, which shows it was needed back to the 6.1.y tree.

thanks,

greg k-h

