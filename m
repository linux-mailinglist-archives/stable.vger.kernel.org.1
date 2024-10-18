Return-Path: <stable+bounces-86791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E952B9A390E
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A162B22F12
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B018EFFB;
	Fri, 18 Oct 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iC3IdWCL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C418E76B
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241309; cv=none; b=f8Uo1ydrq253s/UyBvxpWz1+obn+I1nQmbnfIRJTKayUywmvoBTFCftyfUMNOSRDLb8ugtX+KS/3fBgaw42DFA4FaV0UoAYgvmX+WgtSQ8pvM5SfTh4BeQH22bREA6KAA1bA8KbFb/9t7wPqLEzBHUaN/09RdGJ+yqcVHoLgsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241309; c=relaxed/simple;
	bh=UlEqRQRIlloUct5IQsJ7hOsjyuK3sE/ul8hrb86Rg6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR8Sb/ZPo5cLpnkz8WI6X6due8O/FBCtJAcnPxujFjRKVRs6PaYmn1oR4O5At4fSGaqy0h/C3tx4kVStG/K3sp++D2MjUb3QyWYC13dc0FmHpLmbX8YbN6VOEWaRTTB2GTiZr4n9iBTUD3u2a0+YMYp3BC9I+wgEFq6xqaRMfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iC3IdWCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87221C4CEC7;
	Fri, 18 Oct 2024 08:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729241309;
	bh=UlEqRQRIlloUct5IQsJ7hOsjyuK3sE/ul8hrb86Rg6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iC3IdWCLy/tfC472bDL2mJG6HXBJ8SDUKgonFtpPXE9PmT179FSGtrbCON93GQs3X
	 Zyd0ebpPbKcpp+uMiKQg30Z2bMPFpODS8zEUhykC/Au0UxzldDUYHiGt7akfSMXUVC
	 0JZKrHqm0+dldZO2x63B1UHW650oY2UTwP0x62yk=
Date: Fri, 18 Oct 2024 10:48:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, jiri@nvidia.com,
	jacob.e.keller@intel.com, sashal@kernel.org, vkarri@nvidia.com,
	nogikh@google.com
Subject: Re: [PATCH stable 6.1 0/2] devlink: Fix RCU stall when unregistering
 a devlink instance
Message-ID: <2024101821-bankroll-edge-2205@gregkh>
References: <20241015113625.613416-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015113625.613416-1-idosch@nvidia.com>

On Tue, Oct 15, 2024 at 02:36:23PM +0300, Ido Schimmel wrote:
> Upstream commit c2368b19807a ("net: devlink: introduce "unregistering"
> mark and use it during devlinks iteration") in v6.0 introduced a race
> when unregistering a devlink instance that can result in RCU stalls and
> in the system completely locking up. Exact details and reproducer can be
> found here [1]. The bug was inadvertently fixed in v6.3 by upstream
> commit d77278196441 ("devlink: bump the instance index directly when
> iterating").
> 
> This patchset fixes the bug by backporting the second commit and a
> related dependency from v6.3 to v6.1.y while adjusting them to the
> devlink file structure in v6.1.y (net/devlink/{core.c,devl_internal.h}
> -> net/devlink/leftover.c).
> 
> Tested by running the devlink tests under
> tools/testing/selftests/drivers/net/netdevsim/ and the reproducer
> mentioned in [1].
> 
> [1] https://lore.kernel.org/stable/20241001112035.973187-1-idosch@nvidia.com/
> 
> Jakub Kicinski (2):
>   devlink: drop the filter argument from devlinks_xa_find_get
>   devlink: bump the instance index directly when iterating
> 
>  net/devlink/leftover.c | 40 ++++++++++------------------------------
>  1 file changed, 10 insertions(+), 30 deletions(-)
> 
> -- 
> 2.47.0
> 
> 

Both now queued up, thanks.

greg k-h

