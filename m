Return-Path: <stable+bounces-104445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621059F4556
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCC7188B638
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495D1D358B;
	Tue, 17 Dec 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="haAzuF/Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288D1C9B7A
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421304; cv=none; b=UZdAF5IsBbD3horYii1ki3h9PNTkUpjkhMh4k8FVv80ix7Pzs0akpG3YvYMbIwIuzIZOCCfRKgBZuuuRn+PTF9fVn8CQvUDadRKtTv3ECXzl91oE3mNcthqy7PJAGwKSF07ARm9qbo0uvAGfZJKHkVpQ+JC2446XH9J+J8yfFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421304; c=relaxed/simple;
	bh=6sPzz6CNmaRYkRb/wW0Y5wnN8Cev39lhOakD3qauWkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPL5WXK0NuL6je6fgrRqQtgA1NfKO8sW/UwD6nz+WZkRrUUgKAUR25HIWqbi5MJ4qSFMytH1+g/MXdpYp7L5JLQUClkw2X9BhHWjHRrGYcj46tyaapw+piwFhDfTESGHbPU1+9slBYiYG1s7QsEV+tzhS6gm7fkKegKeCMSjAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=haAzuF/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A4EC4CED3;
	Tue, 17 Dec 2024 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734421303;
	bh=6sPzz6CNmaRYkRb/wW0Y5wnN8Cev39lhOakD3qauWkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haAzuF/Z8ziCLcqebKjJ5qChvOktMVwcdUJUEzLECHKiTO+2oINoFFvTvBQISGMin
	 9k9tVg6gN7HudtPxonhkQqXsbXL0/E5SdmjsMpDPDMK3AbpXHvex/HBJUQbJD9HqhN
	 MwfOr/ecnDjebpmEYiNzpQYSOh+Bv8fLSSbtOfXo=
Date: Tue, 17 Dec 2024 08:41:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH stable 6.6 v2 2/2] selftests/bpf: remove use of __xlated()
Message-ID: <2024121700-mystified-hush-72d8@gregkh>
References: <20241217072821.43545-1-shung-hsi.yu@suse.com>
 <20241217072821.43545-3-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217072821.43545-3-shung-hsi.yu@suse.com>

On Tue, Dec 17, 2024 at 03:28:19PM +0800, Shung-Hsi Yu wrote:
> [ Downstream commit for stable/linux-6.6.y ]

What does this mean?

> Commit 68ec5395bc24, backport of mainline commit a41b3828ec05 ("selftests/bpf:
> Verify that sync_linked_regs preserves subreg_def") uses the __xlated() that
> wasn't in the v6.6 code-base, and causes BPF selftests to fail compilation.
> 
> Remove the use of the __xlated() macro in
> tools/testing/selftests/bpf/progs/verifier_scalar_ids.c to fix compilation
> failure. Without the __xlated() checks the coverage is reduced, however the
> test case still functions just fine.
> 
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---

So this is just a fixup of a commit in a stable tree?  Can you properly
set the Fixes: tag then?

thanks,

greg k-h

