Return-Path: <stable+bounces-136858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D9CA9EF99
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCEF3B90DC
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F359B71;
	Mon, 28 Apr 2025 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b7Nsg7x2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE2433CA
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840825; cv=none; b=hsXLxlUsipk3WhVZErtDL2V2wiPOZ8rLkv6Wf/fj8HazOim1I5ajdBy0gwLikSx/CYBnY2EhMn4udKQcVhOpVQGosLBsqFGsaNhys+h2Fj3WU6+430hr2XBt1OrlBZMTeGB1liBshNlNLktNOQmrMmejUxnZkEGWfny65FUCpJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840825; c=relaxed/simple;
	bh=YbWZBM4QhzyZ3LiMqs5/2TVe2v1ewLrpbi81QCbJ+Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbe8LOf6x9oPUZT/YEp64X7g2LUAb8eULdDVub/u2yZJrh4MIsw5k/83OPsFVqdIAOBR5Qgs3vqmx+bxVo7n2+aMqv4tkhyg4u0KeXNGwBS5VQISoTpsuzz0MnIuFqiWaAaohAF5q7n0kx/XZH70pcctyhNCc9T8BrS+S/AioG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b7Nsg7x2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9452C4CEE4;
	Mon, 28 Apr 2025 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745840824;
	bh=YbWZBM4QhzyZ3LiMqs5/2TVe2v1ewLrpbi81QCbJ+Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7Nsg7x23W0cLc7B+jP0trgxVMPurTnZEA6oPdKsQ0N6/wck4qlLkDC/X0cqMAneO
	 3mNEoiz0Hwuv991coWl66iYB/gh2oDRQNLudX0E8K8G+m6+PBc0u0NmgCPvUcGS30j
	 qqnvTGloLDFJSVb6mXmNi6zGUHFpETi9nrxKiORA=
Date: Mon, 28 Apr 2025 13:47:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Naveen N Rao <naveen@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	stable@vger.kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: Please apply commit d81cadbe1642 to 6.12 stable tree
Message-ID: <2025042856-slug-neurosis-8bfa@gregkh>
References: <j7wxayzatx6fwwavjhhvymg3wj5xpfy7xe7ewz3c2ij664w475@53i6qdqqgypy>
 <2025042207-bladder-preset-f0e8@gregkh>
 <ht7jaoxtqi2njlb3blzgztmqukjbadkpt4cy2qxzgnqc26nbj2@2ja6ubtzaiip>
 <aAe8fypVeKa4vLMr@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAe8fypVeKa4vLMr@google.com>

On Tue, Apr 22, 2025 at 08:57:51AM -0700, Sean Christopherson wrote:
> On Tue, Apr 22, 2025, Naveen N Rao wrote:
> > On Tue, Apr 22, 2025 at 09:40:22AM +0200, Greg KH wrote:
> > > On Mon, Apr 21, 2025 at 11:00:39PM +0530, Naveen N Rao wrote:
> > > > Please apply commit d81cadbe1642 ("KVM: SVM: Disable AVIC on SNP-enabled 
> > > > system without HvInUseWrAllowed feature") to the stable v6.12 tree. This 
> > > > patch prevents a kernel BUG by disabling AVIC on systems without 
> > > > suitable support for AVIC to work when SEV-SNP support is enabled in the 
> > > > host.
> > > 
> > > We need an ack from the KVM maintainers before we can take this.
> > 
> > Sure. Adding Sean and Paolo.
> 
> AIUI, there's no sane alternative, so:
> 
> Acked-by: Sean Christopherson <seanjc@google.com>

Now queued up, thanks.

greg k-h

