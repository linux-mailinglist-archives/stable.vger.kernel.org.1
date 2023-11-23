Return-Path: <stable+bounces-36-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EAF7F5E4B
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059361C20C86
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F322377E;
	Thu, 23 Nov 2023 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bow/JHz0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735F23774;
	Thu, 23 Nov 2023 11:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB92C433C9;
	Thu, 23 Nov 2023 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700740413;
	bh=g/xxUt9OQ1Xbt4EL/8qo6tjBYgOoMtRu6Y2H3RCsEtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bow/JHz0AWyZQMydFd3kvcnBkHRjgkGZmB89CI+9BMAQ7FiznLXuK3FVrW+afu6qp
	 meyTRqjCcJnPJAzv2dIfgszGWP26395waSd7wh/7tlM+/iNu15erqqzng5G/bvce7i
	 Tuz7gARZBIoL97n0F9TqdDHPZ9pq2K8Nn3bfCLu0=
Date: Thu, 23 Nov 2023 11:53:20 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-sound@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable-6.6 0/2] ASoC: codecs: wsa883x: fix pops and clicks
Message-ID: <2023112313-handlebar-handwash-b263@gregkh>
References: <20231123094749.20462-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123094749.20462-1-johan+linaro@kernel.org>

On Thu, Nov 23, 2023 at 10:47:47AM +0100, Johan Hovold wrote:
> This is a backport of commits
> 
> 	0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
> 	805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")
> 
> which specifically fix a loud crackling noise when starting a stream on
> the Lenovo ThinkPad X13s.
> 
> These backports should apply to any stable tree which already has commit
> 3efcb471f871 ("ASoC: soc-pcm.c: Make sure DAI parameters cleared if the
> DAI becomes inactive") backported (e.g. 6.6.2 and 6.5.12).
> 
> Note that the interaction of these commits resulted in a bad merge in
> mainline which is fixed up here:
> 
> 	https://lore.kernel.org/lkml/20231123091815.21933-1-johan+linaro@kernel.org/

Thanks, now queued up.

greg k-h

