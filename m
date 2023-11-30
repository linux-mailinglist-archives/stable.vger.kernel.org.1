Return-Path: <stable+bounces-3225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE5A7FF175
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA32B20F7B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83C6495D2;
	Thu, 30 Nov 2023 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="DZIvNAlP"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D506F196
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 06:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=fZiUUjVX7bK6+GAdwc/p90o79jfuJzhQxueLC2uk+Qw=; b=DZIvNAlPHrtkxx3RE3PLB+4nPB
	YCFaC8rBRipdbUL0xWyYytSpsBSoMXwA6082sYEN9QW86nskxaPldslNqqgRTZULjcy7Y4H42JGp+
	BckM3aoMmnC+0cVoWLr0BaYgVwpCJoZFuXY1qnix9IJQwd3tgya0b4wCnyQhZD90ikJA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54736 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r8hnv-0000Oi-7E; Thu, 30 Nov 2023 09:14:11 -0500
Date: Thu, 30 Nov 2023 09:14:10 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Message-Id: <20231130091410.fce25128b041dd8bf95d9938@hugovil.com>
In-Reply-To: <2023113028-petal-persevere-2618@gregkh>
References: <20231128131501.3a3345477530cfdeeb2f0c62@hugovil.com>
	<2023113028-petal-persevere-2618@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: Re: arm64: dts: imx8mn-var-som: add 20ms delay to ethernet
 regulator enable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 30 Nov 2023 13:33:11 +0000
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Nov 28, 2023 at 01:15:01PM -0500, Hugo Villeneuve wrote:
> > Hi,
> > the following patch:
> > 
> > 26ca44bdbd13 arm64: dts: imx8mn-var-som: add 20ms delay to ethernet
> > regulator enable
> > 
> > Was introduced in kernel 6.5.
> > 
> > It needs to be applied to the stable kernels:
> >   6.1
> >   6.2
> >   6.3
> >   6.4
> 
> Only 6.1.y is still an active kernel, all others are end-of-life as the
> front page of kernel.org shows.

Copy that, thank you.

Hugo.


> I'll go queue it up for 6.1.y now, thanks.
> 
> greg k-h
> 

