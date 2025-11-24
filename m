Return-Path: <stable+bounces-196762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1DAC8170C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DC93AA300
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB19F314A87;
	Mon, 24 Nov 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhXr94fF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788CB2D59F7
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999780; cv=none; b=YvOneWOvXUviHa+AjGA0g26hOsKNSmEjwAwsVcn6Ch17u61RKrLrRV9q8tmq+ivYuAyJZXtqIgvp4NMBFmoc+v9x3NNMwTk26rGm0ByrvaWzUP1fUGVWr4+ovMOkdEX5dvZLqyN1+jVqvzzV0tQGemJt3k3psT+gHzGDCEbbyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999780; c=relaxed/simple;
	bh=hTnv90f/cN59jjS3vHljAHfvNkLmqsFolx7YZt41ypo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfYQK5P9qLxcf0iXXtGj7sFgxdMIwypEZ9fSaeUkeZAu71CfXhpcVryOjZI4aAfdsS3Nj3+rgtm7If99x3jXBtlGEXNnJ9j+oksqwsjSG60seR34Y6771uV7ixd3LLMkpeUnqz4pybEgqJlt1LGNOBiufsi03ro0gir3kn3PjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhXr94fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFA2C4CEF1;
	Mon, 24 Nov 2025 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763999780;
	bh=hTnv90f/cN59jjS3vHljAHfvNkLmqsFolx7YZt41ypo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhXr94fFKIvhAu9GvghotYfcnaAS34Vmv4Fii/1xNOzsx5Ff8mCaNAiF2/xAQWMHy
	 G+TlpRx8Mxv2zLkmMmhKPiUf7kS1m5sYYGmGbGsn4EHQxhoKi2/lNypTBr+UIY3VeJ
	 VnNg59zywhiaBkeED5pQJerUe4DFTxn5YL1FUjfU=
Date: Mon, 24 Nov 2025 16:56:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 6.6.y] KVM: arm64: Check the untrusted offset in FF-A
 memory share
Message-ID: <2025112450-dinghy-trousers-e398@gregkh>
References: <2025112429-pasture-geometry-591b@gregkh>
 <20251124141134.4098048-1-sashal@kernel.org>
 <2025112405-campus-flatworm-25a5@gregkh>
 <aSRy8LqAopE82ZPs@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSRy8LqAopE82ZPs@google.com>

On Mon, Nov 24, 2025 at 03:00:00PM +0000, Sebastian Ene wrote:
> On Mon, Nov 24, 2025 at 03:50:45PM +0100, Greg KH wrote:
> > On Mon, Nov 24, 2025 at 09:11:34AM -0500, Sasha Levin wrote:
> > > From: Sebastian Ene <sebastianene@google.com>
> > > 
> > > [ Upstream commit 103e17aac09cdd358133f9e00998b75d6c1f1518 ]
> > > 
> > > Verify the offset to prevent OOB access in the hypervisor
> > > FF-A buffer in case an untrusted large enough value
> > > [U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
> > > is set from the host kernel.
> > > 
> > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > Acked-by: Will Deacon <will@kernel.org>
> > > Link: https://patch.msgid.link/20251017075710.2605118-1-sebastianene@google.com
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > index 8d21ab904f1a9..eacf4ba1d88e9 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > @@ -425,7 +425,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> > >  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
> > >  	struct ffa_composite_mem_region *reg;
> > >  	struct ffa_mem_region *buf;
> > > -	u32 offset, nr_ranges;
> > > +	u32 offset, nr_ranges, checked_offset;
> > >  	int ret = 0;
> > >  
> > >  	if (addr_mbz || npages_mbz || fraglen > len ||
> > > @@ -460,7 +460,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> > >  		goto out_unlock;
> > >  	}
> > >  
> > > -	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
> > > +	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
> > > +		ret = FFA_RET_INVALID_PARAMETERS;
> > > +		goto out_unlock;
> > > +	}
> 
> hello Greg,
> 
> > 
> > I was told that a "straight" backport like this was not correct, so we
> > need a "better" one :(
> > 
> > Sebastian, can you provide the correct backport for 6.6.y please?
> > 
> 
> I think Sasha's patch is doing the right thing. Sasha thanks for
> posting it so fast.

Then why is the backport that is in the android 6.6.y kernel branches
different from this one?  Which one is "correct"?

thanks,

greg k-h

