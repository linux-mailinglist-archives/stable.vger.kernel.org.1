Return-Path: <stable+bounces-111996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D93A255DF
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174273A8DA8
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5601FF605;
	Mon,  3 Feb 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oh7McrJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B57E107;
	Mon,  3 Feb 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575033; cv=none; b=dKrlakuGviIntTghVkeJiLfd+KxXPhiPgsquTzeg0fNf2uOFQHXbBf/Ij8EVPtoGhsCjTkEvW+M+KS8BupqUEbNzBcTUOPuYGjq8IL4J0kLU94FB6wfowKFbwumkU8u+kxyHquL+8Oz7oGLSKPRreNTrXapuXlmOvk/eMwxRoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575033; c=relaxed/simple;
	bh=7dRHxBJwteHt75w/Fl1j68P8sLvSNB4O6RLpnDt6I1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of0wuVUth9Uxhaid6NALWWojMa4siaJipPy+lvUGCPdlz3PwpsT5MLHUGu6JNz997Qbcj8RUp2eV9Lbq3uTDAUNQJuojP2RXo+KypSF/d8VYlMwoguViTQeKGotTkLFuvN6KlXBbKs+54aIJlrCGsOXyJMGV6v+U+z8PI8KYH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oh7McrJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B29C4CEE2;
	Mon,  3 Feb 2025 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738575031;
	bh=7dRHxBJwteHt75w/Fl1j68P8sLvSNB4O6RLpnDt6I1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oh7McrJn3fsdURUzXuwhp7CkWmkjPDmQ6oGH6tPYKHof1sjh8xj0318kBibYpBmi2
	 yJmYXO6yeGg+TeDOw6msEAis6jgvu9wPYuhe2tF6l3iBAwg/RXkt2A1ricKiIsqlzp
	 Xz7ZYPeMkFfdJ44okaSgvUU7aQORlKxslw9Hgq2c=
Date: Mon, 3 Feb 2025 10:29:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	sui.jingfeng@linux.dev,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: Patch "drm/etnaviv: Drop the offset in page manipulation" has
 been added to the 6.12-stable tree
Message-ID: <2025020354-helpless-tiring-9fc5@gregkh>
References: <20250202043355.1913248-1-sashal@kernel.org>
 <d8b6c3b4eda513277f19640c8f792c6d70b03f06.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b6c3b4eda513277f19640c8f792c6d70b03f06.camel@pengutronix.de>

On Mon, Feb 03, 2025 at 09:59:56AM +0100, Lucas Stach wrote:
> Hi Sasha,
> 
> Am Samstag, dem 01.02.2025 um 23:33 -0500 schrieb Sasha Levin:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     drm/etnaviv: Drop the offset in page manipulation
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      drm-etnaviv-drop-the-offset-in-page-manipulation.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> please drop this patch and all its dependencies from all stable queues.
> 
> While the code makes certain assumptions that are corrected in this
> patch, those assumptions are always true in all use-cases today. I
> don't see a reason to introduce this kind of churn to the stable trees
> to fix a theoretical issue.

Maybe in the future, for "theoretical issues", please don't put a
"Fixes:" tag on them?

thanks,

greg k-h

