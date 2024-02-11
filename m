Return-Path: <stable+bounces-19436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572BC850A49
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EF81C219ED
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372CA5C5E8;
	Sun, 11 Feb 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7RZLCjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91415A780
	for <stable@vger.kernel.org>; Sun, 11 Feb 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707668778; cv=none; b=jEg63owaYBzQAbvbJx6O9/06VXWVN2pIFUsrrKmA0w5Rmu2/lOmnLyD8Uo1k61Gn/W9QaHjYqZ8JxD+t1efyLHljWjihLtZAuSlbO9AX4gou5h8CKaWCHg9FSof2HTJewq2Hz/7ry0dh8bBnRrDep8UWBK5fCr5PxBFaFpoGX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707668778; c=relaxed/simple;
	bh=t2ZpZ4qmtocNwdJFwOBHwO+pTY2MRHKRN/m65mzt6sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCGkaNLygRhuWyzVPvl0lY3mRlfvw/nvQ98nB5hi6eRflJPxQrNpxQwNaWGt3YOS3nFqXrfMpihjQGbPIg0KNnqd05h/jotvx4CrbFjQOXEsTfipsiHlkbnweaAOQCwGBsD7ZP7S3xS4mJUb1nfY+T5KP3Yqe6Nsba8BpN6Rk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7RZLCjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3C6C433C7;
	Sun, 11 Feb 2024 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707668777;
	bh=t2ZpZ4qmtocNwdJFwOBHwO+pTY2MRHKRN/m65mzt6sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7RZLCjXnjN1E/cIInVWj6qdaSmtVRvi1pxZTX4KouR+n107B38a/IzRcgq4l04gZ
	 1LnWubAw0+oXWiX8+a/kreJ86xZsQVpYyZf1oFhnDqfEja3b3gBJ2pksOCj2pT7DrS
	 ON8fMvMthKuSglLYeS6wz40dPNOaOYhcriZd1NdjTiRTQ5LeN7Pm7gNxHI/e30sZoq
	 fRUhn0ixscYY1IOtZUxne9r6+NKLLGZ5rP9UpZHszZaPleiZHmXbGqTeAx0MB8Up81
	 wE/MpoFRl4q+Espg4D7N8UEngIeJrUvXWHU7nv6b9Ow9zTMxj9GBL2TELmQceiE6Cs
	 qrGuGHmVl0YdQ==
Date: Sun, 11 Feb 2024 11:26:15 -0500
From: Sasha Levin <sashal@kernel.org>
To: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: stable@vger.kernel.org, Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 6.1.y] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Message-ID: <Zcj1JyNJww8njJFv@sashalap>
References: <20240207163240.433-1-shiraz.saleem@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240207163240.433-1-shiraz.saleem@intel.com>

On Wed, Feb 07, 2024 at 10:32:39AM -0600, Shiraz Saleem wrote:
>From: Mike Marciniszyn <mike.marciniszyn@intel.com>
>
>[ Upstream commit 0a5ec366de7e94192669ba08de6ed336607fd282 ]
>
>The SQ is shared for between kernel and used by storing the kernel page
>pointer and passing that to a kmap_atomic().
>
>This then requires that the alignment is PAGE_SIZE aligned.
>
>Fix by adding an iWarp specific alignment check.
>
>The patch needed to be reworked because the separate routines
>present upstream are not there in older irdma drivers.
>
>Fixes: e965ef0e7b2c ("RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp")

Is this fixes tag incorrect? there's no e965ef0e7b2c in 6.1.

-- 
Thanks,
Sasha

