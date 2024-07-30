Return-Path: <stable+bounces-62675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B5940D21
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48421C236B2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB7B19415C;
	Tue, 30 Jul 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HiqYXjPS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE94194154;
	Tue, 30 Jul 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330709; cv=none; b=tMs4jiBCfTt95+V2p+wSgLptqxXH6MGZJ6+82g0RMFsbi3BnFME0bv8EdegV+lplFap/NJTsdH8JWX/2bJ7GfH9/i2eNla07vo975U9IFzURSb1Nr9gDSAlDa4ju0vaWcSpXKK/i1CcCuDjU6yzgFAYssfP5rT/BvEbgVz72qrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330709; c=relaxed/simple;
	bh=OwiYcdxTSrCffCnuGSDj7ZNsbAxtXP8QO7bcFGAC/3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGddm4ch/iEzenCwska5C+RMTCmwqGwjeLdJJWL2IkfFvbjQtKfHPdyi6SfW2LYKRGEAOaxL1WpjEw6Qdu5AEa8gif/NRBnT6oJUxwcJ90grUIZZnoRoDeO7nvxFrU+sE2l+Ukgi6P63BLHtv0dwj1DyV/4KzI6sQc39ZkDMudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HiqYXjPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F869C32782;
	Tue, 30 Jul 2024 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722330708;
	bh=OwiYcdxTSrCffCnuGSDj7ZNsbAxtXP8QO7bcFGAC/3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiqYXjPSJRF19w4HQfL1m/VS8x+MTCT0mGBUKZGTIIqi8FUr90sn9zhPC4N72SCw0
	 qh33R2WlMOmoA5GURaAM6I0fywBWGgGgpoaodTKMMETKG75mV87MueZC0yr7vVdIZA
	 IjsKvUaS4r0bzNizvHTltD64qJVpa6vvU8wPegH0=
Date: Tue, 30 Jul 2024 11:11:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wujing <realwujing@qq.com>
Cc: peterz@infradead.org, dongml2@chinatelecom.cn,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	yuanql9@chinatelecom.cn, stable@vger.kernel.org,
	mengong8.dong@gmail.com
Subject: Re: Re: [PATCH] sched/fair: Correct CPU selection from isolated
 domain
Message-ID: <2024073032-ferret-obtrusive-3ce4@gregkh>
References: <20240730082239.GF33588@noisy.programming.kicks-ass.net>
 <tencent_0C989DE2631E74C23BA8B60EA234C4B2FA0A@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0C989DE2631E74C23BA8B60EA234C4B2FA0A@qq.com>

On Tue, Jul 30, 2024 at 05:03:38PM +0800, wujing wrote:
> > If you're trying to backport something, I think you forgot to Cc stable
> > and provide the proper upstream commit.
> >
> > As is this isn't something I can do anything with. The patch does not
> > apply to any recent kernel and AFAICT this issue has long since been
> > fixed.
> 
> When fixing this bug, I didn't pay much attention to upstream changes.
> Upon reviewing the history of relevant commits, I found that they have
> been merged and reverted multiple times:
> 
> ```bash
> git log -S 'cpumask_test_cpu(cpu, sched_domain_span(sd))' --oneline \
> kernel/sched/fair.c
> 
> 8aeaffef8c6e sched/fair: Take the scheduling domain into account in select_idle_smt()
> 3e6efe87cd5c sched/fair: Remove redundant check in select_idle_smt()
> 3e8c6c9aac42 sched/fair: Remove task_util from effective utilization in feec()
> c722f35b513f sched/fair: Bring back select_idle_smt(), but differently
> 6cd56ef1df39 sched/fair: Remove select_idle_smt()
> df3cb4ea1fb6 sched/fair: Fix wrong cpu selecting from isolated domain
> ```
> 
> The latest upstream commit 8aeaffef8c6e is not applicable to linux-4.19.y.
> The current patch has been tested on linux-4.19.y and I am looking forward
> to its inclusion in the stable version.

What "current patch"?

confused,

greg k-h

