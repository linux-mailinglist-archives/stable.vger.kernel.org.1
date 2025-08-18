Return-Path: <stable+bounces-171647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D534B2B1CD
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703DE5E4B6B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B323A274649;
	Mon, 18 Aug 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elVAXFpI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E942273D6D;
	Mon, 18 Aug 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545932; cv=none; b=Xyc/PuQ6Qurm36Xcb4oza58RUaC6GRlBwQWafttxCuLWIIBo0vSmpA9kJhPdOU5urtK2xWKCql6zh0ZqEYo8t3R2l6V3Lfw6NEVLWEoGI5ist9sHkg12472aQG8pH0t/ZuBioIQXS5709J13S4BFxHdo7c4DY8aPBoTp3oaqZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545932; c=relaxed/simple;
	bh=VkrdvVd5SEXtLNxlHzDFLtCsAV8AnNDaqUpaJZ60WSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moSFyMU+u5KF9kv/SGf9GDd/CGgXl6lE/2ZVLX50uOxZWbfsbtno1nOmlUtwAh8n5O5fgrcwOpjNqdQcyS9vb9g6BWcxrUgzVKRJQMmOBz2T1Kh4mfmO5CvfabG4CyY2vBVfcyebgPBzbnhOoHF4oByV7xlnpNOPNGFRkRIyXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elVAXFpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4719C4CEED;
	Mon, 18 Aug 2025 19:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755545931;
	bh=VkrdvVd5SEXtLNxlHzDFLtCsAV8AnNDaqUpaJZ60WSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elVAXFpIRcifcL1F2/hmBDTQJ6fhrtmkcCHFaqwVx2qrap9TcXEw36jXWkzl3PcO4
	 qmFQ1Ha9zJToVhsw4TH7GzB7MbNgiP0z9CpZ674yoNNvx/R33Bkf9QhZ459iBjzxxD
	 apBJoA11dnf9PKTsQaAC7IFHZUNcUwbJvVqm62DQubRSKd1U9uRZebN2g11ETnBGJC
	 8bPkk/oeJvWqcULZym1G2UXe6SRt4YrdRGnZZQjMM+ln8PkfYOmf+obrzX6NtXyuGC
	 v2wB+EszDHEoKUCT509NrF/woTI7ViQuI0rJjVrDKFqBIKOzdtUJlHzZYZJphZ5Rts
	 /lcTXZOG2+mDQ==
Date: Mon, 18 Aug 2025 19:38:49 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, David Lebrun <dlebrun@google.com>,
	stable@vger.kernel.org, stefano.salsano@uniroma2.it,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Subject: Re: [PATCH net-next 1/3] ipv6: sr: Fix MAC comparison to be
 constant-time
Message-ID: <20250818193849.GB12939@google.com>
References: <20250816031136.482400-1-ebiggers@kernel.org>
 <20250816031136.482400-2-ebiggers@kernel.org>
 <20250818211607.c8eb87fbac2f81774022b54b@uniroma2.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818211607.c8eb87fbac2f81774022b54b@uniroma2.it>

On Mon, Aug 18, 2025 at 09:16:07PM +0200, Andrea Mayer wrote:
> On Fri, 15 Aug 2025 20:11:34 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > To prevent timing attacks, MACs need to be compared in constant time.
> > Use the appropriate helper function for this.
> > 
> > Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >  net/ipv6/seg6_hmac.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> 
> Hi Eric,
> 
> Thanks for the fix!
> 
> I believe it would be best to submit this fix separately from the current patch
> set. Since this addresses a bug rather than an enhancement or cleanup, sending
> it individually with the 'net' tag will help facilitate applying this patch to
> the net tree.
> 
> Ciao,
> Andrea

Then there would be a merge conflict between the two patchsets.

I can do that if you want, but then I'd probably have to wait for this
patch to reach net-next before the rest can proceed.

- Eric

