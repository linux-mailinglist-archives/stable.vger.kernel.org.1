Return-Path: <stable+bounces-29-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164747F5BB9
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 10:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C100B2818B6
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA221119;
	Thu, 23 Nov 2023 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEOul13w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457422303
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 09:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE9CC433C8;
	Thu, 23 Nov 2023 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700733265;
	bh=h4u+Z4PevK+HccYSFyk9MZh1m/3uRe4+K6fsxaTqZzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEOul13wUWM1V1seWURR8g8h66cbFpwNNVN7LH0fFQNPSjTpFQHZChPKKLDhOsuHU
	 XESZktq2bXQFoApB41k1Ru89s7tRN1HgK8OnRK3FOFkbzfDQznhseFn8iKEHeP5BQW
	 vsZiykJEYqpPwrZrIaKLPzRbAJvo3WxQwhHDqG9r5r9AhBDaB+BOyxnWDsVBsPOBdn
	 X67kHRdFPAFABq+Gr0110OtPcG0JLmWhv1MEJU+4rKs0zClbMBFzUyPese7y/h1pEw
	 QhY2rs283QA8Rc7KwrJPyVLMpfOpl8mlgnnOpR0J3SPGWjsfcIQXjDqZwasWklqHLl
	 4iSTpyCzbg55Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1r66Py-0005N4-1e;
	Thu, 23 Nov 2023 10:54:43 +0100
Date: Thu, 23 Nov 2023 10:54:42 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <ZV8hYid_Gc0hE4xg@hovoldconsulting.com>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
 <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
 <ZV4hMR8oGQBSbnMl@hovoldconsulting.com>
 <2023112225-crop-uncle-9097@gregkh>
 <ZV4xH0lBhlwWYtLO@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV4xH0lBhlwWYtLO@hovoldconsulting.com>

On Wed, Nov 22, 2023 at 05:49:35PM +0100, Johan Hovold wrote:
> On Wed, Nov 22, 2023 at 04:35:17PM +0000, Greg Kroah-Hartman wrote:
> > On Wed, Nov 22, 2023 at 04:41:37PM +0100, Johan Hovold wrote:
> 
> > > These fixes are now in 6.7-rc1 as
> > > 
> > > 	f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
> > 
> > This doesn't backport cleanly, can you provide a working backport?
> 
> Sure, I'll do that tomorrow.
>  
> > > 	805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")
> > 
> > Now queued up, thanks.
> 
> I don't think this one will build without the former so better to drop
> it from your queues and I'll send backports of both patches tomorrow.

I've just posted backports of these commits to 6.6.2 here:

	https://lore.kernel.org/lkml/20231123094749.20462-1-johan+linaro@kernel.org/

They should apply to 6.5.12 as well.

Turns out we had a conflict with commit 3efcb471f871 ("ASoC: soc-pcm.c:
Make sure DAI parameters cleared if the DAI becomes inactive") which was
just backported to 6.6.2 and 6.5.12.

Johan

