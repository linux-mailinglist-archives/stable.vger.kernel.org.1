Return-Path: <stable+bounces-40759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5E8AF79F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AF01C22759
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B32E1411F4;
	Tue, 23 Apr 2024 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bx0ePmvD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9813D532
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901952; cv=none; b=XjaeJElHkUpuKtxpf5A2TqEd+5Xev4TIgThEZJ8TLuguVf+pr6FMBiSvO7f8LwVv7K8IUby6G65xJraArGQCbqAmBPi3Wz4RKeyc8SHtgnWzZFNCvisCsp5q4Kxh14KrMa34lE+Acx8NPquBFB9nYbL00QAPY2qNm1wRq1EvDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901952; c=relaxed/simple;
	bh=F4yewMbmNOY0/vkYcGelIstavnimYWAwUXUAfOThS5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1dYOHBwCaQvpL+pDYxnFe+GoNJw+XZi0kTdLlPUvzU8T18Lq4n0QdXvT8236g44Sh4zvk7v6WqcNithQJxJFBIyVKR10p6C28J4DaCsWFCtV+WWau+hx6FyTSkuMfQWnY7AW1HVKdnVL8UQyZCy60WMFMrnib2GVP0EL0KFbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bx0ePmvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2A4C116B1;
	Tue, 23 Apr 2024 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713901951;
	bh=F4yewMbmNOY0/vkYcGelIstavnimYWAwUXUAfOThS5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bx0ePmvDM/EiViFDl1Xcfuilno1Jjq4zEiOvh/m9YBEAzLwUQ9tViGNx4RBe8vQgw
	 J4ke2j+sMWRYdmT6k1eCCpdR5FExvtRb0gnQskMSoDT5ylW79PFadWu6rkXnE/sWqX
	 x7EzjH91fm2/84F3MQD+u/6R4XrL8rBe++n4iEs0=
Date: Tue, 23 Apr 2024 12:52:22 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Reset thunderbolt topologies at bootup
Message-ID: <2024042312-stipulate-daunting-4b6e@gregkh>
References: <a06d9047-114f-4e63-b3b4-efcd83ca6d1e@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06d9047-114f-4e63-b3b4-efcd83ca6d1e@amd.com>

On Tue, Apr 23, 2024 at 01:54:27PM -0500, Mario Limonciello wrote:
> Hi,
> 
> We've got a collection of bug reports about how if a Thunderbolt device is
> connected at bootup it doesn't behave the same as if it were hotplugged by
> the user after bootup.  Issues range from non-functional devices or display
> devices working at lower performance.
> 
> All of the issues stem from a pre-OS firmware initializing the USB4
> controller and the OS re-using those tunnels.  This has been fixed in
> 6.9-rc1 by resetting the controller to a fresh state and discarding whatever
> firmware has done.  I'd like to bring it back to 6.6.y LTS and 6.8.y stable.
> 
> 01da6b99d49f6 thunderbolt: Introduce tb_port_reset()
> b35c1d7b11da8 thunderbolt: Introduce tb_path_deactivate_hop()
> ec8162b3f0683 thunderbolt: Make tb_switch_reset() support Thunderbolt 2, 3
> and USB4 routers
> 9a54c5f3dbde thunderbolt: Reset topology created by the boot firmware

All now queued up, thanks.

greg k-h

