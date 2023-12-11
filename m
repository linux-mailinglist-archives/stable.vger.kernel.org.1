Return-Path: <stable+bounces-5353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E180CB00
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEEA281DC2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A8D3E494;
	Mon, 11 Dec 2023 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW0Kee/Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304F3D964;
	Mon, 11 Dec 2023 13:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D2CC433C7;
	Mon, 11 Dec 2023 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301327;
	bh=0CpLD8dRzQ8OFlBx0wOWEw/1qMni4oZG0S8sbx9hVhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dW0Kee/ZC/h61mXDknAqmvMfOFO0E1U9zx6VF2/UZ9beG6QCr1xu6V0qN73VNbPXx
	 Q+PiKV7Tnabq9/0lDvLtQb7M0kTOW4LKuJtUej29Bw5YRkfw2vnhjg7vEtq6NsLIjD
	 6ipgtF1qCFuxc1ZzywO7uPqpiOwpB5+tkmRVxnnyQulDrtSpW4uRiOUMg/b6+QiSS7
	 bERbLXwUi8b/CjBdwKdzIIgX0+ijf30d2OQ+aUpUhhL1v1lz6IO52hcVdQCFOE39GX
	 dz7BIjQjdDzQ4fXnL/j8SDiuvtMmZZh1AmCdyiTvPZrzTQrsvd5M6KDQnmaAJVdig0
	 S8Kyaih/VTytA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rCgLm-0007HX-1E;
	Mon, 11 Dec 2023 14:29:34 +0100
Date: Mon, 11 Dec 2023 14:29:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
	srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 0/2] ASoC: qcom: Limit Digital gains on speaker
Message-ID: <ZXcOvl1tUWmwGalB@hovoldconsulting.com>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
 <ZXbDY1iA_DQLIzqq@hovoldconsulting.com>
 <2023121146-hunger-crane-7dee@gregkh>
 <2023121113-walrus-outmost-ec34@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121113-walrus-outmost-ec34@gregkh>

On Mon, Dec 11, 2023 at 01:54:39PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 11, 2023 at 01:40:52PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Dec 11, 2023 at 09:08:03AM +0100, Johan Hovold wrote:
> > > On Mon, Dec 04, 2023 at 12:47:34PM +0000, srinivas.kandagatla@linaro.org wrote:

> > > These were unfortunately not marked for stable, but could you pick them
> > > up for 6.6?
> > > 
> > > The upstream commits are:
> > > 
> > > 	fb9ad2448508 ("ASoC: ops: add correct range check for limiting volume")
> > > 	716d4e5373e9 ("ASoC: qcom: sc8280xp: Limit speaker digital volumes")
> > 
> > Now queued up, thanks.
> 
> Oops, no, this breaks the build on 6.6.y, can you send a series that is
> at least built for this series successfully?  :)

Sorry about that. I was not aware of the asoc interface rename that went
into 6.7.

Just sent a backport of the series here:

	https://lore.kernel.org/r/20231211132608.27861-1-johan+linaro@kernel.org

Johan

