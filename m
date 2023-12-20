Return-Path: <stable+bounces-7990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A681A39C
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016C81F227ED
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E87C41848;
	Wed, 20 Dec 2023 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="se9WbNYU"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0CA4645B;
	Wed, 20 Dec 2023 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=+NldyuY/BxdtLBEewyvEtWy6UnYa/M2HSy8eSghzyg4=; b=se9WbNYUaP7keWhf5ITLLV+TdY
	t3zov8YrpzqXyIk+OnFT/y9nmgTTttlnN9kvZp+ocOP/iNDvEHlftX35Tm3+SRKN+jw+xgE+1+dRY
	mc1mcG9jAEkUg4f7xeXUYip7v36IBAFpHH0Q2iythyfWJ1f9sh81QcdCOSnfjwF1iF30=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51650 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFyzy-0006jy-Bc; Wed, 20 Dec 2023 11:00:42 -0500
Date: Wed, 20 Dec 2023 11:00:41 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, stable@vger.kernel.org
Message-Id: <20231220110041.23ed3c4e97a61d102c6b1e24@hugovil.com>
In-Reply-To: <ZYMLciH4y_Y5ewiL@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-5-hugo@hugovil.com>
	<ZYMLciH4y_Y5ewiL@smile.fi.intel.com>
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
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 04/18] serial: sc16is7xx: improve do/while loop in
 sc16is7xx_irq()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 17:42:42 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 19, 2023 at 12:18:48PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Simplify and improve readability by replacing while(1) loop with
> > do {} while, and by using the keep_polling variable as the exit
> > condition, making it more explicit.
> 
> ...
> 
> > +	bool keep_polling;
> 
> > +
> 
> Stray blank line. Otherwise LGTM.

Yes, and I just realized I should also change:

    do {
        keep_polling = false;
        int i;
        ...

to:

    do {
        int i;

        keep_polling = false;
        ...

Hugo Villeneuve

