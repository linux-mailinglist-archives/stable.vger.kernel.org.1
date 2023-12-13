Return-Path: <stable+bounces-6592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01C811126
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 13:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9F628199A
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223F1F5E6;
	Wed, 13 Dec 2023 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgUohgwo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F72660EB;
	Wed, 13 Dec 2023 12:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F4BC433C8;
	Wed, 13 Dec 2023 12:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702470769;
	bh=vrdMpHk3hes/pW7t5HwtgiIc6BqoYwfb1U2KPkDWxgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgUohgwoOyhk6M6Wd7/FpKATne5jZCu9xiDWyOmoagGffRNlTYcsChdGvykCND8fn
	 plnKDqWey43X6DVHTv14SZisx9rxXTuCin3kQVp/z4hCwvXL8JD+J0LsXGW1v+D+os
	 RM4xJw8uLWmUECtdtXKkVieONogprH1N/wmuAfmjAGlr21zer0fD2oRef0475J0XYK
	 MCmOrhKOuj7yg4Jni2BiO3dqo1I8epmsTZZRWM3OuVEgAPZK/A+/WuqYOKtiSr1P/j
	 igHPxaS0UybluJ8YmZ74QXb3bmx8hgE42BAe520dtWTgJeblq+gXeZ5f9+WBZquiqm
	 wkp7N1j6pOJ9w==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rDOPu-0004dw-0X;
	Wed, 13 Dec 2023 13:32:46 +0100
Date: Wed, 13 Dec 2023 13:32:46 +0100
From: Johan Hovold <johan@kernel.org>
To: Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <lkp@intel.com>,
	Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Message-ID: <ZXmkbgOqI4D3k7ds@hovoldconsulting.com>
References: <20231211132608.27861-3-johan+linaro@kernel.org>
 <ZXdGxI0OrIUKrbcS@be2c62907a9b>
 <ZXdJZ6yfK0NWz_zj@hovoldconsulting.com>
 <ZXgedtUhbKEwtSMr@yujie-X299>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXgedtUhbKEwtSMr@yujie-X299>

On Tue, Dec 12, 2023 at 04:48:54PM +0800, Yujie Liu wrote:
> On Mon, Dec 11, 2023 at 06:39:51PM +0100, Johan Hovold wrote:
> > On Tue, Dec 12, 2023 at 01:28:36AM +0800, kernel test robot wrote:
> > > Hi,
> > > 
> > > Thanks for your patch.
> > > 
> > > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > > 
> > > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> > > 
> > > Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> > > Subject: [PATCH 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
>                    ^
> 
> > > Link: https://lore.kernel.org/stable/20231211132608.27861-3-johan%2Blinaro%40kernel.org
> > 
> > Please fix your robot. This is a series of stable kernel backports so
> > the above warning makes no sense.
> 
> Sorry for this wrong report. We introduced b4 tool into the robot
> recently to help simplify patch processing, but seems that b4
> automatically removed the "stable-6.6" prefix in the patch subject when
> grabbing the mail thread, and triggered this wrong report. We've fixed
> this issue for the bot just now.

Perfect, thanks!

Johan

