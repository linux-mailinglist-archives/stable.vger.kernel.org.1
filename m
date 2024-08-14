Return-Path: <stable+bounces-67663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786B951CCA
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 16:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F37B28FAC
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D301B4C3E;
	Wed, 14 Aug 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m6L2VgKO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9181B29BD;
	Wed, 14 Aug 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644750; cv=none; b=CSem6O94eMKdKtFCJYz0ZKGQMfP3dtKM0+YhFUrh1qaT0Vd568iLkbl++iPc/vSONWcpQgB5XJDmows5sFyEtuxGC2JNaSimI2yzkj4ShEtGLLLTtUu+4ZnPFsYEyNcbLK+EEHoCjol6WLS7mYbg+7z/T3pLY8OaAWIkcZ6L0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644750; c=relaxed/simple;
	bh=exciCKj3zj6IEoFE38Mdny7KhQyHA+dZmV1pYaT+t8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyVjZ3+3n0POiCjBTiYXHaUtmEfmlJqEhn+aH6vnJqIJdhQINWopaBbc6onkm0AXilJpTa3VwQzUlixjENPMaPW+XOQSc6da1+Pg6kMBJXdfVy28tGW8Zar2MsEZz5xCrZQnYWb7rPM5ROSDMG4Q2h2DjsPNfJzbkXCYcZ1nhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m6L2VgKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A300C32786;
	Wed, 14 Aug 2024 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723644749;
	bh=exciCKj3zj6IEoFE38Mdny7KhQyHA+dZmV1pYaT+t8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6L2VgKOiHuJFXYsJbveBB+bqnmh0Cm2YMpa6VZIWMS+UPyE+GTI7SPd6jYPJd6Fb
	 PLnxUQhFUYJ8Ksm8UuBnbl/UD0+Q6xH7PjoSYwW+insBH+qlk7OCDIxBUG12fID+cy
	 tzNKdixepjkle6vPnCmQDHp1YIEYom2qdGFqDRuI=
Date: Wed, 14 Aug 2024 16:12:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Vitaly Chikunov <vt@altlinux.org>, Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH for stable 1/2] ASoC: topology: Clean up route loading
Message-ID: <2024081404-plow-residual-202b@gregkh>
References: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>
 <20240814140657.2369433-2-amadeuszx.slawinski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814140657.2369433-2-amadeuszx.slawinski@linux.intel.com>

On Wed, Aug 14, 2024 at 04:06:56PM +0200, Amadeusz Sławiński wrote:
> Instead of using very long macro name, assign it to shorter variable
> and use it instead. While doing that, we can reduce multiple if checks
> using this define to one.
> 
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> Link: https://lore.kernel.org/r/20240603102818.36165-5-amadeuszx.slawinski@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/soc-topology.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 

What is the git commit id of this change in Linus's tree?  Same for
patch 2/2

