Return-Path: <stable+bounces-200916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1CCB8FD7
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6E63078E86
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9C275112;
	Fri, 12 Dec 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQXY0nFH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3031A9F87;
	Fri, 12 Dec 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550768; cv=none; b=Lm+u+MsPgtHAuSJJKRJxT6qVuJzwDyVN4cYChnwSoX2wvllBuakoDX+rSY9tmQbl4WgGWfwh+ZUl3Q1aKARtHOhjKjFMHLvYwW0+6EI8lyPgs3OiDMgeP7q1G1ONBHJTKy7ZWpCKMoFbnE8HgBrzj+1F6eAXP5k8GgjAwploDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550768; c=relaxed/simple;
	bh=189Htd6XXodl8CyrTXDtYKVyhYZKDvKx9AdMlw9EutA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fR8qBv+LgI3wWc7k+jUVU44qOH8SGCpaG91FBWqW7Q3n9oR/jVKQ+1XYdTmu7g/A+8LvsInDL75HHSBv1jIp1WmlRGDImCTepk1ciuvdgAjtZwSgmLSK1fVy30ynsnODw9iZkxGR0cJqK0abfBL9F24ecMRCqoSur5BFzLm/NxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQXY0nFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E4CC4CEF1;
	Fri, 12 Dec 2025 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765550768;
	bh=189Htd6XXodl8CyrTXDtYKVyhYZKDvKx9AdMlw9EutA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQXY0nFH44CNy2MRqjJHAfB9Zfmt/Owp5CPC708M/g2WTD63oWRVLmTHTTmMQO3Cw
	 9AJwzrDIq0oZG+o56PYZQwEumhHsH1HOSHICZUF69vsFIBeEt2oPs+Gkg9pdyiV17Y
	 CUigxXCZwL2WQUs2JV7/xHxcEII6A+egbE0hTT6yAHdJbyGvMVXI7glJe2JSuf7KrD
	 ztbf76Qkk1p1/unIX8KXogrgM4RQxEFLDeeUqn/iRvLJO/RHuGcVA7qPoLQ2FvHtHL
	 Z+3nbp26G5Mx126UCb8NDX6C/8HRXucS7mz7+1/BJn3ICxhtv/FrpSqPeTebAH9ZFv
	 rqUQyg/l/Qvcw==
Date: Fri, 12 Dec 2025 14:46:03 +0000
From: Simon Horman <horms@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Ilya Krutskih <devsec@tpz.ru>, Andrew Lunn <andrew+netdev@lunn.ch>,
	oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: fealnx: fix possible 'card_idx' integer overflow
 in
Message-ID: <aTwqqxPgMWG9CqJL@horms.kernel.org>
References: <20251211173035.852756-1-devsec@tpz.ru>
 <202512121907.n3Bzh2zF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202512121907.n3Bzh2zF-lkp@intel.com>

On Fri, Dec 12, 2025 at 07:30:04PM +0800, kernel test robot wrote:
> Hi Ilya,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> [also build test WARNING on net/main linus/master v6.18 next-20251212]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ilya-Krutskih/net-fealnx-fix-possible-card_idx-integer-overflow-in/20251212-013335
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20251211173035.852756-1-devsec%40tpz.ru
> patch subject: [PATCH v2] net: fealnx: fix possible 'card_idx' integer overflow in
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251212/202512121907.n3Bzh2zF-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512121907.n3Bzh2zF-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512121907.n3Bzh2zF-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/net/ethernet/fealnx.c: In function 'fealnx_init_one':
> >> drivers/net/ethernet/fealnx.c:496:35: warning: '%d' directive writing between 1 and 11 bytes into a region of size 6 [-Wformat-overflow=]
>      496 |         sprintf(boardname, "fealnx%d", card_idx);
>          |                                   ^~
>    drivers/net/ethernet/fealnx.c:496:28: note: directive argument in the range [-2147483647, 2147483647]
>      496 |         sprintf(boardname, "fealnx%d", card_idx);
>          |                            ^~~~~~~~~~
>    drivers/net/ethernet/fealnx.c:496:9: note: 'sprintf' output between 8 and 18 bytes into a destination of size 12
>      496 |         sprintf(boardname, "fealnx%d", card_idx);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Although I think these new warnings are not strictly for problems
introduced by this patch. They do make me wonder
if it would be best to cap card_index MAX_UNITS and
return an error if that limit is exceeded.

