Return-Path: <stable+bounces-197097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B217EC8E640
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 166DF3518BD
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41191459FA;
	Thu, 27 Nov 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kdTDgE0L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C42AD04
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249358; cv=none; b=mYQw6TzFhI07F0ohjLLaXa8Ms4+1QGVIWe/n4x0BkvFN9ZbV7U3C+d7iwOT76iATy9XUAr7CrB0zyC2orhqKt7nYDxP+l4jb7uHv7LMCbiOqxgcFCprXWnayfRVnU1Jbk/bGhC5gmQc1Dyz/73GEOp+TRW6DpD+jdkQmdRPmNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249358; c=relaxed/simple;
	bh=VsA1OEEK4o+0REPxnCk7O8+qtQdLOuYb3kiJZl6h4hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcrhSUBu0TEBWggF6Cii1pJ1l7LbDKKJ4xxmv2JAKJjzsUdhaDk9stmP6P/86Kx7G4rDphz/5KQACh2PGGJtE81a5h4VPSH55ZbhWYDkO3xC9PRXAgHDLXqFDQ7pifFNv3++aBn2H6pYvl13c1pFD5WKyyocV3KErqrW4WKS6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kdTDgE0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8DCC4CEFB;
	Thu, 27 Nov 2025 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764249358;
	bh=VsA1OEEK4o+0REPxnCk7O8+qtQdLOuYb3kiJZl6h4hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdTDgE0L3zOkagF70+/Ay0E2FuvgCWwuefOtTeTA1UeHlI8dqCKLn2XKju/wa7WSY
	 +ckXwg5iTFBCfunhMPbRhvhilSdOH1hNsPW8z7L1P+w3mAowch6CXRr0yOv+iPjGOj
	 QLl9ae1ZwMP4s+q+Nmh2MSlgAlKt2e4rweWQuPTo=
Date: Thu, 27 Nov 2025 14:15:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.17.y 1/4] kho: check if kho is finalized in
 __kho_preserve_order()
Message-ID: <2025112728-shelter-cultivate-ff09@gregkh>
References: <2025112149-ahoy-manliness-1554@gregkh>
 <20251122045222.2798582-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122045222.2798582-1-sashal@kernel.org>

On Fri, Nov 21, 2025 at 11:52:19PM -0500, Sasha Levin wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> [ Upstream commit 469661d0d3a55a7ba1e7cb847c26baf78cace086 ]

Still breaks the build :(

I've dropped this and the other kho patches from the queue again.

thanks,

greg k-h

