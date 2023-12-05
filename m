Return-Path: <stable+bounces-3984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867FF80454F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390F428142D
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 02:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5546A2;
	Tue,  5 Dec 2023 02:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0XZa6bNo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F020E8
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 02:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A5CC433C7;
	Tue,  5 Dec 2023 02:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701744502;
	bh=2Gw1WPzaSmWA/pbf1DoPtLM8C02wKcMVNVLbZwtNf/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0XZa6bNoIrPic9UlbcVkrpVOyRI9BFZVQJywUo86Frb1f3MwrSHNAI5zo0A7+jerL
	 AK3vLwfM6Py8jUweWuJcM/qzGrFgoeL4pwyi7Vz2Dc6fazkpTAQrkPbT1yxNCDb3ub
	 ReLV/A39Biv4tqpcdZqVQTIxS+dGHiQA/Z9FDc0w=
Date: Tue, 5 Dec 2023 11:48:18 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	stable <stable@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	James Clark <james.clark@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 5.15.y] driver core: Release all resources during unbind
 before updating device links
Message-ID: <2023120511-marsupial-unlatch-b879@gregkh>
References: <2023112330-squealer-strife-0ecc@gregkh>
 <20231123132835.486026-1-u.kleine-koenig@pengutronix.de>
 <2023112401-willing-drove-581c@gregkh>
 <20231204174200.6gl3fqgg7adzqdgq@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204174200.6gl3fqgg7adzqdgq@pengutronix.de>

On Mon, Dec 04, 2023 at 06:42:00PM +0100, Uwe Kleine-König wrote:
> Hello Greg,
> 
> On Fri, Nov 24, 2023 at 04:44:08PM +0000, Greg Kroah-Hartman wrote:
> > On Thu, Nov 23, 2023 at 02:28:36PM +0100, Uwe Kleine-König wrote:
> > > From: Saravana Kannan <saravanak@google.com>
> > > 
> > > [ Upstream commit 2e84dc37920012b458e9458b19fc4ed33f81bc74 ]
> > > 
> > > This commit fixes a bug in commit 9ed9895370ae ("driver core: Functional
> > > dependencies tracking support") where the device link status was
> > > incorrectly updated in the driver unbind path before all the device's
> > > resources were released.
> > > 
> > > Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> > > Cc: stable <stable@kernel.org>
> > > Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > Closes: https://lore.kernel.org/all/20231014161721.f4iqyroddkcyoefo@pengutronix.de/
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Yang Yingliang <yangyingliang@huawei.com>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> > > Cc: James Clark <james.clark@arm.com>
> > > Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Tested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > Link: https://lore.kernel.org/r/20231018013851.3303928-1-saravanak@google.com
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > [...]
> > 
> > Thanks, I've queued this up now.
> 
> I see it landed in v5.15.140 (as
> 947c9e12ddd6866603fd60000c0cca8981687dd3), but not in v5.10.x and the
> older stables. It should go there, too.
> 
> 947c9e12ddd6866603fd60000c0cca8981687dd3 can be cherry-picked without
> conflicts on top of v5.10.202, 5.4.262, 4.19.300 and 4.14.331.

Now queued up, thanks.

greg k-h

