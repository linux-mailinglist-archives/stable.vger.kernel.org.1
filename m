Return-Path: <stable+bounces-134590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCD5A93784
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 14:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003459200F0
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FC276032;
	Fri, 18 Apr 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmP96ySQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E227602D;
	Fri, 18 Apr 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744981018; cv=none; b=TRYmZ+SAA6ZMfvHvDencLMnEqqryC8mz9Lb5RXpMQEUFD6jfrR6kxFAKwbw4efFGKxZvm+iJXQ4oOFM8m2M1CoBWPxkMAFCdKth4/dwCYNo7RyAv/tObJewNxavTSAyVt5q2RQXC2Bi9wkA1hcuM/MLprHJI2hlMy8KujlhQmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744981018; c=relaxed/simple;
	bh=rJChB9V8kau6yGgQn8mDRXf+tlUqdU/MDuvLU1+WJ5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knLWPB4WbEO4uboKmlf/NlHXxe0pPK+nF1SBNj1kZ4BlVLhWW2fJOClyR1AVRBcTfXD5ISPCCZPtlh9Jn8qtI1oDbbwOl2Er+o51XePrUcWSa8NNRxmzXbwdL1W02hbg9Nsa9L5vtZLyuw+kx4sBRp2etCApf0idoW0MWSrXdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmP96ySQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BEEC4CEE2;
	Fri, 18 Apr 2025 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744981018;
	bh=rJChB9V8kau6yGgQn8mDRXf+tlUqdU/MDuvLU1+WJ5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmP96ySQXqzjuw8sSi38kIIpfsrqhcbGFaE6g4b0vbtUP+3jPhBIGH6KO2YnMA69h
	 vXP11v665UVdwsQ0L0+OzZi9q+xXjeQY+04t6mymnppMBD//0PWFH/BLwKNfLU5JYA
	 apey9jTSKO/qI34UlJ5aFqf5w4S1Np28EB+Ga2HTpR1sPDepk+4SY6yTsUrK/2VBmE
	 dKqSNUQVN0aT5OWJfjKya1uJ5txQceS3eD2XmRa7WDFRtVhLHQCm9GIJ74qnRZEYt7
	 ZoGp7FuZtfmcr+gaQCu+IG5gGUVJCbJ/eo//GkjBi7RRaKDWzbBn4IAiT9ZT8Edsfd
	 J9FQqrS6vqdyQ==
Date: Fri, 18 Apr 2025 14:56:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Sandipan Das <sandipan.das@amd.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu/amd: Fix workaround for erratum 1054
Message-ID: <aAJMFjm82QgpNHAu@gmail.com>
References: <174495817953.31282.5641497960291856424.tip-bot2@tip-bot2>
 <20250418104013.GAaAIsDW2skB12L-nm@renoirsky.local>
 <aAJBgCjGpvyI43E3@gmail.com>
 <20250418123713.GCaAJHedTC_JWN__Td@fat_crate.local>
 <2025041819-harsh-outreach-dd6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025041819-harsh-outreach-dd6d@gregkh>


* Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Apr 18, 2025 at 02:37:13PM +0200, Borislav Petkov wrote:
> > On Fri, Apr 18, 2025 at 02:11:44PM +0200, Ingo Molnar wrote:
> > > No, it doesn't really 'need' a stable tag, it has a Fixes tag already, 
> > > which gets processed by the -stable team.
> 
> NOOOOOO!!!!

Noted!! :-)

> So please ALWAYS use cc: stable@ on patches you know you want to be 
> applied to stable trees.  Use the Fixes: tag to tell us how far back 
> to backport them.  That's it.  Use both.

Undertood!

Thanks,

	Ingo

