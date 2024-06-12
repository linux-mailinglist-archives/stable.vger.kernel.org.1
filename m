Return-Path: <stable+bounces-50315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8C905A96
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E945C283D44
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513693A1CA;
	Wed, 12 Jun 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IybVzzIw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25BB26AD5;
	Wed, 12 Jun 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216199; cv=none; b=Ook+iQDct5R85UjR/Okj9zy//D0pqQx87qzrgZiiYwmWy+4p8XHuNVZentnKgN+M0e7ccjjr0FOzdzfoJ7zkynqorElxdIR9oo63Rzx7oK7dh1+mRle7Eahrk9HAPcHHOt2a/CtREa4AtTLdOOqn/5DH6AZEdRe77cBe6j+Ybe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216199; c=relaxed/simple;
	bh=RiYwOD6LVY2ZM6eEZLk7/530X3wOguHSue3xzCfNu4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJtGLCHm//OXWq3WxGYasfi0VRdY9UM5xMG6TrXrpRUKIs2o7nSMSou6MY3d4dot59Hm18B02PI0JzLnjzCkfSz69UKwoN/JZCZ16M8kwN9yu36NwxBb58vCNctOwkDoWtyNG0CoofubuS4+1pbU6nWZ3KI2nY23f61ZHuPMnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IybVzzIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101DBC116B1;
	Wed, 12 Jun 2024 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718216198;
	bh=RiYwOD6LVY2ZM6eEZLk7/530X3wOguHSue3xzCfNu4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IybVzzIwx6//UauobQxMx1pAP0I8YOdk7SrPPVjna50koUHLEy3DC9R4b7xsGrREr
	 T0zWeka3luX7NOZs/tJ3Tb7FyS7l7kudhlBJsWmC41TUEbZ5gr3AtxKobYXyy64DjY
	 pvShF6ZKnbg26fAQnnlTJUuiSHGQNI2mVi/PJrAs=
Date: Wed, 12 Jun 2024 20:16:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Mirvish <matthew@mm12.xyz>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org
Subject: Re: Patch "bcache: fix variable length array abuse in btree_iter"
 has been added to the 5.15-stable tree
Message-ID: <2024061225-division-dexterous-0bae@gregkh>
References: <2024061210-crib-during-28fe@gregkh>
 <20240612160428.GA1953091@mm12.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612160428.GA1953091@mm12.xyz>

On Wed, Jun 12, 2024 at 12:04:28PM -0400, Matthew Mirvish wrote:
> On Wed, Jun 12, 2024 at 05:29:10PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     bcache: fix variable length array abuse in btree_iter
> > 
> > to the 5.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      bcache-fix-variable-length-array-abuse-in-btree_iter.patch
> > and it can be found in the queue-5.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> 
> Hi, I forgot to add a version tag on this -- it should only be in
> kernels >= v6.1, so please drop it from v5.10 & v5.15.

now dropped, thanks.

greg k-h

