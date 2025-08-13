Return-Path: <stable+bounces-169317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D461DB24040
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 07:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB9A7B565E
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 05:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C52BEC33;
	Wed, 13 Aug 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UVQNBEl4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A928C87C;
	Wed, 13 Aug 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063299; cv=none; b=WLY0JuXFHZ5MIoK6vxXaiKICLHPCotWeg9EnHx22+c4jpOP8HuFUGaW+ImnZSK9yerFVHvlxXzVdMkpplC2ecZJtISBo359zdGBxb7/VBi9DlDy/AXPHf2xTn9dt9jQOiw7xHa8VhX5TO7P2B1P88yt9ryuqPVCsIuwi/iBNC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063299; c=relaxed/simple;
	bh=y2cn1F377n62GhXtZy13sRaL2HV14HmDYX5otP9AhZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0sRwq+xhpnDxRQEDOvtL0zJKJe71hp9ie2HWW+ug7y/j7sjDpyF2MsuNfXPriXyuEBqHvS2K++io4TsD6HGA/sUGVTA6LvlP9OCQjiEp9hawLDQF/tAytF+ZRtGj17oQHFL8sU4L2nZxJ0yOBJI1yDw7ICQ2Mr/qYKfp+/ia5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UVQNBEl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF0CC4CEEB;
	Wed, 13 Aug 2025 05:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755063299;
	bh=y2cn1F377n62GhXtZy13sRaL2HV14HmDYX5otP9AhZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVQNBEl4Mnahh/6yIBSJHL8GXVmvkVjvNEn6JoiqWownwKkR5H46Zh5/mlZsGh15Z
	 usdr427yGZpl577ep4e1H4VltQu32GO9fB2DhfhKGdMQkpBwugAbrMu8kElmHG/fBq
	 Ip6ZkOyTs21Iv8C4HbN+lg6jRK21Nd3bFgAhJ3eE=
Date: Wed, 13 Aug 2025 07:34:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sasha Levin <sashal@kernel.org>, intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 00/12] ice: split ice_virtchnl.c git-blame friendly way
Message-ID: <2025081319-carried-liberty-dc3e@gregkh>
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
 <20250812135714.0e1a7ee0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135714.0e1a7ee0@kernel.org>

On Tue, Aug 12, 2025 at 01:57:14PM -0700, Jakub Kicinski wrote:
> On Tue, 12 Aug 2025 15:28:58 +0200 Przemek Kitszel wrote:
> > Summary:
> > Split ice_virtchnl.c into two more files (+headers), in a way
> > that git-blame works better.
> > Then move virtchnl files into a new subdir.
> > No logic changes.
> > 
> > I have developed (or discovered ;)) how to split a file in a way that
> > both old and new are nice in terms of git-blame
> > There were no much disscussion on [RFC], so I would like to propose
> > to go forward with this approach.
> > 
> > There is more commits needed to have it nice, so it forms a git-log vs
> > git-blame tradeoff, but (after the brief moment that this is on the top)
> > we spend orders of magnitude more time looking at the blame output (and
> > commit messages linked from that) - so I find it much better to see
> > actual logic changes instead of "move xx to yy" stuff (typical for
> > "squashed/single-commit splits").
> > 
> > Cherry-picks/rebases work the same with this method as with simple
> > "squashed/single-commit" approach (literally all commits squashed into
> > one (to have better git-log, but shitty git-blame output).
> > 
> > Rationale for the split itself is, as usual, "file is big and we want to
> > extend it".
> > 
> > This series is available on my github (just rebased from any
> > earlier mentions):
> > https://github.com/pkitszel/linux/tree/virtchnl-split-Aug12
> > (the simple git-email view flattens this series, removing two
> > merges from the view).
> > 
> > 
> > [RFC]:
> > https://lore.kernel.org/netdev/5b94d14e-a0e7-47bd-82fc-c85171cbf26e@intel.com/T/#u
> > 
> > (I would really look at my fork via your preferred git interaction tool
> > instead of looking at the patches below).
> 
> UI tools aside I wish you didn't cut off the diffstat from the cover
> letter :/ It'd make it much easier to understand what you're splitting.
> 
> Greg, Sasha, I suspect stable will suffer the most from any file split /
> movement. Do you have any recommendation on what should be allowed?

We don't care, do whatever you need to for Linus's tree, and the
backports can work themselves out as needed.

thanks,

greg k-h

