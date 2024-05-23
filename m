Return-Path: <stable+bounces-45655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F38CD161
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6640F1F2246C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1B71487D0;
	Thu, 23 May 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="afHhOJku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630AD13C8FF;
	Thu, 23 May 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464377; cv=none; b=IGFYMlQa9mb86VR1d/boQcocNhytiVG18OBDEJAMB6zLtOV6FX2fDeNhUyEJYNmwKKnJ9hnAhF7Mz8lEU4atzVoSF8jSJAFlgmF4IFHdeo+pzJxuVnlqwGR1Mm5cV0+vBYvlvbjovH7ZoxJY9bB8oCPNHSB5DMZhcyw29Gv7mBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464377; c=relaxed/simple;
	bh=w8jWi4je3moYWW+1PYvpd/udmlXfbZl7Sd4Y1C15ytQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k843cHp+vxm0Nm1PrUxCQ3EBLpU9GFL82rQ9pAjgIqMUAJiag8S0MW2lDxBGToxZoOb01GKOtBQt6YJpQn16NlyOTHhNQC+Mrk3QnQb5OkQ1Im5ARZFlqFt3ppM2GHpMgIUgD7HIIKQKi1Arx+v3kHeM4GIhy4h6gpcQBdG8f08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=afHhOJku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC9AC2BD10;
	Thu, 23 May 2024 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716464376;
	bh=w8jWi4je3moYWW+1PYvpd/udmlXfbZl7Sd4Y1C15ytQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afHhOJkuYLsVxCYBTtHV3QORq9M6VymtysX0aI3oGjhH+DDXgI3uNQwJbJDUs0j0i
	 kXOOju9Ebt3TnPwFu7HQ1ekanI44kUifR+NxJbCLh4o1tl5ecLcRMG/HadQXe4eV2r
	 wY4rxjpAYPuFUH2bMlFFhuWJ0OPL1Pnz8VORbEGE=
Date: Thu, 23 May 2024 13:39:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
	edumazet@google.com, kuniyu@amazon.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH stable,5.15 0/2] Revert the patchset for fix
 CVE-2024-26865
Message-ID: <2024052305-almanac-reseal-9f91@gregkh>
References: <20240506030554.3168143-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506030554.3168143-1-shaozhengchao@huawei.com>

On Mon, May 06, 2024 at 11:05:52AM +0800, Zhengchao Shao wrote:
> There's no "pernet" variable in the struct hashinfo. The "pernet" variable
> is introduced from v6.1-rc1. Revert pre-patch and post-patch.

But right now, there is no "pernet" variable in the tree.

I'm confused, what are you trying to do here by reverting these two
commits?  Why are reverts required?

greg k-h

