Return-Path: <stable+bounces-50236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7B905245
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B56CB21084
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6D16F0EE;
	Wed, 12 Jun 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tE9yPr0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEE374D3
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194853; cv=none; b=T8neDRgq4NoE/9Q2ZWCvWgPVtTL+mUyamQiu3IBhbXF2CTc5Q+9EF+gWu7mDaYmmtCFqaDpLWyU3Xx4DSkUXT1zv+ZsQgUJBbA3NufT+HDZI8qwqpKF85NtuGD/clYEyLmTZhvmZdJWLK2XMR84TYKdQyNjPugki7oL1jEXwSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194853; c=relaxed/simple;
	bh=a3JUZYV5zmCDSIqjgCUNNbet4pMx4OT/QPCCrg7A4ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnIBQrmnCx24/t/nyGAV0jMZCklpEHlQ9bxbl0mNxaQFB3xVxHOx7zVokjyFIzzUw52tl18AFhHivaNfQtHYB9/gQdjvIpmV2GCszByoX1+O2/EO6BlMAEgH5gg02IwJFUIOvqomWkOgKYreZVB4/XgJTQwIlakhpyKEMXx/jtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tE9yPr0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC1C3277B;
	Wed, 12 Jun 2024 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718194852;
	bh=a3JUZYV5zmCDSIqjgCUNNbet4pMx4OT/QPCCrg7A4ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tE9yPr0KocbzwSZXmTbixO+igJO5hl9PU/O5d1Mc4UIEz+QefBXCa4JrM2i7EAY+H
	 8apyv1h/U8YgOQimioVc92kwflfeq6Kpf2zk/lPrAnJnoD4Dfo8dAjthZhfcvQ8izJ
	 yn2nKyVH1CvpKeU++vGRuQxi5Qr2gkA56iD/+FTA=
Date: Wed, 12 Jun 2024 14:20:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Gui =?utf-8?B?KOahguaelyk=?= <Lin.Gui@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>,
	Qilin Tan =?utf-8?B?KOiwrem6kum6nyk=?= <Qilin.Tan@mediatek.com>,
	Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
	Mengqi Zhang =?utf-8?B?KOW8oOaipueQpik=?= <Mengqi.Zhang@mediatek.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbng==?=
 =?utf-8?B?5aSNOiDlm57lpI06IOWbnuWkjTogYmFja3BvcnQg?= =?utf-8?Q?a?= patch for
 Linux kernel-5.15 kernel-6.1 kenrel-6.6 stable tree
Message-ID: <2024061258-delegate-drum-1271@gregkh>
References: <PSAPR03MB565389D72939161224B110CE95F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052329-sadden-disallow-a982@gregkh>
 <PSAPR03MB5653135ABCAF08A979BCCE0295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052313-taste-diner-2d78@gregkh>
 <PSAPR03MB5653638EEC15BE49B2E03E9495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052426-recognize-luxurious-bda8@gregkh>
 <PSAPR03MB56537E5242876A4EE9E910A495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052432-ashamed-carport-c4a0@gregkh>
 <PSAPR03MB5653D6A7D9FB3668FD499A1A95F72@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024061246-enlighten-timothy-0386@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024061246-enlighten-timothy-0386@gregkh>

On Wed, Jun 12, 2024 at 02:08:20PM +0200, Greg KH wrote:
> On Sun, May 26, 2024 at 02:51:42AM +0000, Lin Gui (桂林) wrote:
> > Dear  gregkh@linuxfoundation.org,
> > 
> > I'm very sorry for the trouble, here's the update:
> > 
> > From f033ef0bfb29cd413d10aba860ce8d178cc314e2 Mon Sep 17 00:00:00 2001
> > From: Mengqi Zhang <mailto:mengqi.zhang@mediatek.com>
> > Date: Mon, 25 Dec 2023 17:38:40 +0800
> > Subject: [PATCH] mmc: core: Add HS400 tuning in HS400es initialization
> > 
> > commit 77e01b49e35f24ebd1659096d5fc5c3b75975545 upstream
> > 
> > During the initialization to HS400es stage, add a HS400 tuning flow as an optional process. For Mediatek IP, the HS400es mode requires a specific tuning to ensure the correct HS400 timing setting.
> > 
> > Signed-off-by: Mengqi Zhang <mailto:mengqi.zhang@mediatek.com>
> > Link: https://lore.kernel.org/r/20231225093839.22931-2-mengqi.zhang@mediatek.com
> > Signed-off-by: Ulf Hansson <mailto:ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/mmc.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index a56906633ddf..c1eb22fd033b 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1799,8 +1799,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >  
> >  		if (err)
> >  			goto free_card;
> > -
> > -	} else if (!mmc_card_hs400es(card)) {
> > +	} else if (mmc_card_hs400es(card)) {
> > +		if (host->ops->execute_hs400_tuning) {
> > +			err = host->ops->execute_hs400_tuning(host, card);
> > +			if (err)
> > +				goto free_card;
> > +		}
> > +	} else {
> >  		/* Select the desired bus width optionally */
> >  		err = mmc_select_bus_width(card);
> >  		if (err > 0 && mmc_card_hs(card)) {
> > --
> 
> Better, thanks, but your email client still did odd things to the email
> addresses.
> 
> I've fixed this up by hand, but please, be more careful next time...

Wait, again, NO!  This patch does NOT even build at all!

How was this tested?

Here's a hint, this is the build error I get when applying it to the
5.15.y tree.  I tried to say this in a nice way before, but now I will
be specific:

  CC [M]  drivers/mmc/core/mmc.o
drivers/mmc/core/mmc.c: In function ‘mmc_init_card’:
drivers/mmc/core/mmc.c:1803:32: error: ‘const struct mmc_host_ops’ has no member named ‘execute_hs400_tuning’; did you mean ‘prepare_hs400_tuning’?
 1803 |                 if (host->ops->execute_hs400_tuning) {
      |                                ^~~~~~~~~~~~~~~~~~~~
      |                                prepare_hs400_tuning
drivers/mmc/core/mmc.c:1804:42: error: ‘const struct mmc_host_ops’ has no member named ‘execute_hs400_tuning’; did you mean ‘prepare_hs400_tuning’?
 1804 |                         err = host->ops->execute_hs400_tuning(host, card);
      |                                          ^~~~~~~~~~~~~~~~~~~~
      |                                          prepare_hs400_tuning

Please properly test your submissions before sending them and asking
someone else to apply them, otherwise it just wastes our time and we get
very grumpy, as would you.

greg k-h

