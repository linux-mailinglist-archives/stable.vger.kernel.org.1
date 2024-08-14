Return-Path: <stable+bounces-67693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37466952195
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B533CB26483
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6884E1BD002;
	Wed, 14 Aug 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZdT/skdD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6E1B8EB4;
	Wed, 14 Aug 2024 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658116; cv=none; b=c0CFTfUNKsKh32DJLRDaKn8WcImS/lmpg0aIQO5kQIN2iBayGuWcpcWfrcw/ogKgzkIBm9V+NeDj4AgvrCD45A/tqR05tJGfyQ1kYBYPGnkAODSc3u1MQn1hkZ744s6ywskljiFgTITSthsCfVD2rseX83+g/YduC7s+nM+Ghkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658116; c=relaxed/simple;
	bh=4u34LfFjV5jM2GYYXrlW7ZaS3ZVv+MHfwtakKnz4rS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2wXSAtnRoWs2uIU+B0RfG0cnWcd9pYH/Uj0EZIMJNahmtjv+kgzX0vXgNUvGQZobISsADkaYY6hMTW1z1LddxeaCVoBEkvw0KT8kBXrXK2l/7kI8w8pa4M0VlBqPzMulYJpjh2QP13NU9+UEw9tWIeS27a9U6Vnq8PCD+uD318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZdT/skdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E046EC116B1;
	Wed, 14 Aug 2024 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723658115;
	bh=4u34LfFjV5jM2GYYXrlW7ZaS3ZVv+MHfwtakKnz4rS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdT/skdDW0Tc1I1r4xCJD8oCj0VwBij8xecbXBETAJoMvLk4d36l6dT0WEYPrJMaE
	 6RUZOa16lgMNUjik/HMwaXIWnB20JMsoSIVwKwSCn3+6//gkdREp/cebfyGeDYyHta
	 hsaZnxXKb646GTO+q6WQ09Ktum13s0vGMVajC2IA=
Date: Wed, 14 Aug 2024 19:55:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Vitaly Chikunov <vt@altlinux.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH for stable v2 0/2] ASoC: topology: Fix loading topology
 issue
Message-ID: <2024081442-thimble-widget-e370@gregkh>
References: <20240814154749.2723275-1-amadeuszx.slawinski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814154749.2723275-1-amadeuszx.slawinski@linux.intel.com>

On Wed, Aug 14, 2024 at 05:47:47PM +0200, Amadeusz Sławiński wrote:
> Commit 97ab304ecd95 ("ASoC: topology: Fix references to freed memory")
> is a problematic fix for issue in topology loading code, which was
> cherry-picked to stable. It was later corrected in
> 0298f51652be ("ASoC: topology: Fix route memory corruption"), however to
> apply cleanly e0e7bc2cbee9 ("ASoC: topology: Clean up route loading")
> also needs to be applied.
> 
> Link: https://lore.kernel.org/linux-sound/ZrwUCnrtKQ61LWFS@sashalap/T/#mbfd273adf86fe93b208721f1437d36e5d2a9aa19
> 
> Should be applied to stable 6.1, 6.6, 6.9.

6.9 is long end-of-life (as shown on the front page of kernel.org.)

Patches queued up to 6.1 and 6.6 now, thanks.

greg k-h

