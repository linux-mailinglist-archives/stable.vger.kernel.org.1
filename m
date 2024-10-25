Return-Path: <stable+bounces-88128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ACB9AFA58
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 08:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B71C1F239AA
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 06:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B611AF0BA;
	Fri, 25 Oct 2024 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxftS3/Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4k/3pj60"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58818CBFF;
	Fri, 25 Oct 2024 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839100; cv=none; b=t/H+mBRaPL/A3aRb8bBoA2ZilVWRqmAlaNBBkg0tsTi62r/frJdF7Fc+dPj0XTV4JDBIVREUvbBdi3XLR1LlmNrGdqv37PdMBqnSQgEXhsZtR8NPwsEl5n9aEsSJEFwS/E361k5Sroi3c5bArtth3XmmL02H6oPMN6FYuLboHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839100; c=relaxed/simple;
	bh=Fcj07ef6ZmAUJLv0JpSeJ5QvpvjS7urdGRU/woa/GRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gB5EESCC1oOULHvNoxQcN5gmG5e32p4+dlTlR6iYRKCSF3A/AwoWwNIvC27vUmx016SGPqrA8ZN/oT8w4MBR/zQvef/7QcyG2QxzmFYeUsJEv5xTSS3b4+EYqurF1aKixPYtPsF2dP1r+qiBJKddJmauMLy0mJ052+BxIA3Ho84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxftS3/Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4k/3pj60; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 08:51:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729839096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20Bc1eU/s+h4RynsGXBZHHHgbYIcK+6zEwC7BqWsbmE=;
	b=bxftS3/YirzavYM9UjJzWXinFXe3cgs0C1Yk9luCwjZk7wChO17GtCpqpavFtXbOeF3+20
	swzPStw4egcfqn+aFdDn0sYb4/vuVqdAAGKK3Bppgf9h/6uqyytZz5F6MeB5gGkd33iNgI
	bmnwvcQCvMOt3N4BIak9KoCMV/RrCKgMy8CSlZMQB7DA8ZsA9B51gOJ7d4YmEtGvHaK0lh
	cmiezL7sA2Cg8wB1cjobeoAWlvX8SsUCW+uOG2bQnDq+b03wh/F2qGrqhvKLAqBrylw1Jy
	Ewem8m2p4aYYoJDJvycTFwBwfopbWLuBZi8erTXh8ZNo2TxioZKAh/4nhTW3Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729839096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20Bc1eU/s+h4RynsGXBZHHHgbYIcK+6zEwC7BqWsbmE=;
	b=4k/3pj60xk1hswzu8D2SbjRA3cfQ9nyD2d6cL1SeV/wp1XLhdWTA1qxlbnO0gHnWtzIlaX
	oyHa1ZeqW1SVBzAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-stable <stable@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: stable-rc linux-6.6.y: Queues: tinyconfig: undefined reference
 to `irq_work_queue'
Message-ID: <20241025065133.oMP0jTDx@linutronix.de>
References: <CA+G9fYsaQPsvJdCsezaTu1x3koCzkTBEG8C1NpZotZLXZpZ9Qw@mail.gmail.com>
 <CA+G9fYu1QsoBLgqn5yQF28n=0gz773-cO2jq9J=qeUNugD+Hcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYu1QsoBLgqn5yQF28n=0gz773-cO2jq9J=qeUNugD+Hcg@mail.gmail.com>

On 2024-10-24 22:56:53 [+0530], Naresh Kamboju wrote:
> On Thu, 24 Oct 2024 at 20:11, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > Most of the tinyconfigs are failing on stable-rc linux-6.6.y.
> >
> > Build errors:
> > --------------
> > aarch64-linux-gnu-ld: kernel/task_work.o: in function `task_work_add':
> > task_work.c:(.text+0x190): undefined reference to `irq_work_queue'
> > task_work.c:(.text+0x190): relocation truncated to fit:
> > R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> 
> Anders bisected this regression and found,
> # first bad commit:
>   [63ad09867ee1affe4b7a5914deeb031d5b4c0be2]
>   task_work: Add TWA_NMI_CURRENT as an additional notify mode.
>   [ Upstream commit 466e4d801cd438a1ab2c8a2cce1bef6b65c31bbb ]

Would you mind to cherry-pick
	cec6937dd1aae ("task_work: make TWA_NMI_CURRENT handling conditional on IRQ_WORK")

I'm able to to build the arm64 tinyconfig on the queue/6.6 branch with
this (while it fails without).

> - Naresh

Sebastian

