Return-Path: <stable+bounces-4938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E5808CDA
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 17:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2E01F211D6
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C4146523;
	Thu,  7 Dec 2023 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="zj6odPv7"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F39610C3;
	Thu,  7 Dec 2023 08:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=9hxmOxzlmeubWF8MZL43e5U0xtVhFBe0Cobz79lxqI8=; b=zj6odPv7rjZuL72UE9JehHSORQ
	QGDf+Gm9uILicHxNCMYwWZdj0pTcqxXhKJfWWM9FU7fS0pX9lLjuY704AGlZcYh+0+UdcdBMDJaik
	+wURkW151BOqGGrGSUh12VRg/eaHcr5/uHYKEuthIFHWlbg33Bafz4Peqtxz8/CasyZE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52566 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rBGpw-00072a-QE; Thu, 07 Dec 2023 11:02:53 -0500
Date: Thu, 7 Dec 2023 11:02:52 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <20231207110252.1c7dfd46c0c5772edda9a770@hugovil.com>
In-Reply-To: <2023120748-swimming-precinct-722c@gregkh>
References: <20231130191050.3165862-1-hugo@hugovil.com>
	<20231130191050.3165862-2-hugo@hugovil.com>
	<2023120748-swimming-precinct-722c@gregkh>
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
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 7 Dec 2023 10:44:33 +0900
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Nov 30, 2023 at 02:10:43PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Change snprint format specifier from %d to %u since port_id is unsigned.
> > 
> > Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> > Cc: stable@vger.kernel.org # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> > I did not originally add a "Cc: stable" tag for commit 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> > as it was intended only to improve debugging using debugfs. But
> > since then, I have been able to confirm that it also fixes a long standing
> > bug in our system where the Tx interrupt are no longer enabled at some
> > point when transmitting large RS-485 paquets (> 64 bytes, which is the size
> > of the FIFO). I have been investigating why, but so far I haven't found the
> > exact cause, altough I suspect it has something to do with regmap caching.
> > Therefore, I have added it as a prerequisite for this patch so that it is
> > automatically added to the stable kernels.
> 
> Looks like the 0-day test bot found problems with this, so I'll hold off
> on taking this patch and the rest of the series until that's fixed up
> with a new version of this series.

No problem, I am on it.

Hugo

