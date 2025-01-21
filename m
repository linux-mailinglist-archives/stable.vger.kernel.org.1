Return-Path: <stable+bounces-109614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D8A17EBC
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAB11881CF3
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E331E502;
	Tue, 21 Jan 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wzXwhvC8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF21196
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465561; cv=none; b=ZzF+yP6mFpgrG5jsivr5dvKd5JbZ4NT+KsklglLMQIgcxcmzJxLBmfbSWD+qbX44Gn+5rZKivkjsjnY2qJypLx7RPeJ93jI04vqyk8tQLDEApLRQXXJDD4IEvEq0CVTC/ud3+wk3b+zppHhsWRvPRXJwLpgZpxVzkVmTrS8L89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465561; c=relaxed/simple;
	bh=YIwPOWny6WnXxdk0Y5My9HWIyNHkZoh/KLQtIhP23Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK2KwTEyUmhG5ZbiHZF90Z5xLlez0zyWJS6ZH/wAnERgGjCm05JUMrNsQyPOV2YnsP7NBfD8W/WbWqIHHQKcSSPqihx40nIWKq4Bc9g1v0A8+tU4nDHRwBiv8cbVnzw9yAAKQqFOscS1V126yaD/w6USrVQ1PBwBoEImYJnUm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wzXwhvC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED2DC4CEDF;
	Tue, 21 Jan 2025 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737465560;
	bh=YIwPOWny6WnXxdk0Y5My9HWIyNHkZoh/KLQtIhP23Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wzXwhvC8oYlCkmXqcKKimFON/5qRYZkCSP4PJhoA/WSaAsF4yGuFGrLOE95Z65b0p
	 Hm9GYpdynivBZSdhAejkMfJMp0qnhmgTXtyP3GQNhbZ3/v/YkHNwkCX2xsciSy2nBe
	 O5McgfD4+7vuNiNZAs+AonCLO1U5dCHy+UNOJYV0=
Date: Tue, 21 Jan 2025 14:19:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, balbirs@nvidia.com, hannes@cmpxchg.org,
	hch@lst.de, mhocko@suse.com, muchun.song@linux.dev,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	stable@vger.kernel.org, urezki@gmail.com
Subject: Re: FAILED: patch "[PATCH] vmalloc: fix accounting with i915" failed
 to apply to 5.10-stable tree
Message-ID: <2025012101-mashing-unlinked-86c0@gregkh>
References: <2024122301-uncommon-enquirer-5f71@gregkh>
 <Z2nGG8WpNJB__fhR@casper.infradead.org>
 <Z3_y2-mV3eSWmqYQ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3_y2-mV3eSWmqYQ@casper.infradead.org>

On Thu, Jan 09, 2025 at 04:01:31PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 23, 2024 at 08:20:43PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 23, 2024 at 11:18:01AM +0100, gregkh@linuxfoundation.org wrote:
> > > 
> > > The patch below does not apply to the 5.10-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > 
> > The 5.15 patch also applies to the 5.10-stable tree.  Thanks,
> 
> Seems to have been missed?  The 5.15 patch made it into 5.15.176
> but the 5.10 patch isn't in 5.10.233 released the same day.
> 

Odd, don't know what happened there, sorry.  Now queued up for the next
5.10.y release.

thanks,

greg "drowning in backports" k-h

