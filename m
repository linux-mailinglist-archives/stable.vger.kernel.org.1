Return-Path: <stable+bounces-5344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401ED80CA4C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9991F21412
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D963C06F;
	Mon, 11 Dec 2023 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kpMhgjgC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC703B7BB;
	Mon, 11 Dec 2023 12:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7945C433C7;
	Mon, 11 Dec 2023 12:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702299282;
	bh=cVLs2m4zNhGQgeKr8K/RAa56lm+O9Ctlu9DiFQF2P+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpMhgjgCsfcyP66OWTsFQHGzxgOSHf/0bt8DOOATJWGkcto3lQNuqer7dxeSKwjlH
	 l69g+MuHMrfFZnZfHRO9Ha7ppkkQcbKkUXcadXZOlE/AQriOyeajsj8MfujQgsM8yu
	 zquUaW54pC3VwXfFxdOqT1gHruYqJcxXHqYFZBhU=
Date: Mon, 11 Dec 2023 13:54:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
	srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 0/2] ASoC: qcom: Limit Digital gains on speaker
Message-ID: <2023121113-walrus-outmost-ec34@gregkh>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
 <ZXbDY1iA_DQLIzqq@hovoldconsulting.com>
 <2023121146-hunger-crane-7dee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121146-hunger-crane-7dee@gregkh>

On Mon, Dec 11, 2023 at 01:40:52PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 11, 2023 at 09:08:03AM +0100, Johan Hovold wrote:
> > Hi Greg and Sasha,
> > 
> > On Mon, Dec 04, 2023 at 12:47:34PM +0000, srinivas.kandagatla@linaro.org wrote:
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > Limit the speaker digital gains to 0dB so that the users will not damage them.
> > > Currently there is a limit in UCM, but this does not stop the user form
> > > changing the digital gains from command line. So limit this in driver
> > > which makes the speakers more safer without active speaker protection in
> > > place.
> > > 
> > > Apart from this there is also a range check fix in snd_soc_limit_volume
> > > to allow setting this limit correctly.
> > > 
> > > Tested on Lenovo X13s.
> > > 
> > > Srinivas Kandagatla (2):
> > >   ASoC: ops: add correct range check for limiting volume
> > >   ASoC: qcom: sc8280xp: Limit speaker digital volumes
> > 
> > These were unfortunately not marked for stable, but could you pick them
> > up for 6.6?
> > 
> > The upstream commits are:
> > 
> > 	fb9ad2448508 ("ASoC: ops: add correct range check for limiting volume")
> > 	716d4e5373e9 ("ASoC: qcom: sc8280xp: Limit speaker digital volumes")
> 
> Now queued up, thanks.

Oops, no, this breaks the build on 6.6.y, can you send a series that is
at least built for this series successfully?  :)

thanks,

greg k-h

