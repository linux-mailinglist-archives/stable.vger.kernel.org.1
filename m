Return-Path: <stable+bounces-194876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B712FC61903
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB34E6FA2
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66FF30DD30;
	Sun, 16 Nov 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phm0xnB4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5930CDB4
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313249; cv=none; b=PKCBHKbjda0+YMyZX9ummXyR+VrJC5wlxKCYPXGUZ7gGQA27NLqNmO52rpeKNgxpFoXeCQiSoUzW1MimXDLTHKuO5FKhsRoQ+Hl4ObM2m+Z3gvFtYDyASW/CBW56iwy8kv0F9JBUv40HvR5Iv1Y34CsLg8hXSwNjyBmfbHgh3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313249; c=relaxed/simple;
	bh=ckSkflevBvENHF/v+r6feGwZCRm+dQy+RCIDt9XRhx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWQykaz8PFTcZA3uq8maBy87wZkNETFSKT6RoqQFEGYE3vYBjMecz8PDrc7tz4G6zD31stxyONbJEy9J7oQUAeVLSAqB4cPxiZLkwYS7M22Y26jOAG7mrxmbUbPT/IHu+jZvxM35WipxNEpN59DFf8saR4dni3X63c6W6kSOTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phm0xnB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BB7C4CEFB;
	Sun, 16 Nov 2025 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763313249;
	bh=ckSkflevBvENHF/v+r6feGwZCRm+dQy+RCIDt9XRhx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phm0xnB4iU2KUGXTdbAgVHB97WCDz4ojz65gdSRzBN5MgedYp1eX/l2eerSEipQTi
	 xNOZ7lk7kedn6EPtPf8IMqYkLfQHjjilsninh7ab5TPjISxrZVeDyt5hgUx0gDjn6b
	 ONUztnrALYtrzSK0D7eERMqlqoeFo4wCyljyk8vuNSUp9nkin8nr52/2YW8U7F3PcO
	 K6Am0h8s5iatGdUwYFk2FS4AtE5JTHWi40TrkX1jsxPiVXw32+ovs2sOTNS+zpZ7h6
	 rCMy928iyO/FwBHVCXJuhtflMbP5FMOnPbJe8cvXU7tvxGfbHGhP9T0kmWWYE16HO7
	 LXOzyGb0tynrA==
Date: Sun, 16 Nov 2025 12:14:07 -0500
From: Sasha Levin <sashal@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
Message-ID: <aRoGX3KLr43L3HNf@laps>
References: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
 <20251116163915.3588641-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251116163915.3588641-1-sashal@kernel.org>

On Sun, Nov 16, 2025 at 11:39:15AM -0500, Sasha Levin wrote:
>Subject: nfsd: use __clamp in nfsd4_get_drc_mem()
>
>Thanks!

This was NOT queued up, sorry. My script did the wrong thing here :(

-- 
Thanks,
Sasha

