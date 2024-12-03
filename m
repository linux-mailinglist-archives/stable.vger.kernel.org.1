Return-Path: <stable+bounces-96214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A199E1661
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5642820E0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A5B1DDC0B;
	Tue,  3 Dec 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OeqyQDyt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D041DDC39
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216080; cv=none; b=kJVl4PoCHgP9E3EYv0DWt5kypQDEbbBW61uQKfE2sqNCkKCoKfrgX0iG2inoZEtIvvEUrBLM/ROHMiiHxRNEbjWhyFICd68vp+kg6vYYmCRnvIDCfbSG0IWf2ea/z7QU6szzO+atsi3ugdY4H7F90MTzS0XCmL1GmW6OVXL4rTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216080; c=relaxed/simple;
	bh=N4zaKnNhIyGxQ6pszPAxv5TiSj2jbfEgmeYQpRYudEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ydkof7yScHY05HI4gYmPE94O5E3BA+4dzYR6C2dANMOTGWkFOpwFsr6UioRiWUYFrmyEKcTZ8fRNIcKrfBR8DL1CvlTSuAn24C7BqL4j2qIrvMFC5YylLHFW0GlXg9TTE/mJI1z/uHoOjx/GzUlqclHbIuZ1hWZrKIRgZA+a2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OeqyQDyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F23EC4CECF;
	Tue,  3 Dec 2024 08:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733216080;
	bh=N4zaKnNhIyGxQ6pszPAxv5TiSj2jbfEgmeYQpRYudEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeqyQDytJyWCbZqOdklSYs0cpa/xDtdTHaJBuih18OBlhpJO3KB5Ti/L63lN2oPk+
	 HAKELK8wSyIMrPC8erWfW0heMYZ18jx6/vN7KnFpof2KAxnEoM1FbVBW0FGFnwSN+I
	 9nde5SILKq8Ck8pnpbP2UOeMJmPsPVeq1OAkjyHo=
Date: Tue, 3 Dec 2024 09:54:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: stable-rc: queue: v5.15:
 drivers/clocksource/timer-ti-dm-systimer.c:691:39: error: expected '=', ',',
 ';', 'asm' or '__attribute__' before '__free'
Message-ID: <2024120330-concave-favorite-8428@gregkh>
References: <CA+G9fYtQ+8vKa1F1kmjBCH0kDR2PkPRVgDuqCg_X6kKeaYjuyA@mail.gmail.com>
 <e58b3f28-7347-4f89-8f1e-a4f05e5f3ae0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58b3f28-7347-4f89-8f1e-a4f05e5f3ae0@gmail.com>

On Mon, Dec 02, 2024 at 08:08:07PM +0100, Javier Carrasco wrote:
> On 02/12/2024 19:43, Naresh Kamboju wrote:
> > The arm queues build gcc-12 defconfig-lkftconfig failed on the
> > Linux stable-rc queue 5.15 for the arm architectures.
> > 
> > arm
> > * arm, build
> >  - build/gcc-12-defconfig-lkftconfig
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > Build errors:
> > ------
> > drivers/clocksource/timer-ti-dm-systimer.c: In function
> > 'dmtimer_percpu_quirk_init':
> > drivers/clocksource/timer-ti-dm-systimer.c:691:39: error: expected
> > '=', ',', ';', 'asm' or '__attribute__' before '__free'
> >   691 |         struct device_node *arm_timer __free(device_node) =
> >       |                                       ^~~~~~
> > drivers/clocksource/timer-ti-dm-systimer.c:691:39: error: implicit
> > declaration of function '__free'; did you mean 'kfree'?
> > [-Werror=implicit-function-declaration]
> >   691 |         struct device_node *arm_timer __free(device_node) =
> >       |                                       ^~~~~~
> >       |                                       kfree
> > drivers/clocksource/timer-ti-dm-systimer.c:691:46: error:
> > 'device_node' undeclared (first use in this function)
> >   691 |         struct device_node *arm_timer __free(device_node) =
> >       |                                              ^~~~~~~~~~~
> > drivers/clocksource/timer-ti-dm-systimer.c:691:46: note: each
> > undeclared identifier is reported only once for each function it
> > appears in
> > drivers/clocksource/timer-ti-dm-systimer.c:694:36: error: 'arm_timer'
> > undeclared (first use in this function); did you mean 'add_timer'?
> >   694 |         if (of_device_is_available(arm_timer)) {
> >       |                                    ^~~~~~~~~
> >       |                                    add_timer
> > cc1: some warnings being treated as errors
> > 
> 
> The __free() macro is defined in include/linux/cleanup.h, and that
> header does not exist in v5.15. It was introduced with v6.1, and older
> kernels can't profit from it.
> 
> That means that this patch does not apply in its current form for v5.15.
> If someone wants to backport it, calls to of_node_put() have to be added
> to the early returns.

Now dropped, thanks.

greg k-h

