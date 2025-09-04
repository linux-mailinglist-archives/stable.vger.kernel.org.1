Return-Path: <stable+bounces-177718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37693B43AE4
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 13:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0063A170D3F
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C52FCC01;
	Thu,  4 Sep 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1f5RK73z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926762F3C01
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987163; cv=none; b=n/BlJZf2lsL9/UazSW3UAbRwZ+QfvzE33DjEQ2pfrjUZYzHNaOmVldHAwX8/FZfgAZREadyfTTKBwGwtY7bZQF5+SR+4WCcMr293lxZ+z49mr3NL1Z2eJOIAfG+xzmoaqmIuhe67rfGScakeu1PepNWtF7SG+Gfv4CLJYhzpcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987163; c=relaxed/simple;
	bh=Ol3DyGOjldFtDMjiwEVJYrg79VBSQO43AsP9631t5gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPl+D2QlSkktefSb+pK0DjcVUogeBnLB+t4oMW+hEQZAT18LSZZ6elsQ37deHegKRDF+w1sbC1XNS7drHZ0vPM1M8NNn7FHdm6B7FjjYbdeQ4/g0k1NsKnOkBF7EnQFpkq1yDJ87klY8wH+9aHGVvSXXGiCnzMxsOHq2hHdBoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1f5RK73z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B575C4CEF0;
	Thu,  4 Sep 2025 11:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756987163;
	bh=Ol3DyGOjldFtDMjiwEVJYrg79VBSQO43AsP9631t5gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1f5RK73z+HpUCtR4au+tdJ6IFMk+oYW6pb3cOGJ91oWwUx5xkOBWDBB8ZlkoePCVH
	 gF9d/B88oqNcApXgyilVT8ZPouKeIGJa9UfxhVYUxRwN+Lxt/3HEhESy3rqnAPrWQF
	 ajwEekrkYNMTiiMQFPfORkpS6dDPyAuxkQC04DLI=
Date: Thu, 4 Sep 2025 13:59:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, bp@alien8.de
Subject: Re: [PATCH 5.15.y 2/2] KVM: SVM: Properly advertise TSA CPUID bits
 to guests
Message-ID: <2025090443-pull-anchovy-1b65@gregkh>
References: <20250827181524.2089159-1-boris.ostrovsky@oracle.com>
 <20250827181524.2089159-3-boris.ostrovsky@oracle.com>
 <2025090235-washroom-twine-5683@gregkh>
 <dddfe42e-31c1-4bf8-b15b-b7585b708a04@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dddfe42e-31c1-4bf8-b15b-b7585b708a04@oracle.com>

On Wed, Sep 03, 2025 at 12:44:00PM -0400, Boris Ostrovsky wrote:
> 
> 
> On 9/2/25 7:42 AM, Greg KH wrote:
> > On Wed, Aug 27, 2025 at 02:15:24PM -0400, Boris Ostrovsky wrote:
> > > Commit 31272abd5974b38ba312e9cf2ec2f09f9dd7dcba upstream.
> > > Commit f3f9deccfc68a6b7c8c1cc51e902edba23d309d4 LTS
> > 
> > How about you just backport both of these independently, as this change
> > now looks nothing like either of those commits :(
> 
> The trouble is that the first one was already backported by
> c334ae4a545a1b1ae8aff4e5eb741af2c7624cc7 and it missed a few things. Some,
> but not all, of these issues were corrected by the LTS patch (the second
> commit above).
> 
> I couldn't figure out how to separate this into two patches so I merged them
> into one.
> 
> I suppose I could provide an incomplete "fix" for
> c334ae4a545a1b1ae8aff4e5eb741af2c7624cc7 as a separate patch (but the code
> will still be broken) and then do the LTS backport.

Yes please.  When ever possible try to stick to what is upstream, and
that includes backporting partial patches if needed, as then they can
actually be tracked.

thanks,

greg k-h

