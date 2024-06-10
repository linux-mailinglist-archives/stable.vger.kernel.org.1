Return-Path: <stable+bounces-50115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AC0902973
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 21:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B491F22392
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690F14D6E9;
	Mon, 10 Jun 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHo6SH5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232A1EB5B;
	Mon, 10 Jun 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048531; cv=none; b=rlPn75X4lLQnkJeMo0Ly0usCMz2cqMk8V45NJS+g6+rvhsphnvxH97X+h1S+dn93w9RvAjM2g8EuSEzVMpEiQ80tCplBE1C6xmgT32me4vWzNCebsU1WdGdlb1H6br6p/sZTWWOpm4cvegOB+IddadM/Dma2pwLhmVSHIR/tgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048531; c=relaxed/simple;
	bh=EJBht4tMP2l8jMFa7LTPLZQ4plnUvfp6wbmmf0/FaBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORW0McSDjLthL3bnBgbwTmTnMqTcEhHJFbxWxI4YeJb75BvVsQvC5tmMyZFmtPYNkvGXb6/HxShTYuSjdDhcNlfZ1bVN70U0gBYMWuGPF6tgqd0cCZ4mUCTj0ccoou4CUmZvl4y7EeS+NZ6CZ4xvnz98b9u3Rsm6fAaYzlYOB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHo6SH5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F8AC2BBFC;
	Mon, 10 Jun 2024 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718048531;
	bh=EJBht4tMP2l8jMFa7LTPLZQ4plnUvfp6wbmmf0/FaBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHo6SH5m23ecwFHSYRtH8gixMm25xdiP7xhbwvjkmJ++k4X2NQZjzo13Lpa7RNmCT
	 +yO35F+Nmh+aXkGSMGSsRWeYaKsWyMv1vln4eZSdJZXUqrjWxS8HTSh0O+WCIBPns5
	 hGp0VPI7m9xqPCKwLWRdRAaUlHE27ov0zmfb6Oo0tX96/5jedxKyBwZ8OuT+yqeRlm
	 UAP4ImVI/c4uNoK8S33qlETnQEIPDA12zw/FBX240SiG1ngQoqY61EMNJCQcCeR0kV
	 +WO/5SQSNVWw/eaiRP79KEPIhFmTyw02Xkzlnux7M5iYu9Wkx1wJ/jQBR6jII5ombr
	 p/MKSSGZzL9Xw==
Date: Mon, 10 Jun 2024 21:42:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: timers/urgent] tick/nohz_full: Don't abuse
 smp_call_function_single() in tick_setup_device()
Message-ID: <ZmdXEDOdM8Oe4gl_@pavilion.home>
References: <20240528122019.GA28794@redhat.com>
 <171804398181.10875.7931386382573929520.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171804398181.10875.7931386382573929520.tip-bot2@tip-bot2>

Le Mon, Jun 10, 2024 at 06:26:21PM -0000, tip-bot2 for Oleg Nesterov a écrit :
> The following commit has been merged into the timers/urgent branch of tip:
> 
> Commit-ID:     07c54cc5988f19c9642fd463c2dbdac7fc52f777
> Gitweb:        https://git.kernel.org/tip/07c54cc5988f19c9642fd463c2dbdac7fc52f777
> Author:        Oleg Nesterov <oleg@redhat.com>
> AuthorDate:    Tue, 28 May 2024 14:20:19 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Mon, 10 Jun 2024 20:18:13 +02:00
> 
> tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()
> 
> After the recent commit 5097cbcb38e6 ("sched/isolation: Prevent boot crash
> when the boot CPU is nohz_full") the kernel no longer crashes, but there is
> another problem.
> 
> In this case tick_setup_device() calls tick_take_do_timer_from_boot() to
> update tick_do_timer_cpu and this triggers the WARN_ON_ONCE(irqs_disabled)
> in smp_call_function_single().
> 
> Kill tick_take_do_timer_from_boot() and just use WRITE_ONCE(), the new
> comment explains why this is safe (thanks Thomas!).
> 
> Fixes: 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full")
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240528122019.GA28794@redhat.com
> Link: https://lore.kernel.org/all/20240522151742.GA10400@redhat.com

I think we agreed on that version actually:

https://lore.kernel.org/all/20240603153557.GA8311@redhat.com/

Thanks.

