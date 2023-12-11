Return-Path: <stable+bounces-5355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A25480CB43
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594E71C20F1E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952A3FE2E;
	Mon, 11 Dec 2023 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EWISpyq8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3611F60B;
	Mon, 11 Dec 2023 13:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE03EC433C9;
	Mon, 11 Dec 2023 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702302061;
	bh=nxM3m0fd/Qts426VUxaIvUcMjAL8BjhTWiFbn8gjtHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWISpyq8wNowbv0aYVcvdj3yFg7Rf4k6p1s8hhxK6NY7eiVikxtLg/N67DRry/c6+
	 xCDto1x/dyxRE0i4mxYN1Kyh9Y2z8AtYz4/CsyfjqJ2ltyisaobLefFGXmNNWm7j3/
	 U4r3banV4ANXrkdOJVgt7wqtT/0L9dgO0G01A4n0=
Date: Mon, 11 Dec 2023 14:40:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH stable-6.6 0/2] ASoC: qcom: sc8280xp: Limit speaker
 digital volumes
Message-ID: <2023121154-mule-utter-98cf@gregkh>
References: <20231211132608.27861-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211132608.27861-1-johan+linaro@kernel.org>

On Mon, Dec 11, 2023 at 02:26:06PM +0100, Johan Hovold wrote:
> This is a backport of the following series:
> 
> 	https://lore.kernel.org/lkml/20231204124736.132185-1-srinivas.kandagatla@linaro.org/
> 
> which did not build on 6.6 due a rename of the asoc_rtd_to_cpu()
> interface.
> 
> Johan
> 
> 
> Srinivas Kandagatla (2):
>   ASoC: ops: add correct range check for limiting volume
>   ASoC: qcom: sc8280xp: Limit speaker digital volumes
> 
>  sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
>  sound/soc/soc-ops.c       |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> -- 
> 2.41.0
> 
> 

Now queued up, thanks.

greg k-h

