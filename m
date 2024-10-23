Return-Path: <stable+bounces-87803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871BB9ABDB2
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 07:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D901C22ED5
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 05:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1915B83CDA;
	Wed, 23 Oct 2024 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aQyFWRld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4313A1BA
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660530; cv=none; b=oWZ87L8AmlgfURNyEd3XRTG9DPjeyQCZvZsKjZ0DJQl7ipDgrn9CMfC34IE0U6JxmCJ6ryUVR13d0PTHyG4zJoW0VawOJ8nh59d1CU7ypqTeiuSCYSV5tfDqpGfWKKFpMnRqtAHu53P8StzXO7mRiJIK39ouwkrQJGde7pC1YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660530; c=relaxed/simple;
	bh=8ZurN4cG8QPRPQP6hA8ugM7FE6Zp6kQEotgcfKQ5k6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOYgGQ6Fsfk1vhlhPrK3bqfbRFKO9oESNmCuw0qPNHtA8LoqMl+Uso3Wp5AaADzY630tu8dmWvQNc2WTIL76S7xsc4d/vV3NTJIN5vcItExmPdsYPJB6fKowlE7kwXLf1uuMZ9M1/5B6YiC/ItFSDxSy41kRnlSNZeJIZgBn0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aQyFWRld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9883C4CEC6;
	Wed, 23 Oct 2024 05:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729660530;
	bh=8ZurN4cG8QPRPQP6hA8ugM7FE6Zp6kQEotgcfKQ5k6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQyFWRldFu49eT0V2S16/3d4P3iB/gSWuPIdyvkwZKI5+CWisBmMqLBjYtzgVSiNv
	 qF+7iua5i0tXhIpKzC2g+GpyrvIlBr470aup1rHtF7CNfnKcOoNDMNEnHUAqMrB7rF
	 nFB/Yo7rlGP3GECTpE/3uyGJMZ7kG93+iJj80hhE=
Date: Wed, 23 Oct 2024 07:15:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: Request to include xe and i915 patches for 6.11.y
Message-ID: <2024102344-savanna-skimming-4ee3@gregkh>
References: <k5xojgkymtcgybwu5hbhvidgptxwhv4m4plbhdx26qzmlfryvn@mh4i7xvpx5gi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k5xojgkymtcgybwu5hbhvidgptxwhv4m4plbhdx26qzmlfryvn@mh4i7xvpx5gi>

On Tue, Oct 22, 2024 at 04:39:29PM -0500, Lucas De Marchi wrote:
> Hi,
> 
> I have tested 6.11.4 with these additional fixes for the xe and i915
> drivers:
> 
> 	f0ffa657e9f3913c7921cbd4d876343401f15f52
> 	4551d60299b5ddc2655b6b365a4b92634e14e04f
> 	ecabb5e6ce54711c28706fc794d77adb3ecd0605
> 	2009e808bc3e0df6d4d83e2271bc25ae63a4ac05
> 	e4ac526c440af8aa94d2bdfe6066339dd93b4db2
> 	ab0d6ef864c5fa820e894ee1a07f861e63851664
> 	7929ffce0f8b9c76cb5c2a67d1966beaed20ab61
> 	da9a73b7b25eab574cb9c984fcce0b5e240bdd2c
> 	014125c64d09e58e90dde49fbb57d802a13e2559
> 	4cce34b3835b6f7dc52ee2da95c96b6364bb72e5
> 	a8efd8ce280996fe29f2564f705e96e18da3fa62
> 	f15e5587448989a55cf8b4feaad0df72ca3aa6a0
> 	a9556637a23311dea96f27fa3c3e5bfba0b38ae4
> 	c7085d08c7e53d9aef0cdd4b20798356f6f5d469
> 	eb53e5b933b9ff315087305b3dc931af3067d19c
> 	3e307d6c28e7bc7d94b5699d0ed7fe07df6db094
> 	d34f4f058edf1235c103ca9c921dc54820d14d40
> 	31b42af516afa1e184d1a9f9dd4096c54044269a
> 	7fbad577c82c5dd6db7217855c26f51554e53d85
> 	b2013783c4458a1fe8b25c0b249d2e878bcf6999
> 	c55f79f317ab428ae6d005965bc07e37496f209f
> 	9fc97277eb2d17492de636b68cf7d2f5c4f15c1b
> 
> I have them applied locally and could submit that if preferred, but
> there were no conflicts (since it also brings some additional patches as
> required for fixes to apply), so it should be trivial.
> 
> All of these patches are already in upstream.  Some of them are brought
> as dependency. The ones mentioning "performance changes" are knobs to
> follow the hw spec and could be considered as fixes too.  These patches
> are also enabled downstream in Ubuntu 24.10 in order to allow the new
> Lunar Lake and Battlemage to work correctly. They have more patches not
> included here, but I may follow up with more depending on the acceptance
> of these patches.

As this is a long series, can you just send this as a patch series so
that we know the proper order of them, and it will get your
signed-off-by on as proof you tested these?

thanks,

greg k-h

